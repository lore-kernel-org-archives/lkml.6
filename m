Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4363DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4302430D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkzKGKcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4302430D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeFVNyi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:54:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43380 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFVNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:54:36 -0400
Received: by mail-io0-f196.google.com with SMTP id i23-v6so3272846iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjWYbKBEEie8WejQstcAqMkg76yH1CRmCR9HUCaw8ew=;
        b=LkzKGKcxI6IlnXqc8ofvq+lr8b6IKheNeoDEwJeUr3jlu7c6kJeBJR6je3HswMyRYv
         oflVu7xJHXgGEOLv1EDWj3GxxihuRAlDx1WWl1NMANg8nqFgiOuabbwZb8aVlnz/8g29
         3o8vgmJzY080t34u7cTR5RjG1VtQePgovw6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjWYbKBEEie8WejQstcAqMkg76yH1CRmCR9HUCaw8ew=;
        b=RzKiyVlhKmSQnWZC9fBr48C6orzqMni6nSHFb7MdgDTpWjtV2s/q3gBRJBWd7dzRs/
         Nj2nEGpA5DTTmXUEc+VU5dGYnCKFGXAZ/vajbZHGBf8Vwv18ZC04gJ57XndDKn2yAOcp
         KgbcuSFmcn0OiPufuBj21L5CcJL9yosw7hCJfkp5U1bzllG9jFQvT3JObZlP2FKTsHKg
         qrTsaxFKT/eym8x+NvnHJYAC7U3ALN88MAfEe/sB12nagVnupQCSOQJECGIbxLUZ5AqS
         tO8mDp6SuNWUixBsOEWHEKL6dtuOigWSvkNk3rQysIlTNa5n9clC8lwIE0no9pNvZsLy
         gqVQ==
X-Gm-Message-State: APt69E3iTJIbTJ2ijfd5WjUb4k2hnsK78MGecJzRW7WZ0QkRE+RqWvx5
        qsExbgethqqrFUcXKab2JQxsg1vbdHjWTl9T0Pn7lA==
X-Google-Smtp-Source: AAOMgpd6C93gy6jRQa7jRTJODdosit0yZjHY3nLXKOKRcFK6V9W1mSO1XCOhx/UR4dKBC/A+xNcU5GrfLsJuQQM7E7U=
X-Received: by 2002:a6b:2cd:: with SMTP id 196-v6mr1340033ioc.294.1529675676149;
 Fri, 22 Jun 2018 06:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net> <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622132624.GL2494@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 15:54:24 +0200
Message-ID: <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 22, 2018 at 02:23:22PM +0200, Vincent Guittot wrote:
> > On Fri, 22 Jun 2018 at 13:37, Peter Zijlstra <peterz@infradead.org> wrote:
> > > I suppose we can make it more complicated, something like:
> > >
> > >              u           u
> > >   f := u + (--- - u) * (---)^n
> > >             1-r         1-r
> > >
> > > Where: u := cfs util
> > >        r := \Sum !cfs util
> > >        f := frequency request
> > >
> > > That would still satisfy all criteria I think:
> > >
> > >   r = 0      -> f := u
> > >   u = (1-r)  -> f := 1
> > >
> > > and in particular:
> > >
> > >   u << (1-r) -> f ~= u
> > >
> > > which casuses less inflation than the linear thing where there is idle
> > > time.
>
> > And we are not yet at the right value for quentin's example as we need
> > something around 0.75 for is example
>
> $ bc -l
> define f (u,r,n) { return u + ((u/(1-r)) - u) * (u/(1-r))^n; }
> f(.2,.7,0)
> .66666666666666666666
> f(.2,.7,2)
> .40740740740740740739
> f(.2,.7,4)
> .29218106995884773661
>
> So at 10% idle time, we've only inflated what should be 20% to 40%, that
> is entirely reasonable I think. The linear case gave us 66%.  But feel
> free to increase @n if you feel that helps, 4 is only one mult more than
> 2 and gets us down to 29%.

I'm a bit lost with your example.
u = 0.2 (for cfs) and r=0.7 (let say for rt) in your example and idle is 0.1

For rt task, we run 0.7 of the time at f=1 then we will select f=0.4
for run cfs task with u=0.2 but u is the utilization at f=1 which
means that it will take 250% of normal time to execute at f=0.4 which
means 0.5  time instead of 0.2 at f=1 so we are going out of time. In
order to have enough time to run r and u we must run at least  f=0.666
for cfs = 0.2/(1-0.7). If rt task doesn't run at f=1 we would have to
run at f=0.9

>
> > The non linearity only comes from dl so if we want to use the equation
> > above, u should be (cfs + rt) and r = dl
>
> Right until we allow RT to run at anything other than f=1. Once we allow
> rt util capping, either through Patrick's thing or CBS servers or
> whatever, we get:
>
>   f = min(1, f_rt + f_dl + f_cfs)
>
> And then u_rt does want to be part of r. And while we do run RT at f=1,
> it doesn't matter either way around I think.
>
> > But this also means that we will start to inflate the utilization to
> > get higher OPP even if there is idle time and lost the interest of
> > using dl bw
>
> You get _some_ inflation, but only if there is actual cfs utilization to
> begin with.
>
> And that is my objection to that straight sum thing; there the dl util
> distorts the computed dl bandwidth thing even if there is no cfs
> utilization.

hmm,


>
