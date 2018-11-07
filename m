Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3925C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEBE2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3TK6P4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEBE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeKGTQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:16:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44648 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:16:29 -0500
Received: by mail-io1-f68.google.com with SMTP id c6-v6so11424040iob.11;
        Wed, 07 Nov 2018 01:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+Z2VDdGJBrjOCjp1FzQBxub6eAd8h+NQq76y4fufyes=;
        b=P3TK6P4W1Wf94UGOxsIkwKeUKmdgk6cyMoau1EP+oCd9Nw6ITQwtAhKqhN+yMKekCO
         blUNRBs6RPZMAdAeLBhPQGsv6NM0kD67bCO1ogLCEBkZuA7IufDKdCp6rl27owib0ne9
         W9Bk9W4hgGbtGvT4mqGIeofXi10joxg8qmqZe+WJghSB7BHNvUgC3QM6lUMoeV+xr5lv
         u2OFjA58oUBOO4ik53L/tq6XP92JkFh1prPoZK3d/3NzA/kChbEB3MK1XqGa9MWCr6MI
         g6ptJYd4dGJS0Mb7NCZAf80NPP0B1fSQdo1PwN7rHNnsG+FcQh7WKg87AoqgKyAkZzn9
         COoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+Z2VDdGJBrjOCjp1FzQBxub6eAd8h+NQq76y4fufyes=;
        b=o0AaiRRz5/zjo9KQAvsKoQvPTRFnkdCOPzNaGDKVXG/RsHQMnKfP9tyq3KaIlpNGHi
         2uHYcR8qsf1yQ3W5itmPvOBcP1/KWqxo2O9cw03F/9UKlJvlh66kAiB1LDD99dkvogmF
         pimxAvl8K869LP92x4kmCd9INC4HEafCsvMQFhW5CI1I8t2zWbdDnZEd7pZKS+rIfFK4
         WHnNloHOyadcyFHuh/LDVT9+18LV0Gg1kVcSVGniyoLSjOLhZwSvqeAStcF/0L552XYl
         WLXKgUBCoJCzC0M6G9YlHbt8IaMR+5Gv2fK4z+gGdellArWSZj0tTFCJ5weMnvxGbANS
         0Xqg==
X-Gm-Message-State: AGRZ1gI9dT8CCCDIF+tEW5SteK3j3CPa3mTci8lRNuB3qYqznz562T5B
        DBUwVRVOThinJ+/i4Ma9vtB2RBLyabtknZSz4Qw=
X-Google-Smtp-Source: AJdET5d3Gti1R0FT0oNpOvCBrfgfS/3BvsgDC3XNNBN2/fVzc4sc1Y1jwTtuctxpZMBHX4geRhl/0waE1JctmCs5pes=
X-Received: by 2002:a6b:8e90:: with SMTP id q138-v6mr966826iod.112.1541584013617;
 Wed, 07 Nov 2018 01:46:53 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 7 Nov 2018 04:46:42 -0500
Message-ID: <CAEAjamv2+DExHp2kyuBU=fZx-59MgOWyahDqTUL-uQMgUAmzuA@mail.gmail.com>
Subject: WARNING in pkt setup dev
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in v4.19-rc2 (the latest as well):

kernel config: https://kt0755.github.io/etc/config_v2-4.19
repro: https://kt0755.github.io/etc/repro.aa68f.c

In pkt_ctl_ioctl (cmd: PKT_CTRL_CMD_SETUP), it attempts to retrieve a
block device
using a variable "dev" that comes from ioctl's third argument
(driver/block/pktcdvd.c:2592).
However, an inappropriate block device can be retrieved and allowed to
access following statements.
It's because "dev" is used to retrieve block_device without prior sanity check.
although it can be manipulated by compromising syscall input.


Crash log:
===========================
Attempt to register a non-SCSI queue
WARNING: CPU: 0 PID: 6710 at drivers/block/pktcdvd.c:2599 pkt_new_dev
drivers/block/pktcdvd.c:2599 [inline]
WARNING: CPU: 0 PID: 6710 at drivers/block/pktcdvd.c:2599
pkt_setup_dev+0x1054/0x1340 drivers/block/pktcdvd.c:2760
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6710 Comm: syz-executor1 Not tainted 4.19.0-rc2 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 panic+0x1ff/0x419 kernel/panic.c:184
 __warn+0x208/0x220 kernel/panic.c:536
 report_bug+0x243/0x300 lib/bug.c:186
 fixup_bug.part.9+0x3e/0x90 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:248 [inline]
 do_error_trap+0x278/0x2c0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x20/0x30 arch/x86/kernel/traps.c:316
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:pkt_new_dev drivers/block/pktcdvd.c:2599 [inline]
RIP: 0010:pkt_setup_dev+0x1054/0x1340 drivers/block/pktcdvd.c:2760
Code: c2 48 c7 c7 80 89 68 87 e8 6e e7 0e fe e9 c7 fe ff ff e8 ef 8f
23 fe 48 c7 c7 40 8a 68 87 c6 05 06 bb e5 05 01 e8 cc 69 f8 fd <0f> 0b
e9 40 ff ff ff e8 80 0d 56 fe e9 1d f5 ff ff e8 f6 0c 56 fe
RSP: 0018:ffff880102f17b30 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88010126f600 RCX: ffffffff81439b91
RDX: 0000000000010000 RSI: ffffc9000335b000 RDI: ffffffff8a183e20
RBP: ffff880102f17c28 R08: ffffed0023503cfb R09: ffffed0023503cfb
R10: ffff88010f75731f R11: ffffed0023503cfa R12: ffff88010f757300
R13: 0000000000000000 R14: ffff8800b97cdd80 R15: ffff8801149f8000
 pkt_ctl_ioctl+0x273/0x3b0 drivers/block/pktcdvd.c:2881
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4be1b72c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4be1b736cc RCX: 00000000004497b9
RDX: 00000000200003c0 RSI: 00000040c0185801 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000055b0 R14: 00000000006ed650 R15: 00007f4be1b73700
Dumping ftrace buffer:
   (ftrace buffer empty)
==========================

Thanks,
Kyungtae Kim
