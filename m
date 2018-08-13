Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B43C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D05217B8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AL1K8Xgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D05217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeHMOtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:49:20 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37692 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbeHMOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:49:19 -0400
Received: by mail-it0-f49.google.com with SMTP id h20-v6so13586167itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqN48GJ2CsHyNom/Ak2EBVQTVxfD0KIPkoIw2Bn+Ymk=;
        b=AL1K8XggGbEO8eP5E5eLD4PISbeYE3dlMI2uoY+mlBwViSo3t+j7Khfcip4l3P9LWd
         uTEpUdFUrMzruov6KWISo5Bhc1xR34IScDqFrYmPmxNZPtqCPM7zlxdR0VlWIU0JO8R7
         Eodj0jQ+rhaZpFcWRzR1KK25ldUER3SLugW+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqN48GJ2CsHyNom/Ak2EBVQTVxfD0KIPkoIw2Bn+Ymk=;
        b=n8jDA7QXWJEdah5AsSc/4YCe3OzErSUouB737ZD5JEwtyQ5cSCalSlbOlHPFW2Ox2w
         SGm+7vSjCGrEGSnqdTOPwzxKbqUBmqMLqr1Rcm9lp6CZHHKPZ5ATbacKz97rW8m8zswU
         I+UeNDOEXOldR3Zoa2QfqQf8FMjmAx3cebEPvUVDt+dfxJsn6k/jEfU1RGeRZ8Zhdaka
         L6QGsBl23fAmzI1/B+wdoHF7ZhVmTdLL1C6D3QvCJGY0XCA9vBaiZGTHcUkdbXk+ps6h
         9QZVKKywn/rPViNjAkbPi7Z/l4MX6SC7kFa9XZd5FsYsfldCQ1IjCss0mmDncKuuXbly
         hV6A==
X-Gm-Message-State: AOUpUlETzCDRyvtDlE2cK/OqfcTIbqpd1A4O1DGQAR40wT83F6P0ZqXZ
        0CAUR0QXOH0CIk7byJL3DvYp+HS5eiXZWlafbX1TUg==
X-Google-Smtp-Source: AA+uWPyMFLRopNDB5sAPgB9gB1SeZUGOb6MDP4Wx/dpXPo5m0WfGt9JtLrmD0W/Kf8ZhtJzgtQJFsHHMVnZpsZUOuAs=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr10135563itb.8.1534162038824;
 Mon, 13 Aug 2018 05:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar> <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
In-Reply-To: <20180813101221.GA2605@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Aug 2018 14:07:07 +0200
Message-ID: <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
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

On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> Hi Vincent!
>
> On 09-Aug 18:03, Vincent Guittot wrote:
> > > On 07-Aug 15:26, Juri Lelli wrote:
>
> [...]
>
> > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > +           util = 0;
> > > > > +           if (util_cfs)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > +           if (util_rt)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > +   } else {
> > > > > +           util  = cpu_util_cfs(rq);
> > > > > +           util += cpu_util_rt(rq);
> > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > +   }
> > >
> > > Regarding the two policies, do you have any comment?
> >
> > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > make sense as it is ?
> > I mean, uclamp_util doesn't make any difference between rt and cfs
> > tasks when clamping the utilization so why should be add twice the
> > returned value ?
> > IMHO, this policy would make sense if there were something like
> > uclamp_util_rt() and a uclamp_util_cfs()
>
> The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> low-priority classese, especially when we have high RT utilization.
>
> Let say we have:
>
>  util_rt  = 40%, util_min=0%
>  util_cfs = 10%, util_min=50%
>
> the two policies will select:
>
>   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
>  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
>
> Which means that, despite the CPU's util_min will be set to 50% when
> CFS is running, these tasks will have almost no boost at all, since
> their bandwidth margin is eclipsed by RT tasks.

Hmm ... At the opposite, even if there is no running rt task but only
some remaining blocked rt utilization,
even if util_rt  = 10%, util_min=0%
and  util_cfs = 40%, util_min=50%
the UCLAMP_SCHED_CLASS: util = uclamp(10) + uclamp(40) = 50 + 50   = 100%

So cfs task can get double boosted by a small rt task.

Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%

So in this case cfs tasks don't get more boost and have to share the
bandwidth and you don't ensure 50% for each unlike what you try to do
for rt.
You create a difference in the behavior depending of the class of the
others co-schedule tasks which is not sane IMHO


>
> > > We had an internal discussion and we found pro/cons for both... but
>
> The UCLAMP_SCHED_CLASS policy is thus less energy efficiency but it
> should grant a better "isolation" in terms of what is the expected
> speed-up a task will get at run-time, independently from higher
> priority classes.
>
> Does that make sense?
>
> > > I'm not sure keeping the sched_feat is a good solution on the long
> > > run, i.e. mainline merge ;)
>
> This problem still stands...
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
