Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350922085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsAZHEPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350922085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeKFXx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:53:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39404 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbeKFXx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:53:28 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so17812325itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4pcJItPgSeyxZm9q16wMA9gZcHZhddjdnOk9ux/yLA=;
        b=TsAZHEPN0JhJJi5q8LGZ82AnN6ue5iNoMNts8nu1BHYzh1ff+yQ3t4nAkKh4aCGAGv
         YQU/FdPtMDmBTtGoMrYUA5ZV7Ko0PbF9ocwmFr9fRYiydrFgDFvebmmRBQbWelL4/64n
         wYwU2jvHbwsjXE3DhWVacZtUrCEBMRnufqBb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4pcJItPgSeyxZm9q16wMA9gZcHZhddjdnOk9ux/yLA=;
        b=lVuaZSr2QCPvursVKAbTGIcGa7oGR1OU1qbVrdMFmAFBYGVvjU5+xU8SgImH12Ms+R
         5/2y8w3pKHZALlLthiEXQJHRKoHf0fH8E56CgU6E+HMbGK7cnWm3+8z/rS8cwZEaSkGT
         LjaCTUaG0vw5j2t7vv1Hy2hPKdmeokve/4hNWJxlziYBkklakgxG5t+X3eZbuH61evyP
         S7dbp/gwoL30+trUs6uYuqdcLYvW4nZTdLZSXeTnWFtyVX5Hs42ey5fmzFuftxn0/rOG
         rFZwf9HveE487uutXwATJZ8gn75wpcJF61aO2knmjJ8iDiLr+afiq/C70YQcvsrFOtwJ
         R14w==
X-Gm-Message-State: AGRZ1gJliHWbCsMqT+voNmRDazztpzT2DKuT2QK7bXthtjaXk1E0CB5x
        BVqttGBJMrvXu+U/GHiO3YTbqyldoDhL3gOyRbpxzw==
X-Google-Smtp-Source: AJdET5ex7Nrfyi1SddeHOg/ov3lBvbSPeKccSiqvgCADJ7/9PfTwfvKxf/XUwBuZnwWAME4wHtqwnTR5Q+MSkACOllM=
X-Received: by 2002:a24:c983:: with SMTP id h125-v6mr2093197itg.152.1541514478516;
 Tue, 06 Nov 2018 06:27:58 -0800 (PST)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com> <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
 <20181105145854.GA6401@e105550-lin.cambridge.arm.com>
In-Reply-To: <20181105145854.GA6401@e105550-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Nov 2018 15:27:47 +0100
Message-ID: <CAKfTPtBafbhO7ekkngDEU0vPkwF0zGpMV2warB-dy=NBpAzYqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 at 15:59, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> On Mon, Nov 05, 2018 at 10:10:34AM +0100, Vincent Guittot wrote:
> > On Fri, 2 Nov 2018 at 16:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >
...
> > > >
> > > > In order to achieve this time scaling, a new clock_pelt is created per rq.
> > > > The increase of this clock scales with current capacity when something
> > > > is running on rq and synchronizes with clock_task when rq is idle. With
> > > > this mecanism, we ensure the same running and idle time whatever the
> > > > current capacity.
> > >
> > > Thinking about this new approach on a big.LITTLE platform:
> > >
> > > CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor
> > >
> > > A 50% (runtime/period) task on a big CPU will become an always running
> > > task on the little CPU. The utilization signal of the task and the
> > > cfs_rq of the little CPU converges to 1024.
> > >
> > > With contrib scaling the utilization signal of the 50% task converges to
> > > 512 on the little CPU, even it is always running on it, and so does the
> > > one of the cfs_rq.
> > >
> > > Two 25% tasks on a big CPU will become two 50% tasks on a little CPU.
> > > The utilization signal of the tasks converges to 512 and the one of the
> > > cfs_rq of the little CPU converges to 1024.
> > >
> > > With contrib scaling the utilization signal of the 25% tasks converges
> > > to 256 on the little CPU, even they run each 50% on it, and the one of
> > > the cfs_rq converges to 512.
> > >
> > > So what do we consider system-wide invariance? I thought that e.g. a 25%
> > > task should have a utilization value of 256 no matter on which CPU it is
> > > running?
> > >
> > > In both cases, the little CPU is not going idle whereas the big CPU does.
> >
> > IMO, the key point here is that there is no idle time. As soon as
> > there is no idle time, you don't know if a task has enough compute
> > capacity so you can't make difference between the 50% running task or
> > an always running task on the little core.
> > That's also interesting to noticed that the task will reach the always
> > running state after more than 600ms on little core with utilization
> > starting from 0.
> >
> > Then considering the system-wide invariance, the task are not really
> > invariant. If we take a 50% running task that run 40ms in a period of
> > 80ms, the max utilization of the task will be 721 on the big core and
> > 512 on the little core.
> > Then, if you take a 39ms running task instead, the utilization on the
> > big core will reach 709 but it will be 507 on little core. So your
> > utilization depends on the current capacity
> > With the new proposal, the max utilization will be 709 on big and
> > little cores for the 39ms running task. For the 40ms running task, the
> > utilization will be 721 on big core. then if the task moves on the
> > little, it will reach the value 721 after 80ms,  then 900 after more
> > than 160ms and 1000 after 320ms
>
> It has always been debatable what to do with utilization when there are
> no spare cycles.
>
> In Dietmar's example where two 25% tasks are put on a 512 (50%) capacity
> CPU we add just enough utilization to have no spare cycles left. One
> could argue that 25% is still the correct utilization for those tasks.
> However, we only know their true utilization because they just ran
> unconstrained on a higher capacity CPU. Once they are on the 512 capacity
> CPU we wouldn't know if the tasks grew in utilization as there are no
> spare cycles to use.
>
> As I see it, the most fundamental difference between scaling
> contribution and time for PELT is the characteristics when CPUs are
> over-utilized.

