Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF653C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3ED20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7oL2wf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3ED20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeHAKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:20:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44447 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbeHAKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:20:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so33133055oih.11;
        Wed, 01 Aug 2018 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FqZifYWcdWdX32kAU1/VIWpZnpE7RiqEjk1gtqTXvr8=;
        b=p7oL2wf9mTnyY0MHqNyg7aadTs/rFwMzJEaSc9/0Dl8fBOrOVg6E/0UPM69G0sWGK1
         C6UTJ/0oy9tQ5nPCMHhqpGjwxf7rdTNnd2bQdvs0qUoF8ut/CuenmZ57xbZwT6w2K6xm
         qAzlxoBAZOhbw1aP+VhGbU0SuAqKm8xzPrlwZwgGQNrlF2AiHJvTWJL3z7BCX/UsBlEQ
         iRNt+8TLlD0OHS4bQbHo+XHUVxTIpoopM1LAMNFsVIkaO6KEywT9WEetyGIyCfRXf6/I
         xVQOMDy76y5YMDl6RUVEW37soNQsIMYELXH26jXmZfuSdeMfh18XaJYUaYVbd8o6M1d5
         F6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FqZifYWcdWdX32kAU1/VIWpZnpE7RiqEjk1gtqTXvr8=;
        b=eeljzF3/Ik+h328JqZn+u9lnXLWozA7NCf1CozAVPyDoUzYGX02sWQePbJeZnpB7sK
         moxzrXq6/yYeYQ/icBgDyR0fKT4mMVrZHOB0L9oo4KA35KKR4NxpW4uIM6Mwet0Pg4js
         cwfzPpGdArbDyERozSLsDribbrTNssgI6VZH+Qrf+Qzb4epoSEu9SWnqfhYidAV/Dsa5
         2hfnR5AgkYYmbLWorKVXApqVoARfRtHtZNKMGtssfEjmnMeo+9POuoQHsQwVEs63U2BG
         vb8Lif8kpWE8olUI75i7Mp1AYlXjFHfGDrtg57imjYfKPa5S9D0UFb4MO5GY1WdXdRH+
         d36w==
X-Gm-Message-State: AOUpUlFCd3WdTzD7XzLEhygVM/ettkMd+uHJdf4sgv7/dmGsmKixCK+v
        lywU7z24Mbmg1SxY0P2W5Eq8ByfWnNKUG1gNLdw=
X-Google-Smtp-Source: AAOMgpfL4euXl49/MZJeemOJJIr2xsRcP/oltTNmYuXSlTi630BGkQ0a6ptr6pPw0/YTO75MTjuQ0D3mL9Z+LWBCyTI=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr2652706oie.174.1533112532707;
 Wed, 01 Aug 2018 01:35:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 01:35:32 -0700 (PDT)
In-Reply-To: <20180801082353.egym4tsbr7ppql27@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com> <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin> <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com> <20180801082353.egym4tsbr7ppql27@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 10:35:32 +0200
X-Google-Sender-Auth: WCNu7ydNPvZdP4h7eQUPdMr4Lf4
Message-ID: <CAJZ5v0joYFXkXxoV8odPtrCNW=jAw3RVv3rTzMoabeYWGDnREw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@quicinc.com,
        skannan@quicinc.com, Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>,
        linux-pm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Wednesday 01 Aug 2018 at 09:32:49 (+0200), Rafael J. Wysocki wrote:
>> On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
>> > On 2018-07-31 00:59, Quentin Perret wrote:
>> >>
>> >> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
>> >> [...]
>> >>>
>> >>> If it's going to be a different aggregation from what's done for
>> >>> frequency
>> >>> guidance, I don't see the point of having this inside schedutil. Why not
>> >>> keep it inside the scheduler files?
>> >>
>> >>
>> >> This code basically results from a discussion we had with Peter on v4.
>> >> Keeping everything centralized can make sense from a maintenance
>> >> perspective, I think. That makes it easy to see the impact of any change
>> >> to utilization signals for both EAS and schedutil.
>> >
>> >
>> > In that case, I'd argue it makes more sense to keep the code centralized in
>> > the scheduler. The scheduler can let schedutil know about the utilization
>> > after it aggregates them. There's no need for a cpufreq governor to know
>> > that there are scheduling classes or how many there are. And the scheduler
>> > can then choose to aggregate one way for task packing and another way for
>> > frequency guidance.
>>
>> Also the aggregate utilization may be used by cpuidle governors in
>> principle to decide how deep they can go with idle state selection.
>
> The only issue I see with this right now is that some of the things done
> in this function are policy decisions which really belong to the governor,
> I think.

