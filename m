Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AAC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8F2082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXlEOfQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD8F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJ2C3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:29:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35078 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJ2C3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:29:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so2115563plp.2;
        Sun, 28 Oct 2018 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SxJzlePoYhZt44K5A0c0KbubJu7xOCgusduYjy7ZdsY=;
        b=IXlEOfQH8ZdW93+/72Gc+8Hn4FnySr1M2+d5YRLhFcTCxH79IE3uH5xwOdGqR3pgfM
         EFZfNl8ywmum+j3PiaoxHQjJCUjxL8J9X+JzGynZP0+O1hKE/rHw2MhJ0OTyvrCrqgnk
         KxtFyU0EtzZ5OPthz8b32eAZVDC3YZLDTLEeyWHqvEYRsp1I17lBE8Z4aOqZHxXqpVao
         EKs8ULxlEGODAoG8BtPhASCFBSl8X9/DKu37icJ06U1pCVaH3qim4dVy/zRCcSuF+IWI
         zTkjxO5kNUzzfY3PWRJGqqxXzIELPde8zSPJyWsjyCGb7/Hiy5zpRgky9c8mNZu4M0UI
         9uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SxJzlePoYhZt44K5A0c0KbubJu7xOCgusduYjy7ZdsY=;
        b=Y6QHRMNQ4fKvAbV1NLCJqllY+1kC9CAjDTtLGKzrbzb2dtINC5koyu3yvZ+xKJhuX5
         B+DovtDO4zlmieMn2fV0pT2VQelT4+lLl5/bRwaZpk21VGsNA03U5afsx+X2aBcIzdda
         b8Vale6aNSdUJnv75X1kQPKyTfu8hHEX3z0nTVQMIusArOp/DZ5ETgpd3t4eD+WEXxLn
         /yRKClRwtVvJnvBHEQCVF0+1glUs97hk20jpIzTheiHkkjxJoEcvvC2PqDjR3eBLBzNV
         H4yqsDPrTtHYJP9DoAF3AEqULG5J6LnmvJJNvDsgBzd+PzqRGVB2eekHbKmURiLDGupu
         u/1g==
X-Gm-Message-State: AGRZ1gLm/zrgbkclDFAJm/dBfyw2M10IQzkIFkruJV2TbM4HsZRk1zha
        93vGb+wL4xlARdYhrsaFvYjkRzmM
X-Google-Smtp-Source: AJdET5dkARyf2k31VS/kBSF9FPScQNJP3yQlrhCWS1aMGcMoL7xnBbkbNXQH/4RbAZZWV+MJsw1BMw==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr10832463pln.302.1540748642756;
        Sun, 28 Oct 2018 10:44:02 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id v19-v6sm22535754pgl.80.2018.10.28.10.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 10:44:01 -0700 (PDT)
Subject: Re: WARNING in __debug_object_init (3)
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
References: <0000000000008db3210579416691@google.com>
 <CACT4Y+bxF2gZpdp5JuWSWwyqX=ZumOmei-pOpnGFjALDeaqmQQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <64bc75ce-336d-2115-1016-b10bc920539f@gmail.com>
Date:   Sun, 28 Oct 2018 10:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bxF2gZpdp5JuWSWwyqX=ZumOmei-pOpnGFjALDeaqmQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2018 08:13 AM, Dmitry Vyukov wrote:
> On Sun, Oct 28, 2018 at 3:18 AM, syzbot
> <syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=100feec5400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6e682caa546b7c96c859
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13579abd400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13654f6b400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+6e682caa546b7c96c859@syzkaller.appspotmail.com
> 
> +Eric knows what's wrong here. Something about "bpf: add tests for
> direct packet access from CGROUP_SKB" commit. Was is amended to fix a
> bug?
> 

I know little.

It seems that this linux-next tree contains a (buggy) pre-version of 
this commit :

commit 2cb494a36c98279c5c6ce8e99cf9776f15449ade
Author: Song Liu <songliubraving@fb.com>
Date:   Fri Oct 19 09:57:58 2018 -0700

    bpf: add tests for direct packet access from CGROUP_SKB
    
    Tests are added to make sure CGROUP_SKB cannot access:
      tc_classid, data_meta, flow_keys
    
    and can read and write:
      mark, prority, and cb[0-4]
    
    and can read other fields.
    
    To make selftest with skb->sk work, a dummy sk is added in
    bpf_prog_test_run_skb().
    
    Signed-off-by: Song Liu <songliubraving@fb.com>
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Maybe bpf maintainers chose to pre-submit a buggy patch and rebased their tree.

The buggy patch in linux-next was :

