Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9871E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfn557LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeL0J52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:57:28 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:39632 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbeL0J51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:57:27 -0500
Received: by mail-it1-f171.google.com with SMTP id a6so23110649itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh4CwJYexQOTSq9snDzkTVP2sYCW9ydJg6x06xSu0/Q=;
        b=kfn557LG4pn3Ug3IAquzq059EKkP9mTbWz+esMk/DEw9cr/a1fhu6Uk0PLXjzaQ9+s
         1PD3XLYaNQmk5/Z39tkwl4p39E5q+LwDo8iblupxvUZPKGwYKC7hS2X8Meej+4mIi5sz
         fmP5Ido/3muTWzZWFpgsBIDv+Ttig0ERPY2XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh4CwJYexQOTSq9snDzkTVP2sYCW9ydJg6x06xSu0/Q=;
        b=klc/Ma0n9D43HGL5xWAsb7zUPpjiKI/uYBqu4tpGo+awKy6SHDtR6NH05rd/8byWbF
         E3LuzPEhhSEz7L+9HR28OeaDxPqpBs4sok+OrFUckqykW6LcR8WxjxOgScCMTwsmgejv
         eG2r0lDLjNIXoy7VXazoCMbnmxYAmaIO+P2nvCrXPp0wH2DbGv7mHIXI27SBuMhv8m8P
         H8nsLs3TcCguh2WsKI6Rk//D1zYgJ6RKyc6viKJ7LwMFkXHW4V4XQU3DiNwgND/XPJnw
         LdZH/5i14GOAFiTc0zUJXBKv/TIDDq7mm6MHhrSYG3TPLfwjUZEIkCD1rubjk6BSIc8y
         F8Jg==
X-Gm-Message-State: AA+aEWb1DZUgRvM9Atjx+eWgSJwuk+6mY/kOLjhlddD4fVIi9tHCS7i3
        UtqVa0sFfQ11UqYyHIytwqiPxJouEs6+A9EfYfZkjH//FPXsOQ==
X-Google-Smtp-Source: AFSGD/X4t21g922gLgz3bm6Wxl7zMo8CwnTkJ3x/9dwdydWTjCNI9r1Trdlx3EY0irA18YWEkO9LJsUD/7IGq/vsvE4=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr14677941itb.152.1545904645679;
 Thu, 27 Dec 2018 01:57:25 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn8YdVh62Ti=CPfoerK=QuHTp-HKiWPEdRb8kB325-KDdw@mail.gmail.com>
 <CAMp4zn-J22fU8+Rp4WYtB0cZpXHo=mde_LWc+jjzRm9b=F=vNA@mail.gmail.com>
In-Reply-To: <CAMp4zn-J22fU8+Rp4WYtB0cZpXHo=mde_LWc+jjzRm9b=F=vNA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Dec 2018 10:57:14 +0100
Message-ID: <CAKfTPtB02C6P9VYYk2j0Kw7By529axQ2mxoZLqEJAojpPK60iw@mail.gmail.com>
Subject: Re: CPUs blocking in update_blocked_averages -- 4.19.12
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, dmitry.adamushko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sargun,

On Thu, 27 Dec 2018 at 10:36, Sargun Dhillon <sargun@sargun.me> wrote:
>
> >
> > We're seeing an issue introduced in 4.18, and that still persists in
> > 4.19.12 (we upgraded from 4.9), where update_blocked_averages is
> > blocking. We're running a workload where a majority of our workloads
> > are  confined by cgroups. This exhibits itself due to a softlockup on
> > a CPU which is waiting on a lock that's held by
> > update_blocked_averages. I don't have access to any bare metal
> > hardware at the moment, and these are all systems running under KVM.
> > This kernel has CONFIG_FAIR_GROUP_SCHED on.

Your report looks similar to Xie ones:
https://lkml.org/lkml/2018/12/26/541