Well, the scheduler makes policy decisions too, in quite a few places. :-)

The really important consideration here is whether or not there may be
multiple governors making different policy decisions in that respect.
If not, then where exactly the single policy decision is made doesn't
particularly matter IMO.

> The RT-go-to-max-freq thing in particular. And I really don't
> think EAS should cope with that, at least for now.
>
> But if this specific bit is factored out of the aggregation function, I
> suppose we could move it somewhere else. Maybe pelt.c ?
>
> How ugly is something like the below (totally untested) code ? It would
> change slightly how we deal with DL utilization in EAS but I don't think
> this is an issue.
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index af86050edcf5..51c9ac9f30e8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -178,121 +178,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -/*
> - * This function computes an effective utilization for the given CPU, to be
> - * used for frequency selection given the linear relation: f = u * f_max.
> - *
> - * The scheduler tracks the following metrics:
> - *
> - *   cpu_util_{cfs,rt,dl,irq}()
> - *   cpu_bw_dl()
> - *
> - * Where the cfs,rt and dl util numbers are tracked with the same metric and
> - * synchronized windows and are thus directly comparable.
> - *
> - * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> - * which excludes things like IRQ and steal-time. These latter are then accrued
> - * in the irq utilization.
> - *
> - * The DL bandwidth number otoh is not a measured metric but a value computed
> - * based on the task model parameters and gives the minimal utilization
> - * required to meet deadlines.
> - */
> -unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> -                                 enum schedutil_type type)
> -{
> -       struct rq *rq = cpu_rq(cpu);
> -       unsigned long util, irq, max;
> -
> -       max = arch_scale_cpu_capacity(NULL, cpu);
> -
> -       if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
> -               return max;
> -
> -       /*
> -        * Early check to see if IRQ/steal time saturates the CPU, can be
> -        * because of inaccuracies in how we track these -- see
> -        * update_irq_load_avg().
> -        */
> -       irq = cpu_util_irq(rq);
> -       if (unlikely(irq >= max))
> -               return max;
> -
> -       /*
> -        * Because the time spend on RT/DL tasks is visible as 'lost' time to
> -        * CFS tasks and we use the same metric to track the effective
> -        * utilization (PELT windows are synchronized) we can directly add them
> -        * to obtain the CPU's actual utilization.
> -        */
> -       util = util_cfs;
> -       util += cpu_util_rt(rq);
> -
> -       if (type == frequency_util) {
> -               /*
> -                * For frequency selection we do not make cpu_util_dl() a
> -                * permanent part of this sum because we want to use
> -                * cpu_bw_dl() later on, but we need to check if the
> -                * CFS+RT+DL sum is saturated (ie. no idle time) such
> -                * that we select f_max when there is no idle time.
> -                *
> -                * NOTE: numerical errors or stop class might cause us
> -                * to not quite hit saturation when we should --
> -                * something for later.
> -                */
> -
> -               if ((util + cpu_util_dl(rq)) >= max)
> -                       return max;
> -       } else {
> -               /*
> -                * OTOH, for energy computation we need the estimated
> -                * running time, so include util_dl and ignore dl_bw.
> -                */
> -               util += cpu_util_dl(rq);
> -               if (util >= max)
> -                       return max;
> -       }
> -
> -       /*
> -        * There is still idle time; further improve the number by using the
> -        * irq metric. Because IRQ/steal time is hidden from the task clock we
> -        * need to scale the task numbers:
> -        *
> -        *              1 - irq
> -        *   U' = irq + ------- * U
> -        *                max
> -        */
> -       util *= (max - irq);
> -       util /= max;
> -       util += irq;
> -
> -       if (type == frequency_util) {
> -               /*
> -                * Bandwidth required by DEADLINE must always be granted
> -                * while, for FAIR and RT, we use blocked utilization of
> -                * IDLE CPUs as a mechanism to gracefully reduce the
> -                * frequency when no tasks show up for longer periods of
> -                * time.
> -                *
> -                * Ideally we would like to set bw_dl as min/guaranteed
> -                * freq and util + bw_dl as requested freq. However,
> -                * cpufreq is not yet ready for such an interface. So,
> -                * we only do the latter for now.
> -                */
> -               util += cpu_bw_dl(rq);
> -       }
> -
> -       return min(max, util);
> -}
> -
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
> -       unsigned long util = cpu_util_cfs(rq);
>
>         sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>
> -       return schedutil_freq_util(sg_cpu->cpu, util, frequency_util);
> +       if (rt_rq_is_runnable(&rq->rt))
> +               return sg_cpu->max;
> +
> +       return cpu_util_total(sg_cpu->cpu, cpu_util_cfs(rq));
>  }
>
>  /**
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 35475c0c5419..5f99bd564dfc 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -397,3 +397,77 @@ int update_irq_load_avg(struct rq *rq, u64 running)
>         return ret;
>  }
>  #endif
> +
> +/*
> + * This function computes an effective utilization for the given CPU, to be
> + * used for frequency selection given the linear relation: f = u * f_max.
> + *
> + * The scheduler tracks the following metrics:
> + *
> + *   cpu_util_{cfs,rt,dl,irq}()
> + *   cpu_bw_dl()
> + *
> + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> + * synchronized windows and are thus directly comparable.
> + *
> + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> + * which excludes things like IRQ and steal-time. These latter are then accrued
> + * in the irq utilization.
> + *
> + * The DL bandwidth number otoh is not a measured metric but a value computed
> + * based on the task model parameters and gives the minimal utilization
> + * required to meet deadlines.
> + */
> +unsigned long cpu_util_total(int cpu, unsigned long util_cfs)
> +{
> +       struct rq *rq = cpu_rq(cpu);
> +       unsigned long util, irq, max;
> +
> +       max = arch_scale_cpu_capacity(NULL, cpu);
> +
> +       /*
> +        * Early check to see if IRQ/steal time saturates the CPU, can be
> +        * because of inaccuracies in how we track these -- see
> +        * update_irq_load_avg().
> +        */
> +       irq = cpu_util_irq(rq);
> +       if (unlikely(irq >= max))
> +               return max;
> +
> +       /*
> +        * Because the time spend on RT/DL tasks is visible as 'lost' time to
> +        * CFS tasks and we use the same metric to track the effective
> +        * utilization (PELT windows are synchronized) we can directly add them
> +        * to obtain the CPU's actual utilization.
> +        */
> +       util = util_cfs;
> +       util += cpu_util_rt(rq);
> +
> +       if ((util + cpu_util_dl(rq)) >= max)
> +               return max;
> +
> +       /*
> +        * There is still idle time; further improve the number by using the
> +        * irq metric. Because IRQ/steal time is hidden from the task clock we
> +        * need to scale the task numbers:
> +        *
> +        *              1 - irq
> +        *   U' = irq + ------- * U
> +        *                max
> +        */
> +       util *= (max - irq);
> +       util /= max;
> +       util += irq;
> +
> +       /*
> +        * Bandwidth required by DEADLINE must always be granted while, for
> +        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> +        * to gracefully reduce the frequency when no tasks show up for longer
> +        * periods of time.
> +        *
> +        * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> +        * bw_dl as requested freq. However, cpufreq is not yet ready for such
> +        * an interface. So, we only do the latter for now.
> +        */
> +       return min(max, util + cpu_bw_dl(rq));
> +}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 51e7f113ee23..7ad037bb653e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2185,14 +2185,9 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  # define arch_scale_freq_invariant()   false
>  #endif
>
> -enum schedutil_type {
> -       frequency_util,
> -       energy_util,
> -};
>
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> -unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> -                                 enum schedutil_type type);
> +#ifdef CONFIG_SMP
> +unsigned long cpu_util_total(int cpu, unsigned long cfs_util);
>
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
>  {
> @@ -2233,12 +2228,6 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
>  }
>
>  #endif
> -#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> -static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
> -                                 enum schedutil_type type)
> -{
> -       return util;
> -}
>  #endif
>
>  #ifdef CONFIG_SMP

This doesn't look objectionable to me.
