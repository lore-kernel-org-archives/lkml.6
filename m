Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAAFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA342086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAxKraJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA342086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeIZQp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:45:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32946 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeIZQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:45:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19-v6so10201592ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvBLnk1FSUo0Z0fGGtDnFOOoKd91cv3aAnsFX7/weu0=;
        b=ZAxKraJJmiwUSQ6R6ajloLf2XEuPxeWgPCiMuTDrbKujHa7GV5/yzfgw8RLbtvHA8N
         UtYVVa5fjBhZriJXfM9eI81xb9vStHeBypOonTlGo7JgxsoiT3RYWPc7K0McqP1Cw0xn
         X0zb8o7MoT5B8g8RxNo9FaO5UIzHPemij5FFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvBLnk1FSUo0Z0fGGtDnFOOoKd91cv3aAnsFX7/weu0=;
        b=sNuY/fapg28/Duk888JJSztfhH8vQ7nsnbzn/GKKv74datKluIOJWsWQduKpObVa3l
         LNPPMjj5QJ/iXmJ440sGChlikTRKZdBooKjlKwc/bPMAhusMlkncIbnM9MW2sSNN3lRj
         vUFrkD++cIrb/v7NjjvD0SBuHT8cXKFMrJsJrjtq1dwus3MSQNYNH0xGLHbRPWq+W09v
         KETpeiiN7eSt9X/rql06tWQm6MLfiZOUh/UkPpVW2MJU0ZxnIpcwa+qhoCUUI69VNy4W
         Zc/JCRcLeqSnPJ7wkq6iKb7zXXHVZj70MpLHbfhmJ2meARVjsSLkfaBeYKZIMqoJWkyU
         uOvg==
X-Gm-Message-State: ABuFfojfq/RKZ/ELITln2fj/5NcT/7XzFM/S53VTAjs5DZ8RbtzgOYqn
        7Qn09TpTCvqxNq+uMGEH4HZtkfYaFvGeEJrAjYxrbijqI4E=
X-Google-Smtp-Source: ACcGV62MtgVPWcOnh7oL6OMZqYgdzEywVjv+xVtn8kfkEoDBbsgsiKlhV8+QU3TsWFT3ZHBVARUamDNq/KE7Tg02hI4=
X-Received: by 2002:a2e:2025:: with SMTP id g37-v6mr4161323ljg.40.1537958017402;
 Wed, 26 Sep 2018 03:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com> <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com>
In-Reply-To: <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Sep 2018 12:33:25 +0200
Message-ID: <CAKfTPtAUUcwPThggDMfQ1k7z4kguTwrLVEFKnkMqszs9nTri=g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 11:35, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi,
>
> On 26/09/18 09:13, Vincent Guittot wrote:
> > On Tue, 25 Sep 2018 at 19:38, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> When load_balance() fails to move some load because of task affinity,
> >> we end up increasing sd->balance_interval to delay the next periodic
> >> balance in the hopes that next time we look, that annoying pinned
> >> task(s) will be gone.
> >
> > It's not about hope but to minimize useless periodic load balance as
> > there is no possibility to balance anything
> >
> >>
> >> However, idle_balance() pays no attention to sd->balance_interval, yet
> >> it will still lead to an increase in balance_interval in case of
> >> pinned tasks.
> >
> > I would say that this makes sense as there is no way to pull the
> > pinned task on this rq so running periodic load balance (busy or idle)
> > is a waste of time  and resources
> >
>
> Increasing the delay for the next periodic balance when there's pinned tasks
> makes sense. The issue I have here is that the balance_interval can potentially
> be doubled at every failed idle_balance() without waiting for a sufficient
> amount of time.
>
> When going through periodic balance, load_balance() is gated by:
>
>     time_after_eq(jiffies, sd->last_balance + interval)
>
> So if we previously ran load_balance() and failed to pull anything because
> of task affinity, we'll wait for at least the new interval before attempting
> another load_balance().
>
> On the other hand, idle_balance() will call load_balance() regardless of
> balance_interval values. So if the task composition allows it, we can repeatedly
> fail to load_balance() and thus double balance_interval at every idle_balance()
> "tick". So you can go from 8ms to 512ms in a few successive idle_balance()s,
> whereas periodic balance would have to wait for at least the sum of all
> intermediate balance_intervals leading to 512 (8, 16, 32, etc).
>
> >>
> >> If we're going through several newidle balances (e.g. we have a
> >> periodic task), this can lead to a huge increase of the
> >
> > This only happen when overload is set which means that there are tasks
> > on another CPU but this one can't pull one of them.
> >
> > Can you give us details about the use case that you care about ?
> >
>
> It's the same as I presented last week - devlib (some python target communication

ok. you mean at linaro connect

> library I use) has some phase where it spawns at lot of tasks at once to do
> some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
> particular CPU, and that can lead to failed load_balance() - and to make things
> worse, there's a lot of idle_balance() in there.
>
> Eventually when I start running my actual workload a few ~100ms later, it's
> impacted by that balance_interval increase.
>
> Admittedly that's a specific use-case, but I don't think this quick increase
> is something that was intended.

Yes, this really sounds like a specific use-case. Unluckily you find a
way to reach max interval quite easily/every time with your test
set-up but keep in mind that this can also happen in real system life
and without using the newly idle path.
So if it's a problem to have a interval at max value for your unitary
test, it probably means that it's a problem for the system and the max
value is too high

Taking advantage of all load_balance event to update the interval
makes sense to me. It seems that you care about a short and regular
balance interval more that minimizing overhead of load balancing.
At the opposite, i'm sure that you don't complain if newly idle load
balance resets the interval to min value and overwrite what the
periodic load balance set up previously :-)

>
> > Also, If the interval reaches a value that becomes a problem for you
> > why don't you reduce the max_interval with sysfs ? This max interval
> > can be reach in several other occasions
> >
>
> True, although I saw that as an unwanted behaviour rather than a tuning problem.
>
> >> balance_interval in a very small amount of time.
> >>
> >> To prevent that, don't increase the balance interval when going
> >> through a newidle balance.
> >>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 19 ++++++++++++++-----
> >>  1 file changed, 14 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 6bd142d..620910d 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8782,13 +8782,22 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >>         sd->nr_balance_failed = 0;
> >>
> >>  out_one_pinned:
> >> +       ld_moved = 0;
> >> +
> >> +       /*
> >> +        * idle_balance() disregards balance intervals, so we could repeatedly
> >> +        * reach this code, which would lead to balance_interval skyrocketting
> >> +        * in a short amount of time. Skip the balance_interval increase logic
> >> +        * to avoid that.
> >> +        */
> >> +       if (env.idle == CPU_NEWLY_IDLE)
> >> +               goto out;
> >> +
> >>         /* tune up the balancing interval */
> >> -       if (((env.flags & LBF_ALL_PINNED) &&
> >> -                       sd->balance_interval < MAX_PINNED_INTERVAL) ||
> >> -                       (sd->balance_interval < sd->max_interval))
> >> +       if ((env.flags & LBF_ALL_PINNED &&
> >> +            sd->balance_interval < MAX_PINNED_INTERVAL) ||
> >> +           (sd->balance_interval < sd->max_interval))
> >
> > This looks like a code cleanup that is not related to the subject
> >
>
> Absolutely, I figured I could get away with it but if that's preferred I can
> split that more clearly

That's easier to make separate review.

>
> >>                 sd->balance_interval *= 2;
> >> -
> >> -       ld_moved = 0;
> >>  out:
> >>         return ld_moved;
> >>  }
> >> --
> >> 2.7.4
> >>
