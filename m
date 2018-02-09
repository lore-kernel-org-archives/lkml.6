Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeBIXYp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:24:45 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41269 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeBIXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:24:43 -0500
X-Google-Smtp-Source: AH8x226V3J/Cw9p7bWTUAxTBwbiOn+7TMreTL88lNZ/YNEyb6GLqPWrosbieYMIbCQwdjkEiVPlXyA==
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Zstd and zram - not finished?
Date: Sat, 10 Feb 2018 02:13:51 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201802100213.52152.randrianasulu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I was trying to test zstd compression for zram devices with kernel 4.15
But to my surprize I found zstd comressor missing from  list of compression 
algos.

I found out this patch or equivalent was still missing in 4.15 and missing in 
4.16 as it nearing -rc1:
https://lkml.org/lkml/2017/8/4/582

[PATCH v4 5/5] crypto: Add zstd support

After manually applying this patch I can see


cat /sys/class/block/zram0/comp_algorithm
[lzo] lz4 lz4hc 842 zstd

and can change algo to zstd

If I try and mkfs.ext2 this device (with size, say, ~1Gb) - I can uncompress 
nearly full kernel tree into it (I first run out of inodes, tons of small files 
for such small "disk", re-run mkfs with specified number of inodes, around 100 
000, worked). But 1Gb device probably was visible size of device, not amount of 
memory it consumes..So, I run mkfs.btrfs over /dev/zram0 with zstd compression. 
This give me ~1Gb sized device  able to keep full kernel tree, and compile it , 
too. So, I assume it worked ....
