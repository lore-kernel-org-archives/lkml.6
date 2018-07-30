Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6318208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GC9gQ/pK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6318208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbeG3STY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:19:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41759 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeG3STY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:19:24 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so10415835ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2QylJxMn/MVRjHq13avhMxTpjjJ1WHPaKT7FA0PBVo=;
        b=GC9gQ/pKKmvwO6xNwitQxykMXUC1jXhr+/F9IGyZdaAVs2UD9WnrJ/pj56JrI2PEbE
         yTkw86pCS6KlDDmJzNz+HmDUEOROGnmrRe2LXoNzahcsk+HXz/zAhud5WtrkawTkiyKt
         KUneK2hX2UO2flRfted7vtoWLGG0zIoDECxNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2QylJxMn/MVRjHq13avhMxTpjjJ1WHPaKT7FA0PBVo=;
        b=BuZ/+uKSxvU2OrxhBZl/Mb7HlgH25O7mz+P+ZtsT71cTw5aMA9Wo3LsGUvkLREUWHV
         81ab5E9Jkk8d/6wJTtuB4ZhPK3tePZhFHRKw20WvG3c69nATz8B3AxOSarjMfbr8qvbl
         XQ1xUrKNyY4He2FqSQ9s/Ed7yoDKkhTPpdrtGJnhM9sIPmM+kUFAcZ8lzzhtfDgmYVnq
         cc+n8oFDJE0gmnlEhF+GktdH2vVSg1IILuosl7VxOiORdfEMXTn8G2aCg1EL2P8xfkvA
         IJj6OIuL8mErIlBfdLqeKmAjmX1GqrZr/bmvL7zYJgVEQ8uMn2RYRjwWkwQmnFfzAQL0
         ZD8A==
X-Gm-Message-State: AOUpUlE+1yTdYbR935SiVDKuRZaTsFpsEir41yga8uViDpMTNtB/n0wi
        9fNrbL7K/SBeZU/x4f+r8OqGWxQnaMQdDGkIkwLtpw==
X-Google-Smtp-Source: AAOMgpdAAEF3weXyBeZUC8accObo8IdPNvVEyBaj85b3rLVJky2IEnbGzZHMoTdMeb7F+DVSN4iTO7hvW/p4LMvptTM=
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr13941445ioa.294.1532969014022;
 Mon, 30 Jul 2018 09:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org> <CANRm+Cz0-61-WOT8CLf02G-aHEwrff6WVWd6mp0DKV+GfFyvWw@mail.gmail.com>
In-Reply-To: <CANRm+Cz0-61-WOT8CLf02G-aHEwrff6WVWd6mp0DKV+GfFyvWw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Jul 2018 18:43:23 +0200
Message-ID: <CAKfTPtBMSvfLYAZz6p+uj0G2uq87QzXBOnTHMmzV=niwd0nMjA@mail.gmail.com>
Subject: Re: [PATCH 06/11] sched/irq: add irq utilization tracking
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanpeng,

On Thu, 26 Jul 2018 at 05:09, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> Hi Vincent,
> On Fri, 29 Jun 2018 at 03:07, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > interrupt and steal time are the only remaining activities tracked by
> > rt_avg. Like for sched classes, we can use PELT to track their average
> > utilization of the CPU. But unlike sched class, we don't track when
> > entering/leaving interrupt; Instead, we take into account the time spent
> > under interrupt context when we update rqs' clock (rq_clock_task).
> > This also means that we have to decay the normal context time and account
> > for interrupt time during the update.
> >
> > That's also important to note that because
> >   rq_clock == rq_clock_task + interrupt time
> > and rq_clock_task is used by a sched class to compute its utilization, the
> > util_avg of a sched class only reflects the utilization of the time spent
> > in normal context and not of the whole time of the CPU. The utilization of
> > interrupt gives an more accurate level of utilization of CPU.
> > The CPU utilization is :
> >   avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq
> >
> > Most of the time, avg_irq is small and neglictible so the use of the
> > approximation CPU utilization = /Sum avg_rq was enough
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c  |  4 +++-
> >  kernel/sched/fair.c  | 13 ++++++++++---
> >  kernel/sched/pelt.c  | 40 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/pelt.h  | 16 ++++++++++++++++
> >  kernel/sched/sched.h |  3 +++
> >  5 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 78d8fac..e5263a4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -18,6 +18,8 @@
> >  #include "../workqueue_internal.h"
> >  #include "../smpboot.h"
> >
> > +#include "pelt.h"
> > +
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/sched.h>
> >
> > @@ -186,7 +188,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> >
> >  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> >         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> > -               sched_rt_avg_update(rq, irq_delta + steal);
> > +               update_irq_load_avg(rq, irq_delta + steal);
>
> I think we should not add steal time into irq load tracking, steal
> time is always 0 on native kernel which doesn't matter, what will
> happen when guest disables IRQ_TIME_ACCOUNTING and enables
> PARAVIRT_TIME_ACCOUNTING? Steal time is not the real irq util_avg. In
> addition, we haven't exposed power management for performance which
> means that e.g. schedutil governor can not cooperate with passive mode
> intel_pstate driver to tune the OPP. To decay the old steal time avg
> and add the new one just wastes cpu cycles.

