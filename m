Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A28C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893B21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGSJeIOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfADQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:41:49 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:35354 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfADQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:41:48 -0500
Received: by mail-it1-f171.google.com with SMTP id p197so2253333itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6uY574y4zkmkLPMzTXTBildwb+ZsSDIvUB0/zRc2as=;
        b=QGSJeIOLNd+gXn7/qdOgNNDRlAU+5m1SdTF+ImDfoUmx7T0ghkc7/VPje2I7SMw0V3
         1fo4DCQ+v+pBhJSAuhrCy5VwW5KSyB6bXhp3dYJXvIwJKkF4M6pJvXOyrbch9bhUYgr1
         Z6sDMnGxYB08TLJazycVX+AuiL+adBOHrI6tYW155hog8fykHomOS3eF6rJqMEWayJA0
         FQbr1leYxoRsHfWIG/64q63C8XRi3cDb72csDeKERZH6LwkY9sonkNvwDv1u6BMM/nqW
         CI+YKux2HaNaW5vtgM0A6kTxT0eC7YexdB6t+J685GJvNvS1R8eupsaR3UvrCINOjgOb
         u/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6uY574y4zkmkLPMzTXTBildwb+ZsSDIvUB0/zRc2as=;
        b=sL1HGSPs7YhKW3C5BKsfzD+ez2BvoOysinPS6U6UEckuTS8dk1TT/aXmUsyPhuU22N
         SDF0nZeXcoiwqF+0PbBjITNtmwbfLJAy5wiGJGBiHhqvx977j22rSy3T4AiOV5fEQqBX
         XQsQtEm8JR90i5wSiK9m5e3DAGW+7ozfXlmePePWtEB5xvDmYaUPfJFXAM10TkXdwYPG
         EunXC9L09aFw2DQAk1DXjHqdssJVuwsrvD4L8fOBTa2yuBT3DK4Lkb96fkbL5rmybyKA
         QVq6x5REEm2eifu5/wjHo0wXHt0b3vIVOa6UIXFEuTHfJhgvoGwjQhyyk1Q7e6Vf//RV
         BKsA==
X-Gm-Message-State: AJcUukc8LMW75510c5QteNOcB0V0JkNIYdR3u4o6v9Qa/YYwnw3wNhLG
        3OHlqaa7mqEtnAIfXHN5U5b2ZAGYROL9OCgOiWm6eg==
X-Google-Smtp-Source: ALg8bN6xDLjZlV6CIEAdlZwwDKV3G5MEfIQneCSgk9FkrsoUckSv/y3LPFr7xx6ECxTL/6D0dzUXXEbf3MQVYj6+RVM=
X-Received: by 2002:a24:6511:: with SMTP id u17mr1423423itb.12.1546620106238;
 Fri, 04 Jan 2019 08:41:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a0a1aa057ea479e4@google.com>
In-Reply-To: <000000000000a0a1aa057ea479e4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 17:41:35 +0100
Message-ID: <CACT4Y+Y2N87fTWR=jBxz+puH8qBph95Rh6Hec_byNCV7PpjqVA@mail.gmail.com>
Subject: Re: general protection fault in timerqueue_add (2)
To:     syzbot <syzbot+0bdf4106024c4d67538b@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 5:36 PM syzbot
<syzbot+0bdf4106024c4d67538b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a9329f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20271e14bc1c87f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=0bdf4106024c4d67538b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0bdf4106024c4d67538b@syzkaller.appspotmail.com

This looks similar to and appeared roughly at the same time as:
KASAN: stack-out-of-bounds Read in timerqueue_add (2)
https://syzkaller.appspot.com/bug?id=668693e5222d4c252d63a6d4c8c4628269adf9d8

That one has one has a repro that looks like the udp stack overflow
bug. So let's consider it the same. This does not look too actionable
on its own.

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2

