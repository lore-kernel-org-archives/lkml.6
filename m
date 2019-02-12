Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A026C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42F20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqR/vhg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfBLAbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:31:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33441 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBLAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:31:17 -0500
Received: by mail-it1-f194.google.com with SMTP id q78so145762itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/kdbY1fbR5TL7GLUl2SNTg11jYl0SCQibpcXyAdQRdg=;
        b=EqR/vhg67Q9AsxHKjDzoAt1KBmT0hCxn2+oKryIjWEtAxjo16swvsRSdLNN+Ff4ziK
         whqDVEUYLF5g6glhS0IoL6Neoo5MP6WjpzmLcSn7Bu/VAdWXiVv3ehhG4XjD88Qs6HxH
         uDnj4NX6viO0VqVx9lLFZvnrDj0LA5N6izbfSRsq/Dk9RIbRwOtm5DKK71/mKbl+KeZR
         zCXb5p+stTbtbSJjsU2eS89CGKKm9vsT4UfgBprw16ZUlVYDoYNx4wGZx4HCMipapLTn
         3ge1B8Xv8p33lnH8W47WsN3DGPqUa8nL+O2lEHnHoJ1P1L5zj6vYIoO8B5FEImmZoCzb
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/kdbY1fbR5TL7GLUl2SNTg11jYl0SCQibpcXyAdQRdg=;
        b=P9WnPPcfeKHilbQU5G+Lt2vAKGDAh2o2NFUMKHVhAibctu7Zfb3KVq5VzVJBSSnikE
         TCV2mInpjvVrQ4m2WTvodNoBPguTfPtUjcs+9xKHV+KP8467k/v4lFJfovNUzUKGh01a
         ts+5YmyWydVTwBDGw6x93gFqzY7bRxZdcWK6rXgmbB22j92jZpyFIwuekHUFKWmeSSr7
         usdKDJeC9md8JZrqL9qfn5141r5f20G8F7zT3HulwRCU63Cfh4UdptKb2ylfnCsyoFnT
         D8RCgP3yonp+Ksr6YFpDCLSjojK1jID2bRImv/00+VodQQx9EXM1pZlKRjicuhKIxhWf
         +oEQ==
X-Gm-Message-State: AHQUAuYdSV1DfbYIr73N8Jt23CrLveCe+LTxttun81FTMSZvHce2Aere
        QHR9vVZ38H4ULh1vVkl2CDLOMrnAkb39P82YEnQ=
X-Google-Smtp-Source: AHgI3Ia0YTV2uu4QETeGJfVPQYYy/R+LNxjVjvJOIcS625QAsqoWhUaVWX2lE74L6mZ4S89qEa8l9ZxnR9YEqraArFA=
X-Received: by 2002:a02:bb0a:: with SMTP id y10mr547533jan.125.1549931476367;
 Mon, 11 Feb 2019 16:31:16 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 11 Feb 2019 19:31:05 -0500
Message-ID: <CAEAjamsmr08WRFy9f8CLZ78rpwD=Ti4nBVxZeNiwNwvfVHm06Q@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in fs/jfs/jfs_dmap.c
To:     shaggy@kernel.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        jfs-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-4.19.19: "UBSAN: Undefined behaviour in
fs/jfs/jfs_dmap.c"
(don't have repro)

A memory access violation (invalid array index) arose in dmtree
function dbAdjTree().
For now, however, it's hard to say for sure this caused by user-supplied input.

=========================================
UBSAN: Undefined behaviour in fs/jfs/jfs_dmap.c:2915:15
index 342 is out of range for type 's8 [341]'
CPU: 0 PID: 3703 Comm: syz-executor6 Not tainted 4.19.19 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386
 dbAdjTree+0x5e5/0x6b0 fs/jfs/jfs_dmap.c:2915
 dbSplit+0x170/0x230 fs/jfs/jfs_dmap.c:2694
 dbAdjCtl+0x357/0x9c0 fs/jfs/jfs_dmap.c:2569
 dbAllocDmap+0xd0/0x120 fs/jfs/jfs_dmap.c:2082
 dbAllocDmapLev+0x154/0x370 fs/jfs/jfs_dmap.c:2026
 dbAllocCtl+0x12b/0x7b0 fs/jfs/jfs_dmap.c:1866
 dbAllocAG+0x99e/0x1180 fs/jfs/jfs_dmap.c:1407
 dbAlloc+0x47c/0xb00 fs/jfs/jfs_dmap.c:863
 extBalloc fs/jfs/jfs_extent.c:531 [inline]
 extAlloc+0x4b4/0x1000 fs/jfs/jfs_extent.c:138
 jfs_get_block+0x5d0/0xbf0 fs/jfs/inode.c:257
 nobh_write_begin+0x35b/0xc90 fs/buffer.c:2607
 jfs_write_begin+0x42/0x100 fs/jfs/inode.c:322
 generic_perform_write+0x224/0x4f0 mm/filemap.c:3139
 __generic_file_write_iter+0x395/0x6c0 mm/filemap.c:3264
 generic_file_write_iter+0x31e/0x6e0 mm/filemap.c:3292
 call_write_iter include/linux/fs.h:1811 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fde5da97c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fde5da986cc RCX: 00000000004497b9
RDX: 000000000000009e RSI: 0000000020000100 RDI: 0000000000000016
RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000bd90 R14: 00000000006f4e30 R15: 00007fde5da98700
=========================================

Thanks,
Kyungtae
