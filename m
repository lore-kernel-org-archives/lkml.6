Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C25C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC4F2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCntU7Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC4F2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeHMOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:51:18 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39595 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeHMOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:51:18 -0400
Received: by mail-it0-f52.google.com with SMTP id g141-v6so13595393ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vExfePqjGig734gpYzOV0lcWRT0ynTcCTK02eQujStY=;
        b=bCntU7QtgScK8xtjPhUBgfe6tzmCiWkf7mO1TNDVbarQ8PVHA2holbgLEgMRlhj7Bn
         vwlwkYfUKmBdM1zZvoaZRBtgcJjS6svPKxIGhZkxsQ1sRPlBrwx4jJ/f99vnmm2JPEkn
         zypc4Xqpgq297NPel0XYqEhwddTtz+WyxK754=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vExfePqjGig734gpYzOV0lcWRT0ynTcCTK02eQujStY=;
        b=qsn9WCm+bDL+YmByfcaE9d19KOSSyrNPhGYCq81ZcmBukMp/AyJfsMfP1WvfhlKl5M
         fV0HgMOfBM5BbIPBZUtBu3M7kyFsmdEXqGhxJhdeIyFeMzfZ0kXEOLdezqJftxi8/Oes
         0vbrVdHPtnpxHvSVDYHwYZ0S0MSoLhoFb600+ivbHdY7e/9ECYvyvEsDOYHh2uZNHl+5
         fC4+HHPVbIIoNKJb+2lw0c7mhkL1W4WGjzt9wouD3zDa7+fYWx6cpyP/VnbW/J6z2ROd
         xD2CFFST0M876Ts93d7ksmZPE8oJnFMZ68QIZsAiRcHnhZfkUX/PR15ToJtIvK2tyzMF
         W/DQ==
X-Gm-Message-State: AOUpUlHg/go/NIrrgrQAGjNHf66N0l/bQzIUO+psaUCx35LloOjrsOnK
        UeISvCmERyFwWE/osSjaxAh2wMRR9sN/CiKbm2aHMQ==
X-Google-Smtp-Source: AA+uWPxNi3GCDXT7bUaXZbqdnGsUnVyiN1UOF1oqBDu5C50zm3W7gHI3/AAmVC3hmPTaM5OUHWoUeda/pCnc+uQPJD8=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr10141705itb.8.1534162157090;
 Mon, 13 Aug 2018 05:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar> <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin> <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
In-Reply-To: <CAKfTPtBN+K=8fqukZix2k0rdcjG8YiYagxZtzLx7kk3US+9V2Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Aug 2018 14:09:06 +0200
Message-ID: <CAKfTPtCReRSGY_O8c+gpVbYJ_OgUFXsO=Ua1V_QaW41+4PWw8A@mail.gmail.com>
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

On Mon, 13 Aug 2018 at 14:07, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 13 Aug 2018 at 12:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > Hi Vincent!
> >
> > On 09-Aug 18:03, Vincent Guittot wrote:
> > > > On 07-Aug 15:26, Juri Lelli wrote:
> >
> > [...]
> >
> > > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > > +           util = 0;
> > > > > > +           if (util_cfs)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > > +           if (util_rt)
> > > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > > +   } else {
> > > > > > +           util  = cpu_util_cfs(rq);
> > > > > > +           util += cpu_util_rt(rq);
> > > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > > +   }
> > > >
> > > > Regarding the two policies, do you have any comment?
> > >
> > > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > > make sense as it is ?
> > > I mean, uclamp_util doesn't make any difference between rt and cfs
> > > tasks when clamping the utilization so why should be add twice the
> > > returned value ?
> > > IMHO, this policy would make sense if there were something like
> > > uclamp_util_rt() and a uclamp_util_cfs()
> >
> > The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> > low-priority classese, especially when we have high RT utilization.
> >
> > Let say we have:
> >
> >  util_rt  = 40%, util_min=0%
> >  util_cfs = 10%, util_min=50%
> >
> > the two policies will select:
> >
> >   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
> >  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> >
> > Which means that, despite the CPU's util_min will be set to 50% when
> > CFS is running, these tasks will have almost no boost at all, since
> > their bandwidth margin is eclipsed by RT tasks.
>
> Hmm ... At the opposite, even if there is no running rt task but only
> some remaining blocked rt utilization,
> even if util_rt  = 10%, util_min=0%
> and  util_cfs = 40%, util_min=50%
> the UCLAMP_SCHED_CLASS: util = uclamp(10) + uclamp(40) = 50 + 50   = 100%
>
> So cfs task can get double boosted by a small rt task.
>
> Furthermore, if there is no rt task but 2 cfs tasks of 40% and 10%
> the UCLAMP_SCHED_CLASS: util = uclamp(0) + uclamp(40) = 50   = 50%

s/uclamp(40)/uclamp(50)/

>
> So in this case cfs tasks don't get more boost and have to share the
> bandwidth and you don't ensure 50% for each unlike what you try to do
> for rt.
> You create a difference in the behavior depending of the class of the
> others co-schedule tasks which is not sane IMHO
>
>
> >
> > > > We had an internal discussion and we found pro/cons for both... but
> >
> > The UCLAMP_SCHED_CLASS policy is thus less energy efficiency but it
> > should grant a better "isolation" in terms of what is the expected
> > speed-up a task will get at run-time, independently from higher
> > priority classes.
> >
> > Does that make sense?
> >
> > > > I'm not sure keeping the sched_feat is a good solution on the long
> > > > run, i.e. mainline merge ;)
> >
> > This problem still stands...
> >
> > --
> > #include <best/regards.h>
> >
> > Patrick Bellasi