> rdma_op 0000000067c360de conn xmit_rdma           (null)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1087 Comm: syz-executor0 Not tainted 4.20.0+ #7
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:timerqueue_add+0xf2/0x320 lib/timerqueue.c:52
> Code: 48 c1 ea 03 42 80 3c 2a 00 0f 85 bc 01 00 00 49 8b 17 48 85 d2 74 3d
> 48 89 d3 e8 49 19 93 f9 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00
> 0f 85 a3 01 00 00 4c 8b 7b 18 4c 89 f7 4c 89 fe e8
> RSP: 0018:ffff8880ae607b68 EFLAGS: 00010003
> RAX: 000000000000004f RBX: 0000000000000266 RCX: ffffffff87ee7d4c
> RDX: 0000000000010000 RSI: ffffffff87ee7d27 RDI: 000000000000027e
> RBP: ffff8880ae607b98 R08: ffff888098ad8040 R09: ffffed1015cc5b90
> R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff88804ef69618
> R13: dffffc0000000000 R14: 000000b853ef7a10 R15: ffff8880a941f468
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000f31e80 CR3: 000000006792b000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
>   __run_hrtimer kernel/time/hrtimer.c:1404 [inline]
>   __hrtimer_run_queues+0xc39/0x1050 kernel/time/hrtimer.c:1451
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:766
> [inline]
> RIP: 0010:lock_acquire+0x259/0x570 kernel/locking/lockdep.c:3844
> Code: 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 64 02 00 00 48 83 3d 26
> 69 2e 08 00 0f 84 d0 01 00 00 48 8b bd 48 ff ff ff 57 9d <0f> 1f 44 00 00
> 48 b8 00 00 00 00 00 fc ff df 48 03 85 40 ff ff ff
> RSP: 0018:ffff88804bed7598 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffffff13249e6 RBX: ffff888098ad8040 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000ec1 RDI: 0000000000000286
> RBP: ffff88804bed7668 R08: 0000000000000000 R09: ffff888098ad88e0
> R10: ffff888098ad88c0 R11: 0000000000000001 R12: ffff888098ad87e0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
>   spin_lock include/linux/spinlock.h:329 [inline]
>   task_lock include/linux/sched/task.h:145 [inline]
>   switch_task_namespaces+0x38/0xd0 kernel/nsproxy.c:223
>   exit_task_namespaces+0x18/0x20 kernel/nsproxy.c:234
>   do_exit+0x19d1/0x2650 kernel/exit.c:866
>   do_group_exit+0x177/0x430 kernel/exit.c:970
>   get_signal+0x8b4/0x19b0 kernel/signal.c:2517
>   do_signal+0x91/0x1e80 arch/x86/kernel/signal.c:816
>   exit_to_usermode_loop+0x2f7/0x3b0 arch/x86/entry/common.c:162
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f457f93bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffa1 RBX: 0000000000000003 RCX: 0000000000457ec9
> RDX: 0000000000000000 RSI: 0000000020001600 RDI: 0000000000000006
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f457f93c6d4
> R13: 00000000004c5233 R14: 00000000004d8b00 R15: 00000000ffffffff
> Modules linked in:
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.20.0+ #7 Not tainted
> ------------------------------------------------------
> syz-executor0/1087 is trying to acquire lock:
> 000000009f70c497 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70
> kernel/locking/semaphore.c:136
>
> but task is already holding lock:
> 0000000015bfd133 (hrtimer_bases.lock){-.-.}, at: __run_hrtimer
> kernel/time/hrtimer.c:1391 [inline]
> 0000000015bfd133 (hrtimer_bases.lock){-.-.}, at:
> __hrtimer_run_queues+0x40f/0x1050 kernel/time/hrtimer.c:1451
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #4 (hrtimer_bases.lock){-.-.}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
>         lock_hrtimer_base.isra.0+0x75/0x130 kernel/time/hrtimer.c:165
>         hrtimer_start_range_ns+0x120/0xda0 kernel/time/hrtimer.c:1104
>         hrtimer_start_expires include/linux/hrtimer.h:409 [inline]
>         start_rt_bandwidth kernel/sched/rt.c:70 [inline]
>         inc_rt_group kernel/sched/rt.c:1147 [inline]
>         inc_rt_tasks kernel/sched/rt.c:1191 [inline]
>         __enqueue_rt_entity kernel/sched/rt.c:1261 [inline]
>         enqueue_rt_entity kernel/sched/rt.c:1305 [inline]
>         enqueue_task_rt+0x95b/0x1010 kernel/sched/rt.c:1335
>         enqueue_task+0xb9/0x380 kernel/sched/core.c:730
>         __sched_setscheduler+0xe32/0x1fe0 kernel/sched/core.c:4336
>         _sched_setscheduler+0x218/0x340 kernel/sched/core.c:4373
>         sched_setscheduler+0xe/0x10 kernel/sched/core.c:4388
>         watchdog_dev_init+0x109/0x1db drivers/watchdog/watchdog_dev.c:1144
>         watchdog_init+0x81/0x294 drivers/watchdog/watchdog_core.c:355
>         do_one_initcall+0x129/0x937 init/main.c:889
>         do_initcall_level init/main.c:957 [inline]
>         do_initcalls init/main.c:965 [inline]
>         do_basic_setup init/main.c:983 [inline]
>         kernel_init_freeable+0x4db/0x5ca init/main.c:1136
>         kernel_init+0x12/0x1c5 init/main.c:1056
>         ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>
> -> #3 (&rt_b->rt_runtime_lock){-.-.}:
>         __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>         _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
>         __enable_runtime kernel/sched/rt.c:786 [inline]
>         rq_online_rt+0xb4/0x390 kernel/sched/rt.c:2178
>         set_rq_online.part.0+0xe7/0x140 kernel/sched/core.c:5666
>         set_rq_online kernel/sched/core.c:5772 [inline]
>         sched_cpu_activate+0x29e/0x430 kernel/sched/core.c:5765
>         cpuhp_invoke_callback+0x2f6/0x2110 kernel/cpu.c:168
>         cpuhp_thread_fun+0x496/0x8a0 kernel/cpu.c:685
>         smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
>         kthread+0x357/0x430 kernel/kthread.c:246
>         ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>
> -> #2 (&rq->lock){-.-.}:
>         __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>         _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
>         rq_lock kernel/sched/sched.h:1149 [inline]
>         task_fork_fair+0xb5/0x7a0 kernel/sched/fair.c:10058
>         sched_fork+0x437/0xb90 kernel/sched/core.c:2359
>         copy_process+0x1ff6/0x8730 kernel/fork.c:1893
>         _do_fork+0x1a9/0x1170 kernel/fork.c:2222
>         kernel_thread+0x34/0x40 kernel/fork.c:2281
>         rest_init+0x28/0x37b init/main.c:409
>         arch_call_rest_init+0xe/0x1b
>         start_kernel+0x882/0x8bd init/main.c:741
>         x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
>         x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
>
> -> #1 (&p->pi_lock){-.-.}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
>         try_to_wake_up+0xb9/0x1480 kernel/sched/core.c:1965
>         wake_up_process+0x10/0x20 kernel/sched/core.c:2129
>         __up.isra.0+0x1c0/0x2a0 kernel/locking/semaphore.c:262
>         up+0x13e/0x1c0 kernel/locking/semaphore.c:187
>         __up_console_sem+0xb7/0x1c0 kernel/printk/printk.c:236
>         console_unlock+0x778/0x11e0 kernel/printk/printk.c:2426
>         vprintk_emit+0x370/0x960 kernel/printk/printk.c:1931
>         vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
>         vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
>         printk+0xba/0xed kernel/printk/printk.c:1991
>         check_stack_usage kernel/exit.c:755 [inline]
>         do_exit.cold+0x57/0x16a kernel/exit.c:916
>         do_group_exit+0x177/0x430 kernel/exit.c:970
>         __do_sys_exit_group kernel/exit.c:981 [inline]
>         __se_sys_exit_group kernel/exit.c:979 [inline]
>         __x64_sys_exit_group+0x44/0x50 kernel/exit.c:979
>         do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 ((console_sem).lock){-.-.}:
>         lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
>         down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>         __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
>         console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
>         console_trylock_spinning kernel/printk/printk.c:1662 [inline]
>         vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
>         vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
>         vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
>         printk+0xba/0xed kernel/printk/printk.c:1991
>         kasan_die_handler arch/x86/mm/kasan_init_64.c:252 [inline]
>         kasan_die_handler.cold+0x11/0x23 arch/x86/mm/kasan_init_64.c:247
>         notifier_call_chain+0x179/0x380 kernel/notifier.c:93
>         __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
>         atomic_notifier_call_chain+0x96/0x190 kernel/notifier.c:193
>         notify_die+0x1b2/0x270 kernel/notifier.c:549
>         do_general_protection+0x13d/0x300 arch/x86/kernel/traps.c:557
>         general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
>         timerqueue_add+0xf2/0x320 lib/timerqueue.c:52
>         enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
>         __run_hrtimer kernel/time/hrtimer.c:1404 [inline]
>         __hrtimer_run_queues+0xc39/0x1050 kernel/time/hrtimer.c:1451
>         hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>         local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>         smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>         apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>         arch_local_irq_restore arch/x86/include/asm/paravirt.h:766 [inline]
>         lock_acquire+0x259/0x570 kernel/locking/lockdep.c:3844
>         __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>         _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
>         spin_lock include/linux/spinlock.h:329 [inline]
>         task_lock include/linux/sched/task.h:145 [inline]
>         switch_task_namespaces+0x38/0xd0 kernel/nsproxy.c:223
>         exit_task_namespaces+0x18/0x20 kernel/nsproxy.c:234
>         do_exit+0x19d1/0x2650 kernel/exit.c:866
>         do_group_exit+0x177/0x430 kernel/exit.c:970
>         get_signal+0x8b4/0x19b0 kernel/signal.c:2517
>         do_signal+0x91/0x1e80 arch/x86/kernel/signal.c:816
>         exit_to_usermode_loop+0x2f7/0x3b0 arch/x86/entry/common.c:162
>         prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>         syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>         do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>    (console_sem).lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(hrtimer_bases.lock);
>                                 lock(&rt_b->rt_runtime_lock);
>                                 lock(hrtimer_bases.lock);
>    lock((console_sem).lock);
>
>   *** DEADLOCK ***
>
> 3 locks held by syz-executor0/1087:
>   #0: 00000000721032d7 (&(&p->alloc_lock)->rlock){+.+.}, at: spin_lock
> include/linux/spinlock.h:329 [inline]
>   #0: 00000000721032d7 (&(&p->alloc_lock)->rlock){+.+.}, at: task_lock
> include/linux/sched/task.h:145 [inline]
>   #0: 00000000721032d7 (&(&p->alloc_lock)->rlock){+.+.}, at:
> switch_task_namespaces+0x38/0xd0 kernel/nsproxy.c:223
>   #1: 0000000015bfd133 (hrtimer_bases.lock){-.-.}, at: __run_hrtimer
> kernel/time/hrtimer.c:1391 [inline]
>   #1: 0000000015bfd133 (hrtimer_bases.lock){-.-.}, at:
> __hrtimer_run_queues+0x40f/0x1050 kernel/time/hrtimer.c:1451
>   #2: 0000000018881b81 (rcu_read_lock){....}, at:
> atomic_notifier_call_chain+0x0/0x190 kernel/notifier.c:329
>
> stack backtrace:
> CPU: 0 PID: 1087 Comm: syz-executor0 Not tainted 4.20.0+ #7
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
>   check_prev_add kernel/locking/lockdep.c:1866 [inline]
>   check_prevs_add kernel/locking/lockdep.c:1979 [inline]
>   validate_chain kernel/locking/lockdep.c:2350 [inline]
>   __lock_acquire+0x3014/0x4a30 kernel/locking/lockdep.c:3338
>   lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
>   down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>   __down_trylock_console_sem+0xa8/0x210 kernel/printk/printk.c:219
>   console_trylock+0x15/0xa0 kernel/printk/printk.c:2242
>   console_trylock_spinning kernel/printk/printk.c:1662 [inline]
>   vprintk_emit+0x351/0x960 kernel/printk/printk.c:1930
>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1958
>   vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:398
>   printk+0xba/0xed kernel/printk/printk.c:1991
>   kasan_die_handler arch/x86/mm/kasan_init_64.c:252 [inline]
>   kasan_die_handler.cold+0x11/0x23 arch/x86/mm/kasan_init_64.c:247
>   notifier_call_chain+0x179/0x380 kernel/notifier.c:93
>   __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
>   atomic_notifier_call_chain+0x96/0x190 kernel/notifier.c:193
>   notify_die+0x1b2/0x270 kernel/notifier.c:549
>   do_general_protection+0x13d/0x300 arch/x86/kernel/traps.c:557
>   general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
> RIP: 0010:timerqueue_add+0xf2/0x320 lib/timerqueue.c:52
> Code: 48 c1 ea 03 42 80 3c 2a 00 0f 85 bc 01 00 00 49 8b 17 48 85 d2 74 3d
> 48 89 d3 e8 49 19 93 f9 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00
> 0f 85 a3 01 00 00 4c 8b 7b 18 4c 89 f7 4c 89 fe e8
> RSP: 0018:ffff8880ae607b68 EFLAGS: 00010003
> RAX: 000000000000004f RBX: 0000000000000266 RCX: ffffffff87ee7d4c
> RDX: 0000000000010000 RSI: ffffffff87ee7d27 RDI: 000000000000027e
> RBP: ffff8880ae607b98 R08: ffff888098ad8040 R09: ffffed1015cc5b90
> R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff88804ef69618
> R13: dffffc0000000000 R14: 000000b853ef7a10 R15: ffff8880a941f468
>   enqueue_hrtimer+0x1ae/0x570 kernel/time/hrtimer.c:951
>   __run_hrtimer kernel/time/hrtimer.c:1404 [inline]
>   __hrtimer_run_queues+0xc39/0x1050 kernel/time/hrtimer.c:1451
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>   apic_timer_in
> Lost 71 message(s)!
> ---[ end trace 8a8a632e11ab3799 ]---
> general protection fault: 0000 [#2] PREEMPT SMP KASAN
> CPU: 1 PID: 3 Comm:  Tainted: G      D           4.20.0+ #7
> RIP: 0010:timerqueue_add+0xf2/0x320 lib/timerqueue.c:52
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:191 [inline]
> RIP: 0010:get_running_cputimer include/linux/sched/cputime.h:85 [inline]
> RIP: 0010:account_group_system_time include/linux/sched/cputime.h:149
> [inline]
> RIP: 0010:account_system_index_time+0xe8/0x5f0 kernel/sched/cputime.c:168
> Code: 48 c1 ea 03 42 80 3c 2a 00 0f 85 bc 01 00 00 49 8b 17 48 85 d2 74 3d
> 48 89 d3 e8 49 19 93 f9 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00
> 0f 85 a3 01 00 00 4c 8b 7b 18 4c 89 f7 4c 89 fe e8
> Code: 04 00 00 49 8b 84 24 00 07 00 00 48 ba 00 00 00 00 00 fc ff df 48 8d
> b8 40 01 00 00 48 8d 88 28 01 00 00 48 89 fe 48 c1 ee 03 <0f> b6 14 16 48
> 89 fe 83 e6 07 40 38 f2 7f 08 84 d2 0f 85 93 03 00
> RSP: 0018:ffff8880ae607b68 EFLAGS: 00010003
> RSP: 0018:ffff8880ae707a80 EFLAGS: 00010006
> RAX: 000000000000004f RBX: 0000000000000266 RCX: ffffffff87ee7d4c
> RAX: 0000000041b58ab3 RBX: 1ffff11015ce0f54 RCX: 0000000041b58bdb
> RDX: dffffc0000000000 RSI: 000000000836b17e RDI: 0000000041b58bf3
> RDX: 0000000000010000 RSI: ffffffff87ee7d27 RDI: 000000000000027e
> RBP: ffff8880ae707b48 R08: ffff8880ae71f5f0 R09: fffffbfff1335bc5
> R10: fffffbfff1301b45 R11: ffffffff899ade23 R12: ffff8880a94bc440
> RBP: ffff8880ae607b98 R08: ffff888098ad8040 R09: ffffed1015cc5b90
> R13: 000000000097884e R14: 0000000000000003 R15: ffff8880ae707b20
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff88804ef69618
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f457f8fad90 CR3: 000000008cfa0000 CR4: 00000000001426e0
> R13: dffffc0000000000 R14: 000000b853ef7a10 R15: ffff8880a941f468
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   <IRQ>
> CR2: 0000000000f31e80 CR3: 000000006792b000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a0a1aa057ea479e4%40google.com.
> For more options, visit https://groups.google.com/d/optout.