> >
> > The Softlocked CPU:
> > crash> bt
> > PID: 29314  TASK: ffff99b5f0671f00  CPU: 0   COMMAND: "ag"
> >  #0 [ffff99b67b203d58] machine_kexec at ffffffff91a602f3
> >  #1 [ffff99b67b203db0] __crash_kexec at ffffffff91b49011
> >  #2 [ffff99b67b203e70] panic at ffffffff91a896d1
> >  #3 [ffff99b67b203ef8] watchdog_timer_fn at ffffffff91b816af
> >  #4 [ffff99b67b203f28] __hrtimer_run_queues at ffffffff91b26359
> >  #5 [ffff99b67b203f88] hrtimer_interrupt at ffffffff91b26de2
> >  #6 [ffff99b67b203fd8] smp_apic_timer_interrupt at ffffffff92402b06
> >  #7 [ffff99b67b203ff0] apic_timer_interrupt at ffffffff92401a9f
> > --- <IRQ stack> ---
> >  #8 [ffffa49fa1acbc08] apic_timer_interrupt at ffffffff92401a9f
> >     [exception RIP: smp_call_function_many+543]
> >     RIP: ffffffff91b3e84f  RSP: ffffa49fa1acbcb0  RFLAGS: 00000202
> >     RAX: 0000000000000010  RBX: ffff99b67b224fc0  RCX: ffff99b67b6286a0
> >     RDX: 0000000000000001  RSI: 0000000000000200  RDI: ffff99b67b224fc8
> >     RBP: ffff99b67b224fc8   R8: 0000000000000001   R9: 0000000000000000
> >     R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000025080
> >     R13: ffffa49fa1acbd00  R14: 0000000000000001  R15: 0000000000000200
> >     ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
> >  #9 [ffffa49fa1acbcf8] flush_tlb_mm_range at ffffffff91a7853c
> > #10 [ffffa49fa1acbd90] free_pgtables at ffffffff91c4ac3b
> > #11 [ffffa49fa1acbdc8] unmap_region at ffffffff91c54439
> > #12 [ffffa49fa1acbe90] do_munmap at ffffffff91c56355
> > #13 [ffffa49fa1acbee0] vm_munmap at ffffffff91c56587
> > #14 [ffffa49fa1acbf20] __x64_sys_munmap at ffffffff91c565e2
> > #15 [ffffa49fa1acbf38] do_syscall_64 at ffffffff91a04590
> > #16 [ffffa49fa1acbf50] entry_SYSCALL_64_after_hwframe at ffffffff9240008d
> >     RIP: 00007f43e94de747  RSP: 00007f43e91d7e28  RFLAGS: 00000213
> >     RAX: ffffffffffffffda  RBX: 00000000011a6f30  RCX: 00007f43e94de747
> >     RDX: 0000000000000001  RSI: 0000000000000ade  RDI: 00007f43ea47d000
> >     RBP: 0000000000000005   R8: 00007f43e00008c0   R9: 00007f43e91d7d00
> >     R10: 00000000011a53b0  R11: 0000000000000213  R12: 00007f43ea47d000
> >     R13: 0000000000000ade  R14: 00007f43e91d89c0  R15: 0000000000000060
> >     ORIG_RAX: 000000000000000b  CS: 0033  SS: 002b
> >
> > This is waiting on CPU 16:
> > crash> bt
> > PID: 29299  TASK: ffff99b5dffd1f00  CPU: 16  COMMAND: "ag"
> >  #0 [fffffe00002c8e38] crash_nmi_callback at ffffffff91a54202
> >  #1 [fffffe00002c8e50] nmi_handle at ffffffff91a32ee2
> >  #2 [fffffe00002c8ea0] default_do_nmi at ffffffff91a333ea
> >  #3 [fffffe00002c8ec0] do_nmi at ffffffff91a33553
> >  #4 [fffffe00002c8ef0] end_repeat_nmi at ffffffff924014e8
> >     [exception RIP: native_queued_spin_lock_slowpath+33]
> >     RIP: ffffffff91af2dc1  RSP: ffffa49fa1a93948  RFLAGS: 00000002
> >     RAX: 0000000000000001  RBX: ffff99b67b763f40  RCX: 000000004f19a57a
> >     RDX: 0000000000000001  RSI: 0000000000000001  RDI: ffff99b67b763f40
> >     RBP: 0000000000000082   R8: 0000000000000001   R9: 0000000000000000
> >     R10: ffffa49fa1a938f8  R11: ffffffff91aca4a7  R12: 0000000000000015
> >     R13: ffff99b67b764940  R14: ffffa49fa1a93a60  R15: 0000000000000015
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> > --- <NMI exception stack> ---
> >  #5 [ffffa49fa1a93948] native_queued_spin_lock_slowpath at ffffffff91af2dc1
> >  #6 [ffffa49fa1a93948] do_raw_spin_lock at ffffffff91af48dd
> >  #7 [ffffa49fa1a93958] _raw_spin_lock_irqsave at ffffffff923c1154
> >  #8 [ffffa49fa1a93978] update_blocked_averages at ffffffff91aca4a7
> >  #9 [ffffa49fa1a93a10] update_nohz_stats at ffffffff91acaa3d
> > #10 [ffffa49fa1a93a20] find_busiest_group at ffffffff91ad2137
> > #11 [ffffa49fa1a93bb8] load_balance at ffffffff91ad2be0
> > #12 [ffffa49fa1a93cf0] pick_next_task_fair at ffffffff91ad41e6
> > #13 [ffffa49fa1a93da0] mark_held_locks at ffffffff91aeebe4
> > #14 [ffffa49fa1a93de8] schedule at ffffffff923b9ec2
> > #15 [ffffa49fa1a93df8] rwsem_down_read_failed at ffffffff923be859
> > #16 [ffffa49fa1a93e80] call_rwsem_down_read_failed at ffffffff923ae944
> > #17 [ffffa49fa1a93ec8] down_read at ffffffff923bdf0b
> > #18 [ffffa49fa1a93ee0] __do_page_fault at ffffffff91a71083
> > #19 [ffffa49fa1a93f50] async_page_fault at ffffffff924010ee
> >     RIP: 00007f43e945f786  RSP: 00007ffde2b50070  RFLAGS: 00010206
> >     RAX: 0000000000015f41  RBX: 00007f43e97a1b20  RCX: 0000000000000111
> >     RDX: 00000000011affb0  RSI: 00000000011b00c0  RDI: 0000000000000000
> >     RBP: 0000000000000111   R8: 00007f43e97a1bd8   R9: 0000000000000000
> >     R10: 00007f43e97a1b78  R11: 00007f43e97a1b78  R12: 00007f43e97a1b78
> >     R13: 00007f43e97a1b78  R14: 0000000000002710  R15: 00007f43e97a1c78
> >     ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> >
> > Which is waiting on a lock held by CPU owned by CPU 9:
> > crash> struct raw_spinlock_t ffff99b67b763f40
> > struct raw_spinlock_t {
> >   raw_lock = {
> >     {
> >       val = {
> >         counter = 1
> >       },
> >       {
> >         locked = 1 '\001',
> >         pending = 0 '\000'
> >       },
> >       {
> >         locked_pending = 1,
> >         tail = 0
> >       }
> >     }
> >   },
> >   magic = 3735899821,
> >   owner_cpu = 9,
> >   owner = 0xffff99b66e7a8000,
> >   dep_map = {
> >     key = 0xffffffff9331d120,
> >     class_cache = {0xffffffff93a13da0, 0x0},
> >     name = 0xffffffff92a7d9ad "&rq->lock"
> >   }
> > }
> >
> > Which is hanging out in update_blocked_averages:
> > crash> bt
> > PID: 0      TASK: ffff99b66e7a8000  CPU: 9   COMMAND: "swapper/9"
> >  #0 [fffffe0000194e38] crash_nmi_callback at ffffffff91a54202
> >  #1 [fffffe0000194e50] nmi_handle at ffffffff91a32ee2
> >  #2 [fffffe0000194ea0] default_do_nmi at ffffffff91a33362
> >  #3 [fffffe0000194ec0] do_nmi at ffffffff91a33553
> >  #4 [fffffe0000194ef0] end_repeat_nmi at ffffffff924014e8
> >     [exception RIP: lock_is_held_type+70]
> >     RIP: ffffffff91aecec6  RSP: ffff99b67b443e20  RFLAGS: 00000046
> >     RAX: 0000000000000001  RBX: ffff99b66e7a8000  RCX: 00000000000000a8
> >     RDX: 0000000000000001  RSI: 00000000ffffffff  RDI: 0000000000000046
> >     RBP: 0000000000000046   R8: 0000000000000004   R9: 0000000000000000
> >     R10: ffff99b67b443e38  R11: ffffffff91aca4a7  R12: ffff99b67b763f40
> >     R13: ffff99b67b764940  R14: 0000000000000000  R15: ffff99b6193d9200
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > --- <NMI exception stack> ---
> >  #5 [ffff99b67b443e20] lock_is_held_type at ffffffff91aecec6
> >  #6 [ffff99b67b443e30] update_blocked_averages at ffffffff91aca841
> >  #7 [ffff99b67b443ec8] update_nohz_stats at ffffffff91acaa3d
> >  #8 [ffff99b67b443ed8] _nohz_idle_balance at ffffffff91ad39f7
> >  #9 [ffff99b67b443f70] __softirqentry_text_start at ffffffff926000d1
> > #10 [ffff99b67b443fd0] irq_exit at ffffffff91a911f5
> > #11 [ffff99b67b443fd8] smp_apic_timer_interrupt at ffffffff92402b2c
> > #12 [ffff99b67b443ff0] apic_timer_interrupt at ffffffff92401a9f
> > --- <IRQ stack> ---
> > #13 [ffffa49f98993df8] apic_timer_interrupt at ffffffff92401a9f
> >     [exception RIP: mwait_idle+108]
> >     RIP: ffffffff923c02fc  RSP: ffffa49f98993ea8  RFLAGS: 00000246
> >     RAX: 0000000000000000  RBX: 0000000000000009  RCX: 0000000000000000
> >     RDX: 0000000000000001  RSI: 0000000000000001  RDI: ffff99b66e7a8000
> >     RBP: 0000000000000009   R8: 0000000000000001   R9: 0000000000000000
> >     R10: 0000000000000000  R11: 0000000000000000  R12: ffff99b66e7a8000
> >     R13: 0000000000000000  R14: 0000000000000000  R15: ffff99b66e7a8000
> >     ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
> > #14 [ffffa49f98993ec0] do_idle at ffffffff91ac6ba3
> > #15 [ffffa49f98993f10] cpu_startup_entry at ffffffff91ac6f4f
> > #16 [ffffa49f98993f30] start_secondary at ffffffff91a55759
> > #17 [ffffa49f98993f50] secondary_startup_64 at ffffffff91a000d4
> >
> > ---
> >
> > Lockdep tells me nothing, which makes me think, somehow is the code in
> > for_each_leaf_cfs_rq_safe looping forever?
>
> On further investigation from another crash dump, it looks like (where
> 0xffff9680bb4e3f40 = cpu_rq(11)) --
> crash> struct rq.leaf_cfs_rq_list 0xffff9680bb4e3f40
>   leaf_cfs_rq_list = {
>     next = 0xffff9680622ed980,
>     prev = 0xffff9680bb4e4180
>   }
> crash> struct list_head 0xffff9680622ed980
> struct list_head {
>   next = 0xffff9680622ed980,
>   prev = 0xffff9680622ed980
> }
>
> ---
> I instrumented update_blocked_averages with the start time of the
> function, to keep track of it with the scheduler clock, and it
> coincides at almost exactly 5.5 seconds, way longer than it should be.
>
>
> It looks like it never terminates because it stays in this loop
> forever. I'm not sure how things can get into this state, or even if
> this was the state to start with, and this isn't the result of some
> kind of concurrency skew or other shenanigans.
