Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B54C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C12073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfACKpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:45:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39281 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfACKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:45:05 -0500
Received: by mail-io1-f70.google.com with SMTP id q23so38418361ior.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 02:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uAavmrXVDxhFMWBatEHSb+lW+Fgj/Qa/A46F/OF7iPQ=;
        b=r8qFY9HJ3U8r+SUVjvOR8hlWtgxIkQnLszZOdsWcDfCHqzoEohUJSYHJQg4spO/YRS
         JixJo6sujialxEDf5iMh2ufEPLdeNHbz8casUwjzIagB1dkfXTQJZDvf/L/5zT3rx/mr
         ajN/o5vpwCVvoRDV5m7ABpRetgDuV2Zbg2yKAC17JlU1Ache9arVC0MU6q0CF3aBwlfe
         ruD6mhW3cOxiAlqWWl6A0rw5WUlcT/P2u+s9mmxvHxJaEel8SNsP7Lu1qa923KD1SCJP
         g2iuLZDDwK79bVE88GGKPOR0F972HUEDpyFTWQGE+ARotYfN6M3ohYIKmzgAmurhc0W+
         QVtA==
X-Gm-Message-State: AJcUukfucQNce3uVnhQCYCuKC3LQNP/g7tg25bPzpTgbwVx23Uv01zdL
        LkpCOi9+WT5SYEKDac33GFAzmhlfj0YCTDsMivLt+sI/FRdb
X-Google-Smtp-Source: ALg8bN4fUOVa1XrgyDeoJZCMqnghwXBbLlGMiJoE9O5EtSrXokir8cmKvwKkr2tiURR0ovvSHDoVHajlpxIwwZdQ68XQ6xwy7lFc
MIME-Version: 1.0
X-Received: by 2002:a5e:df44:: with SMTP id g4mr528775ioq.0.1546512304351;
 Thu, 03 Jan 2019 02:45:04 -0800 (PST)
Date:   Thu, 03 Jan 2019 02:45:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ab3c0057e8b747f@google.com>
Subject: general protection fault in rb_erase (2)
From:   syzbot <syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    85f78456f286 Merge tag '9p-for-4.21' of git://github.com/m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cf53fd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17c50660d3a88302
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c40862180d8949d624
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: -1861588088 Comm: R
  Not tainted 4.20.0+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:131 [inline]
RIP: 0010:____rb_erase_color lib/rbtree.c:271 [inline]
RIP: 0010:rb_erase+0x7b0/0x3550 lib/rbtree.c:462
Code: 89 a7 a0 fb ff ff 80 3c 1f 00 0f 85 25 23 00 00 48 c1 e9 03 48 89 c7  
4d 89 66 10 48 c1 ef 03 c6 04 19 f8 4c 89 e1 48 83 c9 01 <80> 3c 1f 00 0f  
85 54 23 00 00 48 89 08 4c 89 e1 48 c1 e9 03 80 3c
RSP: 0018:ffff8880ae707698 EFLAGS: 00010082
RAX: 1c47e888753ca400 RBX: dffffc0000000000 RCX: ffff88807ccb78d9
RDX: 1ffff11015ce0edb RSI: ffffed1015ce0f07 RDI: 0388fd110ea79480
RBP: ffff8880ae707c00 R08: ffff88807ccb78e0 R09: ffff8880a9427470
R10: fffffbfff16d4c6d R11: ffffffff8b6a636b R12: ffff88807ccb78d8
R13: ffff8880ae725e00 R14: ffff8880a9427460 R15: ffff8880ae707bd8
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 00000000a48e9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  timerqueue_del+0x86/0x150 lib/timerqueue.c:87
  __remove_hrtimer+0xa8/0x1c0 kernel/time/hrtimer.c:975
  __run_hrtimer kernel/time/hrtimer.c:1371 [inline]
  __hrtimer_run_queues+0x311/0x1050 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
