Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CDC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6142146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX7Eg0q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBHRFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:05:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34550 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfBHRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:05:22 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so9227710itd.1;
        Fri, 08 Feb 2019 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BhAQnkkENdrleAfzFQ02qsGulmwWPwoatygl13R9a4Y=;
        b=OX7Eg0q6fmnMPvx0Thbej7Dw2PnjZutfPj2YOvMP+ZZht9WrYDcvj6r6Ae+iA8yMu1
         XqEPT+/QKqVxWV3cTbUL3Bda5pL81NikziuAnLKK3pXe1KX4w5sPjiceLbHBylf2BQCH
         2baR6C7Hjh4lpGTbx4CoASKVyjIXAfDPUDdBt1lENnCb0aaGt68x7+LyRmbGMehItmXY
         hqAhfwSyOMRzBJoL/f8e/ccvpQMO4EsexmUx/OGZ1eb3v9supPCX5EcJcf9ruOA1aAM2
         Bt9JuUZ/v1nZVMFHuiol6wTrMiUbmS81aWKWKrQ6RhH3j6AabQIYzr+Yw2TwnMT7ww+h
         vJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BhAQnkkENdrleAfzFQ02qsGulmwWPwoatygl13R9a4Y=;
        b=n7Vf/4Ibj5dInRa5QFoe/BtVgxcL9QsQGkWkKHGAVvNm34wT4YvqyFndNx/olsQx5T
         nTsT5tcmPcNwLbXo/QICVTN7dIMjNbvnhgK4J8L8OtMNI0iPy8BR61/0Muk1rF1nP6DL
         psMfQRqqXXTslWZD5xD5qcM/sjVTgHnDjlMVHVC9wAv+y+OXlJwYivOCvj81SwYJvkMv
         8vZmmX4vDTdJATGTtY//t1q0cJ0/nuheeF49DKwrkyrsbVFjM6T/Wa6QWYGYkSXiBF22
         6H6Ba1cpFLd6nTFiJzWqg30TJohuM0aZChYPgpABAvbJmASz22yJ3lGWk1O78g+bGoss
         Hagw==
X-Gm-Message-State: AHQUAua7qmJrqnKVb8dYKVSJR8tfvY2yUcyMzA5uYHyTkPnnuG7VlU9B
        6wZc4j/T2BVsLYm9kprOk+D/h8/aV39YTeuXe6N2VGqn
X-Google-Smtp-Source: AHgI3IZEr0+VjJUSOD5TCaqGz4euQVcxRBc6mTpI2UkMVZsDLHPGjgeb995EhYYSvbNLg7BQT3MFKM20kV9rfBUwjUg=
X-Received: by 2002:a02:9204:: with SMTP id x4mr8007505jag.81.1549645520963;
 Fri, 08 Feb 2019 09:05:20 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Fri, 8 Feb 2019 12:05:09 -0500
Message-ID: <CAEAjamtgtkkBbwOEjSG+m9Oe0Jb2JDpZoAiYXg4Js4hEMB9pBw@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in fs/xfs/xfs_ioctl.c
To:     darrick.wong@oracle.com
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-4.19.19: "UBSAN: Undefined behaviour in
fs/xfs/xfs_ioctl.c"

kernel config: https://kt0755.github.io/etc/config_4.19.19
repro: https://kt0755.github.io/etc/repro.8d35e.c (xfs is mounted on
/mnt/xfs/)

Integer overflow arose in xfs_ioc_space() when bf->l_start + bf->l_len
(at line 676) is larger than the boundary of its storage (i.e., long long int).
A sanity check right before it would help.

=========================================
UBSAN: Undefined behaviour in fs/xfs/xfs_ioctl.c:676:18
signed integer overflow:
2378465760851919362 + 8382694012240466910 cannot be represented in
type 'long long int'
CPU: 0 PID: 8220 Comm: syz-executor2 Not tainted 4.19.19 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 xfs_ioc_space+0xb97/0xc70 fs/xfs/xfs_ioctl.c:676
 xfs_file_ioctl+0x101e/0x1690 fs/xfs/xfs_ioctl.c:1926
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:690
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:705
 __do_sys_ioctl fs/ioctl.c:712 [inline]
 __se_sys_ioctl fs/ioctl.c:710 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:710
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7df3931c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7df39326cc RCX: 00000000004497b9
RDX: 0000000020000000 RSI: 0000020040305829 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005f70 R14: 00000000006ef010 R15: 00007f7df3932700
=========================================

Thanks,
Kyungtae
