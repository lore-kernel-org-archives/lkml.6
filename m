Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7083A206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTp4CVF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfBWKvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:51:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45904 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBWKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:51:02 -0500
Received: by mail-io1-f68.google.com with SMTP id x9so3842577iog.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnFOiEyol1zwWPfxg/tFyOdsmGhiF1zh5G3vsBZCr6c=;
        b=aTp4CVF38CZKFNpHgV0jXzLyInxzSr5tbzMNfGwjPYtlVr+PfG95OGY+n97/NJ4pq8
         e5/90IP93YL46TUGGBmqAqeqRUJKl48J+bwqe32lPHLxNueJa2DzYQ+cwE+EQpMuHMfQ
         nowmjxL5eoCZOMBKCDWjNKWUxOcV/6h71pwjSHv6aBGbIcvEy2BrHjNU3TmVWk7fZ84k
         /Ftzfpfk7GrhRhvHMkZsZmTstVLmTFOiJX5QxJ2i+aBTuwSzOF9/xsSDyShf8vdAfQfB
         SI3Efw5zrAknYJSEdquUrtZwhmIJ46r7M4bi80gLZ6reuLMHp/vcftfwI5RPdAQPUkrq
         WESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnFOiEyol1zwWPfxg/tFyOdsmGhiF1zh5G3vsBZCr6c=;
        b=MViPZe6Oy9CEcgPj2akkw1rdexOJjDdZk+aC+Z111kyF8I4ewJEpSLlT6VSC3ovq57
         eijvm2GjrxdmmrTtgxk1O192ehO7sYq7IvawzxltmsP6KFdTihnhCxPn//HskL7rGOvT
         pPANnwj0jE7JPaZugFnjxPQzSgFajsc/fCTkgKlkGV5CMt1fyWhL5deDYbHWcu1puZC3
         hrO0Rg88EhyIeakBH+tO8zJ+XrEWqq+XypqIQK0uc31k+32k0hLgwYyBCeGfugW1YdUU
         Df9YCDL9I+PwvXW69ywQJMMuiHK1JtUXgk4ygb/1RFSp8OeYhTF7GUZ6rKpBLkpkXzRL
         r6EA==
X-Gm-Message-State: AHQUAube19yu83/ECWfYJf16uxGtukLU1iaUq+9wDUlNUPJviRYzZcBN
        8YZl93VaPrEy0kKIqRzoPbp4becF/ggeBIQ+Rx1SAQ==
X-Google-Smtp-Source: AHgI3IZWlaj/9oKC/63bbUP76Z3iL8BRg58PNcOv+aXGEesVRuPhBEiSlnYOPNnLL3GRvQ/kH0clackyu8r04zMR9eE=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr4111738ioc.282.1550919060647;
 Sat, 23 Feb 2019 02:51:00 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007da94e05827ea99a@google.com> <20190222222036.GC30766@zn.tnic>
 <CACT4Y+aq+5Hor2f-SsaO4VW3p1Xq2Xk-2OUeKhpp=aOx0XMmzg@mail.gmail.com> <20190223103809.GB23376@zn.tnic>
In-Reply-To: <20190223103809.GB23376@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Feb 2019 11:50:49 +0100
Message-ID: <CACT4Y+ZaUe+_ZT4tLpXWUtfih4ocNgAsa4WdV4NRceLdK4tc4Q@mail.gmail.com>
Subject: Re: WARNING in rcu_check_gp_start_stall
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, puwen@hygon.cn,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:38 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Feb 23, 2019 at 11:33:33AM +0100, Dmitry Vyukov wrote:
> > On Fri, Feb 22, 2019 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Feb 22, 2019 at 09:10:04AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    8a61716ff2ab Merge tag 'ceph-for-5.0-rc8' of git://github...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1531dd3f400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000
> > >
> > > So I ran this for more than an hour in a guest here with the above
> > > .config but nothing happened. The compiler I used is 8.2, dunno of that
> > > makes the difference or I'm missing something else...
> >
> > I was able to reproduce this on the first run:
> >
> > # ./syz-execprog -procs=8 -repeat=0 hang
>
> Ok, this is what I'm missing: I ran the reproducer directly but you run
> a multithreaded thing with this syz-execprog. Where do I get that syz-
> thing?
>
> > There is a bunch of other bug reports about hangs where reproducers
> > mention perf_event_open and sched_setattr.
>
> This is a known issue, says peterz.


