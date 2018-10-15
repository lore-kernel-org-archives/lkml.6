Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89475C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1D920876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8/aTHeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1D920876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeJOH5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 03:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOH5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 03:57:08 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C01A20659;
        Mon, 15 Oct 2018 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539562461;
        bh=5i4/Vgs2FpMuxvC0w7QqAKciorXc1vwVVx5VL6qfxJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8/aTHeYezGvjjy4NUapke3boWBOwi9eIutClzldctIPWt0d9H5OKEPuQKpL9K5qd
         /tGAhdHNEcVekHTthLouuK5zYm8z/NmSTKZpii2qWCm1RjzWkAb8ju25M0thkMtKE5
         eN1MjINKpwPvMkfehBa8fcB3RWgizVCMl/ec94/Q=
Date:   Sun, 14 Oct 2018 17:14:19 -0700
From:   Shaohua Li <shli@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Shaohua Li <shli@fb.com>, Gioh Kim <gi-oh.kim@profitbricks.com>,
        Guoqing Jiang <gqjiang@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [MD]  d595567dc4: mdadm-selftests.02lineargrow.fail
Message-ID: <20181015001419.GA12053@kernel.org>
References: <20181012085844.GN13396@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012085844.GN13396@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:58:44PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: d595567dc4f0c1d90685ec1e2e296e2cad2643ac ("MD: fix invalid stored role for a disk")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: mdadm-selftests
> with following parameters:
> 
> 	disk: 1HDD
> 	test_prefix: 02
> 
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> 
> Welcome to fdisk (util-linux 2.29.2).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
> 
> Device does not contain a recognized partition table.
> Created a new DOS disklabel with disk identifier 0xd50ae9f0.
> 
> Command (m for help): Partition type
>    p   primary (0 primary, 0 extended, 4 free)
>    e   extended (container for logical partitions)
> Select (default p): Partition number (1-4, default 1): First sector (2048-536870911, default 2048): Last sector, +sectors or +size{K,M,G,T,P} (2048-536870911, default 536870911): 
> Created a new partition 1 of type 'Linux' and of size 5 GiB.
> 
> Command (m for help): The partition table has been altered.
> Calling ioctl() to re-read partition table.
> Syncing disks.
> 
> 2018-10-12 11:05:55 mkdir -p /var/tmp
> 2018-10-12 11:05:55 mke2fs -t ext3 -b 1024 -J size=1 -q /dev/vda1
> 2018-10-12 11:06:00 mount -t ext3 /dev/vda1 /var/tmp
> sed -e 's/{DEFAULT_METADATA}/1.2/g' \
> -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
> /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
> /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
> /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
> /usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
> /usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
> /usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
> /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
> /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
> Testing on linux-4.19.0-rc5-00182-gd595567 kernel
> tests/02lineargrow... FAILED - see /var/tmp/log for details
> Testing on linux-4.19.0-rc5-00182-gd595567 kernel
> tests/02r1add... succeeded
> Testing on linux-4.19.0-rc5-00182-gd595567 kernel
> tests/02r1grow... succeeded
> Testing on linux-4.19.0-rc5-00182-gd595567 kernel
> tests/02r5grow... succeeded
> Testing on linux-4.19.0-rc5-00182-gd595567 kernel
> tests/02r6grow... succeeded
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

Thanks for reporting, I fixed it in md-next tree.

Thanks,
Shaohua
