Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4566C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7002220828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeLaUpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:45:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:57084 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeLaUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 15:45:04 -0500
Received: by mail-io1-f72.google.com with SMTP id x2so32125558ioa.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 12:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/cYfCndD854JJu74ObDxBORrkjFrqipy3e3fvpE4fQk=;
        b=iGSOxxc4SAnsP1drx2q8Dx+6zcInvVbKIYrBeXISfd7bSVPvA9GwcYooFpT01SJI/w
         A0k6zJqFh4yL039dpcLzGGMyvXJ5EFAYrlx7C80A20H8hv5ylaUV4EzYK2p3gbFiuQRj
         +PVeFMHIO54k9Go4hpH07C5+0xBusQbphlxv238akuY5bsQOwrDq0qR6LcMfZIHd3FXv
         p1Hw4nf6ihIcgqUnDSyaMxPDFeJugshWH71qN3Ua4YGv88FKjjpxvTOq/IVWixi0B2na
         G6AuN1NnJpnWZhYHRC2pwGWldqFMEVtw3CjUOEfv/l9t1uMRhnLEPmKzIXlA2NV+6rOS
         Bohw==
X-Gm-Message-State: AA+aEWbyg4nxC8flDjkC3jmTa1GzRXMy7etMmgiJt3tFqnaBUEFVC1Jg
        9eKkMjK9SOD1CCkp4s0DnKu0eaWQv8JIeGE4UaKGqnvOeLq1
X-Google-Smtp-Source: AFSGD/VP3HyjcFmxO1dXeghO+mwVUap9CcgWxx82CIBgNtsX52pIrzeq5oEo3wengFrrXrmcPO01jDxo1AbKOy5m5EGx5GU15wBp
MIME-Version: 1.0
X-Received: by 2002:a02:77c2:: with SMTP id g185mr30353714jac.9.1546289103540;
 Mon, 31 Dec 2018 12:45:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 12:45:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc9ddf057e577c98@google.com>
Subject: WARNING: ODEBUG bug in netdev_freemem
From:   syzbot <syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        davem@davemloft.net, decot@googlers.com, dmitry.torokhov@gmail.com,
        jeffrey.t.kirsher@intel.com, joe@perches.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fc2fd5f0f1aa Merge branch 'x86-platform-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172a9e53400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a98287508be3ff9
dashboard link: https://syzkaller.appspot.com/bug?extid=979ffc89b87309b1b94b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com

bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:4916
WARNING: CPU: 1 PID: 26336 at lib/debugobjects.c:328  
debug_print_object+0x16a/0x210 lib/debugobjects.c:325
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 26336 Comm: kworker/u4:3 Not tainted 4.20.0+ #391
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:325
Code: 80 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
a0 f1 80 88 4c 89 fe 48 c7 c7 40 e7 80 88 e8 76 ea b8 fd <0f> 0b 83 05 01  
3b a7 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff888026fdee48 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165c255 RDI: 0000000000000005
RBP: ffff888026fdee88 R08: ffff888027f762c0 R09: ffffed1015ce3ef8
R10: ffffed1015ce3ef8 R11: ffff8880ae71f7c7 R12: 0000000000000001
R13: ffffffff897a5ce0 R14: ffffffff816c1a80 R15: ffffffff8880ebe0
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3816
  kvfree+0x61/0x70 mm/util.c:445
  netdev_freemem+0x4c/0x60 net/core/dev.c:8903
  netdev_release+0x121/0x180 net/core/net-sysfs.c:1640
  device_release+0x7e/0x210 drivers/base/core.c:912
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  netdev_run_todo+0x715/0xa60 net/core/dev.c:8808
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  default_device_exit_batch+0x43f/0x540 net/core/dev.c:9589
  ops_exit_list.isra.5+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #391 Not tainted