Modules linked in:

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #6 Not tainted
------------------------------------------------------
syz-executor1/8509 is trying to acquire lock:
00000000dbbab0d5 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
00000000e947a71e (&obj_hash[i].lock){-.-.}, at: debug_object_deactivate  
lib/debugobjects.c:540 [inline]
00000000e947a71e (&obj_hash[i].lock){-.-.}, at:  
debug_object_deactivate+0x101/0x4b0 lib/debugobjects.c:529

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
        vprintk_emit+0x370/0x960 kernel/printk/printk.c:1931
        dev_vprintk_emit+0x25d/0x560 drivers/base/core.c:3029
        dev_printk_emit+0xbb/0xf0 drivers/base/core.c:3040
        __dev_printk+0xa9/0x110 drivers/base/core.c:3052
        _dev_warn+0x10a/0x160 drivers/base/core.c:3096
        _request_firmware+0xe6b/0x15c0  
drivers/base/firmware_loader/main.c:590
        request_firmware_work_func+0xf1/0x2f0  
drivers/base/firmware_loader/main.c:783
        process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
        worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
        kthread+0x357/0x430 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

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
        kasan_die_handler arch/x86/mm/kasan_init_64.c:252 [inline]
        kasan_die_handler.cold+0x11/0x23 arch/x86/mm/kasan_init_64.c:247
        notifier_call_chain+0x179/0x380 kernel/notifier.c:93
        __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
        atomic_notifier_call_chain+0x96/0x190 kernel/notifier.c:193
        notify_die+0x1b2/0x270 kernel/notifier.c:549
        do_general_protection+0x13d/0x300 arch/x86/kernel/traps.c:557
        general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
        lookup_object lib/debugobjects.c:156 [inline]
        debug_object_deactivate lib/debugobjects.c:542 [inline]
        debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
        debug_hrtimer_deactivate kernel/time/hrtimer.c:412 [inline]
        debug_deactivate kernel/time/hrtimer.c:462 [inline]
        __run_hrtimer kernel/time/hrtimer.c:1359 [inline]
        __hrtimer_run_queues+0x225/0x1050 kernel/time/hrtimer.c:1451
        hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
        local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
        smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
        apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
        arch_local_irq_enable arch/x86/include/asm/paravirt.h:776 [inline]
        __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
        _raw_spin_unlock_irq+0x54/0x90 kernel/locking/spinlock.c:192
        finish_lock_switch kernel/sched/core.c:2581 [inline]
        finish_task_switch+0x1e9/0xac0 kernel/sched/core.c:2681
        context_switch kernel/sched/core.c:2834 [inline]
        __schedule+0x89f/0x1e90 kernel/sched/core.c:3472
        schedule+0xfe/0x350 kernel/sched/core.c:3516
        freezable_schedule include/linux/freezer.h:172 [inline]
        do_nanosleep+0x208/0x750 kernel/time/hrtimer.c:1679
        hrtimer_nanosleep+0x2e4/0x640 kernel/time/hrtimer.c:1733
        __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
        __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
        __x64_sys_nanosleep+0x1e0/0x280 kernel/time/hrtimer.c:1754
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

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

3 locks held by syz-executor1/8509:
  #0: 00000000df9a0e7b (hrtimer_bases.lock){-.-.}, at:  
hrtimer_interrupt+0xff/0x770 kernel/time/hrtimer.c:1490
  #1: 00000000e947a71e (&obj_hash[i].lock){-.-.}, at:  
debug_object_deactivate lib/debugobjects.c:540 [inline]
  #1: 00000000e947a71e (&obj_hash[i].lock){-.-.}, at:  
debug_object_deactivate+0x101/0x4b0 lib/debugobjects.c:529
  #2: 0000000064b5e2dd (rcu_read_lock){....}, at:  
atomic_notifier_call_chain+0x0/0x190 kernel/notifier.c:329

stack backtrace:
CPU: 0 PID: 8509 Comm: syz-executor1 Not tainted 4.20.0+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
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
  kasan_die_handler arch/x86/mm/kasan_init_64.c:252 [inline]
  kasan_die_handler.cold+0x11/0x23 arch/x86/mm/kasan_init_64.c:247
  notifier_call_chain+0x179/0x380 kernel/notifier.c:93
  __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
  atomic_notifier_call_chain+0x96/0x190 kernel/notifier.c:193
  notify_die+0x1b2/0x270 kernel/notifier.c:549
  do_general_protection+0x13d/0x300 arch/x86/kernel/traps.c:557
  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 84  