I agree that there is a big difference in the way the over utilization
state is handled

>
> With contribution scaling the PELT utilization of a task is a _minimum_
> utilization. Regardless of where the task is currently/was running (and
> provided that it doesn't change behaviour) its PELT utilization will
> approximate its _minimum_ utilization on an idle 1024 capacity CPU.

The main drawback is that the _minimum_ utilization depends on the CPU
capacity on which the task runs. The two 25% tasks on a 256 capacity
CPU will have an utilization of 128 as an example

>
> With time scaling the PELT utilization doesn't really have a meaning on
> its own. It has to be compared to the capacity of the CPU where it
> is/was running to know what the its current PELT utilization means. When

I would have said the opposite. The utilization of the task will
always reflect the same amount of work that has been already done
whatever the CPU capacity.
In fact, the new scaling mechanism uses the real amount of work that
has been already done to compute the utilization signal which is not
the case currently. This gives more information about the real amount
of worked that has been computed in the over utilization case.

> the utilization over-shoots the capacity its value is no longer
> represents utilization, it just means that it has a higher compute
> demand than is offered on its current CPU and a high value means that it
> has been suffering longer. It can't be used to predict the actual
> utilization on an idle 1024 capacity any better than contribution scaled
> PELT utilization.

I think that it provides earlier detection of over utilization and
more accurate signal for a longer time duration which can help the
load balance
Coming back to 50% task example . I will use a 50ms running time
during a 100ms period for the example below to make it easier

Starting from 0, the evolution of the utilization is:

With contribution scaling:
         time  0ms  50ms  100ms  150ms  200ms
capacity
1024           0    666
512            0    333   453
When the CPU start to be over utilized (@100ms), the utilization is
already too low (453 instead of 666) and scheduler doesn't detect yet
that we are over utilized
256            0    169   226    246    252
That's even worse with this lower capacity

With time scaling,
         time  0ms  50ms  100ms  150ms  200ms
capacity
1024           0    666
512            0    428   677
We know that the current capacity is not enough and the utilization
reflect the correct utilization level compare to 1024 capacity (the
666 vs 677 difference comes from the 1024us window so the last window
is not full in the case of max capacity)
256            0    234   468    564    677
At 100ms, we know that there is not enough capacity. (In fact we know
that at 56ms). And even at time 200ms, the amount of work is exactly
what would have been executed on a CPU 4x faster

>
> This change might not be a showstopper, but it is something to be aware
> off and take into account wherever PELT utilization is used.

The point above is clearly a big difference between the 2 approaches
of the no spare cycle case but I think it will help by giving more
information in the over utilization case

Vincent
>
> Morten
