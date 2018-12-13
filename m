Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21033C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85B420672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuXjSDtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85B420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLMIGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:06:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52634 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLMIGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:06:00 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so2428620itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnj+G1yj3fNPeylUmLrwzOntugiQoQmY8m3O/PIKQUE=;
        b=KuXjSDtHZweFmKwGdxTFNy3BTcAzbaP2gA72N2hObcsTPYn5klQlDVYfSC3p2MB2bD
         ZYtSy6o1+c8311m0FCich6grSO9HzNW2/rCY2JF7GG8MDvAHS4h0ecNGIke4m2h/a5Mm
         99Puyx7fZbZFAPG9wbyZcU9UP2bk8VeLuOJaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnj+G1yj3fNPeylUmLrwzOntugiQoQmY8m3O/PIKQUE=;
        b=WJ/KvityosI6IbqJ8iZhEqfqR96MgtdpJISe4ztM5YKRpfidNmTJXG5XiRVUx1M4S/
         Gh8jDeE6Xk3DD/14oZxr5aJ8e2E0OUrgc8zTUH/DwdXXZ43vmIoO8Spxo+dMpbugQmul
         WyM5p3j6Bk2QnQ3R/avTXed2wVLkw/FSbp8DRle91enFKCXWY912SsXA0GuwK0/AufsU
         KjhPe8iNg49QJzgc0AggPqHrBR03XzYLw9fIP42Oix2nIh0ww1tCPbt4opadnaVqhYDa
         6p4OOU8m6WORsIw9QvYTmUbnQdVtL04l+Tr0+klKOp4mJaGMvl2HzCiRcJ9uQ2IO6CS4
         JLxQ==
X-Gm-Message-State: AA+aEWYgj7iSKqjDnarHmSFf9aSVoKKzLgXj0gg+yQunqXYbX8Y8DNvY
        v9mqhjWSdZBF8W5YvvkMtxOSEHlDqpeOJORFbjYrEw==
X-Google-Smtp-Source: AFSGD/Xs9YgEHPTB9R6JXSeiT1coPwVRWKE9FSWUmZMFT2J5gcTSOHGBG+Vglz4eyjTmxHM+E+DBOnV/118wxTiNsLI=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr8815530itb.152.1544688358604;
 Thu, 13 Dec 2018 00:05:58 -0800 (PST)
MIME-Version: 1.0
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
 <acea081e-e9c0-10de-8a66-762a01f15b7b@arm.com> <CAKfTPtAzDXKatZN_Wu-J3W8YX9bWcRxeg5CSXSxV-eRjq4vRAQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAzDXKatZN_Wu-J3W8YX9bWcRxeg5CSXSxV-eRjq4vRAQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Dec 2018 09:05:47 +0100
Message-ID: <CAKfTPtDKt32+UgQmx0aP9SZs-CY+K0eSw-5famxnWrNGVWsmpw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ingo,

On Fri, 14 Sep 2018 at 18:26, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 14 Sep 2018 at 05:22, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > Hi,
> >
> > On 10/09/18 07:43, Vincent Guittot wrote:
> > > When CPUs have different capacity because of RT/DL tasks or
> > > micro-architecture or max frequency differences, there are situation where
> > > the imbalance is not correctly set to migrate waiting task on the idle CPU.
> > >
> > > The UC uses the force_balance case :
> > >       if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > >           busiest->group_no_capacity)
> > >               goto force_balance;
> > >
> > > But calculate_imbalance fails to set the right amount of load to migrate
> > > a task because of the special condition:
> > >   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> > >
> > > Add in fix_small_imbalance, this special case that triggered the force
> > > balance in order to make sure that the amount of load to migrate will be
> > > enough.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Other than the commit nit, LGTM. Out of curiosity I ran some kernel compile
> > on my HiKey960 (-j8) but didn't see much change - something along the lines
> > of ~1% speedup, and although it was consistent over a few iterations, I'd
> > need a whole lot more of them to back this up.
> >
> > I kind of expected it because some sporadic task can show up and tip the
> > scale in the right direction, so even without the patch the situation can
> > "fix itself" eventually, and it becomes less noticeable on really long
> > workloads.
>
> I have seen a better stdev and shorter duration for the tests that you
> used for misfit patch.
> The test have been done with asym packing and the few fixes that I
> sent in another patchset for asym packing
>
> >
> > I do see a difference by looking at the trace of a simple 8 100% tasks rt-app
> > workload though, as I no longer see that idling LITTLE I sometimes get
> > without the patch, which is what we expect, so:
> >
> > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
>
> Thanks
>
> >
> > > ---
> >
> > Again, I'd argue for a slightly more explicit header. As you pointed out in
> > v1, it's not just long running tasks, so maybe just "fix 1 *running* task per
> > CPU"? Otherwise I feel it's a tad obscure.
>
> To be honest i don't mind about header but I don't see the benefit of
> adding *running*.
> So I let Peter or Ingo decide what they prefer

This patch has been in the list for a while.
What should i do to move forward with it ?

Thanks
Vincent

>
> >
> > >  kernel/sched/fair.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 309c93f..72bc5e8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> > >       local = &sds->local_stat;
> > >       busiest = &sds->busiest_stat;
> > >
> > > +     /*
> > > +      * There is available capacity in local group and busiest group is
> > > +      * overloaded but calculate_imbalance can't compute the amount of load
> > > +      * to migrate because load_avg became meaningless due to asymetric
> > > +      * capacity between groups.
> >
> > Could you add something along the lines of "(see similar condition in
> > find_busiest_group())"?
> >
> > In such case, we only want to migrate at
> > > +      * least one tasks of the busiest group and rely of the average load
> > > +      * per task to ensure the migration.
> > > +      */
> > > +     if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > > +         busiest->group_no_capacity) {
> > > +             env->imbalance = busiest->load_per_task;
> > > +             return;
> > > +     }
> > > +
> > >       if (!local->sum_nr_running)
> > >               local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
> > >       else if (busiest->load_per_task > local->load_per_task)
> > >