d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00  
0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
RSP: 0018:ffff8880ae607b80 EFLAGS: 00010006
RAX: 1ffffffff16dbb64 RBX: 0000000000000004 RCX: ffff8880ae626620
RDX: 0000000000000003 RSI: 0000000000000004 RDI: 0000000000000019
RBP: ffff8880ae607c70 R08: 1ffff11015cc0f5c R09: ffffffff899ad160
R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000001
R13: dffffc0000000000 R14: 1ffff11015cc0f74 R15: ffffffff8b6ddb28
  debug_hrtimer_deactivate kernel/time/hrtimer.c:412 [inline]
  debug_deactivate kernel/time/hrtimer.c:462 [inline]
  __run_hrtimer kernel/time/hrtimer.c:1359 [inline]
  __hrtimer_run_queues+0x225/0x1050 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169  
[inline]
RIP: 0010:_raw_spin_unlock_irq+0x54/0x90 kernel/locking/spinlock.c:192
Code: c0 40 4f 92 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00  
75 33 48 83 3d 85 5b 9f 01 00 74 20 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 82 c3 64 f9 65 8b 05 fb f9 0e 78 85 c0 74 06 41
RSP: 0018:ffff888093957888 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff13249e8 RBX: 1ffff1101272af1a RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffff8880979fac7c
RBP: ffff888093957890 R08: ffff8880979fa400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880ae62ce00
R13: ffff88809df9c040 R14: ffff88807ab06780 R15: ffff888093957950
  finish_lock_switch kernel/sched/core.c:2581 [inline]
  finish_task_switch+0x1e9/0xac0 kernel/sched/core.c:2681
  ? __swit
Lost 50 message(s)!
---[ end trace e47dcfc1ee5ed8ea ]---
general protection fault: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 8509 Comm: syz-executor1 Tainted: G      D           4.20.0+ #6
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:131 [inline]
RIP: 0010:____rb_erase_color lib/rbtree.c:271 [inline]
RIP: 0010:rb_erase+0x7b0/0x3550 lib/rbtree.c:462
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code: 89 a7 a0 fb ff ff 80 3c 1f 00 0f 85 25 23 00 00 48 c1 e9 03 48 89 c7  
4d 89 66 10 48 c1 ef 03 c6 04 19 f8 4c 89 e1 48 83 c9 01 <80> 3c 1f 00 0f  
85 54 23 00 00 48 89 08 4c 89 e1 48 c1 e9 03 80 3c
RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
RSP: 0018:ffff8880ae707698 EFLAGS: 00010082
Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 84  
d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00  
0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
RAX: 1c47e888753ca400 RBX: dffffc0000000000 RCX: ffff88807ccb78d9
RSP: 0018:ffff8880ae607b80 EFLAGS: 00010006
RDX: 1ffff11015ce0edb RSI: ffffed1015ce0f07 RDI: 0388fd110ea79480
RAX: 1ffffffff16dbb64 RBX: 0000000000000004 RCX: ffff8880ae626620
RBP: ffff8880ae707c00 R08: ffff88807ccb78e0 R09: ffff8880a9427470
RDX: 0000000000000003 RSI: 0000000000000004 RDI: 0000000000000019
R10: fffffbfff16d4c6d R11: ffffffff8b6a636b R12: ffff88807ccb78d8
RBP: ffff8880ae607c70 R08: 1ffff11015cc0f5c R09: ffffffff899ad160
R13: ffff8880ae725e00 R14: ffff8880a9427460 R15: ffff8880ae707bd8
R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
R13: dffffc0000000000 R14: 1ffff11015cc0f74 R15: ffffffff8b6ddb28
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
FS:  000000000267c940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CR2: 0000000000000068 CR3: 00000000a48e9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
CR2: 00007f678ca7b000 CR3: 0000000096054000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
