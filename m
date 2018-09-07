Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC162075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC99B6Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC162075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeIGRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:49:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37936 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeIGRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:49:40 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so19783988ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/KOsm+xjajxHv0OEvggXRAv5+GXdjtoRaVqEjZruFVo=;
        b=KC99B6Wd5cB5CrzndEygfkEXaVhx9kBQNLKT7FMQtVbH34+23oaPrgXzkDoOrCcLZa
         /53lZRuQFAG5genxouao4nZhAV4Djnaz9bn89gcACoktKHEQtUe8PyA3+2LrKAkokoNP
         gBTKvonhPirN6tIaLzdJNo3oEM94ycnyMwF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/KOsm+xjajxHv0OEvggXRAv5+GXdjtoRaVqEjZruFVo=;
        b=oV6emvJN29PYCHK9qwl/y7+W9h0eRuQ0qc3RBOuAPMMQ0WA3QOdBgQcQnOni/c+zmd
         zqRhyFNRWnet+/QnXn4YYNgdmBfWQkemwQoOgfInEwxWfR+307vAIXoOHYER8+eysd7T
         KcsfR2trGTdRJj7D+BBn1SF+zXJ7fHqIZAa41Hgw68r961o2Py7Gcz7Uy/c5kAc9No9+
         +q+fqDkdBA09ggtkMuot+6Dz4e+VaUF8fUo+PQkCZdvP2C2b3Nn4sEmtl9GMySQpcFeA
         Cje8RL7TS4ufFiAgyG0DfRRrWf1xS8xMTCdab4pGd0UCf84k9bO40zyHLILi5KBfIMUZ
         pfTw==
X-Gm-Message-State: APzg51BH+pLldfXvXmJq8u2F4df4yGROGM6JWIHHdG8/cBvQJRWIFOnT
        gj2qBEFlemD1J2dCPSBKGiEDv9heuS83iiW77eCC8g==
X-Google-Smtp-Source: ANB0VdYEbJ04HcSWJjde9bNffYorAKsGE7WmxuNigIuy6+B7NdcwXmCmFktcHFwJ9Fq7ad/hh057SlkcdnFHCcqo+cA=
X-Received: by 2002:a24:d104:: with SMTP id w4-v6mr7102289itg.29.1536325725816;
 Fri, 07 Sep 2018 06:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
 <20180907113748.GV24106@hirez.programming.kicks-ass.net> <20180907123551.GA9955@linaro.org>
 <20180907125554.GA24106@hirez.programming.kicks-ass.net>
In-Reply-To: <20180907125554.GA24106@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 Sep 2018 15:08:34 +0200
Message-ID: <CAKfTPtDRq4YXFTJ29+yxdYb0GPUff1C6wnPJwazLoapO6BCJ3g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        jhugo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 at 14:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 07, 2018 at 02:35:51PM +0200, Vincent Guittot wrote:
> > Le Friday 07 Sep 2018 =C3=A0 13:37:49 (+0200), Peter Zijlstra a =C3=A9c=
rit :
> > > On Fri, Sep 07, 2018 at 09:51:04AM +0200, Vincent Guittot wrote:
> > > > It can happen that load_balance finds a busiest group and then a bu=
siest rq
> > > > but the calculated imbalance is in fact null.
> > >
> > > Cute. Does that happen often?
> >
> > I have a use case with RT tasks that reproduces the problem regularly.
> > It happens at least when we have CPUs with different capacity either be=
cause
> > of heterogeous CPU or because of RT/DL reducing available capacity for =
cfs
> > I have put the call path that trigs the problem below and accroding to =
the
> > comment it seems that we can reach similar state when playing with prio=
rity.
> >
> > >
> > > > If the calculated imbalance is null, it's useless to try to find a =
busiest
> > > > rq as no task will be migrated and we can return immediately.
> > > >
> > > > This situation can happen with heterogeneous system or smp system w=
hen RT
> > > > tasks are decreasing the capacity of some CPUs.
> > >
> > > Is it the result of one of those "force_balance" conditions in
> > > find_busiest_group() ? Should we not fix that to then return NULL
> > > instead?
> >
> > The UC is:
> > We have a newly_idle load balance that is triggered when RT task become=
s idle
> > ( but I think that I have seen that with idle load balance too)
> >
> > we trigs:
> >       if (env->idle !=3D CPU_NOT_IDLE && group_has_capacity(env, local)=
 &&
> >           busiest->group_no_capacity)
> >               goto force_balance;
> >
> > In calculate_imbalance we use the path
> >       /*
> >        * Avg load of busiest sg can be less and avg load of local sg ca=
n
> >        * be greater than avg load across all sgs of sd because avg load
> >        * factors in sg capacity and sgs with smaller group_type are
> >        * skipped when updating the busiest sg:
> >        */
> >       if (busiest->avg_load <=3D sds->avg_load ||
> >           local->avg_load >=3D sds->avg_load) {
> >               env->imbalance =3D 0;
> >               return fix_small_imbalance(env, sds);
> >       }
> >
> > but fix_small_imbalance finally decides to return without modifying imb=
alance
> > like here
> >       if (busiest->avg_load + scaled_busy_load_per_task >=3D
> >           local->avg_load + (scaled_busy_load_per_task * imbn)) {
> >               env->imbalance =3D busiest->load_per_task;
> >               return;
> >       }
>
> That one actually does modify imbalance :-) But I get your point.
>
> > Beside this patch, I'm preparing another patch in fix small imbalance t=
o
> > ensure 1 task per CPU in similar situation but according to the comment=
 above,
> > we can reach this situation because of tasks priority
>
> Didn't we all hate fix_small_imbalance() ?

yes.  the rational of some decisions in the function are more and more
opaque to me. For now I'm trying to fix all UCs that I can find to
then try to get a generic rule
As an example, I have some situations (other than those discussed
here) in fix_small_imbalance where the task migration decision mainly
depends of a variation of +/-5 in the load of a task. This finally
generates good fairness between tasks but the root cause of this
fairness is a bit random.

>
> Anyway, I think I'd prefer something like the below; although it might
> be nicer to thread the return value through calculate_imbalance() and
> fix_small_imbalance(), but looking at them that's not going to be
> particularly nicer.
>
> Do you agree with this?, If so, I'll stick your orignal Changelog on it
> and pretend this is what you send me :-)

That's fine to me :-)

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb596f6c1..0596a29f3d2a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8269,7 +8269,7 @@ static struct sched_group *find_busiest_group(struc=
t lb_env *env)
>  force_balance:
>         /* Looks like there is an imbalance. Compute it */
>         calculate_imbalance(env, &sds);
> -       return sds.busiest;
> +       return env->imbalance ? sds.busiest : NULL;
>
>  out_balanced:
>         env->imbalance =3D 0;
