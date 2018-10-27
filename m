Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E5C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9FF20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSS8V4x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9FF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeJ0T5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:57:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33695 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeJ0T5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:57:52 -0400
Received: by mail-it1-f195.google.com with SMTP id h6-v6so6489197ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0781gJOjO76kYtQR1KxNXFJAf5l4cns/NMzPhquz0tw=;
        b=VSS8V4x2ljZrTKE8q5Yi57Vl6AsykPy3HLTQoDTED6h+NNib8NJrjcmDgUxFR1EANj
         0Tin3pqSvwcTCks7a1ncgR+C3lT7F5L2NvU1Xuqir5+l8+UIxAO1kqXJ5aUJLQ0DAixJ
         QhDBF7lFcvfKX8QTyYivAMMfHPu6eVyjxUCtTMEIxtWFeZ6YG96IUaOWrBxykmtSrzlZ
         D5VLOQkS+hUvoYlK/Xi3HL24k+m2PUMg9+KgalotVJDOJ6ufbI8BrlXzlPkCfIgKZB5m
         eLKTxVPzXN9+fKaX9IxXbGHrvylmiNd4ft8ZO9O2sgESwcs55M25ydH9KX3tZBZGlwGj
         WuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0781gJOjO76kYtQR1KxNXFJAf5l4cns/NMzPhquz0tw=;
        b=r9/oZwpSWFEN/ehRmGBYbHipzyGB3NrUNIEhW8vPWtA7t3fZwxTawr7XDi+O1mLm1b
         2DY8OwALUUMYK24gtuLTgK3erHmwYPgEYpOA8Ed/O03FE62GhU2ryHqol6QZyODyQ+YD
         SHBSwNsCZQrLQGvhcOfjQiE1JLz0gVqeO2rOBxhDFY4u2AQVm0Ykrn3etO3A+c9b8mbL
         6zI//i6mbRlPgVGJNUWdQlexVVI/X3+QnlWvxoJ+e+02+mdPHcGans0pJElFgT+SPp5N
         v/zjW6k3mtutPFmau1QzylP567EtJOj9fw34gTNjDFjGISMnER4S2vg34rx4//Hs+t75
         YJ6g==
X-Gm-Message-State: AGRZ1gLhaL+IlocnF+LVrPP/UBqz57WzyhGp1Tc39kelCPS57Y0R5KnL
        u94sYxGnHldG3724be97o1PdORTGwcjoyeDAfWkpPA==
X-Google-Smtp-Source: AJdET5d0GqCqnyAFWueCN13bNpyKAWIZRqc+d+wuAX10CkLJfCnpxx1gEy45zBb70gJpb/7PKZxGzNz0ZP0j/CcsdK4=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr6083625ite.12.1540639033640;
 Sat, 27 Oct 2018 04:17:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Sat, 27 Oct 2018 04:16:52
 -0700 (PDT)
In-Reply-To: <20181024120335.GE29272@localhost.localdomain>
References: <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain> <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain> <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64> <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64> <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere> <20181024120335.GE29272@localhost.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 27 Oct 2018 12:16:52 +0100
Message-ID: <CACT4Y+Y3uvX+Zb9nG_sYfbRXoxD1XR-1PLyitwm-UQyjGv5r1A@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in do_idle
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nstange@suse.de,
        syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:03 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
>
> On 19/10/18 22:50, luca abeni wrote:
> > On Fri, 19 Oct 2018 13:39:42 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > On Thu, Oct 18, 2018 at 01:08:11PM +0200, luca abeni wrote:
> > > > Ok, I see the issue now: the problem is that the "while
> > > > (dl_se->runtime <= 0)" loop is executed at replenishment time, but
> > > > the deadline should be postponed at enforcement time.
> > > >
> > > > I mean: in update_curr_dl() we do:
> > > >   dl_se->runtime -= scaled_delta_exec;
> > > >   if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > >           ...
> > > >           enqueue replenishment timer at dl_next_period(dl_se)
> > > > But dl_next_period() is based on a "wrong" deadline!
> > > >
> > > >
> > > > I think that inserting a
> > > >         while (dl_se->runtime <= -pi_se->dl_runtime) {
> > > >                 dl_se->deadline += pi_se->dl_period;
> > > >                 dl_se->runtime += pi_se->dl_runtime;
> > > >         }
> > > > immediately after "dl_se->runtime -= scaled_delta_exec;" would fix
> > > > the problem, no?
> > >
> > > That certainly makes sense to me.
> >
> > Good; I'll try to work on this idea in the weekend.
>
> So, we (me and Luca) managed to spend some more time on this and found a
> few more things worth sharing. I'll try to summarize what we have got so
> far (including what already discussed) because impression is that each
> point might deserve a fix or at least consideration (just amazing how a
> simple random fuzzer thing can highlight all that :).

