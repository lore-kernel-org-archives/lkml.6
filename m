Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2302146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua1Pr3tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2302146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeK2VsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:48:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33392 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeK2VsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:48:20 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so7091068itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W43hL2jxdV8AviS5wnWHYTM9XjIWPe0lzZEOvGfc1wE=;
        b=Ua1Pr3tSIgzmkZSoujH70qmcJOcIvA3QzeNR0GqoXVl8FbIJyyiBdP1k5KQNpvNRBZ
         wlYZklPBe/IlTHOXFXo8WQlGIapQUPBOalR8Eq+Gikh8Xf3oE5iAnuhLuofhTj+5ITF7
         vbuHTpKlGt1lbIHV521bUlUmd/u3SnCS9udsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W43hL2jxdV8AviS5wnWHYTM9XjIWPe0lzZEOvGfc1wE=;
        b=dd/rHa72BdyHHOXlbx/zKex8sG7qkg25OuzF7FYDL8YGZEcqN0gaESgIr7jRZDyQRe
         tSKp9RfSb346MwFEkdzGDUnT/MPFrZANTWUyY1DpTvvG7Zfc3+HABot+zQkxDQZ4RK9l
         VJ5odHJXWNQBQkccPDltrcATZGjGIPsXNM9/z8TQGaj46nmkN2DOn7CRfeNNHjC/EUbH
         g9sLnaLqJ724/Xt2FJziDCmkeT0Eo09kKjAL7EyaeXAxJMHtNu9MobRUVYFcTQ+EWxtR
         bI3zVsmozgLFrWKRVud/6I18Ui1wD28dO3dSB7iOfwzC2k6MtZCT+SiC8Or6iR2ixUmo
         lhFQ==
X-Gm-Message-State: AA+aEWYd/FpmgwAmdfdZ52GB7M9aY2bPEdnN1CG/lfMLbIrLrZcBwAPz
        TCs4cB3q1F102+JQBpjyPy7IaTwO+5hVdBwJ49WUIg==
X-Google-Smtp-Source: AFSGD/UQ9RxgYaZGivOr3mJrEfoYd4l+d2efCy5VqAqLzyFeFWXRdDmSCBWwcNHkr94P5rMk6WeGcmJRqQTqL3933HU=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr979083itb.152.1543488203263;
 Thu, 29 Nov 2018 02:43:23 -0800 (PST)
MIME-Version: 1.0
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net> <20181128115336.GB23094@e110439-lin>
 <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
 <20181128144039.GC23094@e110439-lin> <CAKfTPtAR7otTTwKYbg5OWbgrUYNKBNsUnOcMS9CfQtbYspvO5A@mail.gmail.com>
 <20181128152133.GD23094@e110439-lin> <CAKfTPtDTSXiVsPepiJDFT9ZCXfUVYTQhRvgfZbF=_w87girPAQ@mail.gmail.com>
 <20181128163545.GE23094@e110439-lin>
In-Reply-To: <20181128163545.GE23094@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Nov 2018 11:43:11 +0100
Message-ID: <CAKfTPtAd8V=Qst82HPb1HW7ZdvrHGgaVhZ=rAdzbHNednp+ztg@mail.gmail.com>
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

