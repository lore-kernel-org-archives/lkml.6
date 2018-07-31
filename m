Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A5C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283CB20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283CB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGaOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:11:11 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:59220 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbeGaOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:11:10 -0400
Received: by mail-it0-f70.google.com with SMTP id y13-v6so2463686ita.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+1glQ6ZSX7Jo49REiKd95sABTvq1Pchq0LvbEV52uKg=;
        b=tioFK9QIy9+IYCm/+CSpV9BIutKfZPK7AowkNnWvleDUaVstrJwIZUXfTYNu79OmyT
         2KTjHVvBKDl09LZKifLG7Lw1Eqao5QT6p/KZSNZgJ3sFIjq976cSekAT1OhpH8K51+Pt
         cxE0f6VZ7h9V2KDCXgfdZfcSWF3s7tOcTw4knSaYRV1qPA2VNTw2bH/KWH8fWzzwGV63
         ekED6cQ1U1/FuX8Ve1Jqj7XwOb3ljBXxkg+IO9pkpY5hVGliH0SxtXQtX7OXN+9knT1u
         0iOuWDtDiWnmV3iLxqot/74nnGIlhCtK539oI9ubDbCbvIHzXdq7Uv/mjgzoN5cqU0QS
         HhHw==
X-Gm-Message-State: AOUpUlHhLHitLf35whpiRWLaNyB0ZHRHFsxEb8Op87eMzMAwM2zSoRln
        1p8KBFdcjnTsw8SEaPiOwGMnErSotmzWAg/v6+CKj+3tAuCu
X-Google-Smtp-Source: AAOMgpfm1WnGfsONFmCQUA2AxDv5lLN7ZOZHujlbe0bUOzWkg5GPC4Po/Ohi8EGo+cGV9IVQ7SyqU5RlfMYWMPyjF2RjMIdniU2y
MIME-Version: 1.0
X-Received: by 2002:a6b:fa07:: with SMTP id p7-v6mr7517172ioh.46.1533040263344;
 Tue, 31 Jul 2018 05:31:03 -0700 (PDT)
Date:   Tue, 31 Jul 2018 05:31:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052bc9805724ac083@google.com>
Subject: WARNING: ODEBUG bug in enqueue_hrtimer
From:   syzbot <syzbot+3c31c6798616dc2d9ee6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    527838d470e3 Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e90362400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=3c31c6798616dc2d9ee6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3c31c6798616dc2d9ee6@syzkaller.appspotmail.com

netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor3'.
------------[ cut here ]------------
ODEBUG: activate not available (active state 0) object type: hrtimer hint:  
bcm_tx_timeout_handler+0x0/0x60 net/can/bcm.c:241
WARNING: CPU: 1 PID: 18 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.18.0-rc7+ #170
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
RSP: 0018:ffff8801d9f27680 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: 0000000000000100 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff8801d9f276c0 R08: ffff8801d9f0c4c0 R09: ffffed003b623ec2
R10: ffffed003b623ec2 R11: ffff8801db11f617 R12: 0000000000000001
R13: ffffffff87fa0660 R14: ffffffff873a7040 R15: ffffffff816a48f0
  debug_object_activate+0x359/0x690 lib/debugobjects.c:513
  debug_hrtimer_activate kernel/time/hrtimer.c:416 [inline]
  debug_activate kernel/time/hrtimer.c:465 [inline]
  enqueue_hrtimer+0x9e/0x540 kernel/time/hrtimer.c:954
  __hrtimer_start_range_ns kernel/time/hrtimer.c:1089 [inline]
  hrtimer_start_range_ns+0x616/0xd20 kernel/time/hrtimer.c:1115
  hrtimer_start include/linux/hrtimer.h:398 [inline]
  bcm_tx_start_timer+0x11d/0x1b0 net/can/bcm.c:361
  bcm_tx_timeout_tsklet+0x1ab/0x4b0 net/can/bcm.c:392
  tasklet_action_common.isra.19+0x26f/0x720 kernel/softirq.c:522
  tasklet_action+0x1d/0x20 kernel/softirq.c:540
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
  run_ksoftirqd+0x86/0x100 kernel/softirq.c:653
  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc7+ #170 Not tainted
