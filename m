Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B7B23EBE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvDsP/AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B7B23EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeFVIKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:10:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35137 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeFVIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:43 -0400
Received: by mail-it0-f66.google.com with SMTP id a3-v6so1797905itd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrQHcXtEvYQPuJQSnafN4aimANbnt9CSk2ZfZLFsfL8=;
        b=JvDsP/AWSMIfE0s5/GJiYeBWLaGyfqc946sLFloYUTaoVV4GCxIY1aDMkmC7TiWbpT
         BEjbTVauH/s0s+wjhYq1qNMd2nTCE+N2GDjqjHS1U+yj3z+md1Rv51N4nE8RHkoiQAwy
         jiXJQIU/xK7W+9iPcn9BJwUSx6ruW4YA/b/NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrQHcXtEvYQPuJQSnafN4aimANbnt9CSk2ZfZLFsfL8=;
        b=PQEChCZMRbemyDiL9sf8jL0hTCJC4u2/p0tOrinSSMOedD65BlZjQ5PX2KLEUcTZLl
         gbyhoSL0+BeNidpIkLoimKr39wXeBzrlgWoKDORCUEYz8I/4s+b4YjTRz758JsIH/hA1
         lBYb0p1TD18RjF6y5ZT8rBTTH4x/TouWwGt9aF2us3czye36u8SPCrQqnXLbwrKmK/uG
         yndq3709xVaNU0fZbYa00dC9gHkTv6fs321fQXscxFM4UzOMJHEbXTjVUnxgyWeRvGdX
         cJ16kwnbkPddDbMPAS0NYBzHNJUoDPNBd+U7nM8YNeK/CH5nf055edUep+/3jeU7J2aZ
         D/HA==
X-Gm-Message-State: APt69E1rJg1eP6fZBGBFzAESv6yqKTTvGxb0rl+6J/06sahCKw3WKaXf
        0990kqhprsejsR7EunymBiB80Lr3ur/oBdNRmojBIw==
X-Google-Smtp-Source: ADUXVKL9UT5KvR/2YwP9XhJB0kSrnk8pqYgJoBS1ZNXm7gjqNFHXDXATG2azhPjGlS1xxPXKVMlgucM17qnkJTCo7OI=
X-Received: by 2002:a24:9401:: with SMTP id j1-v6mr677318ite.89.1529655043077;
 Fri, 22 Jun 2018 01:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180621185706.GA4900@worktop.programming.kicks-ass.net>
In-Reply-To: <20180621185706.GA4900@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 10:10:32 +0200
Message-ID: <CAKfTPtA=iWQc3RB2dgJf2LT2e0XezLzGKbQNx=w1xYEPFDEsQQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 at 20:57, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 21, 2018 at 08:45:24PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 08, 2018 at 02:09:47PM +0200, Vincent Guittot wrote:
> > >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> > >  {
> > >     struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > +   unsigned long util;
> > >
> > >     if (rq->rt.rt_nr_running)
> > >             return sg_cpu->max;
> > >
> > > +   util = sg_cpu->util_dl;
> > > +   util += sg_cpu->util_cfs;
> > > +   util += sg_cpu->util_rt;
> > > +
> > >     /*
> > >      * Utilization required by DEADLINE must always be granted while, for
> > >      * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> > > @@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> > >      * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> > >      * ready for such an interface. So, we only do the latter for now.
> > >      */
> > > -   return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > > +   return min(sg_cpu->max, util);
> > >  }
> >
> > So this (and the dl etc. equivalents) result in exactly the problems
> > complained about last time, no?
> >
> > What I proposed was something along the lines of:
> >
> >       util = 1024 * sg_cpu->util_cfs;
> >       util /= (1024 - (sg_cpu->util_rt + sg_cpu->util_dl + ...));
> >
> >       return min(sg_cpu->max, util + sg_cpu->bw_dl);

I see that you use sg_cpu->util_dl and sg_cpu->bw_dl in your equation
above but this patch 04 only adds rt util_avg and the dl util_avg has
not been added yet.
 dl util_avg is added in patch 6
So for this patch, we are only using sg_cpu->bw_dl

> >
> > Where we, instead of directly adding the various util signals.
>
> That looks unfinished; I think that wants to include: "we renormalize
> the CFS signal".
>
> > I now see an email from Quentin asking if these things are not in fact
> > the same, but no, they are not. The difference is that the above only
> > affects the CFS signal and will re-normalize the utilization of an
> > 'always' running task back to 1 by compensating for the stolen capacity.
> >
> > But it will not, like these here patches, affect the OPP selection of
> > other classes. If there is no CFS utilization (or very little), then the
> > renormalization will not matter, and the existing DL bandwidth
> > compuation will be unaffected.
> >
