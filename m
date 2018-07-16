Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C8EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D8F20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC77z7D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D8F20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGPLv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:51:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42387 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeGPLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:51:59 -0400
Received: by mail-io0-f194.google.com with SMTP id g11-v6so4118591ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ht2XPhOdIwCiIAIB61h01YXwgPiMHuxcOt6ft59wYuk=;
        b=aC77z7D9TsAvY6JlkTCkzXgwTxD7/3SGlH0RB3Aop9ydNJF9B4cYm9/5uTj5IkxX/O
         5YmzKfMRa/UnrYQe7Lk4zUCS5AjGCBhRkwdqJXebFPX1h80X0NrCA3irRHrnJ5Hxv4/6
         iv3AqZrWRW19l2bwSMSS2pjE7n8Ck2I3XHMgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ht2XPhOdIwCiIAIB61h01YXwgPiMHuxcOt6ft59wYuk=;
        b=SZFWKxyQAZIqzqOLTYO9wB66EMbdwAZNx9GcaKgmbLZYTHdtGRqJl5koHNFgEWtiX8
         rqwaM/y6S7XlY2vocI/K8aoALJNscL3a+lKCePa8RuEarAN1XOdhlgrv/xaBp4K/6Oyi
         CWXsjdrgj4jsewGQTPgrua1J5XPN1tuLDiVV/e85Z7rJdNrtUIpX0SDseH+xDD2c+tPn
         aSDi53A8IyfkxhIqXpchlUIM9ydS5eQm8dbCNefzkONE6b4/RwPehkMsluA40AGtOGdM
         JDnV7rqbzCwAG9+8/4CtrOMOLTWME2LOB3HowGQomH3+ey5WeWY13SQIVmSmCuhYv/CO
         D5xg==
X-Gm-Message-State: AOUpUlGGlYysOsAydTd3k8oOTUzdkX+LAklOIY86ilucdfIDH1b5vUKg
        QwYNM9CAvLgKEOvh/IThUBxys7Xs2LvDE2ykLbAf3gaC
X-Google-Smtp-Source: AAOMgpdJPQznBXyaR6g0329YbO4pjwTtB1Dc0icQUmpIrdg9rVourswEePF8G3n/uxw7V7cmcA3JmZIytf7KVQKdF4A=
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr38185893ioa.294.1531740300812;
 Mon, 16 Jul 2018 04:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org> <20180715221538.GA23280@gmail.com>
In-Reply-To: <20180715221538.GA23280@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Jul 2018 13:24:48 +0200
Message-ID: <CAKfTPtCNtsu3v95+2vtVAn_mxAO_gQgb0X1L2G97T2dwdvee1g@mail.gmail.com>
Subject: Re: [PATCH 09/11] sched: use pelt for scale_rt_capacity()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, 16 Jul 2018 at 00:15, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>

> > @@ -7550,39 +7550,36 @@ static inline int get_sd_load_idx(struct sched_=
domain *sd,
> >  static unsigned long scale_rt_capacity(int cpu)
> >  {
> >       struct rq *rq =3D cpu_rq(cpu);
> > -     u64 total, used, age_stamp, avg;
> > -     s64 delta;
> > -
> > -     /*
> > -      * Since we're reading these variables without serialization make=
 sure
> > -      * we read them once before doing sanity checks on them.
> > -      */
> > -     age_stamp =3D READ_ONCE(rq->age_stamp);
> > -     avg =3D READ_ONCE(rq->rt_avg);
> > -     delta =3D __rq_clock_broken(rq) - age_stamp;
> > +     unsigned long max =3D arch_scale_cpu_capacity(NULL, cpu);
> > +     unsigned long used, irq, free;
> >
> > -     if (unlikely(delta < 0))
> > -             delta =3D 0;
> > +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIM=
E_ACCOUNTING)
> > +     irq =3D READ_ONCE(rq->avg_irq.util_avg);
> >
> > -     total =3D sched_avg_period() + delta;
> > +     if (unlikely(irq >=3D max))
> > +             return 1;
> > +#endif
>
> Note that 'irq' is unused outside that macro block, resulting in a new wa=
rning on
> defconfig builds:
>
>  CC      kernel/sched/fair.o
>  kernel/sched/fair.c: In function =E2=80=98scale_rt_capacity=E2=80=99:
>  kernel/sched/fair.c:7553:22: warning: unused variable =E2=80=98irq=E2=80=
=99 [-Wunused-variable]
>    unsigned long used, irq, free;
>                        ^~~
>
> I have applied the delta fix below for simplicity, but what we really wan=
t is a
> cleanup of that function to eliminate the #ifdefs. One solution would be =
to factor
> out the 'irq' utilization value into a helper inline, and double check th=
at if the
> configs are off the compiler does the right thing and eliminates this ide=
ntity
> transformation for the irq=3D=3D0 case:
>
>         free *=3D (max - irq);
>         free /=3D max;
>
> If the compiler refuses to optimize this away (due to the zero and overfl=
ow
> cases), try to find something more clever?

Thanks for the fix.
I'm off for now and will look at your proposal above once back

Regards,
Vincent

>
> Thanks,
>
>         Ingo
>
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e3221db0511a..d5f7d521e448 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7550,7 +7550,10 @@ static unsigned long scale_rt_capacity(int cpu)
>  {
>         struct rq *rq =3D cpu_rq(cpu);
>         unsigned long max =3D arch_scale_cpu_capacity(NULL, cpu);
> -       unsigned long used, irq, free;
> +       unsigned long used, free;
> +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_=
ACCOUNTING)
> +       unsigned long irq;
> +#endif
>
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_=
ACCOUNTING)
>         irq =3D READ_ONCE(rq->avg_irq.util_avg);