------------------------------------------------------
ksoftirqd/1/18 is trying to acquire lock:
000000006298a4a7 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
0000000018a38b75 (hrtimer_bases.lock){-.-.}, at:  
lock_hrtimer_base.isra.18+0x75/0x130 kernel/time/hrtimer.c:174

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (hrtimer_bases.lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        lock_hrtimer_base.isra.18+0x75/0x130 kernel/time/hrtimer.c:174
        hrtimer_start_range_ns+0x128/0xd20 kernel/time/hrtimer.c:1113
        hrtimer_start_expires include/linux/hrtimer.h:412 [inline]
        start_rt_bandwidth kernel/sched/rt.c:68 [inline]
        inc_rt_group kernel/sched/rt.c:1147 [inline]
        inc_rt_tasks kernel/sched/rt.c:1191 [inline]
        __enqueue_rt_entity kernel/sched/rt.c:1261 [inline]
        enqueue_rt_entity kernel/sched/rt.c:1305 [inline]
        enqueue_task_rt+0x96a/0xfd0 kernel/sched/rt.c:1335
        enqueue_task+0xa2/0x1d0 kernel/sched/core.c:750
        __sched_setscheduler+0xe80/0x20b0 kernel/sched/core.c:4365
        _sched_setscheduler+0x20c/0x370 kernel/sched/core.c:4402
        sched_setscheduler+0xe/0x10 kernel/sched/core.c:4417
        watchdog_set_prio kernel/watchdog.c:455 [inline]
        watchdog_enable+0x12d/0x1a0 kernel/watchdog.c:477
        smpboot_thread_fn+0x4c0/0x870 kernel/smpboot.c:145
        kthread+0x345/0x410 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

-> #3 (&rt_b->rt_runtime_lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        start_rt_bandwidth kernel/sched/rt.c:56 [inline]
        inc_rt_group kernel/sched/rt.c:1147 [inline]
        inc_rt_tasks kernel/sched/rt.c:1191 [inline]
        __enqueue_rt_entity kernel/sched/rt.c:1261 [inline]
        enqueue_rt_entity kernel/sched/rt.c:1305 [inline]
        enqueue_task_rt+0x618/0xfd0 kernel/sched/rt.c:1335
        enqueue_task+0xa2/0x1d0 kernel/sched/core.c:750
        __sched_setscheduler+0xe80/0x20b0 kernel/sched/core.c:4365
        _sched_setscheduler+0x20c/0x370 kernel/sched/core.c:4402
        sched_setscheduler+0xe/0x10 kernel/sched/core.c:4417
        watchdog_set_prio kernel/watchdog.c:455 [inline]
        watchdog_enable+0x12d/0x1a0 kernel/watchdog.c:477
        smpboot_thread_fn+0x4c0/0x870 kernel/smpboot.c:145
        kthread+0x345/0x410 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

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

-> #0 ((console_sem).lock){-.-.}:
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
        debug_object_activate+0x359/0x690 lib/debugobjects.c:513
        debug_hrtimer_activate kernel/time/hrtimer.c:416 [inline]
        debug_activate kernel/time/hrtimer.c:465 [inline]
        enqueue_hrtimer+0x9e/0x540 kernel/time/hrtimer.c:954
        __hrtimer_start_range_ns kernel/time/hrtimer.c:1089 [inline]
        hrtimer_start_range_ns+0x616/0xd20 kernel/time/hrtimer.c:1115
        hrtimer_start include/linux/hrtimer.h:398 [inline]
        bcm_tx_start_timer+0x11d/0x1b0 net/can/bcm.c:361
        bcm_tx_timeout_tsklet+0x1ab/0x4b0 net/can/bcm.c:392
        tasklet_action_common.isra.19+0x26f/0x720 kernel/softirq.c:522
        tasklet_action+0x1d/0x20 kernel/softirq.c:540
        __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
        run_ksoftirqd+0x86/0x100 kernel/softirq.c:653
        smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
        kthread+0x345/0x410 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(hrtimer_bases.lock);
                                lock(&rt_b->rt_runtime_lock);
                                lock(hrtimer_bases.lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

1 lock held by ksoftirqd/1/18:
  #0: 0000000018a38b75 (hrtimer_bases.lock){-.-.}, at:  
lock_hrtimer_base.isra.18+0x75/0x130 kernel/time/hrtimer.c:174

stack backtrace:
CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.18.0-rc7+ #170
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
  debug_object_activate+0x359/0x690 lib/debugobjects.c:513
  debug_hrtimer_activate kernel/time/hrtimer.c:416 [inline]
  debug_activate kernel/time/hrtimer.c:465 [inline]
  enqueue_hrtimer+0x9e/0x540 kernel/time/hrtimer.c:954
  __hrtimer_start_range_ns kernel/time/hrtimer.c:1089 [inline]
  hrtimer_start_range_ns+0x616/0xd20 kernel/time/hrtimer.c:1115
  hrtimer_start include/linux/hrtimer.h:398 [inline]
  bcm_tx_start_timer+0x11d/0x1b0 net/can/bcm.c:361
  bcm_tx_timeout_tsklet+0x1ab/0x4b0 net/can/bcm.c:392
  tasklet_action_common.isra.19+0x26f/0x720 kernel/softirq.c:522
  tasklet_action+0x1d/0x20 kernel/softirq.c:540
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
  run_ksoftirqd+0x86/0x100 kernel/softirq.c:653
  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
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
