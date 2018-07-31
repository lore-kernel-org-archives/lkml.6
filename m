Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB671C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF79208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF79208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeGaHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:25:34 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:40435 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeGaHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:25:34 -0400
Received: by mail-it0-f70.google.com with SMTP id 136-v6so1676974itw.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 22:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZnEpbaO0MWmqVAVfzUoSKXuOKPTk+YV8Q8Wc8OLQmg4=;
        b=I/q2b/8RrDYzTfnP0iIr62dh01l9fUGeDm2uTtuaDZcMCRDg1KrYbAZjZOiNh7BMIv
         HUhFMxfLTLLAFOrPzakle06j5wCZzaK/PMka32dC8m+rfBtCOnXKFXa0JEAeXrlkTwhb
         LgCd8rlpnFr2HFmY1TxG22X8biFjzctbOXERgNPtQO2JhE3kSnni4gwdO2We/1KvJtOI
         Pmzo/KpbHMBULkVJ8AFbzCW4QfVo/iojNEKSJvy0TIWQWr5T9QU0JY0EfS1/k5HhqlJW
         gzdG/ah0eybUBLqpZaGeHFakVXezdMkr+PPf6jEn4QofCQh0xyfJtRGZCD2guUrJGaDO
         YTpQ==
X-Gm-Message-State: AOUpUlHhGIn4Nn2N0qIwLKlxxECsn96hBXaf6+spThrXKUeXTor8y1rM
        ZoxHCCs2BzDnw/fhmjX2c+n2imByafayk++ltsAIET+r8reJ
X-Google-Smtp-Source: AAOMgpfyaxTxOX0c/Hx7geRuTRkUc+pJ0ffzEiEBbFqA2zI+4pnB3Y8mO12MgtdJFCHogp5h5sq6odPslQhdv2jwltSI+Z3XE7q3
MIME-Version: 1.0
X-Received: by 2002:a24:b713:: with SMTP id h19-v6mr962100itf.28.1533016022416;
 Mon, 30 Jul 2018 22:47:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 22:47:02 -0700
In-Reply-To: <000000000000ea418a0572384417@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007388610572451b46@google.com>
Subject: Re: WARNING: ODEBUG bug in vsock_stream_connect
From:   syzbot <syzbot+8a9b1bd330476a4f3db6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvlasenk@redhat.com, jhansen@vmware.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    527838d470e3 Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160e3d78400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=8a9b1bd330476a4f3db6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15100f2c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a9b1bd330476a4f3db6@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:1414
WARNING: CPU: 1 PID: 6513 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 6513 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #73
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
Code: 3a 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
20 74 3a 87 4c 89 f6 48 c7 c7 c0 69 3a 87 e8 c6 b0 e6 fd <0f> 0b 83 05 a9  
e6 29 05 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8801b446f608 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff8801b446f648 R08: ffff8801ae066340 R09: ffffed003b623ec2
R10: ffffed003b623ec2 R11: ffff8801db11f617 R12: 0000000000000001
R13: ffffffff87f9c9e0 R14: ffffffff873a6fc0 R15: ffffffff816918a0
  __debug_object_init+0x8e9/0x12e0 lib/debugobjects.c:403
  debug_object_init+0x16/0x20 lib/debugobjects.c:429
  debug_timer_init kernel/time/timer.c:704 [inline]
  debug_init kernel/time/timer.c:757 [inline]
  init_timer_key+0xa9/0x490 kernel/time/timer.c:806
  vsock_stream_connect+0xc7a/0xfc0 net/vmw_vsock/af_vsock.c:1224
  __sys_connect+0x37d/0x4c0 net/socket.c:1673
  __do_sys_connect net/socket.c:1684 [inline]
  __se_sys_connect net/socket.c:1681 [inline]
  __ia32_sys_connect+0x72/0xb0 net/socket.c:1681
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f95cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f4e0cc EFLAGS: 00000296 ORIG_RAX: 000000000000016a
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000100
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc7+ #73 Not tainted
------------------------------------------------------
syz-executor4/6513 is trying to acquire lock:
(____ptrval____) ((console_sem).lock){-...}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
(____ptrval____) (&obj_hash[i].lock){-.-.}, at:  
__debug_object_init+0x127/0x12e0 lib/debugobjects.c:381

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
        copy_process.part.39+0x1bf5/0x70b0 kernel/fork.c:1796
        copy_process kernel/fork.c:1639 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2122
        kernel_thread+0x34/0x40 kernel/fork.c:2181
        rest_init+0x22/0xe4 init/main.c:408
        start_kernel+0x90e/0x949 init/main.c:738
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xd2/0x12a0 kernel/sched/core.c:1985
        wake_up_process+0x10/0x20 kernel/sched/core.c:2148
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7a2/0x10b0 kernel/printk/printk.c:2411
        vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
        printk+0xa7/0xcf kernel/printk/printk.c:1981
        load_umh+0x51/0xbd net/bpfilter/bpfilter_kern.c:98
        do_one_initcall+0x127/0x913 init/main.c:884
        do_initcall_level init/main.c:952 [inline]
        do_initcalls init/main.c:960 [inline]
        do_basic_setup init/main.c:978 [inline]
        kernel_init_freeable+0x49b/0x58e init/main.c:1135
        kernel_init+0x11/0x1b3 init/main.c:1061
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

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
        __debug_object_init+0x8e9/0x12e0 lib/debugobjects.c:403
        debug_object_init+0x16/0x20 lib/debugobjects.c:429
        debug_timer_init kernel/time/timer.c:704 [inline]
        debug_init kernel/time/timer.c:757 [inline]
        init_timer_key+0xa9/0x490 kernel/time/timer.c:806
        vsock_stream_connect+0xc7a/0xfc0 net/vmw_vsock/af_vsock.c:1224
        __sys_connect+0x37d/0x4c0 net/socket.c:1673
        __do_sys_connect net/socket.c:1684 [inline]
        __se_sys_connect net/socket.c:1681 [inline]
        __ia32_sys_connect+0x72/0xb0 net/socket.c:1681
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

2 locks held by syz-executor4/6513:
  #0: (____ptrval____) (sk_lock-AF_VSOCK){+.+.}, at: lock_sock  
include/net/sock.h:1474 [inline]
  #0: (____ptrval____) (sk_lock-AF_VSOCK){+.+.}, at:  
vsock_stream_connect+0x1e3/0xfc0 net/vmw_vsock/af_vsock.c:1152
  #1: (____ptrval____) (&obj_hash[i].lock){-.-.}, at:  
__debug_object_init+0x127/0x12e0 lib/debugobjects.c:381

stack backtrace:
CPU: 1 PID: 6513 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #73
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
  __debug_object_init+0x8e9/0x12e0 lib/debugobjects.c:403
  debug_object_init+0x16/0x20 lib/debugobjects.c:429
  debug_timer_init kernel/time/timer.c:704 [inline]
  debug_init kernel/time/timer.c:757 [inline]
  init_timer_key+0xa9/0x490 kernel/time/timer.c:806
  vsock_stream_connect+0xc7a/0xfc0 net/vmw_vsock/af_vsock.c:1224
  __sys_connect+0x37d/0x4c0 net/socket.c:1673
  __do_sys_connect net/socket.c:1684 [inline]
  __se_sys_connect net/socket.c:1681 [inline]
  __ia32_sys_connect+0x72/0xb0 net/socket.c:1681
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f95cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f4e0cc EFLAGS: 00000296 ORIG_RAX: 000000000000016a
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000100
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

