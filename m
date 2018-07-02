Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71583C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139A124AA8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8djI/RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139A124AA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeGBSug (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:50:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38823 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeGBSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:50:33 -0400
Received: by mail-io0-f193.google.com with SMTP id v26-v6so3362780iog.5;
        Mon, 02 Jul 2018 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=99fDJ2yj2t4ukGjEaU/AaffEO5v8SyBy1YQw4CmYAYI=;
        b=k8djI/RVTcoDfE/nGQBWP1PBrpQNMJjhG+VwSpE3/2vZN2BWeqbn/tnmXRU1MS/hxH
         fFQwRPJ6XUq87vwTEQ/0MajXRd8oMMOjHGMQZqJk+nwrKjULQF1wnR7DIiiDbyyCo0wN
         qOcqLoqggO2ZLcxvA/68VQhDfqTx4J0AGoR/OQANENzOGqz9o3JKWiSB1OHVVk0i5kZx
         ny0UEJ08QedBSykFecWjNXubNhHCtCw16nAT5fHBFXcWN7XN54DTnSvp/Cfj9FXWpzrv
         meCX7szsjDNgPD4ZAGmKf87hjKRPRN/bQPsHo/3E0DnHr9svtF29aNg8rFcSky7Zw6kZ
         4atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99fDJ2yj2t4ukGjEaU/AaffEO5v8SyBy1YQw4CmYAYI=;
        b=XLogIZj92gEfFcCJrcfvnm13vDHNA9f8xnxfvPxi1MtIlftzoA3bby7/uIKxn0Rdz8
         U3+pjlnUqGN381RwOjFqIrCV1KJjMVuIad5RU47OaRVYt+lv7p9XVASsqI/N6Kz0xbza
         ja0SRH1zeeeM1vO3GKrbGy72w2hd9bySxThZzqeLB2T81WpTJR7jda9y+qbebaGweZj3
         P9qUTfuqatZIiYpdbd7dNyqpsAi2vsGj9qUh3U4U4NKkU+wtIylgdyBRkpFfABnjEOD4
         crin/HbTj5tXxkX1WPqXULLmxHCGC8tehMcZMbzxqPLLBLn/vvSxfucaow+RI/ugcr0e
         KJUA==
X-Gm-Message-State: APt69E389JKN3BUHsz2xnvi15sFV845ewMBHdnrL/5bYWKwiFKMI5mJw
        592SBiWtJUSULdjQ9cgdTt4=
X-Google-Smtp-Source: AAOMgpdQIlpifRbwXXS8DefK2PqXVwxGd3TEC3I9l3aGskiS610tQ6XqYLcJuUDzhN+TEvYXqs8rew==
X-Received: by 2002:a6b:a58f:: with SMTP id o137-v6mr18164418ioe.63.1530557432295;
        Mon, 02 Jul 2018 11:50:32 -0700 (PDT)
Received: from [192.168.86.235] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id e18-v6sm1213717iof.23.2018.07.02.11.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:50:31 -0700 (PDT)
Subject: Re: WARNING: ODEBUG bug in sock_hash_free
To:     syzbot <syzbot+71aeaaf993d216185076@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000037c7d5056f84cabc@google.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <a5b01be4-e11c-58a8-2199-9b4faab8a3e3@gmail.com>
Date:   Mon, 2 Jul 2018 11:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <00000000000037c7d5056f84cabc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 10:30 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1725589f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=71aeaaf993d216185076
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+71aeaaf993d216185076@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> ODEBUG: free active (active state 1) object type: rcu_head hint:           (null)
> WARNING: CPU: 1 PID: 4959 at lib/debugobjects.c:329 debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 4959 Comm: kworker/1:3 Not tainted 4.17.0+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events bpf_map_free_deferred
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  panic+0x22f/0x4de kernel/panic.c:184
>  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Code: 1a 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd 60 75 1a 88 4c 89 f6 48 c7 c7 e0 6a 1a 88 e8 06 62 ec fd <0f> 0b 83 05 39 5b 44 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffff880198e47490 EFLAGS: 00010082
> RAX: 0000000000000051 RBX: 0000000000000003 RCX: ffffffff81854ed8
> RDX: 0000000000000000 RSI: ffffffff8161f371 RDI: 0000000000000001
> RBP: ffff880198e474d0 R08: ffff8801d84b2240 R09: ffffed003b5e3ec2
> R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: 0000000000000001
> R13: ffffffff88f91d80 R14: ffffffff881a6f80 R15: 0000000000000000
>  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
>  debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
>  kfree+0xc7/0x260 mm/slab.c:3812
>  sock_hash_free+0x24e/0x6e0 kernel/bpf/sockmap.c:2093
>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
>  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
>  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0+ #39 Not tainted
> ------------------------------------------------------
> kworker/1:3/4959 is trying to acquire lock:
> 00000000190110fa ((console_sem).lock){-...}, at: down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
> 
> but task is already holding lock:
> 00000000af3150e8 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
> 00000000af3150e8 (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0x159/0x584 lib/debugobjects.c:815
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&obj_hash[i].lock){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        __debug_object_init+0x11f/0x12c0 lib/debugobjects.c:381
>        debug_object_init+0x16/0x20 lib/debugobjects.c:429
>        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
>        debug_init kernel/time/hrtimer.c:458 [inline]
>        hrtimer_init+0x8f/0x460 kernel/time/hrtimer.c:1308
>        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1056
>        __sched_fork+0x2a8/0x570 kernel/sched/core.c:2184
>        init_idle+0x75/0x7a0 kernel/sched/core.c:5404
>        sched_init+0xbeb/0xd10 kernel/sched/core.c:6102
>        start_kernel+0x475/0x92d init/main.c:602
>        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
> 
> -> #2 (&rq->lock){-.-.}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
>        rq_lock kernel/sched/sched.h:1805 [inline]
>        task_fork_fair+0x8a/0x660 kernel/sched/fair.c:9953
>        sched_fork+0x43e/0xb30 kernel/sched/core.c:2380
>        copy_process.part.38+0x1bf1/0x7180 kernel/fork.c:1765
>        copy_process kernel/fork.c:1608 [inline]
>        _do_fork+0x291/0x12a0 kernel/fork.c:2091
>        kernel_thread+0x34/0x40 kernel/fork.c:2150
>        rest_init+0x22/0xe4 init/main.c:408
>        start_kernel+0x906/0x92d init/main.c:738
>        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
> 
> -> #1 (&p->pi_lock){-.-.}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        try_to_wake_up+0xca/0x1280 kernel/sched/core.c:1984
>        wake_up_process+0x10/0x20 kernel/sched/core.c:2147
>        __up.isra.1+0x1b8/0x290 kernel/locking/semaphore.c:262
>        up+0x12f/0x1b0 kernel/locking/semaphore.c:187
>        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
>        console_unlock+0x79a/0x10a0 kernel/printk/printk.c:2411
>        vprintk_emit+0x6b2/0xde0 kernel/printk/printk.c:1907
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>        printk+0x9e/0xba kernel/printk/printk.c:1981
>        load_umh+0x51/0xbd net/bpfilter/bpfilter_kern.c:99
>        do_one_initcall+0x127/0x913 init/main.c:884
>        do_initcall_level init/main.c:952 [inline]
>        do_initcalls init/main.c:960 [inline]
>        do_basic_setup init/main.c:978 [inline]
>        kernel_init_freeable+0x49b/0x58e init/main.c:1135
>        kernel_init+0x11/0x1b3 init/main.c:1061
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> -> #0 ((console_sem).lock){-...}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
>        console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
>        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
>        vprintk_emit+0x699/0xde0 kernel/printk/printk.c:1906
>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>        printk+0x9e/0xba kernel/printk/printk.c:1981
>        __warn_printk+0x83/0xd0 kernel/panic.c:590
>        debug_print_object+0x16a/0x210 lib/debugobjects.c:326
>        __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
>        debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
>        kfree+0xc7/0x260 mm/slab.c:3812
>        sock_hash_free+0x24e/0x6e0 kernel/bpf/sockmap.c:2093
>        bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
>        process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
>        worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
>        kthread+0x345/0x410 kernel/kthread.c:240
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   (console_sem).lock --> &rq->lock --> &obj_hash[i].lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&obj_hash[i].lock);
>                                lock(&rq->lock);
>                                lock(&obj_hash[i].lock);
>   lock((console_sem).lock);
> 
>  *** DEADLOCK ***
> 
> 4 locks held by kworker/1:3/4959:
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: __write_once_size include/linux/compiler.h:215 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: set_work_data kernel/workqueue.c:617 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
>  #0: 00000000f67deee4 ((wq_completion)"events"){+.+.}, at: process_one_work+0xb35/0x1b70 kernel/workqueue.c:2124
>  #1: 00000000776b40d0 ((work_completion)(&map->work)){+.+.}, at: process_one_work+0xb8c/0x1b70 kernel/workqueue.c:2128
>  #2: 000000002a359661 (rcu_read_lock){....}, at: sock_hash_free+0x0/0x6e0 include/net/sock.h:2176
>  #3: 00000000af3150e8 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
>  #3: 00000000af3150e8 (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0x159/0x584 lib/debugobjects.c:815
> 
> stack backtrace:
> CPU: 1 PID: 4959 Comm: kworker/1:3 Not tainted 4.17.0+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events bpf_map_free_deferred
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.56+0x1bd/0x27d kernel/locking/lockdep.c:1227
>  check_prev_add kernel/locking/lockdep.c:1867 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
>  validate_chain kernel/locking/lockdep.c:2421 [inline]
>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3435
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3924
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
>  console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
>  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
>  vprintk_emit+0x699/0xde0 kernel/printk/printk.c:1906
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
>  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
>  printk+0x9e/0xba kernel/printk/printk.c:1981
>  __warn_printk+0x83/0xd0 kernel/panic.c:590
>  debug_print_object+0x16a/0x210 lib/debugobjects.c:326
>  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
>  debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
>  kfree+0xc7/0x260 mm/slab.c:3812
>  sock_hash_free+0x24e/0x6e0 kernel/bpf/sockmap.c:2093
>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
>  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
>  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Shutting down cpus with NMI
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.

#syz fix: bpf: sockhash fix omitted bucket lock in sock_close
