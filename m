Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC97C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E91821B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBKRHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:07:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:40078 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfBKRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:07:04 -0500
Received: by mail-it1-f197.google.com with SMTP id 135so21642888itk.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/EhU+OIX75I087Lx3z1ppxFRbVl25KXxvfpamY5coQw=;
        b=PA9GxS0dsQi6ZQJRUI0lYF6yz22kV3teu137xGGBSbojKtHrbXpJnlDD6GeCbubEZY
         3jHVZh5t90gJW7blhZzTnM0EvPjEDyo6XkUbu940vWXQlmm18udrRLXSynLl2DsbzMq+
         K9u2kJyX0iMIQX5xRfAYFFuj3szjjDKrzDFhhccYIXS3lKfE3FZX0vHYJ7Yzk+s90hpC
         gO4mqwlRw30uf7/ZLoJN8WzZ+OJJlm1qYofY276iiv7ypMbZKgbYHvayo9vJxk+90caU
         VhSJem2uIyQEJbR4jDlN4c8L6Fyn1VCgtlsvTRhkxFuCI8K+jZyT4ObCsYyRDuRSYQri
         t6mw==
X-Gm-Message-State: AHQUAuZOlX2lkcUCP7K6grs5in1KR+qDvZHH/Xwp8FcBLqb8dntLk8MD
        tgo+iLub/c3Tj16XUENFEwED8fw0n5Z6m1ox6EyX3G1O8Kga
X-Google-Smtp-Source: AHgI3IbJFuatCgHrHMjlq1a5Kb8dKcLrywE5j6K+5ehV3kfrzbjZmSDmnHcx+o7cfkXZydOQ1RhDkG9j3SNVGAZ4g3lc44SDMmAv
MIME-Version: 1.0
X-Received: by 2002:a24:a945:: with SMTP id x5mr340102iti.26.1549904823006;
 Mon, 11 Feb 2019 09:07:03 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:07:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006941590581a15637@google.com>
Subject: INFO: trying to register non-static key in hci_uart_flush
From:   syzbot <syzbot+e8cd9d8b4dfedf394390@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    df3865f8f568 Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11274624c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=e8cd9d8b4dfedf394390
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8cd9d8b4dfedf394390@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
kobject: 'sit0' (00000000268f641e): kobject_add_internal: parent: 'net',  
set: 'devices'
turning off the locking correctness validator.
CPU: 1 PID: 19154 Comm: syz-executor.5 Not tainted 5.0.0-rc5+ #66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:731 [inline]
  register_lock_class+0x1bdc/0x1bf0 kernel/locking/lockdep.c:757
kobject: 'sit0' (00000000268f641e): kobject_uevent_env
kobject: 'sit0' (00000000268f641e): fill_kobj_path: path  
= '/devices/virtual/net/sit0'
  __lock_acquire+0x11f/0x4700 kernel/locking/lockdep.c:3224
kobject: 'queues' (000000008049d3e4): kobject_add_internal: parent: 'sit0',  
set: '<NULL>'
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
kobject: 'queues' (000000008049d3e4): kobject_uevent_env
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  hci_uart_flush+0x110/0x3f0 drivers/bluetooth/hci_ldisc.c:248
kobject: 'queues' (000000008049d3e4): kobject_uevent_env: filter function  
caused the event to drop!
  hci_uart_close drivers/bluetooth/hci_ldisc.c:274 [inline]
  hci_uart_tty_close+0x8e/0x260 drivers/bluetooth/hci_ldisc.c:528
  tty_ldisc_close.isra.0+0x100/0x180 drivers/tty/tty_ldisc.c:485
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:633
  tty_ldisc_release+0xc6/0x280 drivers/tty/tty_ldisc.c:805
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1610
  tty_release+0xbce/0xe90 drivers/tty/tty_io.c:1783
  __fput+0x2df/0x8d0 fs/file_table.c:278
kobject: 'rx-0' (00000000542b41ce): kobject_add_internal: parent: 'queues',  
set: 'queues'
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  get_signal+0x1969/0x1d60 kernel/signal.c:2388
kobject: 'rx-0' (00000000542b41ce): kobject_uevent_env
kobject: 'rx-0' (00000000542b41ce): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/rx-0'
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
kobject: 'tx-0' (0000000073d51d99): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000073d51d99): kobject_uevent_env
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
kobject: 'tx-0' (0000000073d51d99): fill_kobj_path: path  
= '/devices/virtual/net/sit0/queues/tx-0'
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6abc510c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kobject: 'ip6tnl0' (00000000dd9201d6): kobject_add_internal: parent: 'net',  
set: 'devices'
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000009 RSI: 00000000400455c8 RDI: 0000000000000005
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6abc5116d4
R13: 00000000004c06ce R14: 00000000004d2338 R15: 00000000ffffffff
kobject: 'ip6tnl0' (00000000dd9201d6): kobject_uevent_env
kobject: 'loop1' (0000000056803190): kobject_uevent_env
kobject: 'loop1' (0000000056803190): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'ip6tnl0' (00000000dd9201d6): fill_kobj_path: path  
= '/devices/virtual/net/ip6tnl0'
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 19154 Comm: syz-executor.5 Not tainted 5.0.0-rc5+ #66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x620 kernel/sched/wait.c:85
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 69 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 12 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff88808d02f768 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888052f6eb78 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffffffff12b951f RDI: 0000000000000000
RBP: ffff88808d02f7c0 R08: ffffffffffffffe8 R09: ffff88808d02f818
R10: ffffed1011a05ee6 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f6abc511700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fede4724000 CR3: 00000000587d0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_common_lock+0xe9/0x190 kernel/sched/wait.c:121
  __wake_up+0xe/0x10 kernel/sched/wait.c:145
  rcu_sync_enter+0x193/0x310 kernel/rcu/sync.c:132
  percpu_down_write+0x61/0x440 kernel/locking/percpu-rwsem.c:143
  hci_uart_tty_close+0x13a/0x260 drivers/bluetooth/hci_ldisc.c:531
  tty_ldisc_close.isra.0+0x100/0x180 drivers/tty/tty_ldisc.c:485
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:633
  tty_ldisc_release+0xc6/0x280 drivers/tty/tty_ldisc.c:805
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1610
  tty_release+0xbce/0xe90 drivers/tty/tty_io.c:1783
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  get_signal+0x1969/0x1d60 kernel/signal.c:2388
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6abc510c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000009 RSI: 00000000400455c8 RDI: 0000000000000005
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6abc5116d4
R13: 00000000004c06ce R14: 00000000004d2338 R15: 00000000ffffffff
Modules linked in:
---[ end trace 3e8fad1d5cab0c4e ]---
RIP: 0010:__wake_up_common+0xdf/0x620 kernel/sched/wait.c:85
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 69 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 12 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff88808d02f768 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888052f6eb78 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffffffff12b951f RDI: 0000000000000000
RBP: ffff88808d02f7c0 R08: ffffffffffffffe8 R09: ffff88808d02f818
R10: ffffed1011a05ee6 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f6abc511700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fede4724000 CR3: 00000000587d0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
