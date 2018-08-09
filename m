Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E90C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544C921C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544C921C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeHIGBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:01:44 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:42395 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbeHIGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:01:44 -0400
Received: by mail-it0-f71.google.com with SMTP id g187-v6so602998ita.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 20:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C2718aPjB2AIvdpCXYnjKLaw+ui+IMPGIM+M/P8rKic=;
        b=NnAmXdwg4od7BM5Jk2pwAdi/pNTGERIHOfUk5kv5hxmLLwQXCS3NLxHpz5u/lbWA7a
         AWi9juU/iHGSQrv99zjvCmTVhaqoEkxUOWXLYIyPExusqKnEhVY7Kb10TXDE0ZfTMwXh
         FT7Xo45AN4ESaSMFjU1+w0TuLSUTwTq0jyxcxWDjX/x0NjzVEfbxc/PrSoi5kJ/pNV0K
         xb+rEQx23IJd1rQLTW3btsv1+JaogsXJkMdJ5W+XAIuIQNG0NdSZ1O7zLsn4mXax30xe
         uqR6o4OtHTbOU3dTlYOVCMbykvAclzaKw3aNGZuB9SJgLVpX05VnSAjSte+dJ81AyrcF
         6xdw==
X-Gm-Message-State: AOUpUlHTl73gIWBi8+rZ4fY+mJXZOyD35gWsRXf/1235bntGgwsPJNaJ
        r7WQdB4iUM0/ySk/n0ySp5oM9JVpivQbnA2CtR3Fi/M63jVp
X-Google-Smtp-Source: AA+uWPxyvKtuGnIerfiZCJIYGcoAywoii6GbaV2HIhu7YwsG/eVJReJZRJe9JEu1mDVp9+kTeDBWrDy6Eub6qFX0sGegPJkdTqaq
MIME-Version: 1.0
X-Received: by 2002:a24:50c1:: with SMTP id m184-v6mr310648itb.25.1533785942017;
 Wed, 08 Aug 2018 20:39:02 -0700 (PDT)
Date:   Wed, 08 Aug 2018 20:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c4e6d0572f85eb2@google.com>
Subject: WARNING in generic_make_request_checks
From:   syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    60f5a2173632 Merge tag 'usercopy-fix-v4.18-rc8' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e200e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17b87bfc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117ccc8c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
generic_make_request: Trying to write to read-only block-device loop0  
(partno 0)
WARNING: CPU: 1 PID: 4396 at block/blk-core.c:2161 bio_check_ro  
block/blk-core.c:2158 [inline]
WARNING: CPU: 1 PID: 4396 at block/blk-core.c:2161  
generic_make_request_checks+0x1618/0x24a0 block/blk-core.c:2263
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4396 Comm: syz-executor533 Not tainted 4.18.0-rc7+ #177
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:bio_check_ro block/blk-core.c:2158 [inline]
RIP: 0010:generic_make_request_checks+0x1618/0x24a0 block/blk-core.c:2263
Code: 8d bd 78 ff ff ff 45 8b b6 d4 04 00 00 48 89 df 4c 89 fe e8 ea 54 07  
00 44 89 f2 48 c7 c7 60 16 39 87 48 89 c6 e8 68 30 ff fd <0f> 0b e9 56 ed  
ff ff 48 8b bd 50 fd ff ff e8 75 f3 71 fe e9 ca ea
RSP: 0018:ffff8801acc8f640 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8801ae5e0400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff8801acc8f940 R08: ffff8801ace94500 R09: ffffed003b624fc0
R10: ffffed003b624fc0 R11: ffff8801db127e07 R12: ffff8801d3083140
R13: ffff8801ae5e0408 R14: 0000000000000000 R15: ffff8801acc8f8b8
  generic_make_request+0x2aa/0x1800 block/blk-core.c:2387
  submit_bio+0xba/0x460 block/blk-core.c:2552
  submit_bio_wait+0x134/0x1e0 block/bio.c:1004
  blkdev_issue_flush+0x204/0x300 block/blk-flush.c:553
  blkdev_fsync+0x93/0xd0 fs/block_dev.c:633
  vfs_fsync_range+0x140/0x220 fs/sync.c:197
  vfs_fsync fs/sync.c:211 [inline]
  do_fsync+0x52/0xa0 fs/sync.c:221
  __do_sys_fsync fs/sync.c:229 [inline]
  __se_sys_fsync fs/sync.c:227 [inline]
  __x64_sys_fsync+0x33/0x40 fs/sync.c:227
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444999
Code: e8 ec b2 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb d4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdc1fbd458 EFLAGS: 00000213 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444999
RDX: 0000000000401430 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000021eb880 R09: 00000000000000c2
R10: 000000000000000f R11: 0000000000000213 R12: 00000000000074ed
R13: 0000000000402370 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
