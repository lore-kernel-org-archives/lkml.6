Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E71CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C12B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnIRnHKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C12B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeFRM6k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:58:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40261 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeFRM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:58:38 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so11782208ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cqEnYy00bMT7pGtHVlgPpBTY+fjCGZSIRDNvksC1UA=;
        b=OnIRnHKteatAm89CvcFBegBkI8zMb7nyk+rUNdFH3BB10LAL2XMHPQ8E6bMHD5Ds3x
         jnwvB/uoiqn4RlPwVLyoWdduyxMTLg1ELHon/GUEMP2S4Qd8L8aHAXuKQUvpmMkj2fVo
         Tj1dFHk+R6asp95d2cCZeEcU4NUQDii1E9IfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cqEnYy00bMT7pGtHVlgPpBTY+fjCGZSIRDNvksC1UA=;
        b=QgoaBlkdA1tYgK5t7edshv3BHfXhfGxkL3U9D7Vpm7C2jDLAhKxprCrfhPRugpDvDN
         iw4BVNTZkBUyzna52Cm1QoaDqmW30v16E4lbGCjY2JKm6GjfsHotneFoJvsJ11IEgm+j
         joWdxkeJ6SkG3aTjF42pfhC4E4KXLEVa+VOvmWDMcuE8FFT/UCVzn+pAT+iZ2ZtBNI5k
         9wuSn0NEGBLKlQ6deu0MnFJVFf/tX1ZRAg2Y8Rsgn0DYawEiDcV/3vN+KOTB2+vykCb/
         Ehi6iDdwCO0qkRQ3E9IAR/Fi0CFts2CO68o2O6lv2F5YDNUsTKLawwbIUHM9nSLdbzoM
         WOOw==
X-Gm-Message-State: APt69E23KL9wOdzVV8BvUXs1lciwmMkNLqkskwAU17QQKkn+SBU2CQ94
        7yU+hGGXnmVWPqGKh21W6obqnnoIPBL5kSNqa9T1QA==
X-Google-Smtp-Source: ADUXVKKAIOOSQC9x6x7iFaAQyAdv+LZHGdXKKgt8UbIbYCNsN2c2k7x5iZVA+yNWy29waI7avWoa9Pu7dhQvLktzAzs=
X-Received: by 2002:a24:4985:: with SMTP id e5-v6mr8985146itd.89.1529326717813;
 Mon, 18 Jun 2018 05:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org> <072d862a-7b9c-3d17-d0cc-a3082b826cf9@arm.com>
In-Reply-To: <072d862a-7b9c-3d17-d0cc-a3082b826cf9@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jun 2018 14:58:26 +0200
Message-ID: <CAKfTPtD_j0q0_Pvn1B9BJRe-fDELgPY0=hO8BY4tNt4xe8ynGg@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 at 11:00, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 06/08/2018 02:09 PM, Vincent Guittot wrote:
> > Take into account rt utilization when selecting an OPP for cfs tasks in order
> > to reflect the utilization of the CPU.
>
> The rt utilization signal is only tracked per-cpu, not per-entity. So it
> is not aware of PELT migrations (attach/detach).
>
> IMHO, this patch deserves some explanation why the temporary
> inflation/deflation of the OPP driving utilization signal in case an
> rt-task migrates off/on (missing detach/attach for rt-signal) doesn't
> harm performance or energy consumption.
>
> There was some talk (mainly on #sched irc) about ... (1) preempted cfs
> tasks (with reduced demand (utilization id only running) signals) using
> this remaining rt utilization of an rt task which migrated off and ...
> (2) going to max when an rt tasks runs ... but a summary of all of that
> in this patch would really help to understand.

Ok. I will add more comments in the next version. I just wait a bit to
let time to get more feedback before sending a new release

>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 28592b6..32f97fb 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -56,6 +56,7 @@ struct sugov_cpu {
> >       /* The fields below are only needed when sharing a policy: */
> >       unsigned long           util_cfs;
> >       unsigned long           util_dl;
> > +     unsigned long           util_rt;
> >       unsigned long           max;
> >
> >       /* The field below is for single-CPU policies only: */
> > @@ -178,15 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >       sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> >       sg_cpu->util_cfs = cpu_util_cfs(rq);
> >       sg_cpu->util_dl  = cpu_util_dl(rq);
> > +     sg_cpu->util_rt  = cpu_util_rt(rq);
> >   }
> >
> >   static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >   {
> >       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +     unsigned long util;
> >
> >       if (rq->rt.rt_nr_running)
> >               return sg_cpu->max;
> >
> > +     util = sg_cpu->util_dl;
> > +     util += sg_cpu->util_cfs;
> > +     util += sg_cpu->util_rt;
> > +
> >       /*
> >        * Utilization required by DEADLINE must always be granted while, for
> >        * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> > @@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >        * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >        * ready for such an interface. So, we only do the latter for now.
> >        */
> > -     return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > +     return min(sg_cpu->max, util);
> >   }
> >
> >   static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> >
>
