Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD63FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B70C2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ExIyHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B70C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI0WhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:37:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44017 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0WhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:37:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id u23so5558818edx.10;
        Thu, 27 Sep 2018 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygLPWlyqsHE7tgr59AQ+wPR9gH3fljP4+btgjnHnWXQ=;
        b=g6ExIyHFXW0pBAyGyrjVLQNXJdQ+jV3+OffyUpWuEDu9weHrMGZG1+YPShGkCoqo3U
         feb4rbI4bqXDKd6JyEGMDsPhs0mRw4NQmAcieruU1wbWMv0QuFnrFv6I/LTnOOwBYNQF
         GVFmimfXk9SfVNYEaCHIVeoTgxPRcmPG3rd1yNmts2LeCI81VNpWPIncFD5rRRdQfVdK
         sgBa3x2PpuTgBPmdM22QBvgXl05hnZZkwwu4SafUBTp+Ko/RTdfM+5cvrD4uMr4Z2a7I
         vWYf6FBQnX86By1loniU8rBY7X/cZy0JU3tCM4Un2XDyQ2VuQDrVxPvrExccjKCWjW8T
         iF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygLPWlyqsHE7tgr59AQ+wPR9gH3fljP4+btgjnHnWXQ=;
        b=mWnFJO9zDTWW4orRfmy7DbVJ9WtQJttfX5RJ8likbPAPU9CmC9vBHQPfTkPIhueqA6
         7FHJHaoJd20dPvkBuQ3/HgerkhGbQtS9lVvc0KygrfaLZS7NCpKqaYFeKzKUEggckg4O
         oPug6d01X5G0huVwC9SaKNt1GP270M0D3wevVxMg93OGNe7rKfKegS+B6Xfvh4KUk6u7
         /kJMVuickIBF3H8Zs2qKLnDrjNGai4gVHETC3O6Wei2RXJIou8zVlALVg/axA3UxSu9B
         f5HI3I+X85EujQ3XfA+Sup4uvn7yDWOafE0TBxTrqTH9mOdzp23d/wdlZ0EXrMiDk+BX
         D1Qg==
X-Gm-Message-State: ABuFfohpLJ9w5KtBbdDiiq5vBxVG7HOkLLXhRqjij9xyj+Xg4dgnFwKp
        eHMVLcHMRzUhNLA4S2cNDqu1l0gX2IBePKmbgLclJg==
X-Google-Smtp-Source: ACcGV62um5WCwAq5Nswo3am3BT9ke0Hglc/M6t0PO5q7EJweJN/C7nug0sWdgCzG7JMu2cuvdf6+ngqxx5ocGrNQ2IE=
X-Received: by 2002:a50:b704:: with SMTP id g4-v6mr19561809ede.139.1538065077759;
 Thu, 27 Sep 2018 09:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
 <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com>
 <2fdf2bd7-1cc4-a1e1-15c2-e2badfcd4d59@virtuozzo.com> <CANn89iK8X5cW3=YnNRrKo=BVCFJkJ0D22YY_eJFLyGCX+5SxsQ@mail.gmail.com>
 <84d38f11-2133-9d34-e468-d2ef16715f49@virtuozzo.com>
