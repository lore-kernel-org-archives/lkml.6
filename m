Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119F62431B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIkP96L1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119F62431B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeFVN5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:57:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54429 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFVN5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:57:36 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so2940121itx.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQzPWUgHSDzFwajND+EI9yiao63axvtl7FBjsV477Ro=;
        b=eIkP96L1z9D7wkJEx4ZqWFWJ9gJLsQPyMtCeDBs6S9N1n/7r4dh9skT0xHDvJkvdEu
         CAk45USaPBMbSP60HkHj+GNiZuegKG84zCjoEkUSYoeeWQVQAhYzlfk5H0WqakOaug95
         3dtSUvprAhWH5TK3vJNBjWa4f2ZbK28aNR9gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQzPWUgHSDzFwajND+EI9yiao63axvtl7FBjsV477Ro=;
        b=BFM4yaVZg4wTJckqdnS/1EZ86MV6mte5MdGdE9HCGbj75ognExOwvASvY74Muu/Nl7
         vHSrx90UIwHQ5uDKX0HRRBf8pHhLaWpfoEEaZfQmmFijJXLc6pCJXLJ4H/Ig2VFWo6Tb
         ZTXTm0FehLJAqs4h0krrW/ykW4OypF/u9bmfJgdLccCbtm+d84uh7cgeYKRAvfmNsLVi
         KMrSvTrsPHuspFzT86E2T/3YCDLi/OgQU3Jgrn6E2i/yOI2JLkjYllMPgfYz0nkquQEw
         gge0TpKRxvcD8pegVP4ANP4thOb6AYU7yjRJaohUIElYpiKtzk0rEN9n5ke6evvTAbFp
         S/BQ==
X-Gm-Message-State: APt69E1eOt3ejooFY7zSVykuC7Flw+F8HHnqOBYSVvGFs+Pcn0NlvYn8
        fA08vO5Js43H56E8XY2AbJth13UkVF7EHLjRZeTL1g==
X-Google-Smtp-Source: ADUXVKIVeD1FAbZujG44mknGY+xltKGI7h+EOE3YlTsq0Ld8hI872uyIuI0aqfwsE+wYHt8bM7FEQpTe3SuL4JbUAKM=
X-Received: by 2002:a24:1ad7:: with SMTP id 206-v6mr1595529iti.148.1529675855937;
 Fri, 22 Jun 2018 06:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net> <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net> <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 15:57:24 +0200
Message-ID: <CAKfTPtC-4HyMZ82oDdVamN3FVtP4VgShPO6JSei3GZHWv8EqNQ@mail.gmail.com>
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

On Fri, 22 Jun 2018 at 15:54, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jun 22, 2018 at 02:23:22PM +0200, Vincent Guittot wrote:
> > > On Fri, 22 Jun 2018 at 13:37, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > I suppose we can make it more complicated, something like:
> > > >
> > > >              u           u
> > > >   f := u + (--- - u) * (---)^n
> > > >             1-r         1-r
> > > >
> > > > Where: u := cfs util
> > > >        r := \Sum !cfs util
> > > >        f := frequency request
> > > >
> > > > That would still satisfy all criteria I think:
> > > >
> > > >   r = 0      -> f := u
> > > >   u = (1-r)  -> f := 1
> > > >
> > > > and in particular:
> > > >
> > > >   u << (1-r) -> f ~= u
> > > >
> > > > which casuses less inflation than the linear thing where there is idle
> > > > time.
> >
> > > And we are not yet at the right value for quentin's example as we need
> > > something around 0.75 for is example
> >
> > $ bc -l
> > define f (u,r,n) { return u + ((u/(1-r)) - u) * (u/(1-r))^n; }
> > f(.2,.7,0)
> > .66666666666666666666
> > f(.2,.7,2)
> > .40740740740740740739
> > f(.2,.7,4)
> > .29218106995884773661
> >
> > So at 10% idle time, we've only inflated what should be 20% to 40%, that
> > is entirely reasonable I think. The linear case gave us 66%.  But feel
> > free to increase @n if you feel that helps, 4 is only one mult more than
> > 2 and gets us down to 29%.
>
> I'm a bit lost with your example.
> u = 0.2 (for cfs) and r=0.7 (let say for rt) in your example and idle is 0.1
>
> For rt task, we run 0.7 of the time at f=1 then we will select f=0.4
> for run cfs task with u=0.2 but u is the utilization at f=1 which
> means that it will take 250% of normal time to execute at f=0.4 which
> means 0.5  time instead of 0.2 at f=1 so we are going out of time. In
> order to have enough time to run r and u we must run at least  f=0.666
> for cfs = 0.2/(1-0.7). If rt task doesn't run at f=1 we would have to
> run at f=0.9
>
> >
> > > The non linearity only comes from dl so if we want to use the equation
> > > above, u should be (cfs + rt) and r = dl
> >
> > Right until we allow RT to run at anything other than f=1. Once we allow
> > rt util capping, either through Patrick's thing or CBS servers or
> > whatever, we get:
> >
> >   f = min(1, f_rt + f_dl + f_cfs)
> >
> > And then u_rt does want to be part of r. And while we do run RT at f=1,
> > it doesn't matter either way around I think.
> >
> > > But this also means that we will start to inflate the utilization to
> > > get higher OPP even if there is idle time and lost the interest of
> > > using dl bw
> >
> > You get _some_ inflation, but only if there is actual cfs utilization to
> > begin with.
> >
> > And that is my objection to that straight sum thing; there the dl util
> > distorts the computed dl bandwidth thing even if there is no cfs
> > utilization.
>
> hmm,

forgot to finish this sentence

hmm, dl util_avg is only used to detect is there is idle time so if
cfs util is nul we will not distort the  dl bw (for a use case where
there is no rt task running)

>
>
> >
