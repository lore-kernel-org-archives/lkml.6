Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744521EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PiKikA/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6744521EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHIS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:29:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52130 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:29:42 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so966531itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45R2rVVQ7AyLO7hHrHWF/TuxLcpzTR3BLt2OR6mR/cc=;
        b=PiKikA/uVsQo7wLMJKN6X3vPzXEwAYjTVVBGeMiX72PqcakiDaJHbPu1A4GyF/LsP/
         waLHXJzI2NzunhEaRdHlhRTTC8KS5DIA+bMP3CVWnpVfBM8CbCrKookH9w61qLvwdwWv
         fqKQLpnfvBT8tztr7Llr5kpxRFcgH1foW2qlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45R2rVVQ7AyLO7hHrHWF/TuxLcpzTR3BLt2OR6mR/cc=;
        b=te+j+HTVHJNg547J4+BUY3XSuQvA9L2Y9JnUHHJdIWvS8irqdIroRb7upV9GIY+dW5
         V3GUQFLfHGSl5OCp5rKF1bgn2NZv7jm7+5vOi+tG4LPVuWt3gHwH9q7GJgh6TxgORQqR
         KjhNFe2tWS04yR9SpzSPU1vTuX70dIXcBJ7rAgrAb2Iybwe0HoZtmv9k8w4btYQDfvev
         /0I3P+v88CHqvHdewsqWhE2+oJ19ryK87SQGM1yKM80Khv0JZJyQkPN5v9ATJbzVe5vx
         JEOj3YKdDVT5P3ZaFMYVsCvckzV2CMvCFLEHKQRR10JprULYU3xiz0p/Mhw5Qa3LY3aG
         N50w==
X-Gm-Message-State: AOUpUlHrso4Zxm28+mfsPbJUpXtoL27bTRWhEjsBGMx3PXpkAhbC26DX
        00xtLMLRDLOdncexoR6gZseIbu2Qzz6M/k15qIwBvxdEd34=
X-Google-Smtp-Source: AA+uWPy0nXy7ynTF0mLaCo5qjB05LdgE84hHilCzAS6m+YEy/qB5BQbQFD2Kbgiy97+1V/DNnfxGrJlQVe2XZqz18HQ=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr2374747itb.8.1533830648447;
 Thu, 09 Aug 2018 09:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com> <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
In-Reply-To: <20180809153423.nsoepprhut3dv4u2@darkstar>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Aug 2018 18:03:57 +0200
Message-ID: <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
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
        "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Thu, 9 Aug 2018 at 17:34, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 07-Aug 15:26, Juri Lelli wrote:
> > Hi,
> >
> > On 06/08/18 17:39, Patrick Bellasi wrote:
> >
> > [...]
> >
> > > @@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > >      * utilization (PELT windows are synchronized) we can directly add them
> > >      * to obtain the CPU's actual utilization.
> > >      *
> > > -    * CFS utilization can be boosted or capped, depending on utilization
> > > -    * clamp constraints configured for currently RUNNABLE tasks.
> > > +    * CFS and RT utilizations can be boosted or capped, depending on
> > > +    * utilization constraints enforce by currently RUNNABLE tasks.
> > > +    * They are individually clamped to ensure fairness across classes,
> > > +    * meaning that CFS always gets (if possible) the (minimum) required
> > > +    * bandwidth on top of that required by higher priority classes.
> >
> > Is this a stale comment written before UCLAMP_SCHED_CLASS was
> > introduced? It seems to apply to the below if branch only.
>
> Yes, you right... I'll update the comment.
>
> > >      */
> > > -   util = cpu_util_cfs(rq);
> > > -   if (util)
> > > -           util = uclamp_util(cpu_of(rq), util);
> > > -   util += cpu_util_rt(rq);
> > > +   util_cfs = cpu_util_cfs(rq);
> > > +   util_rt  = cpu_util_rt(rq);
> > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > +           util = 0;
> > > +           if (util_cfs)
> > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > +           if (util_rt)
> > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > +   } else {
> > > +           util  = cpu_util_cfs(rq);
> > > +           util += cpu_util_rt(rq);
> > > +           util  = uclamp_util(cpu_of(rq), util);
> > > +   }
>
> Regarding the two policies, do you have any comment?

Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
make sense as it is ?
I mean, uclamp_util doesn't make any difference between rt and cfs
tasks when clamping the utilization so why should be add twice the
returned value ?
IMHO, this policy would make sense if there were something like
uclamp_util_rt() and a uclamp_util_cfs()

>
> We had an internal discussion and we found pro/cons for both... but
> I'm not sure keeping the sched_feat is a good solution on the long
> run, i.e. mainline merge ;)
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