In-Reply-To: <84d38f11-2133-9d34-e468-d2ef16715f49@virtuozzo.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 27 Sep 2018 12:17:21 -0400
Message-ID: <CAF=yD-+u0MoSsg2gmaAiXVP+rLQ3pfyaCgwBwAEnPpCBwf8xbg@mail.gmail.com>
Subject: Re: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
To:     ktkhai@virtuozzo.com
Cc:     Eric Dumazet <edumazet@google.com>, peterz@infradead.org,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tom Herbert <tom@quantonium.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 12:02 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 19.09.2018 18:49, Eric Dumazet wrote:
> > On Wed, Sep 19, 2018 at 8:41 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 19.09.2018 17:55, Eric Dumazet wrote:
> >>> On Wed, Sep 19, 2018 at 5:29 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>
> >>>> Many workloads have polling mode of work. The application
> >>>> checks for incomming packets from time to time, but it also
> >>>> has a work to do, when there is no packets. This RFC
> >>>> tries to develop an idea to queue RPS packets on idle
> >>>> CPU in the the L3 domain of the consumer, so backlog
> >>>> processing of the packets and the application can execute
> >>>> in parallel.
> >>>>
> >>>> We require this in case of network cards does not
> >>>> have enough RX queues to cover all online CPUs (this seems
> >>>> to be the most cards), and  get_rps_cpu() actually chooses
> >>>> remote cpu, and SMP interrupt is sent. Here we may try
> >>>> our best, and to find idle CPU nearly the consumer's CPU.
> >>>> Note, that in case of consumer works in poll mode and it
> >>>> does not waits for incomming packets, its CPU will be not
> >>>> idle, while CPU of a sleeping consumer may be idle. So,
> >>>> not polling consumers will still be able to have skb
> >>>> handled on its CPU.
> >>>>
> >>>> In case of network card has many queues, the device
> >>>> interrupts will come on consumer's CPU, and this patch
> >>>> won't try to find idle cpu for them.
> >>>>
> >>>> I've tried simple netperf test for this:
> >>>> netserver -p 1234
> >>>> netperf -L 127.0.0.1 -p 1234 -l 100
> >>>>
> >>>> Before:
> >>>>  87380  16384  16384    100.00   60323.56
> >>>>  87380  16384  16384    100.00   60388.46
> >>>>  87380  16384  16384    100.00   60217.68
> >>>>  87380  16384  16384    100.00   57995.41
> >>>>  87380  16384  16384    100.00   60659.00
> >>>>
> >>>> After:
> >>>>  87380  16384  16384    100.00   64569.09
> >>>>  87380  16384  16384    100.00   64569.25
> >>>>  87380  16384  16384    100.00   64691.63
> >>>>  87380  16384  16384    100.00   64930.14
> >>>>  87380  16384  16384    100.00   62670.15
> >>>>
> >>>> The difference between best runs is +7%,
> >>>> the worst runs differ +8%.
> >>>>
> >>>> What do you think about following somehow in this way?
> >>>
> >>> Hi Kirill
> >>>
> >>> In my experience, scheduler has a poor view of softirq processing
> >>> happening on various cpus.
> >>> A cpu spending 90% of its cycles processing IRQ might be considered 'idle'
> >>
> >> Yes, in case of there is softirq on top of irq_exit(), the cpu is not
> >> considered as busy. But after MAX_SOFTIRQ_TIME (=2ms), ksoftirqd are
> >> waken up to execute the work in process context, and the processor is
> >> considered as !idle. 2ms is 2 timer ticks in case of HZ=1000. So, we
> >> don't restart softirq in case of it was executed for more then 2ms.
> >>
> >
> > That's the theory, but reality is very different unfortunately.
> >
> > If RFS/RPS is setup properly, we really do not hit MAX_SOFTIRQ_TIME condition
> > unless in some synthetic benchmarks maybe.
> >
> >> The similar way, single net_rx_action() can't be executed longer
> >> than 2ms.
> >>
> >> Having 90% load in softirq (called on top of irq_exit()) should be
> >> very unlikely situation, when there are too many interrupts with small
> >> amount of work, which related softirq calls are doing for each of them.
> >> I think it had be a problem even in plain napi case, since it would
> >> worked not like expected.
> >>
> >> But anyway. You worry, that during handling of next portion of skbs,
> >> we find that previous portion of skbs already woken ksoftirqd, and
> >> we don't see this cpu as idle? Yeah, then we'll try to change cpu,
> >> and this is not what we want. We want to continue use the cpu, where
> >> previous portion was handler. Hm, not so fast I'll answer, but certainly,
> >> this may be handled somehow in more creative way.
> >>
> >>> So please run a real workload (it is _very_ uncommon anyone set up RPS
> >>> on lo interface !)
> >>>
> >>> Like 400 or more concurrent netperf -t TCP_RR on a 10Gbit NIC.
> >>
> >> Yeah, it's just a simulation of a single irq nic. I'll try on something
> >> more real hardware.
> >
> > Also my concern is that you might have results that are tied to a particular
> > version of process scheduling, platform, workload...
> >
> > One month later, a small change in process scheduler,
> > and very different results.
>
> Maybe, but especially that function logic has not changed for a long time.
> 10 years at least. The only change is Peter adds idle core searching
> functionality recently.
>
> > This is why I believe this new feature must be controllable, via a new
> > tunable (like RPS/RFS are controllable per rx queue)

Agreed. For RFS we can have different heuristics, but they
should be configurable.

Please also make clear in your patch that this changes RFS, not
RPS.

For RPS, selection should not silently change to select a CPU
outside the configured rps_cpus set. I don't think that that should
ever be relaxed, even with a new knob, as it makes reasoning
about RPS configuration that much harder.

RFS already ignores rps_cpus, so using a different heuristic there
is easier.

I have thought about experimenting with biasing towards a core affine
with the numa node of the rx softirq cpu. In other words, ignoring
RFS if the request is remote. With the assumption (correct or not)
that wake affinity would pull the thread to the same node, load
permitting. But I have zero data for that.
