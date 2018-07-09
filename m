Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B31C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28F6208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28F6208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeGIF4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:56:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:60238 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeGIF4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:56:03 -0400
Received: by mail-it0-f69.google.com with SMTP id r131-v6so14837035ith.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5zbyzgL5aJ6dkRsHUVw9gFiRjZrTYQK7Uel3Uf6TPu0=;
        b=CwNhb9lTPhjWD/2E9FtrB5HneBbz7/XfY347yt+P+9NMVRngXnyFTd/2bo6+KFELLj
         H20B+QdcDGmwPb4Z6xnpQQhAalXpszBNFSpQwFBFtOXTzOM6Y4ZWWK3CjrA1E2+yelet
         7pzrm8qKAG9S5C84zF+dS49IgzW98cAEt3MwXE5JB4uAvCD9ibOFfKoAa/VzAYldveNp
         ef7R3s2pHoqGA7K6LrG9unZIu6ND8wnzLkm6u3J72Dq88Bp6aRXA0r943MsWX+waj1hQ
         snBcLmc9c8SUTpvFA2/EU6nr8e5iUNjeePRYnCT18tNFIEuQh2uIkoaaU/qKz964FMlp
         0HJA==
X-Gm-Message-State: APt69E0UEdS/CIImAWoYoPZbj6fVdBQXFLHGX5i4r12x2ZJWDcx8dIiE
        hDokSe6630osfy9s7bn9NfrGq/q2ShpqL+rNaV25Ehja865O
X-Google-Smtp-Source: AAOMgpf8aRoxYYHzqfLXAvAEWsgG+pnyWg+xwbIrnkjl6+pbH/D5OeFt/v4/zAhpcXIi9AgF3TJG+mp5zs/6lnEVRKlzD9pgZpys
MIME-Version: 1.0
X-Received: by 2002:a24:14d3:: with SMTP id 202-v6mr8011229itg.50.1531115762670;
 Sun, 08 Jul 2018 22:56:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 22:56:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024f01405708aab83@google.com>
Subject: WARNING: ODEBUG bug in p9_fd_close
From:   syzbot <syzbot+d702a81aadeedd565723@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1360fafc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=d702a81aadeedd565723
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=153562e0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d702a81aadeedd565723@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint:  
p9_read_work+0x0/0x1060 net/9p/trans_fd.c:208
WARNING: CPU: 0 PID: 6655 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6655 Comm: syz-executor6 Not tainted 4.18.0-rc3+ #40
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
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 1a 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
20 71 1a 88 4c 89 f6 48 c7 c7 c0 66 1a 88 e8 c6 94 e6 fd <0f> 0b 83 05 d9  
66 3e 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8801b893f298 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801b893f2d8 R08: ffff8801b6ff0200 R09: ffffed003b5c3ec2
R10: ffffed003b5c3ec2 R11: ffff8801dae1f617 R12: 0000000000000001
R13: ffffffff88f63820 R14: ffffffff881a6b60 R15: ffffffff814ea9c0
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
  kfree+0xc7/0x260 mm/slab.c:3812
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fa5cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f800ac EFLAGS: 00000282 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000020000f00
RDX: 0000000020000f40 RSI: 0000000000000000 RDI: 0000000020000fc0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc3+ #40 Not tainted
------------------------------------------------------
syz-executor6/6655 is trying to acquire lock:
(____ptrval____) ((console_sem).lock){-...}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
(____ptrval____) (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:774 [inline]
(____ptrval____) (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:815

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        __debug_object_init+0x127/0x12e0 lib/debugobjects.c:381
        debug_object_init+0x16/0x20 lib/debugobjects.c:429
        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
        debug_init kernel/time/hrtimer.c:458 [inline]
        hrtimer_init+0x97/0x480 kernel/time/hrtimer.c:1308
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1056
        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2185
        init_idle+0x75/0x7a0 kernel/sched/core.c:5405
        sched_init+0xbf3/0xd2c kernel/sched/core.c:6103
        start_kernel+0x47d/0x949 init/main.c:602
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1812 [inline]
        task_fork_fair+0x93/0x680 kernel/sched/fair.c:9952
        sched_fork+0x446/0xb40 kernel/sched/core.c:2381
        copy_process.part.39+0x1c09/0x7220 kernel/fork.c:1773
        copy_process kernel/fork.c:1616 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2099
        kernel_thread+0x34/0x40 kernel/fork.c:2158
        rest_init+0x22/0xe4 init/main.c:408
        start_kernel+0x90e/0x949 init/main.c:738
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xd2/0x12b0 kernel/sched/core.c:1985
        wake_up_process+0x10/0x20 kernel/sched/core.c:2148
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7a2/0x10b0 kernel/printk/printk.c:2411
        do_con_write+0x12cc/0x22a0 drivers/tty/vt/vt.c:2435
        con_write+0x25/0xc0 drivers/tty/vt/vt.c:2784
        process_output_block drivers/tty/n_tty.c:580 [inline]
        n_tty_write+0x6c1/0x11a0 drivers/tty/n_tty.c:2317
        do_tty_write drivers/tty/tty_io.c:963 [inline]
        tty_write+0x45f/0xae0 drivers/tty/tty_io.c:1051
        __vfs_write+0x117/0x9f0 fs/read_write.c:485
        vfs_write+0x1f8/0x560 fs/read_write.c:549
        ksys_write+0x101/0x260 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-...}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
        vprintk_emit+0x6ad/0xdf0 kernel/printk/printk.c:1906
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
        printk+0xa7/0xcf kernel/printk/printk.c:1981
        __warn_printk+0x8c/0xe0 kernel/panic.c:590
        debug_print_object+0x16a/0x210 lib/debugobjects.c:326
        __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
        debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
        kfree+0xc7/0x260 mm/slab.c:3812
        p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
        p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
        v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
        v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
        mount_fs+0xae/0x328 fs/super.c:1277
        vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
        vfs_kern_mount fs/namespace.c:1027 [inline]
        do_new_mount fs/namespace.c:2518 [inline]
        do_mount+0x581/0x30e0 fs/namespace.c:2848
        __do_compat_sys_mount fs/compat.c:125 [inline]
        __se_compat_sys_mount fs/compat.c:92 [inline]
        __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
        do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
        do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &rq->lock --> &obj_hash[i].lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&obj_hash[i].lock);
                                lock(&rq->lock);
                                lock(&obj_hash[i].lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

1 lock held by syz-executor6/6655:
  #0: (____ptrval____) (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
  #0: (____ptrval____) (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:815

stack backtrace:
CPU: 0 PID: 6655 Comm: syz-executor6 Not tainted 4.18.0-rc3+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.57+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
  vprintk_emit+0x6ad/0xdf0 kernel/printk/printk.c:1906
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
  printk+0xa7/0xcf kernel/printk/printk.c:1981
  __warn_printk+0x8c/0xe0 kernel/panic.c:590
  debug_print_object+0x16a/0x210 lib/debugobjects.c:326
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
  kfree+0xc7/0x260 mm/slab.c:3812
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fa5cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f800ac EFLAGS: 00000282 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000020000f00
RDX: 0000000020000f40 RSI: 0000000000000000 RDI: 0000000020000fc0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Shutting down cpus with NMI
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
