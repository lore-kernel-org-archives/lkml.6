Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0051C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5914F20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5914F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeJ0QtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:49:13 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37031 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeJ0QtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:49:12 -0400
Received: by mail-io1-f69.google.com with SMTP id t4-v6so3197253iof.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 01:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kAgvg+XhpyCLt9cgMxgEYTTHZgIS1+Txv3i8d9OLlqg=;
        b=lV2cUDMIadeEY2vHOSMBbGuz6xmprcnHVZTirsH6Tyxk5PhogMHpkkilgv5hm188xY
         BBGLknMQW58Xdea1uIHMl6irjdaXHCyrv8VE3TdpeTGFwLyLXV0z1b9zT1enfLB5jXPc
         ZYcftAL7N2jWAE/tRXjEVca/rFdB3pi0LYQ+DMqW6B31ktyW+VhE+AE93ZOI54uSmfdE
         Z4Mdauwn1vy22lvBUzeeYPQb3Eybq/Y7DWrmH+YsYCdUvss78j0DBgVxKw0U2UhUoDnJ
         wlpIo1bJMjSy09UL9J7q2UAC2JiBYuJLZdEkc/xSpz8hMBDR4F4BySJz0Me9ag2xhPHL
         2Lsg==
X-Gm-Message-State: AGRZ1gK6UnJIb1AxYYzfzIMenTGXLCxdbXODrEiak+nswpKGTNjeJFJI
        7AbRlbGuQnEBwF5eDrnI9mSMpU0QDQT2R9YAaw1dREE74HbA
X-Google-Smtp-Source: AJdET5dNPH1hhKAE+ldllJ9zByWJPcbN83qDKhaf1Qwl8839JI8ibyJbJByO0FjbS16XD01z8cYwC6bJIc5FG52CC5g9ZK9uFaMM
MIME-Version: 1.0
X-Received: by 2002:a24:21d6:: with SMTP id e205-v6mr2831655ita.19.1540627744301;
 Sat, 27 Oct 2018 01:09:04 -0700 (PDT)
Date:   Sat, 27 Oct 2018 01:09:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e31980579315914@google.com>
Subject: INFO: task hung in __do_page_fault (2)
From:   syzbot <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mcgrof@kernel.org, sudipm.mukherjee@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    18d0eae30e6a Merge tag 'char-misc-4.20-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d952eb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=342f43de913c81b9
dashboard link: https://syzkaller.appspot.com/bug?extid=6b074f741adbd93d2df5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12482713400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fd4a3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com

INFO: task syz-executor198:7946 blocked for more than 140 seconds.
       Not tainted 4.19.0+ #82
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor198 D23160  7946   5577 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3474
  schedule+0xfe/0x460 kernel/sched/core.c:3518
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:280 [inline]
  rwsem_down_read_failed+0x371/0x710 kernel/locking/rwsem-xadd.c:297
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0x9b/0x120 kernel/locking/rwsem.c:26
  do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
  __do_page_fault+0xbc9/0xe60 arch/x86/mm/fault.c:1489
  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1520
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1136
RIP: 0033:0x4ab5dd
Code: Bad RIP value.
RSP: 002b:00007ffe4b4dd2c0 EFLAGS: 00010202
RAX: 00000000004ab700 RBX: 0000000000000001 RCX: 00000000006e0350
RDX: 00000000004073b0 RSI: 0000000000000000 RDI: 00000000004cc9d0
RBP: 00007ffe4b4dd2e0 R08: 000000037ffffa00 R09: 000000037ffffa00
R10: 00007ffe4b4dd350 R11: 0000000000000000 R12: 0000000000000001
R13: 00000000006e0340 R14: 0000000000000008 R15: 00000000006dbd4c
INFO: task syz-executor198:7947 blocked for more than 140 seconds.
       Not tainted 4.19.0+ #82
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor198 D23400  7947   5577 0x80000004
Call Trace:
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3474
  schedule+0xfe/0x460 kernel/sched/core.c:3518
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:280 [inline]
  rwsem_down_read_failed+0x371/0x710 kernel/locking/rwsem-xadd.c:297
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0x9b/0x120 kernel/locking/rwsem.c:26
  exit_mm kernel/exit.c:511 [inline]
  do_exit+0x59c/0x26d0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446569
