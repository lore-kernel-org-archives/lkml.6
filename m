Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E18C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9551217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACzwmml1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9551217C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeHMQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:49:01 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34920 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:49:01 -0400
Received: by mail-io0-f176.google.com with SMTP id w11-v6so14926086iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvHG/8+/b5TFB8/1p9i6sISZ2lSMu9cNl1ktZUjWwqQ=;
        b=ACzwmml1SiPHuVQIO3roxuhG0YGJ3FYEnzWx0iYkIdgKBZYZ6o9+xEKo4Ve7AEO/Wt
         MDFHjXY+9uRZxUvLD+JGznJ5eTJHIiWs0cWaCxjBlVZ2AP1/0e6UdOrvqKoHjLCbk0LZ
         VB2RrZ2ekLodPjAAE9CuEO2vTwVxNqcTW6+h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvHG/8+/b5TFB8/1p9i6sISZ2lSMu9cNl1ktZUjWwqQ=;
        b=Fd0zrulV2izc92soWmQ9abQapyA1G10y6d7gCNe7uTZPMxuOKQz/z5bNiTzBG0HP+7
         gSFGpBcN40QP4wkTcxMfXfEXHSWzqMAH4HAS5RkQKrPmzIztEjmIpcmyNOH0TMy23+OR
         AR+d97T6deob2GwRRyMc+eLC+qQhI4RlRk+wxipQMumGIMqfnNXPuye2QpwrctSIZr/a
         t5N9Yt484H4Jr2d5GN2eFsFWzEQA4KQRuDksk9heqzPHFXldpUCYg1l1cCoJOu1a5KmF
         JVk+iiYVNLrsfD2h7KhGC/pjhcrhroiMpXqoPU5WC2GLiz8wdmDAliabjRJ68IjovIta
         0dgQ==
X-Gm-Message-State: AOUpUlEjcB+qpxZ2vdsVBMYMOIFF6kKcxeZh9FiFmgCL2Q5hmGlnEbVB
        xvltdxH0CZ/78y/TTTZXhF8Hf/OC0cQTAksgMI3smg==
X-Google-Smtp-Source: AA+uWPxAR9G6nL/jGnomyGCNGXDUbfgjKssWpg7oDi7voYeMkGUwZxbjZIwN4dktcOc0kuilNPddViQ+bTHYHGWXpQM=
X-Received: by 2002:a6b:fd04:: with SMTP id c4-v6mr14419486ioi.294.1534169194626;
 Mon, 13 Aug 2018 07:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar> <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin> <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
 <20180813124911.GD2605@e110439-lin>
In-Reply-To: <20180813124911.GD2605@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Aug 2018 16:06:23 +0200
Message-ID: <CAKfTPtDgXdQso94DOwJ4+nyRpJwigEwf7JmNZcgFOg3z6iUWyw@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Steve Muckle" <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 at 14:49, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 13-Aug 14:07, Vincent Guittot wrote:
> > On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > Hi Vincent!
> > >
> > > On 09-Aug 18:03, Vincent Guittot wrote:
> > > > > On 07-Aug 15:26, Juri Lelli wrote:
> > >
> > > [...]
> > >
> > > > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > > > +           util = 0;
> > > > > > > +           if (util_cfs)
> > > > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > > > +           if (util_rt)
> > > > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > > > +   } else {
> > > > > > > +           util  = cpu_util_cfs(rq);
> > > > > > > +           util += cpu_util_rt(rq);
> > > > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > > > +   }
> > > > >
> > > > > Regarding the two policies, do you have any comment?
> > > >
> > > > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > > > make sense as it is ?
> > > > I mean, uclamp_util doesn't make any difference between rt and cfs
> > > > tasks when clamping the utilization so why should be add twice the
> > > > returned value ?
> > > > IMHO, this policy would make sense if there were something like
> > > > uclamp_util_rt() and a uclamp_util_cfs()
> > >
> > > The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> > > low-priority classese, especially when we have high RT utilization.
> > >
> > > Let say we have:
> > >
> > >  util_rt  = 40%, util_min=0%
> > >  util_cfs = 10%, util_min=50%
> > >
> > > the two policies will select:
> > >
> > >   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
> > >  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> > >
> > > Which means that, despite the CPU's util_min will be set to 50% when
> > > CFS is running, these tasks will have almost no boost at all, since
> > > their bandwidth margin is eclipsed by RT tasks.
> >
> > Hmm ... At the opposite, even if there is no running rt task but only
> > some remaining blocked rt utilization,
> > even if util_rt  = 10%, util_min=0%
> > and  util_cfs = 40%, util_min=50%
> > the UCLAMP_SCHED_CLASS: util = uclamp(10) + uclamp(40) = 50 + 50   = 100%
>
> Yes, that's true... since now I clamp util_rt if it's non zero.
> Perhaps this can be fixed by clamping util_rt only:
>   if (rt_rq_is_runnable(&rq->rt))
> ?
>
> > So cfs task can get double boosted by a small rt task.
>
> Well, in principle we don't know if the 50% clamp was asserted by the
> RT or the CFS task, since in the current implementation we max
> aggregate clamp values across all RT and CFS tasks.

Yes it was just the assumption of your example above.
IMHO, having util = 100% for your use case looks more like a bug than a feature

As you said below: "what utilization clamping aims to do is to defined
the minimum capacity to run _all_
the RUNNABLE tasks... not the minimum capacity for _each_ one of them "


>
> > Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
> > the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%
>
> True, but here we are within the same class and what utilization
> clamping aims to do is to defined the minimum capacity to run _all_
> the RUNNABLE tasks... not the minimum capacity for _each_ one of them.

I fully agree and that's exactly what I want to highlight: With
UCLAMP_SCHED_CLASS policy, you try (but fail because the clamping is
not done per class) to distinguish rt and cfs as different kind of
runnable tasks.

>
> > So in this case cfs tasks don't get more boost and have to share the
> > bandwidth and you don't ensure 50% for each unlike what you try to do
> > for rt.
>
> Above I'm not trying to fix a per-task issue. The UCLAMP_SCHED_CLASS
> policy is just "trying" to fix a cross-class issue... if we agree
> there can be a cross-class issue worth to be fixed.

But the cross class issue that you are describing can also exists
between cfs tasks with different uclamp_min
So I'm not sure that's there is more cross-class issue than in class issue

>
> > You create a difference in the behavior depending of the class of the
> > others co-schedule tasks which is not sane IMHO
>
> Yes I agree that the current behavior is not completely clean... still
> the question is: do you reckon the problem I depicted above, i.e. RT
> workloads eclipsing the min_util required by lower priority classes?

As said above, I don't think that there is a problem that is specific
to cross class scheduling that can't also happen in the same class.

Regarding your example:
task TA util=40% with uclamp_min 50%
task TB util=10% with uclamp_min 0%

If TA and TB are cfs, util=50% and it doesn't seem to be a problem
whereas TB will steal some bandwidth to TA and delay it (and i even
don't speak about the impact of the nice priority of TB)
If TA is cfs and TB is rt, Why util=50% is now a problem for TA ?

>
> To a certain extend I see this problem similar to the rt/dl/irq pressure
> in defining cpu_capacity, isn't it?
>
> Maybe we can make use of (cpu_capacity_orig - cpu_capacity) to factor
> in a util_min compensation for CFS tasks?
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