------------------------------------------------------
kworker/u4:3/26336 is trying to acquire lock:
00000000d2979eea ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000002d00477d (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:776 [inline]
000000002d00477d (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:817

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        __debug_object_init+0x127/0x1290 lib/debugobjects.c:383
        debug_object_init+0x16/0x20 lib/debugobjects.c:431
        debug_hrtimer_init kernel/time/hrtimer.c:401 [inline]
        debug_init kernel/time/hrtimer.c:449 [inline]
        hrtimer_init+0x97/0x490 kernel/time/hrtimer.c:1299
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2166
        init_idle+0x75/0x6d0 kernel/sched/core.c:5374
        sched_init+0xb33/0xc07 kernel/sched/core.c:6063
        start_kernel+0x448/0x8ae init/main.c:608
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1149 [inline]
        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:10083
        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
        copy_process+0x25b9/0x8790 kernel/fork.c:1892
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2221
        kernel_thread+0x34/0x40 kernel/fork.c:2280
        rest_init+0x28/0x372 init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x873/0x8ae init/main.c:741
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xdc/0x1460 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
        console_unlock+0x811/0x1180 kernel/printk/printk.c:2432
        vprintk_emit+0x39c/0x990 kernel/printk/printk.c:1922
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        check_stack_usage kernel/exit.c:755 [inline]
        do_exit.cold.19+0x57/0x16f kernel/exit.c:916
        do_group_exit+0x177/0x440 kernel/exit.c:970
        __do_sys_exit_group kernel/exit.c:981 [inline]
        __se_sys_exit_group kernel/exit.c:979 [inline]
        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3841
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
        console_trylock_spinning kernel/printk/printk.c:1653 [inline]
        vprintk_emit+0x37d/0x990 kernel/printk/printk.c:1921
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        __warn_printk+0x8c/0xe0 kernel/panic.c:594
        debug_print_object+0x16a/0x210 lib/debugobjects.c:325
        __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
        debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
        kfree+0xbd/0x230 mm/slab.c:3816
        kvfree+0x61/0x70 mm/util.c:445
        netdev_freemem+0x4c/0x60 net/core/dev.c:8903
        netdev_release+0x121/0x180 net/core/net-sysfs.c:1640
        device_release+0x7e/0x210 drivers/base/core.c:912
        kobject_cleanup lib/kobject.c:662 [inline]
        kobject_release lib/kobject.c:691 [inline]
        kref_put include/linux/kref.h:70 [inline]
        kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
        netdev_run_todo+0x715/0xa60 net/core/dev.c:8808
        rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
        default_device_exit_batch+0x43f/0x540 net/core/dev.c:9589
        ops_exit_list.isra.5+0x105/0x160 net/core/net_namespace.c:156
        cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
        process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
        worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
        kthread+0x35a/0x440 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

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

4 locks held by kworker/u4:3/26336:
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at:  
__write_once_size include/linux/compiler.h:218 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000078b99b2d ((wq_completion)"%s""netns"){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 00000000220ca606 (net_cleanup_work){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128
  #2: 00000000e946b6ef (pernet_ops_rwsem){++++}, at: cleanup_net+0x13f/0xb10  
net/core/net_namespace.c:518
  #3: 000000002d00477d (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:776 [inline]
  #3: 000000002d00477d (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:817

stack backtrace:
CPU: 1 PID: 26336 Comm: kworker/u4:3 Not tainted 4.20.0+ #391
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_circular_bug.isra.34.cold.56+0x1bd/0x27d  
kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x3360/0x4c20 kernel/locking/lockdep.c:3338
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
  console_trylock_spinning kernel/printk/printk.c:1653 [inline]
  vprintk_emit+0x37d/0x990 kernel/printk/printk.c:1921
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1997
  __warn_printk+0x8c/0xe0 kernel/panic.c:594
  debug_print_object+0x16a/0x210 lib/debugobjects.c:325
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3816
  kvfree+0x61/0x70 mm/util.c:445
  netdev_freemem+0x4c/0x60 net/core/dev.c:8903
  netdev_release+0x121/0x180 net/core/net-sysfs.c:1640
  device_release+0x7e/0x210 drivers/base/core.c:912
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  netdev_run_todo+0x715/0xa60 net/core/dev.c:8808
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  default_device_exit_batch+0x43f/0x540 net/core/dev.c:9589
  ops_exit_list.isra.5+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  ? trace_hardirqs_on+
Lost 11 message(s)!
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
