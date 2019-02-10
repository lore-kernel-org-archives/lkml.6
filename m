Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8527C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 11:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645CF21736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549797759;
	bh=fA2kOTzXFJAatOvctxGgCiUDZSyOZ1rsWAV/dRwF4+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6zkUCaDIjpN6gwAB2hpM36UohCFPkjtRP2uA0dPdrBIz3Wh5j5ZFNu8FQ/pfNQ63
	 vkjHtf6gYUbJO6MqW3j9nex3GUGFtXiPorzGNulXf6Mb3ZiX47XRCt5080I3601Tmn
	 3keiGHvNTLrW36NgeH6CzA4bUiia1KpkXTSB6TSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfBJLWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 06:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfBJLWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 06:22:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6168E21736;
        Sun, 10 Feb 2019 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549797755;
        bh=fA2kOTzXFJAatOvctxGgCiUDZSyOZ1rsWAV/dRwF4+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yO7O+9rtabV9NTSjtrgo76Qz1/j7TkyWfRrG5ip9Z23aCMitF+OZhUEwQ7/IKoy5O
         DEwU+QqUkjc8ZGKwLasMefoZdp99LyB/QHUO8msU0GInAquKFS/L6KWuhfagy0Mu3s
         ttv4Q5VOw06PQxzfkX0GfhQkAaUBije0IW4FJI2U=
Date:   Sun, 10 Feb 2019 12:22:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     anand.jain@oracle.com, stable-commits@vger.kernel.org
Subject: Re: Patch "btrfs: harden agaist duplicate fsid on scanned devices"
 has been added to the 4.14-stable tree
Message-ID: <20190210112232.GA17344@kroah.com>
References: <20190209172822.0984B218D2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190209172822.0984B218D2@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 12:28:20PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     btrfs: harden agaist duplicate fsid on scanned devices
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      btrfs-harden-agaist-duplicate-fsid-on-scanned-device.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 2590f717cfd952f726597e4ebf0800154be5e5f5
> Author: Anand Jain <anand.jain@oracle.com>
> Date:   Mon Oct 15 10:45:17 2018 +0800
> 
>     btrfs: harden agaist duplicate fsid on scanned devices
>     
>     [ Upstream commit a9261d4125c97ce8624e9941b75dee1b43ad5df9 ]
>     
>     It's not that impossible to imagine that a device OR a btrfs image is
>     copied just by using the dd or the cp command. Which in case both the
>     copies of the btrfs will have the same fsid. If on the system with
>     automount enabled, the copied FS gets scanned.
>     
>     We have a known bug in btrfs, that we let the device path be changed
>     after the device has been mounted. So using this loop hole the new
>     copied device would appears as if its mounted immediately after it's
>     been copied.
>     
>     For example:
>     
>     Initially.. /dev/mmcblk0p4 is mounted as /
>     
>       $ lsblk
>       NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>       mmcblk0     179:0    0 29.2G  0 disk
>       |-mmcblk0p4 179:4    0    4G  0 part /
>       |-mmcblk0p2 179:2    0  500M  0 part /boot
>       |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
>       `-mmcblk0p1 179:1    0  256M  0 part /boot/efi
>     
>       $ btrfs fi show
>          Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>          Total devices 1 FS bytes used 1.40GiB
>          devid    1 size 4.00GiB used 3.00GiB path /dev/mmcblk0p4
>     
>     Copy mmcblk0 to sda
>     
>       $ dd if=/dev/mmcblk0 of=/dev/sda
>     
>     And immediately after the copy completes the change in the device
>     superblock is notified which the automount scans using btrfs device scan
>     and the new device sda becomes the mounted root device.
>     
>       $ lsblk
>       NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>       sda           8:0    1 14.9G  0 disk
>       |-sda4        8:4    1    4G  0 part /
>       |-sda2        8:2    1  500M  0 part
>       |-sda3        8:3    1  256M  0 part
>       `-sda1        8:1    1  256M  0 part
>       mmcblk0     179:0    0 29.2G  0 disk
>       |-mmcblk0p4 179:4    0    4G  0 part
>       |-mmcblk0p2 179:2    0  500M  0 part /boot
>       |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
>       `-mmcblk0p1 179:1    0  256M  0 part /boot/efi
>     
>       $ btrfs fi show /
>         Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>         Total devices 1 FS bytes used 1.40GiB
>         devid    1 size 4.00GiB used 3.00GiB path /dev/sda4
>     
>     The bug is quite nasty that you can't either unmount /dev/sda4 or
>     /dev/mmcblk0p4. And the problem does not get solved until you take sda
>     out of the system on to another system to change its fsid using the
>     'btrfstune -u' command.
>     
>     Signed-off-by: Anand Jain <anand.jain@oracle.com>
>     Reviewed-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9663b6aa2a56..1e8d216720a2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -696,6 +696,35 @@ static noinline int device_list_add(const char *path,
>  			return -EEXIST;
>  		}
>  
> +		/*
> +		 * We are going to replace the device path for a given devid,
> +		 * make sure it's the same device if the device is mounted
> +		 */
> +		if (device->bdev) {
> +			struct block_device *path_bdev;
> +
> +			path_bdev = lookup_bdev(path);
> +			if (IS_ERR(path_bdev)) {
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +				return ERR_CAST(path_bdev);
> +			}
> +
> +			if (device->bdev != path_bdev) {
> +				bdput(path_bdev);
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +				btrfs_warn_in_rcu(device->fs_info,
> +			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
> +					disk_super->fsid, devid,
> +					rcu_str_deref(device->name), path);
> +				return ERR_PTR(-EEXIST);
> +			}
> +			bdput(path_bdev);
> +			btrfs_info_in_rcu(device->fs_info,
> +				"device fsid %pU devid %llu moved old:%s new:%s",
> +				disk_super->fsid, devid,
> +				rcu_str_deref(device->name), path);
> +		}
> +
>  		name = rcu_string_strdup(path, GFP_NOFS);
>  		if (!name)
>  			return -ENOMEM;

This patch causes a build warning:

../fs/btrfs/volumes.c:709:12: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
     return ERR_CAST(path_bdev);
            ^~~~~~~~~~~~~~~~~~~
../fs/btrfs/volumes.c:719:12: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
     return ERR_PTR(-EEXIST);
            ^~~~~~~~~~~~~~~~

and it's correct, the code is should not do this.  I'll drop this
patch now.

thanks,

greg k-h
