#!/bin/bash


DIALOG=${DIALOG=dialog}

$DIALOG --title "Yolk's Alarming Pi" --clear --yesno "Run fdisk?" 10 30

case $? in
	0)
		fdisk /dev/mmblk0
	1)
		$DIALOG --title "Yolk's Alarming Pi" --clear --yesno "set-timezone?" 10 30
		case $? in
			0)
				timedatectl set-timezone America/Chicago
			1)
				$DIALOG --title "Yolk's Alarming Pi" --clear --yesno "update packages, with base.txt?" 10 30
				case $? in
					0)
						pacman -Syyu tmux screen docker nss-mdns
					1)
						echo "done!"
					255)
						echo "stopped at packages"
				esac
			255)
				echo "stopped at setting packages"
		esac
	255)
		echo "cancelled!"
esac