Peter, what is the canonical location to reference for this issue
(open bug or something)? When we get back to this report later, how
does one know if this is fixed or not and what's the status?

The C repro hanged the machine even faster, so it must be some other difference.
I would expect compiler to not make difference. qemu, number of CPUs
and maybe host kernel config (at least for interrupt granularity or
something?) may be relevant.

But if you want to run syzkaller reproducer with syz-execprog, there
is a docs link in the "syz repro" link.

# [   38.881989] hrtimer: interrupt took 28594 ns
[   91.730829] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0
nice=0 stuck for 51s!
[   91.734505] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0
nice=0 stuck for 51s!
[   91.735403] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0
nice=0 stuck for 51s!
[   91.736273] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0
nice=-20 stuck for 49s!
[   91.737173] BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0
nice=0 stuck for 51s!
[   91.738044] BUG: workqueue lockup - pool cpus=0-3 flags=0x4 nice=0
stuck for 49s!
[   91.738887] Showing busy workqueues and worker pools:
[   91.739496] workqueue events: flags=0x0
[   91.740012]   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=3/256
[   91.740784]     pending: defense_work_handler, e1000_watchdog, cache_reap
[   91.741584]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=2/256
[   91.742237]     pending: cache_reap, check_corruption
[   91.742802]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
[   91.743451]     pending: cache_reap
[   91.743844]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=3/256
[   91.744497]     pending: vmstat_shepherd, cache_reap, psi_update_work
[   91.745286] workqueue events_unbound: flags=0x2
[   91.745872]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/512
[   91.747586]     pending: flush_to_ldisc
[   91.748049]
[   91.748052] ======================================================
[   91.748055] WARNING: possible circular locking dependency detected
[   91.748056] 5.0.0-rc7+ #7 Not tainted
[   91.748058] ------------------------------------------------------
[   91.748060] a.out/6057 is trying to acquire lock:
[   91.748062] 00000000a11439e2 (console_owner){-.-.}, at:
console_unlock+0x4d3/0x11e0
[   91.748068]
[   91.748069] but task is already holding lock:
[   91.748071] 0000000082e8b4f5 (&pool->lock/1){-.-.}, at:
show_workqueue_state.cold+0xac5/0x15a8
[   91.748078]
[   91.748080] which lock already depends on the new lock.
[   91.748081]
[   91.748082]
[   91.748084] the existing dependency chain (in reverse order) is:
[   91.748085]
[   91.748086] -> #3 (&pool->lock/1){-.-.}:
[   91.748092]        _raw_spin_lock+0x2f/0x40
[   91.748094]        __queue_work+0x2d9/0x1450
[   91.748095]        queue_work_on+0x192/0x200
[   91.748097]        tty_schedule_flip+0x149/0x1e0
[   91.748099]        tty_flip_buffer_push+0x16/0x20
[   91.748101]        pty_write+0x1a6/0x200
[   91.748102]        n_tty_write+0xb9e/0x1220
[   91.748104]        tty_write+0x45b/0x7a0
[   91.748105]        __vfs_write+0x116/0xb40
[   91.748107]        vfs_write+0x20c/0x580
[   91.748109]        ksys_write+0x105/0x260
[   91.748110]        __x64_sys_write+0x73/0xb0
[   91.748112]        do_syscall_64+0x1a3/0x800
[   91.748114]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   91.748115]
[   91.748116] -> #2 (&(&port->lock)->rlock){-.-.}:
[   91.748122]        _raw_spin_lock_irqsave+0x95/0xd0
[   91.748123]        tty_port_tty_get+0x22/0x80
[   91.748125]        tty_port_default_wakeup+0x16/0x40
[   91.748127]        tty_port_tty_wakeup+0x5d/0x70
[   91.748129]        uart_write_wakeup+0x46/0x70
[   91.748131]        serial8250_tx_chars+0x4a4/0xcc0
[   91.748133]        serial8250_handle_irq.part.0+0x1be/0x2e0
[   91.748135]        serial8250_default_handle_irq+0xc5/0x150
[   91.748136]        serial8250_interrupt+0xfb/0x1a0
[   91.748138]        __handle_irq_event_percpu+0x1c6/0xb10
[   91.748140]        handle_irq_event_percpu+0xa0/0x1d0
[   91.748142]        handle_irq_event+0xa7/0x134
[   91.748144]        handle_edge_irq+0x232/0x8a0
[   91.748145]        handle_irq+0x252/0x3d8
[   91.748147]        do_IRQ+0x99/0x1d0
[   91.748148]        ret_from_intr+0x0/0x1e
[   91.748150]        native_safe_halt+0x2/0x10
[   91.748152]        arch_cpu_idle+0x10/0x20
[   91.748153]        default_idle_call+0x36/0x90
[   91.748155]        do_idle+0x386/0x5d0
[   91.748157]        cpu_startup_entry+0x1b/0x20
[   91.748158]        rest_init+0x245/0x37b
[   91.748160]        arch_call_rest_init+0xe/0x1b
[   91.748161]        start_kernel+0x877/0x8b2
[   91.748163]        x86_64_start_reservations+0x29/0x2b
[   91.748165]        x86_64_start_kernel+0x77/0x7b
[   91.748167]        secondary_startup_64+0xa4/0xb0
[   91.748168]
[   91.748169] -> #1 (&port_lock_key){-.-.}:
[   91.748175]        _raw_spin_lock_irqsave+0x95/0xd0
[   91.748177]        serial8250_console_write+0x253/0xab0
[   91.748178]        univ8250_console_write+0x5f/0x70
[   91.748180]        console_unlock+0xcff/0x11e0
[   91.748182]        vprintk_emit+0x370/0x960
[   91.748183]        vprintk_default+0x28/0x30
[   91.748185]        vprintk_func+0x7e/0x189
[   91.748187]        printk+0xba/0xed
[   91.748189]        register_console+0x74d/0xb50
[   91.748190]        univ8250_console_init+0x3e/0x4b
[   91.748192]        console_init+0x6af/0x9f3
[   91.748194]        start_kernel+0x5dc/0x8b2
[   91.748196]        x86_64_start_reservations+0x29/0x2b
[   91.748198]        x86_64_start_kernel+0x77/0x7b
[   91.748200]        secondary_startup_64+0xa4/0xb0
[   91.748200]
[   91.748201] -> #0 (console_owner){-.-.}:
[   91.748207]        lock_acquire+0x1db/0x570
[   91.748209]        console_unlock+0x53d/0x11e0
[   91.748211]        vprintk_emit+0x370/0x960
[   91.748212]        vprintk_default+0x28/0x30
[   91.748214]        vprintk_func+0x7e/0x189
[   91.748215]        printk+0xba/0xed
[   91.748217]        show_workqueue_state.cold+0xc5f/0x15a8
[   91.748219]        wq_watchdog_timer_fn+0x6bd/0x7e0
[   91.748221]        call_timer_fn+0x254/0x900
[   91.748222]        __run_timers+0x6fc/0xd50
[   91.748224]        run_timer_softirq+0x88/0xb0
[   91.748226]        __do_softirq+0x30b/0xb11
[   91.748227]        irq_exit+0x180/0x1d0
[   91.748229]        smp_apic_timer_interrupt+0x1b7/0x760
[   91.748231]        apic_timer_interrupt+0xf/0x20
[   91.748233]        __sanitizer_cov_trace_const_cmp8+0x13/0x20
[   91.748234]        sanity+0x109/0x330
[   91.748236]        copy_page_to_iter+0x634/0x1000
[   91.748238]        generic_file_read_iter+0xbb1/0x2d40
[   91.748240]        ext4_file_read_iter+0x180/0x3c0
[   91.748242]        generic_file_splice_read+0x5c4/0xa90
[   91.748243]        do_splice_to+0x12a/0x190
[   91.748245]        splice_direct_to_actor+0x31b/0x9d0
[   91.748247]        do_splice_direct+0x2c7/0x420
[   91.748249]        do_sendfile+0x61d/0xe60
[   91.748250]        __x64_sys_sendfile64+0x15a/0x240
[   91.748252]        do_syscall_64+0x1a3/0x800
[   91.748254]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   91.748255]
[   91.748257] other info that might help us debug this:
[   91.748258]
[   91.748259] Chain exists of:
[   91.748260]   console_owner --> &(&port->lock)->rlock --> &pool->lock/1
[   91.748268]
[   91.748270]  Possible unsafe locking scenario:
[   91.748271]
[   91.748273]        CPU0                    CPU1
[   91.748274]        ----                    ----
[   91.748275]   lock(&pool->lock/1);
[   91.748280]                                lock(&(&port->lock)->rlock);
[   91.748284]                                lock(&pool->lock/1);
[   91.748288]   lock(console_owner);
[   91.748291]
[   91.748293]  *** DEADLOCK ***
[   91.748293]
[   91.748295] 5 locks held by a.out/6057:
[   91.748296]  #0: 00000000878cae3a (sb_writers#3){.+.+}, at:
do_sendfile+0xae0/0xe60
[   91.748304]  #1: 000000007b4589c2 ((&wq_watchdog_timer)){+.-.}, at:
call_timer_fn+0x1b4/0x900
[   91.748311]  #2: 0000000085eca237 (rcu_read_lock_sched){....}, at:
show_workqueue_state+0x0/0x180
[   91.748318]  #3: 0000000082e8b4f5 (&pool->lock/1){-.-.}, at:
show_workqueue_state.cold+0xac5/0x15a8
[   91.748326]  #4: 00000000fffd7726 (console_lock){+.+.}, at:
vprintk_emit+0x351/0x960
[   91.748332]
[   91.748334] stack backtrace:
[   91.748336] CPU: 0 PID: 6057 Comm: a.out Not tainted 5.0.0-rc7+ #7
[   91.748339] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   91.748340] Call Trace:
[   91.748341]  <IRQ>
[   91.748343]  dump_stack+0x1db/0x2d0
[   91.748345]  ? dump_stack_print_info.cold+0x20/0x20
[   91.748347]  ? print_stack_trace+0x77/0xb0
[   91.748348]  ? vprintk_func+0x86/0x189
[   91.748350]  print_circular_bug.isra.0.cold+0x1cc/0x28f
[   91.748352]  __lock_acquire+0x3014/0x4a30
[   91.748354]  ? mark_held_locks+0x100/0x100
[   91.748355]  ? memcpy+0x46/0x50
[   91.748357]  ? add_lock_to_list.isra.0+0x450/0x450
[   91.748358]  ? sprintf+0xc0/0x100
[   91.748360]  ? scnprintf+0x140/0x140
[   91.748362]  ? console_unlock+0x518/0x11e0
[   91.748364]  ? find_held_lock+0x35/0x120
[   91.748365]  lock_acquire+0x1db/0x570
[   91.748367]  ? console_unlock+0x4d3/0x11e0
[   91.748369]  ? lock_release+0xc40/0xc40
[   91.748371]  ? do_raw_spin_trylock+0x270/0x270
[   91.748373]  ? lock_acquire+0x1db/0x570
[   91.748374]  console_unlock+0x53d/0x11e0
[   91.748376]  ? console_unlock+0x4d3/0x11e0
[   91.748378]  ? kmsg_dump_rewind+0x2b0/0x2b0
[   91.748380]  ? _raw_spin_unlock_irqrestore+0xa4/0xe0
[   91.748382]  ? vprintk_emit+0x351/0x960
[   91.748384]  ? __down_trylock_console_sem+0x148/0x210
[   91.748385]  vprintk_emit+0x370/0x960
[   91.748387]  ? wake_up_klogd+0x180/0x180
[   91.748389]  ? lockdep_hardirqs_on+0x19b/0x5d0
[   91.748390]  ? retint_kernel+0x2d/0x2d
[   91.748392]  ? trace_hardirqs_on_caller+0xc0/0x310
[   91.748394]  vprintk_default+0x28/0x30
[   91.748396]  vprintk_func+0x7e/0x189
[   91.748397]  ? printk+0xba/0xed
[   91.748398]  printk+0xba/0xed
[   91.748400]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   91.748402]  ? wq_watchdog_touch+0xb0/0x102
[   91.748404]  show_workqueue_state.cold+0xc5f/0x15a8
[   91.748406]  ? print_worker_info+0x540/0x540
[   91.748408]  ? add_lock_to_list.isra.0+0x450/0x450
[   91.748409]  ? retint_kernel+0x2d/0x2d
[   91.748411]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   91.748413]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748415]  ? lock_downgrade+0x910/0x910
[   91.748416]  ? kasan_check_read+0x11/0x20
[   91.748418]  ? rcu_dynticks_curr_cpu_in_eqs+0xa2/0x170
[   91.748420]  ? rcu_read_unlock_special+0x380/0x380
[   91.748422]  ? wq_watchdog_timer_fn+0x4f4/0x7e0
[   91.748424]  wq_watchdog_timer_fn+0x6bd/0x7e0
[   91.748426]  ? show_workqueue_state+0x180/0x180
[   91.748428]  ? add_lock_to_list.isra.0+0x450/0x450
[   91.748430]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748432]  ? check_preemption_disabled+0x48/0x290
[   91.748433]  ? __lock_is_held+0xb6/0x140
[   91.748435]  call_timer_fn+0x254/0x900
[   91.748437]  ? show_workqueue_state+0x180/0x180
[   91.748438]  ? process_timeout+0x40/0x40
[   91.748440]  ? retint_kernel+0x2d/0x2d
[   91.748442]  ? show_workqueue_state+0x180/0x180
[   91.748443]  ? _raw_spin_unlock_irq+0x54/0x90
[   91.748445]  ? show_workqueue_state+0x180/0x180
[   91.748447]  __run_timers+0x6fc/0xd50
[   91.748449]  ? __bpf_trace_timer_expire_entry+0x30/0x30
[   91.748451]  ? print_usage_bug+0xd0/0xd0
[   91.748452]  ? find_held_lock+0x35/0x120
[   91.748454]  ? clockevents_program_event+0x15f/0x380
[   91.748456]  ? add_lock_to_list.isra.0+0x450/0x450
[   91.748458]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748460]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748462]  ? check_preemption_disabled+0x48/0x290
[   91.748464]  ? __lock_is_held+0xb6/0x140
[   91.748466]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748468]  ? check_preemption_disabled+0x48/0x290
[   91.748469]  run_timer_softirq+0x88/0xb0
[   91.748471]  ? rcu_read_lock_sched_held+0x110/0x130
[   91.748473]  __do_softirq+0x30b/0xb11
[   91.748475]  ? __irqentry_text_end+0x1f96c2/0x1f96c2
[   91.748477]  ? kvm_clock_read+0x18/0x30
[   91.748478]  ? kvm_sched_clock_read+0x9/0x20
[   91.748480]  ? sched_clock+0x2e/0x50
[   91.748482]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[   91.748484]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[   91.748486]  ? check_preemption_disabled+0x48/0x290
[   91.748487]  irq_exit+0x180/0x1d0
[   91.748489]  smp_apic_timer_interrupt+0x1b7/0x760
[   91.748491]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   91.748493]  ? smp_call_function_single_interrupt+0x640/0x640
[   91.748495]  ? trace_hardirqs_off+0x310/0x310
[   91.748497]  ? task_prio+0x50/0x50
[   91.748499]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[   91.748501]  ? check_preemption_disabled+0x48/0x290
[   91.748502]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   91.748504]  apic_timer_interrupt+0xf/0x20
[   91.748505]  </IRQ>
[   91.748508] RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x13/0x20
[   91.748509] Code: 00
[   91.748512] Lost 71 message(s)!
[   91.866234] workqueue events_power_efficient: flags=0x80
[   91.866863]   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=2/256
[   91.867568]     pending: gc_worker, neigh_periodic_work
[   91.868202]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=3/256
[   91.868911]     pending: crda_timeout_work, neigh_periodic_work,
do_cache_clean
[   91.869781]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[   91.870488]     pending: fb_flashcursor
[   91.870963] workqueue mm_percpu_wq: flags=0x8
[   91.871482]   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256
[   91.872188]     pending: vmstat_update
[   91.872644]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
[   91.873353]     pending: vmstat_update
[   91.873806]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
[   91.874512]     pending: vmstat_update
[   91.874964]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[   91.875670]     pending: vmstat_update
[   91.876131] workqueue writeback: flags=0x4e
[   91.876631]   pwq 8: cpus=0-3 flags=0x4 nice=0 active=1/256
[   91.877292]     pending: wb_workfn
[   91.877716] workqueue kblockd: flags=0x18
[   91.878201]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256
[   91.878930]     pending: blk_mq_timeout_work
[   91.879513] workqueue dm_bufio_cache: flags=0x8
[   91.880053]   pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256
[   91.880761]     pending: work_fn