commit 75079847e9d05d4cc1b7e09b29e22cbc8318a6b7
Author: Song Liu <songliubraving@fb.com>
Date:   Thu Oct 18 09:06:49 2018 -0700

    bpf: add tests for direct packet access from CGROUP_SKB
    
    Tests are added to make sure CGROUP_SKB cannot access:
      tc_classid, data_meta, flow_keys
    
    and can read and write:
      mark, prority, and cb[0-4]
    
    and can read other fields.
    
    To make selftest with skb->sk work, a dummy sk is added in
    bpf_prog_test_run_skb().
    
    Signed-off-by: Song Liu <songliubraving@fb.com>
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>




> 
>> ODEBUG: object 0000000015e9012c is on stack 00000000115bcb67, but NOT
>> annotated.
>> WARNING: CPU: 0 PID: 5594 at lib/debugobjects.c:369 debug_object_is_on_stack
>> lib/debugobjects.c:363 [inline]
>> WARNING: CPU: 0 PID: 5594 at lib/debugobjects.c:369
>> __debug_object_init.cold.14+0x51/0xdf lib/debugobjects.c:395
>> Kernel panic - not syncing: panic_on_warn set ...
>> CPU: 0 PID: 5594 Comm: syz-executor740 Not tainted 4.19.0-rc8-next-20181019+
>> #98
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>>  panic+0x2ad/0x55c kernel/panic.c:188
>>  __warn.cold.8+0x20/0x45 kernel/panic.c:540
>>  report_bug+0x254/0x2d0 lib/bug.c:186
>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
>> RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:363 [inline]
>> RIP: 0010:__debug_object_init.cold.14+0x51/0xdf lib/debugobjects.c:395
>> Code: ea 03 80 3c 02 00 75 7c 49 8b 54 24 18 48 89 de 48 c7 c7 c0 f1 40 88
>> 4c 89 85 d0 fd ff ff e8 09 8c d1 fd 4c 8b 85 d0 fd ff ff <0f> 0b e9 09 d6 ff
>> ff 41 83 c4 01 b8 ff ff 37 00 44 89 25 b7 4e 66
>> RSP: 0018:ffff8801bb387308 EFLAGS: 00010086
>> RAX: 0000000000000050 RBX: ffff8801bb387af8 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff816585a5 RDI: 0000000000000005
>> RBP: ffff8801bb387560 R08: ffff8801cb208a20 R09: ffffed003b5c5008
>> R10: ffffed003b5c5008 R11: ffff8801dae28047 R12: ffff8801d82ea300
>> R13: 0000000000069700 R14: ffff8801d82ea300 R15: ffff8801cb208a10
>>  debug_object_init+0x16/0x20 lib/debugobjects.c:432
>>  debug_timer_init kernel/time/timer.c:704 [inline]
>>  debug_init kernel/time/timer.c:757 [inline]
>>  init_timer_key+0xa9/0x480 kernel/time/timer.c:806
>>  sock_init_data+0xe1/0xdc0 net/core/sock.c:2696
>>  bpf_prog_test_run_skb+0x255/0xc40 net/bpf/test_run.c:144
>>  bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1790
>>  __do_sys_bpf kernel/bpf/syscall.c:2427 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:2371 [inline]
>>  __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2371
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440259
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffc212cf818 EFLAGS: 00000213 ORIG_RAX: 0000000000000141
>> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440259
>> RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
>> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
>> R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401ae0
>> R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.19.0-rc8-next-20181019+ #98 Not tainted
>> ------------------------------------------------------
>> syz-executor740/5594 is trying to acquire lock:
>> 00000000688fcc6b ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70
>> kernel/locking/semaphore.c:136
>>
>> but task is already holding lock:
>> 00000000505ead1b (&obj_hash[i].lock){-.-.}, at:
>> __debug_object_init+0x127/0x1290 lib/debugobjects.c:384
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #3 (&obj_hash[i].lock){-.-.}:
>>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
>>        __debug_object_init+0x127/0x1290 lib/debugobjects.c:384
>>        debug_object_init+0x16/0x20 lib/debugobjects.c:432
>>        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
>>        debug_init kernel/time/hrtimer.c:458 [inline]
>>        hrtimer_init+0x97/0x490 kernel/time/hrtimer.c:1308
>>        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
>>        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2166
>>        init_idle+0x75/0x740 kernel/sched/core.c:5382
>>        sched_init+0xb33/0xc02 kernel/sched/core.c:6065
>>        start_kernel+0x4be/0xa2b init/main.c:608
>>        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
>>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
>>        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
>>
>> -> #2 (&rq->lock){-.-.}:
>>        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>>        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
>>        rq_lock kernel/sched/sched.h:1127 [inline]
>>        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9768
>>        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
>>        copy_process+0x2585/0x8770 kernel/fork.c:1887
>>        _do_fork+0x1cb/0x11c0 kernel/fork.c:2216
>>        kernel_thread+0x34/0x40 kernel/fork.c:2275
>>        rest_init+0x28/0x372 init/main.c:409
>>        arch_call_rest_init+0xe/0x1b
>>        start_kernel+0x9f0/0xa2b init/main.c:745
>>        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
>>        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
>>        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
>>
>> -> #1 (&p->pi_lock){-.-.}:
>>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
>>        try_to_wake_up+0xd2/0x12e0 kernel/sched/core.c:1965
>>        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
>>        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
>>        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
>>        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
>>        console_unlock+0x80c/0x1190 kernel/printk/printk.c:2432
>>        vprintk_emit+0x391/0x990 kernel/printk/printk.c:1922
>>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
>>        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
>>        printk+0xa7/0xcf kernel/printk/printk.c:1997
>>        check_stack_usage kernel/exit.c:755 [inline]
>>        do_exit.cold.18+0x57/0x16f kernel/exit.c:916
>>        do_group_exit+0x177/0x440 kernel/exit.c:970
>>        __do_sys_exit_group kernel/exit.c:981 [inline]
>>        __se_sys_exit_group kernel/exit.c:979 [inline]
>>        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
>>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> -> #0 ((console_sem).lock){-.-.}:
>>        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
>>        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>>        __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
>>        console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
>>        console_trylock_spinning kernel/printk/printk.c:1653 [inline]
>>        vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
>>        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
>>        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
>>        printk+0xa7/0xcf kernel/printk/printk.c:1997
>>        debug_object_is_on_stack lib/debugobjects.c:363 [inline]
>>        __debug_object_init.cold.14+0x4a/0xdf lib/debugobjects.c:395
>>        debug_object_init+0x16/0x20 lib/debugobjects.c:432
>>        debug_timer_init kernel/time/timer.c:704 [inline]
>>        debug_init kernel/time/timer.c:757 [inline]
>>        init_timer_key+0xa9/0x480 kernel/time/timer.c:806
>>        sock_init_data+0xe1/0xdc0 net/core/sock.c:2696
>>        bpf_prog_test_run_skb+0x255/0xc40 net/bpf/test_run.c:144
>>        bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1790
>>        __do_sys_bpf kernel/bpf/syscall.c:2427 [inline]
>>        __se_sys_bpf kernel/bpf/syscall.c:2371 [inline]
>>        __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2371
>>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>   (console_sem).lock --> &rq->lock --> &obj_hash[i].lock
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&obj_hash[i].lock);
>>                                lock(&rq->lock);
>>                                lock(&obj_hash[i].lock);
>>   lock((console_sem).lock);
>>
>>  *** DEADLOCK ***
>>
>> 1 lock held by syz-executor740/5594:
>>  #0: 00000000505ead1b (&obj_hash[i].lock){-.-.}, at:
>> __debug_object_init+0x127/0x1290 lib/debugobjects.c:384
>>
>> stack backtrace:
>> CPU: 0 PID: 5594 Comm: syz-executor740 Not tainted 4.19.0-rc8-next-20181019+
>> #98
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>>  print_circular_bug.isra.35.cold.54+0x1bd/0x27d
>> kernel/locking/lockdep.c:1221
>>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>>  validate_chain kernel/locking/lockdep.c:2347 [inline]
>>  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
>>  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
>>  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>>  __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
>>  console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
>>  console_trylock_spinning kernel/printk/printk.c:1653 [inline]
>>  vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
>>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
>>  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
>>  printk+0xa7/0xcf kernel/printk/printk.c:1997
>>  debug_object_is_on_stack lib/debugobjects.c:363 [inline]
>>  __debug_object_init.cold.14+0x4a/0xdf lib/debugobjects.c:395
>>  debug_object_init+0x16/0x20 lib/debugobjects.c:432
>>  debug_timer_init kernel/time/timer.c:704 [inline]
>>  debug_init kernel/time/timer.c:757 [inline]
>>  init_timer_key+0xa9/0x480 kernel/time/timer.c:806
>>  sock_init_data+0xe1/0xdc0 net/core/sock.c:2696
>>  bpf_prog_test_run_skb+0x255/0xc40 net/bpf/test_run.c:144
>>  bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1790
>>  __do_sys_bpf kernel/bpf/syscall.c:2427 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:2371 [inline]
>>  __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2371
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440259
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffc212cf818 EFLAGS: 00000213 ORIG_RAX: 0000000000000141
>> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440259
>> RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
>> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
>> R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401ae0
>> R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008db3210579416691%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