In fact, I have kept the same behavior as with rt_avg, which was
already adding steal time when computing scale_rt_capacity, which is
used to reflect the remaining capacity for FAIR tasks and is used in
load balance. I'm not sure that it's worth using different variables
for irq and steal.
That being said, I see a possible optimization in schedutil when
PARAVIRT_TIME_ACCOUNTING is enable and IRQ_TIME_ACCOUNTING is disable.
With this kind of config, scale_irq_capacity can be a nop for
schedutil but scales the utilization for scale_rt_capacity

Regards,
Vincent

>
> Regards,
> Wanpeng Li
>
> >  #endif
> >  }
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ffce4b2..d2758e3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7289,7 +7289,7 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
> >         return false;
> >  }
> >
> > -static inline bool others_rqs_have_blocked(struct rq *rq)
> > +static inline bool others_have_blocked(struct rq *rq)
> >  {
> >         if (READ_ONCE(rq->avg_rt.util_avg))
> >                 return true;
> > @@ -7297,6 +7297,11 @@ static inline bool others_rqs_have_blocked(struct rq *rq)
> >         if (READ_ONCE(rq->avg_dl.util_avg))
> >                 return true;
> >
> > +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > +       if (READ_ONCE(rq->avg_irq.util_avg))
> > +               return true;
> > +#endif
> > +
> >         return false;
> >  }
> >
> > @@ -7361,8 +7366,9 @@ static void update_blocked_averages(int cpu)
> >         }
> >         update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> >         update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> > +       update_irq_load_avg(rq, 0);
> >         /* Don't need periodic decay once load/util_avg are null */
> > -       if (others_rqs_have_blocked(rq))
> > +       if (others_have_blocked(rq))
> >                 done = false;
> >
> >  #ifdef CONFIG_NO_HZ_COMMON
> > @@ -7431,9 +7437,10 @@ static inline void update_blocked_averages(int cpu)
> >         update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
> >         update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> >         update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> > +       update_irq_load_avg(rq, 0);
> >  #ifdef CONFIG_NO_HZ_COMMON
> >         rq->last_blocked_load_update_tick = jiffies;
> > -       if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
> > +       if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
> >                 rq->has_blocked_load = 0;
> >  #endif
> >         rq_unlock_irqrestore(rq, &rf);
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 8b78b63..ead6d8b 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -357,3 +357,43 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> >
> >         return 0;
> >  }
> > +
> > +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > +/*
> > + * irq:
> > + *
> > + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
> > + *   util_sum = cpu_scale * load_sum
> > + *   runnable_load_sum = load_sum
> > + *
> > + */
> > +
> > +int update_irq_load_avg(struct rq *rq, u64 running)
> > +{
> > +       int ret = 0;
> > +       /*
> > +        * We know the time that has been used by interrupt since last update
> > +        * but we don't when. Let be pessimistic and assume that interrupt has
> > +        * happened just before the update. This is not so far from reality
> > +        * because interrupt will most probably wake up task and trig an update
> > +        * of rq clock during which the metric si updated.
> > +        * We start to decay with normal context time and then we add the
> > +        * interrupt context time.
> > +        * We can safely remove running from rq->clock because
> > +        * rq->clock += delta with delta >= running
> > +        */
> > +       ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
> > +                               0,
> > +                               0,
> > +                               0);
> > +       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
> > +                               1,
> > +                               1,
> > +                               1);
> > +
> > +       if (ret)
> > +               ___update_load_avg(&rq->avg_irq, 1, 1);
> > +
> > +       return ret;
> > +}
> > +#endif
> > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > index 0e4f912..d2894db 100644
> > --- a/kernel/sched/pelt.h
> > +++ b/kernel/sched/pelt.h
> > @@ -6,6 +6,16 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
> >  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
> >  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> >
> > +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > +int update_irq_load_avg(struct rq *rq, u64 running);
> > +#else
> > +static inline int
> > +update_irq_load_avg(struct rq *rq, u64 running)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  /*
> >   * When a task is dequeued, its estimated utilization should not be update if
> >   * its util_avg has not been updated at least once.
> > @@ -51,6 +61,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> >  {
> >         return 0;
> >  }
> > +
> > +static inline int
> > +update_irq_load_avg(struct rq *rq, u64 running)
> > +{
> > +       return 0;
> > +}
> >  #endif
> >
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ef5d6aa..377be2b 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -850,6 +850,9 @@ struct rq {
> >         u64                     age_stamp;
> >         struct sched_avg        avg_rt;
> >         struct sched_avg        avg_dl;
> > +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > +       struct sched_avg        avg_irq;
> > +#endif
> >         u64                     idle_stamp;
> >         u64                     avg_idle;
> >
> > --
> > 2.7.4
> >
