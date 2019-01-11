Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61835C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2530720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpfzB2cV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbfAKOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52984 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbfAKOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:00 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so2720094itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRxNvt96ZeBca8R5/33FhkRtRgTlEVM72mVzdS4WA5k=;
        b=EpfzB2cVcUUU/uHkcz5P8GWbxZHO2z0iyydybyD7CJZm3GTlajma8+hJK/uCkSI1v5
         fvN14br8iK7z49W12Qb79QAZJGsmcXv+0083LdE2IRQzggpa8gjThspo3ngckZuLvdFV
         jyc4om7Ys0MQRwvuyGsn/9jUsMUZ1krkwI+rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRxNvt96ZeBca8R5/33FhkRtRgTlEVM72mVzdS4WA5k=;
        b=gn+z7CIsuTZAhNiKtM4BOttxUOoGXERp98REdFoTnJvjhqX056yrY7DwYwXvtflUKW
         GRtHfm1ZEtTxdh+QP4oXkHMRT6AWK2HQ+x9uYv0mG1FiEj+lHP2UQvcsSqEMhQh3DpQ/
         VCo79uAuD1zLFzoiDYtD8ZXjjgZDO1MSsXotBWaqUhjhbzIbEQgA996CC4p2XgeSsAd8
         66fuKCYpRVDC+lbXBX5F1GoEK+HuzureAJ5iUOzFfiHv2zrneaoWXAUSlASIMqj3vmtn
         p5MDUjsqgCWDYlwKz4WPdgerqj92jVQ3WJzbtxsLuFUONeRRqvFpqh10Z1jQKOywM4ax
         +L9w==
X-Gm-Message-State: AJcUukdy8wjNioHBp/sbmi/5crxsH5FX5cfyUTmP6lyxcESbBKVLwNcy
        EXN9vFjDzJxMuAHQmY6vQmYNa/eis+4OBnEpOaG6cQ==
X-Google-Smtp-Source: ALg8bN6WkZxCOFzvuctzo2YPoRP+vk80ZLcSUFa/OEAMoOD1zf8d4G9jOizOk5p+T79+QNuBjT+5Ba2fJBOoBclayAg=
X-Received: by 2002:a02:6019:: with SMTP id i25mr10835422jac.137.1547216999281;
 Fri, 11 Jan 2019 06:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20181128115336.GB23094@e110439-lin> <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
 <20181128144039.GC23094@e110439-lin> <CAKfTPtAR7otTTwKYbg5OWbgrUYNKBNsUnOcMS9CfQtbYspvO5A@mail.gmail.com>
 <20181128152133.GD23094@e110439-lin> <CAKfTPtDTSXiVsPepiJDFT9ZCXfUVYTQhRvgfZbF=_w87girPAQ@mail.gmail.com>
 <20181128163545.GE23094@e110439-lin> <CAKfTPtAd8V=Qst82HPb1HW7ZdvrHGgaVhZ=rAdzbHNednp+ztg@mail.gmail.com>
 <20181129150020.GF23094@e110439-lin> <CAKfTPtB_uVBx85vWVOhqUYyKGFipa4HGECsC-YZMvaz8wK6oCA@mail.gmail.com>
 <20190110153031.4rh64xz2muctkffe@e110439-lin>
In-Reply-To: <20190110153031.4rh64xz2muctkffe@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 11 Jan 2019 15:29:48 +0100
Message-ID: <CAKfTPtC-M70u+gK2bEd=yQ8pdG1A3Opm-U5f=K-Hxhc6OXgM=w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 16:30, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 29-Nov 17:19, Vincent Guittot wrote:
> > On Thu, 29 Nov 2018 at 16:00, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > On 29-Nov 11:43, Vincent Guittot wrote:
>
> [...]
>
> > > Seems we agree that, when there is no idle time:
> > > - the two 15% tasks will be overestimated
> > > - their utilization will reach 50% after a while
> > >
> > > If I'm not wrong, we will have:
> > > - 30% CPU util in  ~16ms @1024 capacity
> > >                    ~64ms  @256 capacity
> > >
> > > Thus, the tasks will be certainly over-estimated after ~64ms.
> > > Is that correct ?
> >
> > From a pure util_avg pov it's correct
> > But i'd like to weight that a bit with the example below
> >
> > > Now, we can argue that 64ms is a pretty long time and thus it's quite
> > > unlucky we will have no idle for such a long time.
> > >
> > > Still, I'm wondering if we should keep collecting those samples or
> > > better find a way to detect that and skip the sampling.
> >
> > The problem is that you can have util_avg above capacity even with idle time
> > In the 1st example of this thread, the 39ms/80ms task will reach 709
> > which is the value saved by util_est on a big core
> > But on core with half capacity, there is still idle time so 709 is a
> > correct value although above 512
>
> Right, I see your point and (in principle) I like the idea of
> collecting samples for tasks which happen to run at a lower capacity
> then required and the utilization value makes sense...
>
> > In fact, max will be always above the linear ratio because it's based
> > on geometric series
> >
> > And this is true even with 15.6ms/32ms (same ratio as above) task
> > although the impact is smaller (max value, which should be saved by
> > util est, becomes  587 in this case).
>
> However that's not always the case... as per my example above.
>
> Moreover, we should also consider that util_est is mainly meant to be
> a lower-bound for tasks utilization.
> That's why task_util_est() already returns the actual util_avg when
> it's higher than the estimated utilization.

I can imagine that the fact that we use max(util_avg, util_est) helps
to keep using correct utilization in the scheduler when util_avg goes
above cpu capacity whereas there is still idle time

>
> With your new signal and without any special check on samples
> collection, if a task is limited because of thermal capping for
> example, we could end up overestimating its utilization and thus
> perhaps generating an unwanted frequency spike when the capping is
> relaxed... and (even worst) it will take some more activations for the
> estimated utilization to converge back to the actual utilization.
>
> Since we cannot easily know if there is idle time in a CPU when a task
> completes an activation with a utilization higher then the CPU
> capacity, I would better prefer to just skip the sampling with
> something like:
>
> ---8<---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9332863d122a..485053026533 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3639,6 +3639,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>  {
>         long last_ewma_diff;
>         struct util_est ue;
> +       int cpu;
>
>         if (!sched_feat(UTIL_EST))
>                 return;
> @@ -3672,6 +3673,14 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>         if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
>                 return;
>
> +       /*
> +        * To avoid overestimation of actual task utilization, skip updates if
> +        * we cannot grant there is idle time in this CPU.
> +        */
> +       cpu = cpu_of(rq_of(cfs_rq));
> +       if (task_util(p) > cpu_capacity(cpu))
> +               return;
> +
>         /*
>          * Update Task's estimated utilization
>          *
> ---8<---
>
> At least this will ensure that util_est always provides an actual
> measured lower bound for a task utilization.
>
> If you think this makes sense, feel free to add such a patch on
> top of your series.

ok. I'm going to add it when rebasing the series

Thanks
Vincent
>
> Cheers Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
