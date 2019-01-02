Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F81C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852752089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfABEKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 23:10:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:48427 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfABEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 23:10:05 -0500
Received: by mail-io1-f70.google.com with SMTP id s3so29513920iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 20:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qeOnzGdkhRabRxX4QQ7NBPyBaQB4oWADk/Ef9aeWmfk=;
        b=Bewa8Y5MyzRKXyZn5s3X/MgvROKRxe/tg0vwYKAYf+qeQYKB86Qk1W804zodxNgR3C
         PvlF6/qdWjDS48lvvG7jwcRDeuNYAHSuOgQSitCQ5HVgehSUAuVPOVFFKfq5hJU9PJXT
         gyV3YqRBLDtnympbRRjqmc6aAE5U5WvS5bffrCt6OaJVlKyC1c2A9CTAJcYlaWZv1WFI
         t6YGiKvjOsWSt0RbRDYywD67kLdb1UH46KVFVmyCLtTS4XyLUwAoQAHajiykubNngZV1
         d4dTBkOyT2Yrv6vMlGqWKZsSqNCHvJVuqxcuzZlk9tnBJ5H/HOkiEB8GlNlSmcbB3P8I
         QwWQ==
X-Gm-Message-State: AA+aEWZitxPNmlP/uJjbDNXwOfmG3fBXudc4EjW9vf7++fG5PRuCZ4ON
        aif00lI+0/PKG3FU11/jArG/Moaeu6OcBq5COxzUwHm5UYN9
X-Google-Smtp-Source: AFSGD/WMxccnmcoNoh/7gmT91yVIhm+9VEujYTKJ4xnmywRC1H2nDMmAT1beaJkbjLmIvktlN9bJcIIMUkIjpCNFh5JRdN64BebP
MIME-Version: 1.0
X-Received: by 2002:a02:8609:: with SMTP id e9mr32574773jai.8.1546402203690;
 Tue, 01 Jan 2019 20:10:03 -0800 (PST)
Date:   Tue, 01 Jan 2019 20:10:03 -0800
In-Reply-To: <000000000000bc9ddf057e577c98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007f308057e71d2c5@google.com>
Subject: Re: WARNING: ODEBUG bug in netdev_freemem
From:   syzbot <syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        davem@davemloft.net, decot@googlers.com, dmitry.torokhov@gmail.com,
        jeffrey.t.kirsher@intel.com, joe@perches.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        petrm@mellanox.com, syzkaller-bugs@googlegroups.com,
        tyhicks@canonical.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1745f5bf400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=979ffc89b87309b1b94b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a93c4b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com

bond0 (unregistering): Released all slaves
IPVS: ftp: loaded support on port[0] = 21
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:4916
kobject: 'lo' (00000000c9c1b9e0): kobject_add_internal: parent: 'net',  
set: 'devices'
WARNING: CPU: 1 PID: 9386 at lib/debugobjects.c:325  
debug_print_object+0x16a/0x250 lib/debugobjects.c:325
kobject: 'loop1' (000000000c184f51): kobject_uevent_env
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9386 Comm: kworker/u4:6 Not tainted 4.20.0+ #4
kobject: 'lo' (00000000c9c1b9e0): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
kobject: 'loop1' (000000000c184f51): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x589 kernel/panic.c:189
kobject: 'lo' (00000000c9c1b9e0): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (00000000cd7bde5f): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
  __warn.cold+0x20/0x4b kernel/panic.c:544
  report_bug+0x263/0x2b0 lib/bug.c:186
kobject: 'loop1' (000000000c184f51): kobject_uevent_env
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
kobject: 'loop1' (000000000c184f51): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
kobject: 'queues' (00000000cd7bde5f): kobject_uevent_env
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:debug_print_object+0x16a/0x250 lib/debugobjects.c:325
Code: dd c0 46 81 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48  
8b 14 dd c0 46 81 88 48 c7 c7 60 3c 81 88 e8 06 22 bb fd <0f> 0b 83 05 01  
85 cb 06 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffff8880a3ac7270 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8167d666 RDI: 0000000000000005
RBP: ffff8880a3ac72b0 R08: ffff88807a33a040 R09: ffffed1015ce3ef9
R10: ffffed1015ce3ef8 R11: ffff8880ae71f7c7 R12: 0000000000000001
R13: ffffffff899a8e20 R14: ffffffff816e2a80 R15: dffffc0000000000
kobject: 'queues' (00000000cd7bde5f): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000001770de44): kobject_add_internal: parent: 'queues',  
set: 'queues'
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x39d/0x588 lib/debugobjects.c:817
kobject: 'rx-0' (000000001770de44): kobject_uevent_env
  kfree+0xbd/0x230 mm/slab.c:3803
  kvfree+0x61/0x70 mm/util.c:445
  netdev_freemem+0x4c/0x60 net/core/dev.c:8991
  netdev_release+0x119/0x180 net/core/net-sysfs.c:1640
kobject: 'rx-0' (000000001770de44): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
  device_release+0x7d/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  netdev_run_todo+0x704/0xae0 net/core/dev.c:8896
kobject: 'loop3' (0000000021871ddf): kobject_uevent_env
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  default_device_exit_batch+0x4d3/0x5f0 net/core/dev.c:9677
  ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #4 Not tainted