On Wed, 28 Nov 2018 at 17:35, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 28-Nov 16:42, Vincent Guittot wrote:
> > On Wed, 28 Nov 2018 at 16:21, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > On 28-Nov 15:55, Vincent Guittot wrote:
> > > > On Wed, 28 Nov 2018 at 15:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > > >
> > > > > On 28-Nov 14:33, Vincent Guittot wrote:
> > > > > > On Wed, 28 Nov 2018 at 12:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > > > > >
> > > > > > > On 28-Nov 11:02, Peter Zijlstra wrote:
> > > > > > > > On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> > > > > > > >
> > > > > > > > > Is there anything else that I should do for these patches ?
> > > > > > > >
> > > > > > > > IIRC, Morten mention they break util_est; Patrick was going to explain.
> > > > > > >
> > > > > > > I guess the problem is that, once we cross the current capacity,
> > > > > > > strictly speaking util_avg does not represent anymore a utilization.
> > > > > > >
> > > > > > > With the new signal this could happen and we end up storing estimated
> > > > > > > utilization samples which will overestimate the task requirements.
> > > > > > >
> > > > > > > We will have a spike in estimated utilization at next wakeup, since we
> > > > > > > use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
> > > > > > > case we collect multiple samples above the current capacity.
> > > > > >
> > > > > > TBH I don't see how it's different from current implementation with a
> > > > > > task that was scheduled on big core and now wakes up on little core.
> > > > > > The util_est is overestimated as well.
> > > > >
> > > > > While running below the capacity of a CPU, either big or LITTLE, we
> > > > > can still measure the actual used bandwidth as long as we have idle
> > > > > time. If the task is then moved into a lower capacity core, I think
> > > > > it's still safe to assume that, likely, it would need more capacity.
> > > > >
> > > > > Why do you say it's the same ?
> > > >
> > > > In the example of a task that runs 39ms in period of 80ms that we used
> > > > during previous version,
> > > > the utilization on the big core will reach 709 so will util_est too
> > > > When the task migrates on little core (512), util_est is higher than
> > > > current cpu capacity
> > >
> > > Right, and what's the problem ?
> >
> > you worry about an util_est being higher than capacity which is the case there
>
> I worry about util_est being higher then the capacity the task WAS
> running... not the capacity the task IS running... if that value does
> not correspond to what the task really need... (more on that at the
> end).
>
> > > 1) We know that PELT is calibrated to 32ms period task and in your
> > >    example, since the runtime is higher then the half-life, it's
> > >    correct to estimate a utilization higher then 50%.
> > >
> > >    PELT utilization is defined _based on the half-life_: thus
> > >    your task having a 50% duty cycle does not mean we are not correct
> > >    if report a utilization != 50%.
> > >    It would be as broken as reporting 10% utilization for a task
> > >    running 100ms every 1s.
> > >
> > > 2) If it was a 70% task on a previous activation, once it's moved into
> > >    a lower capacity CPU it's still correct to assume that it's likely
> > >    going to require the same bandwidth and thus will be
> > >    under-provisioned.
> > >
> > > I still don't see where we are wrong in this case :/
> > >
> > > To me it looks different then the problem I described.
> > >
> > > > > With your new signal instead, once we cross the current capacity,
> > > > > utilization is just not anymore utilization. Thus, IMHO it make sense
> > > > > avoid to accumulate a sample for what we call "estimated utilization".
> >
> > This is not true. With the example above, the util_est will be exactly the same
> >  on big and little cores with the new signal
>
> ... AFAIU only if we have idle time...
>
> > > > > I would also say that, with the current implementation which caps
> > > > > utilization to the current capacity, we get better estimation in
> > > > > general. At least we can say with absolute precision:
> > > > >
> > > > >    "the task needs _at least_ that amount of capacity".
> > > > >
> > > > > Potentially we can also flag the task as being under-provisioned, in
> > > > > case there was not idle time, and _let a policy_ decide what to do
> > > > > with it and the granted information we have.
> > > > >
> > > > > While, with your new signal, once we are over the current capacity,
> > > > > the "utilization" is just a sort of "random" number at best useful to
> > > > > drive some conclusions about how long the task has been delayed.
> >
> > see my comment above
> >
> > > > >
> > > > > IOW, I fear that we are embedding a policy within a signal which is
> > > > > currently representing something very well defined: how much cpu
> > > > > bandwidth a task used. While, latency/under-provisioning policies
> > > > > perhaps should be better placed somewhere else.
> > > > >
> > > > > Perhaps I've missed it in some of the previous discussions:
> > > > > have we have considered/discussed this signal-vs-policy aspect ?
> > >
> > > What's your opinion on the above instead ?
> >
> > It's not a policy but it gives better knowledge about the amount a work done
> > I have put below discussion on the  subject on previous version
>
> Thanks, I think I've skimmed through it, but it's sill useful...
>
> > > > With contribution scaling the PELT utilization of a task is a _minimum_
> > > > utilization. Regardless of where the task is currently/was running (and
> > > > provided that it doesn't change behaviour) its PELT utilization will
> > > > approximate its _minimum_ utilization on an idle 1024 capacity CPU.
> > >
> > > The main drawback is that the _minimum_ utilization depends on the CPU
> > > capacity on which the task runs. The two 25% tasks on a 256 capacity
> > > CPU will have an utilization of 128 as an example
> > >
> > > >
> > > > With time scaling the PELT utilization doesn't really have a meaning on
> > > > its own. It has to be compared to the capacity of the CPU where it
> > > > is/was running to know what the its current PELT utilization means. When
> > >
> > > I would have said the opposite. The utilization of the task will
> > > always reflect the same amount of work that has been already done
> > > whatever the CPU capacity.
> > > In fact, the new scaling mechanism uses the real amount of work that
> > > has been already done to compute the utilization signal which is not
> > > the case currently. This gives more information about the real amount
> > > of worked that has been computed in the over utilization case.
> > >
> > > > the utilization over-shoots the capacity its value is no longer
> > > > represents utilization, it just means that it has a higher compute
> > > > demand than is offered on its current CPU and a high value means that it
> > > > has been suffering longer. It can't be used to predict the actual
> > > > utilization on an idle 1024 capacity any better than contribution scaled
> > > > PELT utilization.
> > >
> > > I think that it provides earlier detection of over utilization and
> > > more accurate signal for a longer time duration which can help the
> > > load balance
> > > Coming back to 50% task example . I will use a 50ms running time
> > > during a 100ms period for the example below to make it easier
> > >
> > > Starting from 0, the evolution of the utilization is:
> > >
> > > With contribution scaling:
> > >          time  0ms  50ms  100ms  150ms  200ms
> > > capacity
> > > 1024           0    666
> > > 512            0    333   453
> > > When the CPU start to be over utilized (@100ms), the utilization is
> > > already too low (453 instead of 666) and scheduler doesn't detect yet
> > > that we are over utilized
> > > 256            0    169   226    246    252
> > > That's even worse with this lower capacity
> > >
> > > With time scaling,
> > >          time  0ms  50ms  100ms  150ms  200ms
> > > capacity
> > > 1024           0    666
> > > 512            0    428   677
> > > We know that the current capacity is not enough and the utilization
> > > reflect the correct utilization level compare to 1024 capacity (the
> > > 666 vs 677 difference comes from the 1024us window so the last window
> > > is not full in the case of max capacity)
> > > 256            0    234   468    564    677
> > > At 100ms, we know that there is not enough capacity. (In fact we know
> > > that at 56ms). And even at time 200ms, the amount of work is exactly
> > > what would have been executed on a CPU 4x faster
> > >
> > > >
> > > > This change might not be a showstopper, but it is something to be aware
> > > > off and take into account wherever PELT utilization is used.
> > >
> > > The point above is clearly a big difference between the 2 approaches
> > > of the no spare cycle case but I think it will help by giving more
> > > information in the over utilization case
>
> I like the idea that we ramp up faster and always get to the same
> value. I like also the idea that we always reach the same value on
> both LITTLE and big.
>
> As long as there is idle time this is working fine, in these cases we
> should probably also collect util_est samples.
>
> But what happens when we don't have idle time ?

As shown above, the utilization stays correct for a longer time frame
even after the over utilization point and provides better over
utilization detection

>
> Let say we have 2 15% tasks, co-scheduled on a cpu with <300 capacity.
>
> Are not these two tasks being reported as 50% tasks (after a while) ?

Yes they will but similarly to above they will stay correct for longer
time even when they become higher than current cpu capacity


>
> If that's the case, these are samples we should not store...
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
