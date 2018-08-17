Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B880C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3BA21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3BA21A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compro.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeHQVQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:16:04 -0400
Received: from smtp89.ord1d.emailsrvr.com ([184.106.54.89]:42219 "EHLO
        smtp89.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbeHQVQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:16:04 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 17:16:03 EDT
Received: from smtp12.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp12.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 28754E0315
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:04:52 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp12.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp12.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 260D2E0406
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:04:52 -0400 (EDT)
X-Auth-ID: markh@compro.net
Received: by smtp12.relay.ord1d.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id CC056E0315
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:04:51 -0400 (EDT)
X-Sender-Id: markh@compro.net
Received: from [10.15.15.121] ([UNAVAILABLE]. [97.68.168.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 17 Aug 2018 14:04:52 -0400
From:   Mark Hounschell <markh@compro.net>
Subject: 4.18.1 "make install" issue
Reply-To: markh@compro.net
To:     "linux-kernel@vger.kernel.org >> Linux-kernel" 
        <linux-kernel@vger.kernel.org>
Organization: Compro Computer Svcs.
Message-ID: <d5e6db95-0fc1-c112-a988-73b89cdeacc4@compro.net>
Date:   Fri, 17 Aug 2018 14:04:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Something is amiss. A "make install" of an already compiled 4.18.1
kernel is taking 10 minutes or so. The same thing for a 4.17.14 kernel
takes all of a minute.

And during that 10 minutes 
or so we seem hung up on i915.ko

 2626 pts/8    S+     0:00 make -f ./scripts/Makefile.build obj=arch/x86/boot install
 2627 pts/8    S+     0:00 /bin/sh /sbin/installkernel 4.18.1 arch/x86/boot/bzImage System.map /boot
 2642 pts/11   Ss     0:00 /bin/bash
 2659 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4581 pts/1    Ss     0:00 /bin/bash
 4620 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4622 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4623 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4624 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4625 pts/8    S+     0:09 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4627 pts/8    R+     1:47 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4682 pts/8    S+     0:00 /bin/bash --norc /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
 4683 pts/8    S+     0:00 cat /lib/modules/4.18.1//kernel/drivers/gpu/drm/i915/i915.ko
 4684 pts/8    S+     0:00 tr -cd [:print:]



 # date ; make install ; date
Fri Aug 17 10:25:47 EDT 2018

sh ./arch/x86/boot/install.sh 4.18.1 arch/x86/boot/bzImage \
        System.map "/boot"
dracut: Executing: /usr/bin/dracut --hostonly --force /boot/initrd-4.18.1 4.18.1
dracut: *** Including module: bash ***
dracut: *** Including module: systemd ***
dracut: *** Including module: warpclock ***
dracut: *** Including module: systemd-initrd ***
dracut: *** Including module: i18n ***
dracut: Could not find FONT_MAP none!
dracut: *** Including module: drm ***


Here it hangs up for 10 minutes with the above "ps ax" output? 


dracut: Possible missing firmware "nvidia/gv100/sec2/sig.bin" for kernel module "nouveau.ko"
.
.
.
dracut: *** Including module: plymouth ***
dracut: *** Including module: kernel-modules ***
dracut: *** Including module: resume ***
dracut: *** Including module: rootfs-block ***
dracut: *** Including module: terminfo ***
dracut: *** Including module: udev-rules ***
dracut: Skipping udev rule: 40-redhat.rules
dracut: Skipping udev rule: 50-firmware.rules
dracut: Skipping udev rule: 50-udev.rules
dracut: Skipping udev rule: 91-permissions.rules
dracut: Skipping udev rule: 80-drivers-modprobe.rules
dracut: *** Including module: dracut-systemd ***
dracut: *** Including module: haveged ***
dracut: *** Including module: ostree ***
dracut: *** Including module: usrmount ***
dracut: *** Including module: base ***
dracut: *** Including module: fs-lib ***
dracut: *** Including module: shutdown ***
dracut: *** Including module: suse ***
dracut: *** Including modules done ***
dracut: *** Installing kernel module dependencies and firmware ***
dracut: *** Installing kernel module dependencies and firmware done ***
dracut: *** Resolving executable dependencies ***
dracut: *** Resolving executable dependencies done***
dracut: *** Hardlinking files ***
dracut: *** Hardlinking files done ***
dracut: *** Stripping files ***
dracut: *** Stripping files done ***
dracut: *** Generating early-microcode cpio image ***
dracut: *** Constructing AuthenticAMD.bin ****
dracut: *** Store current command line parameters ***
dracut: Stored kernel commandline:
dracut:  resume=UUID=86053ad3-d0fe-483f-bdd3-bdf8c26fa47b
dracut:  root=UUID=a271f078-c500-4099-b058-fa9812037fc2 rootfstype=ext4 rootflags=rw,relatime
dracut: *** Creating image file '/boot/initrd-4.18.1' ***
dracut: *** Creating initramfs image file '/boot/initrd-4.18.1' done ***

Fri Aug 17 10:34:50 EDT 2018


Same machine installing a 4.17.14 kernel take 1 minute:
# date ; make install ; date
Fri Aug 17 13:27:41 EDT 2018

sh ./arch/x86/boot/install.sh 4.17.14-lcrs arch/x86/boot/bzImage \
        System.map "/boot"
renamed '/boot/config-4.17.14-lcrs' -> '/boot/config-4.17.14-lcrs.old'
dracut: Executing: /usr/bin/dracut --hostonly --force /boot/initrd-4.17.14-lcrs 4.17.14-lcrs
dracut: *** Including module: bash ***
dracut: *** Including module: systemd ***
dracut: *** Including module: warpclock ***
dracut: *** Including module: systemd-initrd ***
dracut: *** Including module: i18n ***
dracut: Could not find FONT_MAP none!
dracut: *** Including module: drm ***
dracut: *** Including module: plymouth ***
.
.
.
dracut: *** Generating early-microcode cpio image ***
dracut: *** Constructing AuthenticAMD.bin ****
dracut: *** Store current command line parameters ***
dracut: Stored kernel commandline:
dracut:  resume=UUID=86053ad3-d0fe-483f-bdd3-bdf8c26fa47b
dracut:  root=UUID=a271f078-c500-4099-b058-fa9812037fc2 rootfstype=ext4 rootflags=rw,relatime
dracut: *** Creating image file '/boot/initrd-4.17.14-lcrs' ***
dracut: *** Creating initramfs image file '/boot/initrd-4.17.14-lcrs' done ***

Fri Aug 17 13:28:29 EDT 2018

Regards
Mark
