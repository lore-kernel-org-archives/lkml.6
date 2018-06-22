Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06557C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE52246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj7Q+7oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE52246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934050AbeFVRZD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:25:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35968 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933979AbeFVRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:24:36 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so3939634itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2pbTTGVtVHz3MZXmhHrp7r6kaglmCc0RGbnId53dWQ=;
        b=Pj7Q+7oQZzSTH64JGvDuKs43vgE/AcmaC6A6kM9/B8P/oDfCTTnNfx6adG8+Ys0Psf
         1evOeJWpfSvAYpP6b5MojoXMu3CgkwsWc/Zn6iY9LzK0MgzQQeWSlmEownWuactTwOd/
         ZHRalfPaGdUtWq4WhFuKoV8FZrv8Nm7y1TJNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2pbTTGVtVHz3MZXmhHrp7r6kaglmCc0RGbnId53dWQ=;
        b=efUg4bjDvMgMvrUZaT6e9L+ojsUPsuYyWWmlE0sGSEOaabkHPaUJSumix5KvIM0ZQQ
         Sgkm4Lrf9WXtH+1esoH84OKTWepdQjoeXsQ+NJt4Q1iJSlmwRbl/nAFRqETP6744qClQ
         D8UzrWGkSu5JHInEkJgk9rGBornPzrfbzMUIzL5rJkIWXQ/gX4cYqjr1OVLXDAowCSHy
         MaID+cdR2EHWLedIgp3mdCCxI0CflAvSq5ujzSJpYbonZK/AOsG1sxCxMNDurdUW9GKX
         G6Qla3DGKU8zJ64rEu0WuI/lRXFldui1Y80z0nDMFBFbC1c/nUubGvI7pMJiqhCXaJxc
         zc6g==
X-Gm-Message-State: APt69E3x0oreMIhOahzKwSEwZUh+vzBv8ql1nofIlEGozWwPwr8QlLza
        A/nuGEMHFLdi8BuiBkJFpK22FIhqlg7/CYvN1sPW4Q==
X-Google-Smtp-Source: ADUXVKLsztP9VlxGxqevnZeYU4COmjXZd2p+TnzLupel451eFCUTLy1KIsphNEoMTuvtKxXw0Glmx+WPA+xrMzFm0Rg=
X-Received: by 2002:a02:8604:: with SMTP id e4-v6mr2156386jai.12.1529688275554;
 Fri, 22 Jun 2018 10:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net> <20180622152258.GF2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622152258.GF2512@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 19:24:24 +0200
Message-ID: <CAKfTPtDSuvX5_GEYQ9HgqdEn-EwiCx7MGHtY73GysQh6m9kZFA@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 17:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 22, 2018 at 01:37:13PM +0200, Peter Zijlstra wrote:
> > That is true.. So we could limit the scaling to the case where there is
> > no idle time, something like:
> >
> >       util = sg_cpu->util_cfs;
> >
> >       cap_cfs = (1024 - (sg_cpu->util_rt + ...));
> >       if (util == cap_cfs)
> >               util = sg_cpu->max;
> >
>
> OK, it appears this is more or less what the patches do. And I think
> there's a small risk/hole with this where util ~= cap_cfs but very close
> due to some unaccounted time.
>
> FWIW, when looking, I saw no reason why sugov_get_util() and
> sugov_aggregate_util() were in fact separate functions.

good point

>
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -53,11 +53,7 @@ struct sugov_cpu {
>         unsigned int            iowait_boost_max;
>         u64                     last_update;
>
> -       /* The fields below are only needed when sharing a policy: */
> -       unsigned long           util_cfs;
>         unsigned long           util_dl;
> -       unsigned long           bw_dl;
> -       unsigned long           util_rt;
>         unsigned long           max;
>
>         /* The field below is for single-CPU policies only: */
> @@ -181,44 +177,38 @@ static unsigned int get_next_freq(struct
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
> +       unsigned long util, max;
>
> -       sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> -       sg_cpu->util_cfs = cpu_util_cfs(rq);
> -       sg_cpu->util_dl  = cpu_util_dl(rq);
> -       sg_cpu->bw_dl    = cpu_bw_dl(rq);
> -       sg_cpu->util_rt  = cpu_util_rt(rq);
> -}
> -
> -static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> -{
> -       struct rq *rq = cpu_rq(sg_cpu->cpu);
> -       unsigned long util;
> +       sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> +       sg_cpu->util_dl   = cpu_util_dl(rq);
>
>         if (rq->rt.rt_nr_running)
> -               return sg_cpu->max;
> +               return max;
>
> -       util = sg_cpu->util_cfs;
> -       util += sg_cpu->util_rt;
> +       util  = cpu_util_cfs(rq);
> +       util += cpu_util_rt(rq);
>
> -       if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> -               return sg_cpu->max;
> +       /*
> +        * If there is no idle time, we should run at max frequency.
> +        */
> +       if ((util + cpu_util_dl(rq)) >= max)
> +               return max;
>
>         /*
> -        * As there is still idle time on the CPU, we need to compute the
> -        * utilization level of the CPU.
>          * Bandwidth required by DEADLINE must always be granted while, for
>          * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
>          * to gracefully reduce the frequency when no tasks show up for longer
>          * periods of time.
> +        *
> +        * Ideally we would like to set bw_dl as min/guaranteed freq and bw_dl
> +        * + util as requested freq. However, cpufreq is not yet ready for such
> +        * an interface. So, we only do the latter for now.
>          */
>
> -       /* Add DL bandwidth requirement */
> -       util += sg_cpu->bw_dl;
> -
> -       return min(sg_cpu->max, util);
> +       return min(max, cpu_bw_dl(rq) + util);
>  }
>
>  /**
> @@ -396,9 +386,8 @@ static void sugov_update_single(struct u
>
>         busy = sugov_cpu_is_busy(sg_cpu);
>
> -       sugov_get_util(sg_cpu);
> +       util = sugov_get_util(sg_cpu);
>         max = sg_cpu->max;
> -       util = sugov_aggregate_util(sg_cpu);
>         sugov_iowait_apply(sg_cpu, time, &util, &max);
>         next_f = get_next_freq(sg_policy, util, max);
>         /*
> @@ -437,9 +426,8 @@ static unsigned int sugov_next_freq_shar
>                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>                 unsigned long j_util, j_max;
>
> -               sugov_get_util(j_sg_cpu);
> +               j_util = sugov_get_util(j_sg_cpu);
>                 j_max = j_sg_cpu->max;
> -               j_util = sugov_aggregate_util(j_sg_cpu);
>                 sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
>
>                 if (j_util * max > j_max * util) {
>
