#!/bin/bash

# Name of the script: myscript.sh
# Description: This script is for user and group management in Linux.

# Purpose: Display the main menu for user administration
# Algorithm: Clears the screen and prints the user administration menu options.
show_menu() {
    clear
    echo "*******************************************"
    echo "User Administration Menu"
    echo "1. To Create a user account"
    echo "2. To Change Initial Group for a user account"
    echo "3. To Change Supplementary Group for a user account"
    echo "4. To Change default login shell for a user account"
    echo "5. To Change account expiration date for a user account"
    echo "6. To Delete a user account"
    echo "Q to Quit"
    echo "*******************************************"
    echo "Choose one of the following options, shown above, by entering the appropriate number:"
}

# Purpose: Add a new user
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username, home directory, and login shell. Creates the user with these details.
add_user() {
    read -p "Enter Username: " username
    read -p "Enter Home Directory (absolute path): " home_dir
    read -p "Enter Default Login Shell (absolute path): " login_shell

    mkdir -p "$home_dir"
    useradd -d "$home_dir" -s "$login_shell" "$username"

    # Check if the useradd command was successful
    if [ $? != 0 ]; then
        echo "Error: Failed to create user $username."
    else
        echo "User $username created with home directory $home_dir and shell $login_shell"
    fi
    sleep 4
}

# Purpose: Change the initial group of a user
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username and new initial group, changes the initial group of the specified user.
change_initial_group() {
    read -p "Enter Username: " username
    read -p "Enter new initial group: " group

    # Attempt to change the initial group of the user
    usermod -g "$group" "$username"

    # Check if the usermod command was successful
    if [ $? != 0 ]; then
        echo "Error: Group $group does not exist or user $username not modified."
    else 
        echo "Initial group of user $username changed to $group"
    fi
    sleep 4
}

# Purpose: Change the supplementary group of a user
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username and new supplementary group, changes the supplementary group of the specified user.
change_supplementary_group() {
    read -p "Enter Username: " username
    read -p "Enter new supplementary group: " supp_group

    usermod -aG "$supp_group" "$username"
    # Check if the usermod command was successful
    if [ $? != 0 ]; then
        echo "Error: Group $supp_group does not exist."
    else 
        echo "Supplementary group of user $username changed to $supp_group"
    fi
    sleep 4
}

# Purpose: Change the default login shell of a user
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username and new default shell, changes the login shell of the specified user.
change_login_shell() {
    read -p "Enter Username: " username
    read -p "Enter new default shell (absolute path): " shell

    usermod -s "$shell" "$username"

    # Check if the usermod command was successful
    if [ $? != 0 ]; then
        echo "Error: Failed to change the default shell for user $username."
    else
        echo "Default shell of user $username changed to $shell"
    fi
    sleep 4
}

# Purpose: Change the account expiration date for a user
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username and new expiration date, changes the expiration date of the specified user.
change_expiration_date() {
    read -p "Enter Username: " username
    read -p "Enter new expiration date (YYYY-MM-DD): " exp_date

    # Attempt to change the expiration date of the user
    usermod -e "$exp_date" "$username"

    # Check if the usermod command was successful
    if [ $? != 0 ]; then
        echo "Error: Failed to change the expiration date for user $username."
    else
        echo "Expiration date of user $username changed to $exp_date"
    fi
    sleep 4
}

# Purpose: Delete a user account
# Author name: Zimeng Wang
# Student number: 041095956
# Date Written: November 25, 2023
# Algorithm: Prompts for username and deletes the specified user account.
delete_account() {
    read -p "Enter Username of the account to be deleted: " username

    # Delete the user account
    userdel "$username"
    if [ $? != 0 ]; then
        echo "Error: Failed to delete user account $username."
        return 1
    fi

    # Remove the home directory
    rm -rf "/home/$username"
    echo "User account $username and its home directory have been deleted."
    sleep 5
}

# This is an infinite loop, it will keep running until the user chooses to exit
while true; do
    show_menu
    read choice

    case $choice in
        1) add_user ;;
        2) change_initial_group ;;
        3) change_supplementary_group ;;
        4) change_login_shell ;;
        5) change_expiration_date ;;
        6) delete_account ;;
        [Qq]) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
    sleep 4
    clear
done