1. Fuzzing finds bugs in any code. Always.
If a code wasn't fuzzed, there are bugs.

2. This fuzzer is not so simple ;)


> Apologies for the
> long email.
>
> Reproducer runs on a CONFIG_HZ=100, CONFIG_IRQ_TIME_ACCOUNTING kernel
> and does something like this (only the bits that seems to matter here)
>
> int main(void)
> {
>   [...]
>   [setup stuff at 0x2001d000]
>   syscall(__NR_perf_event_open, 0x2001d000, 0, -1, -1, 0);
>   *(uint32_t*)0x20000000 = 0;
>   *(uint32_t*)0x20000004 = 6;
>   *(uint64_t*)0x20000008 = 0;
>   *(uint32_t*)0x20000010 = 0;
>   *(uint32_t*)0x20000014 = 0;
>   *(uint64_t*)0x20000018 = 0x9917; <-- ~40us
>   *(uint64_t*)0x20000020 = 0xffff; <-- ~65us (~60% bandwidth)
>   *(uint64_t*)0x20000028 = 0;
>   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
>   [busy loop]
>   return 0;
> }
>
> And this causes problems because the task is actually never throttled.
>
> Pain points:
>
>  1. Granularity of enforcement (at each tick) is huge compared with
>     the task runtime. This makes starting the replenishment timer,
>     when runtime is depleted, always to fail (because old deadline
>     is way in the past). So, the task is fully replenished and put
>     back to run.
>
>     - Luca's proposal should help here, since the deadline is postponed
>       at throttling time, and replenishment timer set to that (and it
>       should be in the future)
>
>  1.1 Even if we fix 1. in a configuration like this, the task would
>      still be able to run for ~10ms (worst case) and potentially starve
>      other tasks. It doesn't seem a too big interval maybe, but there
>      might be other very short activities that might miss an occasion
>      to run "quickly".
>
>      - Might be fixed by imposing (via sysctl) reasonable defaults for
>        minimum runtime (w.r.t. HZ, like HZ/2) and maximum for period
>        (as also a very small bandwidth task can have a big runtime if
>        period is big as well)
>
>  (1.2) When runtime becomes very negative (because delta_exec was big)
>        we seem to spend lot of time inside the replenishment loop.
>
>        - Not sure it's such a big problem, might need more profiling.
>          Feeling is that once the other points will be addressed this
>          won't matter anymore
>
>  2. This is related to perf_event_open syscall reproducer does before
>     becoming DEADLINE and entering the busy loop. Enabling of perf
>     swevents generates lot of hrtimers load that happens in the
>     reproducer task context. Now, DEADLINE uses rq_clock() for setting
>     deadlines, but rq_clock_task() for doing runtime enforcement.
>     In a situation like this it seems that the amount of irq pressure
>     becomes pretty big (I'm seeing this on kvm, real hw should maybe do
>     better, pain point remains I guess), so rq_clock() and
>     rq_clock_task() might become more a more skewed w.r.t. each other.
>     Since rq_clock() is only used when setting absolute deadlines for
>     the first time (or when resetting them in certain cases), after a
>     bit the replenishment code will start to see postponed deadlines
>     always in the past w.r.t. rq_clock(). And this brings us back to the
>     fact that the task is never stopped, since it can't keep up with
>     rq_clock().
>
>     - Not sure yet how we want to address this [1]. We could use
>       rq_clock() everywhere, but tasks might be penalized by irq
>       pressure (theoretically this would mandate that irqs are
>       explicitly accounted for I guess). I tried to use the skew between
>       the two clocks to "fix" deadlines, but that puts us at risks of
>       de-synchronizing userspace and kernel views of deadlines.
>
>  3. HRTICK is not started for new entities.
>
>     - Already got a patch for it.
>
> This should be it, I hope. Luca (thanks a lot for your help) and please
> add or correct me if I was wrong.
>
> Thoughts?
>
> Best,
>
> - Juri
>
> 1 - https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L1162
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20181024120335.GE29272%40localhost.localdomain.
> For more options, visit https://groups.google.com/d/optout.