------------------------------------------------------
kworker/u4:6/9386 is trying to acquire lock:
000000001121b7cd ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000005012344f (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:776 [inline]
000000005012344f (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x170/0x588 lib/debugobjects.c:817

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        __debug_object_init+0xf6/0x12d0 lib/debugobjects.c:383
        debug_object_init+0x16/0x20 lib/debugobjects.c:431
        debug_hrtimer_init kernel/time/hrtimer.c:401 [inline]
        debug_init kernel/time/hrtimer.c:449 [inline]
        hrtimer_init+0x97/0x480 kernel/time/hrtimer.c:1299
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
        __sched_fork+0x2bf/0x5b0 kernel/sched/core.c:2166
        init_idle+0x75/0x670 kernel/sched/core.c:5374
        sched_init+0xb10/0xbe8 kernel/sched/core.c:6063
        start_kernel+0x445/0x8bd init/main.c:609
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1149 [inline]
        task_fork_fair+0xb5/0x7a0 kernel/sched/fair.c:10058
        sched_fork+0x437/0xb90 kernel/sched/core.c:2359
        copy_process+0x1ff6/0x8730 kernel/fork.c:1893
        _do_fork+0x1a9/0x1170 kernel/fork.c:2222
        kernel_thread+0x34/0x40 kernel/fork.c:2281
        rest_init+0x28/0x37b init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x882/0x8bd init/main.c:741
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        try_to_wake_up+0xb9/0x1480 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.0+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13e/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xb7/0x1c0 kernel/printk/printk.c:236
        console_unlock+0x778/0x11e0 kernel/printk/printk.c:2426
        do_con_write+0x1021/0x2420 drivers/tty/vt/vt.c:2767
        con_write+0x27/0xb0 drivers/tty/vt/vt.c:3116
        process_output_block drivers/tty/n_tty.c:593 [inline]
        n_tty_write+0x497/0x1220 drivers/tty/n_tty.c:2331
        do_tty_write drivers/tty/tty_io.c:959 [inline]
        tty_write+0x45b/0x7a0 drivers/tty/tty_io.c:1043
        __vfs_write+0x116/0xb40 fs/read_write.c:485
        vfs_write+0x20c/0x580 fs/read_write.c:549
        ksys_write+0x105/0x260 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
        console_trylock_spinning kernel/printk/printk.c:1662 [inline]
        vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
        vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
        printk+0xba/0xed kernel/printk/printk.c:1991
        __warn_printk+0x9c/0x100 kernel/panic.c:598
        debug_print_object+0x16a/0x250 lib/debugobjects.c:325
        __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
        debug_check_no_obj_freed+0x39d/0x588 lib/debugobjects.c:817
        kfree+0xbd/0x230 mm/slab.c:3803
        kvfree+0x61/0x70 mm/util.c:445
        netdev_freemem+0x4c/0x60 net/core/dev.c:8991
        netdev_release+0x119/0x180 net/core/net-sysfs.c:1640
        device_release+0x7d/0x210 drivers/base/core.c:919
        kobject_cleanup lib/kobject.c:662 [inline]
        kobject_release lib/kobject.c:691 [inline]
        kref_put include/linux/kref.h:67 [inline]
        kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
        netdev_run_todo+0x704/0xae0 net/core/dev.c:8896
        rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
        default_device_exit_batch+0x4d3/0x5f0 net/core/dev.c:9677
        ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
        cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
        process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
        worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
        kthread+0x357/0x430 kernel/kthread.c:246
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

4 locks held by kworker/u4:6/9386:
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at:  
__write_once_size include/linux/compiler.h:218 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000040aa4f0f ((wq_completion)"%s""netns"){+.+.}, at:  
process_one_work+0xbc7/0x1ce0 kernel/workqueue.c:2124
  #1: 000000006ce09174 (net_cleanup_work){+.+.}, at:  
process_one_work+0xc1d/0x1ce0 kernel/workqueue.c:2128
  #2: 00000000fe168da9 (pernet_ops_rwsem){++++}, at: cleanup_net+0x126/0xb10  
net/core/net_namespace.c:518
  #3: 000000005012344f (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:776 [inline]
  #3: 000000005012344f (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x170/0x588 lib/debugobjects.c:817

stack backtrace:
CPU: 1 PID: 9386 Comm: kworker/u4:6 Not tainted 4.20.0+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x3014/0x4a30 kernel/locking/lockdep.c:3338
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
  console_trylock_spinning kernel/printk/printk.c:1662 [inline]
  vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
  printk+0xba/0xed kernel/printk/printk.c:1991
  __warn_printk+0x9c/0x100 kernel/panic.c:598
  debug_print_object+0x16a/0x250 lib/debugobjects.c:325
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x39d/0x588 lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3803
  kvfree+0x61/0x70 mm/util.c:445
  netdev_freemem+0x4c/0x60 net/core/dev.c:8991
  netdev_release+0x119/0x180 net/core/net-sysfs.c:1640
  device_release+0x7d/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  netdev_run_todo+0x704/0xae0 net/core/dev.c:8896
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  default_device_exit_batch+0x4d3/0x5f0 net/core/dev.c:9677
  ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..

