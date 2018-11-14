Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E806C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6572087E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJ4ReI51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6572087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeKOKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:01:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34220 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeKOKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:01:47 -0500
Received: by mail-io1-f68.google.com with SMTP id f6so10119876iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmLmN3dt/zfxfkpEIFGDIdCpD+4zRk/tFFa9swpMP8U=;
        b=aJ4ReI512rE1zygMoPShZbLYLtO+QqkVTc/LbTOkMUM8rPAWb/FvB651R8mDw4g+Cc
         +msWHC7hBa3FnfFP69I+tQJ7CjlKquwJWG/DMUQzK1F7PGG6yq9+mAkLTSVqHqpBcqK2
         3VE7knwR9Ot7DVT7W6woAGdtvqOZqRvAziqEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmLmN3dt/zfxfkpEIFGDIdCpD+4zRk/tFFa9swpMP8U=;
        b=SQNXjOTOo0TuCZrmpHeyN0b/xaPnqsE1gO6J+Rtn7gRgLd+q9OuT8dHieb9f5Ilihm
         7s8sYcWhVn+FGjvKTfriplvYBEZ64ak7PmFCelEBJexKBDzO/aUcaj7zKYaqZaAnfXLm
         b8lM9s12FrUGU+FQ5I7At6oHJ5XijKJH0zjjUPKcwlx2ElPM3taUFOP62z0jyiQsSVub
         3+eZKUQSXT3Zmlej+k+0+guZrN0lDeM6hYvSJ0McBmE/mS6XFa4ZR+M6ctg8WhBmi1Ke
         04lE8oq6GbE8FzVrqv94W5f/FAp+JUGRgGTOsuxvAD4+bS2xh1aC7rIRKL+UD+afOpP0
         Qwhg==
X-Gm-Message-State: AGRZ1gJEEvY2sig1iHe0w1k2eamwwQRtPTp0gYTWsBYUvnXSds5DbI9u
        YtvcrYSeEl7J4EXV6qnVg5kEuTExlvqJb2o5/ryBJQ==
X-Google-Smtp-Source: AJdET5emdKblztFVKQ2gWazL3rcDUZQg5BNg7bgUHTL2U7vGiq7YXBc9eSAJciiv1jIRy1p7YlrwWnjm3/MQV/PL2sc=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr3083979iof.183.1542239778678;
 Wed, 14 Nov 2018 15:56:18 -0800 (PST)
MIME-Version: 1.0
References: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
 <1541780454-9934-3-git-send-email-vincent.guittot@linaro.org> <f7725461-bb0e-27fd-04cc-a225c97a9940@arm.com>
In-Reply-To: <f7725461-bb0e-27fd-04cc-a225c97a9940@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 14 Nov 2018 15:56:07 -0800
Message-ID: <CAKfTPtB6Fm2xJQ04GSs5o58Kh-GHxX_Wmn2bfLu=wJPmydijyw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 at 18:53, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/9/18 8:20 AM, Vincent Guittot wrote:
>
> [...]
>
> > In order to achieve this time scaling, a new clock_pelt is created per rq.
> > The increase of this clock scales with current capacity when something
> > is running on rq and synchronizes with clock_task when rq is idle. With
> > this mecanism, we ensure the same running and idle time whatever the
>
> nitpick: s/mecanism/mechanism
>
> [...]
>
> > The responsivness of PELT is improved when CPU is not running at max
>
> nitpick: s/responsivness/responsiveness
>
> > capacity with this new algorithm. I have put below some examples of
> > duration to reach some typical load values according to the capacity of the
> > CPU with current implementation and with this patch. These values has been
> > computed based on the geometric serie and the half period value:
>
> nitpick: s/serie/series

ok for this and previous

