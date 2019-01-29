Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22045C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfA2QnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:43:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:34298 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfA2QnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:43:05 -0500
Received: by mail-io1-f69.google.com with SMTP id q16so17155572ios.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sIv6+AT+ptrB8WA7KqnI7Nd9IMqv1oGR0TAfAAvgzLc=;
        b=JHWVjDsz37n0Z+rpDm9WPU3mKgz9+bvMfQptJYRtC1UhfudjMH0J9GCJnqgBKr13Mm
         AOvWcqkKFsIXNxPe+dKoAcymvoHXNbOkU7UkIIuB9qTVYAPRi2A1AZKA/6JBe1+R/xSU
         FEVj6Np3+Z7cwfaXpauCEq9rpS8OlSlomanWoSAww4sI0z1BjFJz2cVCLA6ZT4rjSLV1
         /XFeD5frD/OP2XimBG+W6ksK6NqpuPxS3dWeEw2mM5RDvo7AW81/A6NRgTQ1XJpQFvq3
         7SxY7xCZ0IslIS2pOw1+hBtC3N+I1ySMdGxkrOc8T5XcKrwEX5zh8A5HnDBhTpblVt8u
         Np8Q==
X-Gm-Message-State: AHQUAuYUb7G0D/w5qRtNUhhH2iadD1K4IE+dQVAp2v9+HI7AKsKL9xHf
        9miOBy8o1hdqjOxeisH88pio+zmAKrM+T1fzw9RGC9lwr7sH
X-Google-Smtp-Source: AHgI3IZDSiECho2XEWtPtepGJVuAmtbe5BrO7Ydqn3l4lQUcq5ZkBO/yoRvYshw1DaIdrMO60KSJ2pdIxnnS/rAXY4EnkvKo2mld
MIME-Version: 1.0
X-Received: by 2002:a02:8785:: with SMTP id t5mr3514769jai.10.1548780184904;
 Tue, 29 Jan 2019 08:43:04 -0800 (PST)
Date:   Tue, 29 Jan 2019 08:43:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1ac2805809b7cf6@google.com>
Subject: WARNING in __flush_work
From:   syzbot <syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    39ad1c1b6bb8 Add linux-next specific files for 20190129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=135e382f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=ba2a929dcf8e704c180e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cc2298c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176c96ef400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 3472 at kernel/workqueue.c:2911  
__flush_work+0x880/0xa60 kernel/workqueue.c:2911
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3472 Comm: kworker/1:2 Not tainted 5.0.0-rc4-next-20190129 #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: md_misc mddev_delayed_delete
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__flush_work+0x880/0xa60 kernel/workqueue.c:2911
Code: 74 58 e8 93 54 2e 00 fb 66 0f 1f 44 00 00 45 31 e4 e9 7d fd ff ff e8  
7f 54 2e 00 0f 0b 45 31 e4 e9 6e fd ff ff e8 70 54 2e 00 <0f> 0b 45 31 e4  
e9 5f fd ff ff e8 61 54 2e 00 4c 89 ff 45 31 e4 e8
RSP: 0018:ffff88809acb7558 EFLAGS: 00010293
RAX: ffff88809acc4580 RBX: ffff88809acb76e8 RCX: ffffffff8153bde9
RDX: 0000000000000000 RSI: ffffffff8153c5c0 RDI: 0000000000000001
RBP: ffff88809acb7710 R08: ffff88809acc4580 R09: ffff88809acc4e48
R10: ffff88809acc4580 R11: 0000000000000000 R12: ffff88809dd24628
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000001
  __cancel_work_timer+0x48d/0x810 kernel/workqueue.c:3007
  cancel_work_sync+0x18/0x20 kernel/workqueue.c:3043
  blk_sync_queue+0x33/0x190 block/blk-core.c:234
  blk_cleanup_queue+0x100/0x200 block/blk-core.c:367
  md_free+0xcb/0x1b0 drivers/md/md.c:5215
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  mddev_delayed_delete+0x34/0x40 drivers/md/md.c:5243
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
