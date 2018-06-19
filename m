Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C3C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EA620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EA620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeFSXtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:49:06 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:53920 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:49:03 -0400
Received: by mail-it0-f69.google.com with SMTP id 189-v6so1454819ito.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GulACMzrMrpcKr1n1ttVHz/bwVTtx5L2zdGYGj/0TMw=;
        b=qOAh+sBpyMIXczNfNoz1JgriumxjfEjz0IdJBaH53XRWlWojyAEKXiBc1HTcBJDlBe
         MNPop5cqoLZIKBSgv/3wyg2eu+KW5rXM0jXr6JJF/MqP77L9HRZS4xkxV5ZpsHkyuMCC
         OJ+MakRoQ7RP8YcAOa5j5dLWGt5vBRvw9sXsE66LqvamBUhSfE/TbjXNbB9VudBL7GV0
         +PEBrD0TlomtnFxWQRiI3/d+4uJh1DBvoxgVhVe5f1OFrNc9eW/cxwDMgSK5edLwlmZX
         oWfHorCJtIkB1jht44Wg/s8OHJPMsgmaExjpXfaRT0nHPxNC1jMZI4hIWXmBrrg56ekS
         27xQ==
X-Gm-Message-State: APt69E0ePpegcvp60Aw/b2hmWfPikTwoYjOuci/mDmNrFyHPS8+UWuU4
        U21dgf+6EpciRsnqUmHt5XdCZZcbHK3J6DKoK9wcPiPEf1ds
X-Google-Smtp-Source: ADUXVKKFRwbJXCUCKL//8Wjgp0/T16gHa/bONZx0fSTzkcKz6ffTYVImOLpac1ZArp/sI7Hxs4g55EwS5pkPfe+t5oyMAxgrDO7H
MIME-Version: 1.0
X-Received: by 2002:a5e:c905:: with SMTP id z5-v6mr7132327iol.133.1529452142430;
 Tue, 19 Jun 2018 16:49:02 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:49:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a69712056f07536c@google.com>
Subject: BUG: soft lockup in __process_echoes
From:   syzbot <syzbot+76a38d85b4b33335777c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/klei..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1583fc5f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
dashboard link: https://syzkaller.appspot.com/bug?extid=76a38d85b4b33335777c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=106007d8400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c42930400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76a38d85b4b33335777c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
watchdog: BUG: soft lockup - CPU#1 stuck for 135s! [kworker/u4:4:656]
Modules linked in:
irq event stamp: 951694
hardirqs last  enabled at (951693): [<ffffffff87a009d5>]  
restore_regs_and_return_to_kernel+0x0/0x2b
hardirqs last disabled at (951694): [<ffffffff87a00905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (725832): [<ffffffff87c00780>]  
__do_softirq+0x780/0xb17 kernel/softirq.c:310
softirqs last disabled at (725765): [<ffffffff81491e21>] invoke_softirq  
kernel/softirq.c:364 [inline]
softirqs last disabled at (725765): [<ffffffff81491e21>]  
irq_exit+0x1d1/0x200 kernel/softirq.c:404
CPU: 1 PID: 656 Comm: kworker/u4:4 Not tainted 4.18.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:write_comp_data+0x6d/0x70 kernel/kcov.c:146
Code: 00 4e 8d 14 dd 28 00 00 00 4d 39 d0 72 1b 49 83 c1 01 4a 89 7c 10 e0  
4a 89 74 10 e8 4a 89 54 10 f0 4a 89 4c d8 20 4c 89 08 5d <c3> 66 90 55 65  
48 8b 04 25 40 ee 01 00 65 8b 15 1f 43 86 7e 48 89
RSP: 0018:ffff8801d801f230 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000267eb5e47 RCX: ffffffff83a40d07
RDX: fffffffd9814b7b2 RSI: 0000000000000edf RDI: 0000000000000007
RBP: ffff8801d801f238 R08: ffff8801d80101c0 R09: 0000000000000006
R10: ffff8801d80101c0 R11: 0000000000000000 R12: ffffc90001e68000
R13: 00000000000015f9 R14: fffffffd9814b7b2 R15: 00000000000000ff
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54f2c5de78 CR3: 00000001ae0aa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __process_echoes+0x277/0x8d0 drivers/tty/n_tty.c:731
  commit_echoes+0x163/0x1d0 drivers/tty/n_tty.c:764
  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x205b/0x2c60 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x115/0x180 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3fd/0x570 drivers/tty/tty_buffer.c:524
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4536 Comm: kworker/u4:11 Not tainted 4.18.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x11/0x20 kernel/kcov.c:173
Code: bf 06 00 00 00 48 89 e5 48 8b 4d 08 e8 c8 fe ff ff 5d c3 66 0f 1f 44  
00 00 55 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 48 89 e5 <48> 8b 4d 08 e8  
a6 fe ff ff 5d c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7
RSP: 0018:ffff8801c8747238 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000000026d68de61 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000082 RDI: 0000000000000001
RBP: ffff8801c8747238 R08: ffff8801ae296140 R09: 0000000000000006
R10: ffff8801ae296140 R11: 0000000000000000 R12: ffffc90001e50000
R13: 00000000000019f9 R14: 0000000000000000 R15: 00000000000000ff
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54f2d02e78 CR3: 00000001ae0aa000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __process_echoes+0x249/0x8d0 drivers/tty/n_tty.c:733
  commit_echoes+0x163/0x1d0 drivers/tty/n_tty.c:764
  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x205b/0x2c60 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x115/0x180 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3fd/0x570 drivers/tty/tty_buffer.c:524
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