>
> [...]
>
> > +/*
> > + * The clock_pelt scales the time to reflect the effective amount of
> > + * computation done during the running delta time but then sync back to
> > + * clock_task when rq is idle.
> > + *
> > + *
> > + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> > + * @ max capacity  ------******---------------******---------------
> > + * @ half capacity ------************---------************---------
> > + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> > + *
> > + */
> > +static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
> > +{
> > +     if (unlikely(is_idle_task(rq->curr))) {
> > +             /* The rq is idle, we can sync to clock_task */
> > +             rq->clock_pelt  = rq_clock_task(rq);
> > +             return;
>
> I think the term (time) stretching was used to to describe what's
> happening to the clock_pelt values at lower capacity and to this re-sync
> with the clock task. But IMHO, one has to be called stretching and the
> other compressing so it makes sense. I think it's a question of definition.
>
> > +     }
> > +
> > +     /*
> > +      * When a rq runs at a lower compute capacity, it will need
> > +      * more time to do the same amount of work than at max
> > +      * capacity: either because it takes more time to compute the
> > +      * same amount of work or because taking more time means
> > +      * sharing more often the CPU between entities.
>
> I wonder if since clock_pelt is related to the sched_avg(s) of the rq
> isn't the only reason the first one "It takes more time to do the same
> amount of work"? IMHO, the sharing of sched entities shouldn't be
> visible here.

yes probably

>
> > +      * In order to be invariant, we scale the delta to reflect how
> > +      * much work has been really done.
> > +      * Running at lower capacity also means running longer to do
> > +      * the same amount of work and this results in stealing some
>
> This is already mentioned above.
>
> > +      * idle time that will disturb the load signal compared to
> > +      * max capacity; This stolen idle time will be automaticcally
>
> nitpick: s/automaticcally/automatically
>
> > +      * reflected when the rq will be idle and the clock will be
> > +      * synced with rq_clock_task.
> > +      */
> > +
> > +     /*
> > +      * scale the elapsed time to reflect the real amount of
> > +      * computation
> > +      */
> > +     delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
> > +     delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
> > +
> > +     rq->clock_pelt += delta;
> > +}
> > +
> > +/*
> > + * When rq becomes idle, we have to check if it has lost some idle time
> > + * because it was fully busy. A rq is fully used when the /Sum util_sum
> > + * is greater or equal to:
> > + * (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> > + * For optimization and computing rounding purpose, we don't take into account
> > + * the position in the current window (period_contrib) and we use the maximum
> > + * util_avg value minus 1
> > + */
>
> In v4 you were using:
>
> u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) <<
> SCHED_CAPACITY_SHIFT;
>
> and switched in v5 to:
>
> u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) -
> LOAD_AVG_MAX;
>
> The period_contrib of rq->cfs.avg, rq->avg_rt and rq->avg_dl are not
> necessarily aligned but for overload you sum up the util_sum values for
> cfs, rt and dl. Was this also a reason why you now assume max util_avg -
> 1 ?

The original reason is optimization

>
> > +static inline void update_idle_rq_clock_pelt(struct rq *rq)
> > +{
> > +     u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
>
> util_avg = util_sum / divider   ,maximum util_avg = 1024
>
> 1024 = util_sum / (LOAD_AVG_MAX - 1024)   w/ period_contrib = 0
>
> util_sum >= (LOAD_AVG_MAX - 1024) * 1024
>
> util_sum >= (LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT;
>
> So you want to use 1024 - 1 = 1023 instead. Wouldn't you have to
> subtract (LOAD_AVG_MAX - 1024) from (LOAD_AVG_MAX - 1024) <<
> SCHED_CAPACITY_SHIFT in this case?
>
> util_sum >= (LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT -
> (LOAD_AVG_MAX - 1024)

(LOAD_AVG_MAX - 1024) is the lower bound of the max value ( it's in
fact LOAD_AVG_MAX*y) so in order to be conservative and prevent any
rounding effect, I'm using the higher bound (LOAD_AVG_MAX*y + a full
new window (1024)) = LOAD_AVG_MAX for the Sum of util_sum side

And his is even more true now that we sum 3 util_sum values

> > +     u32 overload = rq->cfs.avg.util_sum;
> > +     overload += rq->avg_rt.util_sum;
> > +     overload += rq->avg_dl.util_sum;
> > +
> > +     /*
> > +      * Reflecting some stolen time makes sense only if the idle
> > +      * phase would be present at max capacity. As soon as the
> > +      * utilization of a rq has reached the maximum value, it is
> > +      * considered as an always runnnig rq without idle time to
>
> nitpick: s/runnnig/runnig

ok

>
> > +      * steal. This potential idle time is considered as lost in
> > +      * this case. We keep track of this lost idle time compare to
> > +      * rq's clock_task.
> > +      */
> > +     if ((overload >= divider))
> > +             rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
>
> Shouldn't overload still be called util_sum? Overload (or overutilized
> is IMHO the state when util_sum >= divider.

yes i can rename it

>
> [...]
>
