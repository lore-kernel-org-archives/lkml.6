Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DDC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AB2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMmDM1d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9AB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJXRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:34:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52168 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:34:52 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so5274630itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/7fz6bLAWC/Eb+nW3TIMqXX2i5zquFRGZXZJpihnqc=;
        b=kMmDM1d/WA3a8WHk2KMG75S5IeP1nweuBpWDnr4cfLK5AJ9gTSMJhdUzsfNpqGKXao
         GUypwoy8WwfLlq+4DHWhIVdVheS33JXgf0n9Z/1wr6GYrLy30lSAd4FidKUgWF/QIoTZ
         RnQ0mkSmms8g9O1hlQzQxc/eSIviE/65BwAfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/7fz6bLAWC/Eb+nW3TIMqXX2i5zquFRGZXZJpihnqc=;
        b=PTA4Us8ucXifJvWfjHHN1rgAizGOSqB6G3EDoEsUKt5kiktl8rtt+E3ryBPW6HyWne
         B3v3cZU/4vuDEkxmJ5FXNTfJNecrJ7eJZQpSxUvBg4dlDlbe7hf+RV6SZxCurey2ZIzx
         T2NARRxSu1n8LHDJFeQlMhJKT1GsSxGIiULfD8QyxcdHvNHzyU09I4EkJCOvR5CPtbqB
         06A6eaooSMbTkQBYvBBjZe2aC/VFwfbY+NUn6Hof1phvoKZsEzjeFoFVX8McWlTTD9ZF
         0iqlkb3Je9P2MABPEhppzJhUX7/y0rJhvwplHX2G8Wwdz2ehzNLpP48FBvPH9bEMh1i2
         5YBw==
X-Gm-Message-State: AGRZ1gLm4PtwMW1w8yb1XIjctxqNXqfb2nBMP35lriNTWHTVgIv9zNWa
        L6iHc3DDDB6UkNRdC5lRm+SG7q8vn3PJsAqzDJD3YQ==
X-Google-Smtp-Source: AJdET5fhImEmqqYI1lBdhhRnTLQXgmBxLn5IhAqZB9KAnDoJGPbuUBkg9WEUfe9m6ndAqCQnfTG/ulX3VwrqCw9ezLs=
X-Received: by 2002:a02:b889:: with SMTP id p9-v6mr1209559jam.20.1540372055835;
 Wed, 24 Oct 2018 02:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
 <20181023055937.GC27587@codeaurora.org> <CAKfTPtDv3GYx-AXYuoW3ubPvDjGiEaEhYA6=iGC-02mOqwuySQ@mail.gmail.com>
 <20181024045305.GD27587@codeaurora.org>
In-Reply-To: <20181024045305.GD27587@codeaurora.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Oct 2018 11:07:24 +0200
Message-ID: <CAKfTPtDTT7JASWnwJwwC9WD25Xqvf1yfiBRaQ0SU6xx9owiaMA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
To:     pkondeti@codeaurora.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Pavan,

On Wed, 24 Oct 2018 at 06:53, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
>
> Hi Vincent,
>
> Thanks for the detailed explanation.
>
> On Tue, Oct 23, 2018 at 02:15:08PM +0200, Vincent Guittot wrote:
> > Hi Pavan,
> >
> > On Tue, 23 Oct 2018 at 07:59, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
> > > >
> > > >  /*
> > > > + * The clock_pelt scales the time to reflect the effective amount of
> > > > + * computation done during the running delta time but then sync back to
> > > > + * clock_task when rq is idle.
> > > > + *
> > > > + *
> > > > + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> > > > + * @ max capacity  ------******---------------******---------------
> > > > + * @ half capacity ------************---------************---------
> > > > + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> > > > + *
> > > > + */
> > > > +void update_rq_clock_pelt(struct rq *rq, s64 delta)
> > > > +{
> > > > +
> > > > +     if (is_idle_task(rq->curr)) {
> > > > +             u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> > > > +             u32 overload = rq->cfs.avg.util_sum + LOAD_AVG_MAX;
> > > > +             overload += rq->avg_rt.util_sum;
> > > > +             overload += rq->avg_dl.util_sum;
> > > > +
> > > > +             /*
> > > > +              * Reflecting some stolen time makes sense only if the idle
> > > > +              * phase would be present at max capacity. As soon as the
> > > > +              * utilization of a rq has reached the maximum value, it is
> > > > +              * considered as an always runnnig rq without idle time to
> > > > +              * steal. This potential idle time is considered as lost in
> > > > +              * this case. We keep track of this lost idle time compare to
> > > > +              * rq's clock_task.
> > > > +              */
> > > > +             if (overload >= divider)
> > > > +                     rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> > > > +
> > >
> > > I am trying to understand this better. I believe we run into this scenario, when
> > > the frequency is limited due to thermal/userspace constraints. Lets say
> >
> > Yes these are the most common UCs but this can also happen after tasks
> > migration or with a cpufreq governor that doesn't increase OPP fast
> > enough for current utilization.
> >
> > > frequency is limited to Fmax/2. A 50% task at Fmax, becomes 100% running at
> > > Fmax/2. The utilization is built up to 100% after several periods.
> > > The clock_pelt runs at 1/2 speed of the clock_task. We are loosing the idle time
> > > all along. What happens when the CPU enters idle for a short duration and comes
> > > back to run this 100% utilization task?
> >
> > If you are at 100%, we only apply the short idle duration
> >
> > >
> > > If the above block is not present i.e lost_idle_time is not tracked, we
> > > stretch the idle time (since clock_pelt is synced to clock_task) and the
> > > utilization is dropped. Right?
> >
> > yes that 's what would happen. I gives more details below
> >
> > >
> > > With the above block, we don't stretch the idle time. In fact we don't
> > > consider the idle time at all. Because,
> > >
> > > idle_time = now - last_time;
> > >
> > > idle_time = (rq->clock_pelt - rq->lost_idle_time) - last_time
> > > idle_time = (rq->clock_task - rq_clock_task + rq->clock_pelt_old) - last_time
> > > idle_time = rq->clock_pelt_old - last_time
> > >
> > > The last time is nothing but the last snapshot of the rq->clock_pelt when the
> > > task entered sleep due to which CPU entered idle.
> >
> > The condition for dropping this idle time is quite important. This
> > only happens when the utilization reaches max compute capacity of the
> > CPU. Otherwise, the idle time will be fully applied
>
> Right.
>
> rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt
>
> This not only tracks the lost idle time due to running slow but also the
> absolute/real sleep time. For example, when the slow running 100% task
> sleeps for 100 msec, are not we ignoring the 100 msec sleep there?
>
> For example a task ran 323 msec at full capacity and sleeps for (1000-323)
> msec. when it wakes up the utilization is dropped. If the same task runs
> for 626 msec at the half capacity and sleeps for (1000-626), should not
> drop the utilization by taking (1000-626) sleep time into account. I
> understand that why we don't strech idle time to (1000-323) but it is not
> clear to me why we completely drop the idle time.

So this should not happen.
I' m going to update the way I track lost idle time  and move it out
of update_rq_clock_pelt() and only do the test when entering idle
This is even better as it simplifies update_rq_clock_pelt() and
reduces the number of tests for lost idle time

Thanks for spotting this

I'm preparing a new version with this, some build fix for !SMP and the
alignement with cache line suggested by Peter

Vincent
>
> >
> > >