Code: 63 65 20 69 73 20 65 6d 70 74 79 2c 20 79 6f 75 20 6d 61 79 20 77 61  
6e 74 20 74 6f 20 2e 2f 63 6f 6e 66 69 67 75 72 65 20 2d <2d> 65 6e 61 62  
6c 65 2d 72 74 69 6e 73 74 0a 00 00 00 00 00 00 00
RSP: 002b:00007f8ad1b55db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dbc48 RCX: 0000000000446569
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc48
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 00007ffe4b4dd2bf R14: 00007f8ad1b569c0 R15: 00000000006dbd4c
INFO: task syz-executor198:7948 blocked for more than 140 seconds.
       Not tainted 4.19.0+ #82
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor198 D23336  7948   5577 0x80000004
Call Trace:
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3474
  schedule+0xfe/0x460 kernel/sched/core.c:3518
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:280 [inline]
  rwsem_down_read_failed+0x371/0x710 kernel/locking/rwsem-xadd.c:297
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0x9b/0x120 kernel/locking/rwsem.c:26
  exit_mm kernel/exit.c:511 [inline]
  do_exit+0x59c/0x26d0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446569
Code: 63 65 20 69 73 20 65 6d 70 74 79 2c 20 79 6f 75 20 6d 61 79 20 77 61  
6e 74 20 74 6f 20 2e 2f 63 6f 6e 66 69 67 75 72 65 20 2d <2d> 65 6e 61 62  
6c 65 2d 72 74 69 6e 73 74 0a 00 00 00 00 00 00 00
RSP: 002b:00007f8ad1b34db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dbc58 RCX: 0000000000446569
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc58
RBP: 00000000006dbc50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007ffe4b4dd2bf R14: 00007f8ad1b359c0 R15: 00000000006dbd4c

Showing all locks held in the system:
1 lock held by khungtaskd/982:
  #0: 000000006bf8e029 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
1 lock held by rsyslogd/5460:
  #0: 000000001a428f24 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5550:
  #0: 00000000a6ec9e30 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000000ba6ebb5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5551:
  #0: 000000001c296eea (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000008d7c7477 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5552:
  #0: 00000000e6d3c5fa (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000008f05095b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5553:
  #0: 00000000a51f4685 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000007d588b0b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5554:
  #0: 0000000011c5a9cb (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000034232836 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5555:
  #0: 00000000a3089d9b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000002c7368ab (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5556:
  #0: 00000000e9383a5f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000a5ba37f2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
1 lock held by syz-executor198/7946:
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at: do_user_addr_fault  
arch/x86/mm/fault.c:1362 [inline]
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at:  
__do_page_fault+0xbc9/0xe60 arch/x86/mm/fault.c:1489
1 lock held by syz-executor198/7947:
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at: exit_mm kernel/exit.c:511  
[inline]
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at: do_exit+0x59c/0x26d0  
kernel/exit.c:854
1 lock held by syz-executor198/7948:
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at: exit_mm kernel/exit.c:511  
[inline]
  #0: 000000000d212cc7 (&mm->mmap_sem){++++}, at: do_exit+0x59c/0x26d0  
kernel/exit.c:854
1 lock held by syz-executor198/7949:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 982 Comm: khungtaskd Not tainted 4.19.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.1+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb3e/0x1050 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.430  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 7949 Comm: syz-executor198 Not tainted 4.19.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x44b/0x4c20 kernel/locking/lockdep.c:3291
Code: 83 e2 03 83 e0 01 41 09 f6 c1 e0 02 45 88 77 21 83 e1 f8 09 d1 09 c1  
83 e1 f7 44 09 c9 41 88 4f 22 0f b7 55 20 41 0f b7 47 22 <c1> e2 04 83 e0  
0f 09 d0 48 89 fa 66 41 89 47 22 48 c1 ea 03 48 b8
RSP: 0018:ffff8801b88aec90 EFLAGS: 00000002
RAX: 0000000000000004 RBX: 00000000000004e1 RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8801cd5dae8c
RBP: ffff8801b88af018 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000028 R11: ffff8801cd5da5c0 R12: 0000000000000001
R13: ffff8801cd5dae2c R14: 0000000000000004 R15: ffff8801cd5dae68
FS:  00007f8ad1b14700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001b8962000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  perf_mmap+0x86b/0x1cb0 kernel/events/core.c:5646
  call_mmap include/linux/fs.h:1813 [inline]
  mmap_region+0xe82/0x1cd0 mm/mmap.c:1762
  do_mmap+0xa22/0x1230 mm/mmap.c:1535
  do_mmap_pgoff include/linux/mm.h:2316 [inline]
  vm_mmap_pgoff+0x213/0x2c0 mm/util.c:350
  ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446569
Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8ad1b13da8 EFLAGS: 00000216 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000006dbc68 RCX: 0000000000446569
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00000000006dbc60 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000216 R12: 00000000006dbc6c
R13: 00007ffe4b4dd2bf R14: 00007f8ad1b149c0 R15: 00000000006dbd4c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
