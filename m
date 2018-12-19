Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF301C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDFA204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYq24Vyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeLSI1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:27:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36784 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeLSI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:27:41 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so8209767itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGexKK3rzWxBDCSkEvGTZvYWI7ExBJFRVLmz4HZouHM=;
        b=BYq24Vyb7otSalWzPi+hgbb5nQKT+S9TfIDlMJy5ey6qw+4+2wHrCxf1LhNxVC8gs5
         KFpFVxF8rvtx2EAEZq/A9wFXs7Q03HsTTNW/Kqa1ZY9s12oX6b1/RlRY8g3FC4aDjy9j
         LBq97skkGeIyM+8xAqPzJtVKp8ZQlLfRr+rio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGexKK3rzWxBDCSkEvGTZvYWI7ExBJFRVLmz4HZouHM=;
        b=JS67fDdpTTTV4eDSVzXQM+k5KnL2NayjFtu55N+VQ6qP/Kt6PcuDOoB6jedKPMX0nP
         4p4fin2fZ4eRjkxFXT+a0u97W+rGQETv8RoGrAd7U+zyo3aS2F49W6O3/35Niu8JxF+o
         mqLJodfC4XtTOYKb5sMnVpHjQV3m7Pti4xzk/6M7z0AbtMZ98KfcIuoWlzZXJV29dRvo
         Mh7VNMrUCp3vQe8rVtmhAeobc6W0nDKW3sSbA8DZZ2Q32gGYAOnohqD4GzsPjolJgUUO
         qOs402KGrnntWsY/n7z5AWXW/02NX1Jx/gSVsGW4wUkyFHDsmvlkEVyzQhwiaLG7usdW
         9WEg==
X-Gm-Message-State: AA+aEWZ4OoFTU1X80oFS5kSmrG182mHRF1ECqkdGMblKm0rwLER58OYd
        +C8SJuOeZny9Ctcrec8mNyqzKB+5TcOZOHs/v4todsGRAsc=
X-Google-Smtp-Source: AFSGD/WTHfCAiPKD/XrLiQooRHP+LJcTZOyEvir8M+Ju1gvMAQnHNJmP65MaecrJ+DTYrW/CIiao80d3lNaQM7vvWAc=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr17594812jak.11.1545208059707;
 Wed, 19 Dec 2018 00:27:39 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com> <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com> <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
 <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com>
In-Reply-To: <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 09:27:28 +0100
Message-ID: <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 15:09, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 18/12/2018 13:23, Vincent Guittot wrote:
> [...]
> >> Ah, I think I get it: you're saying that this balance_interval increase
> >> is done because it is always assumed we do an active balance with
> >> busiest->nr_running > 1 && pinned tasks, and that all that is left to
> >> migrate after the active_balance is pinned tasks that we can't actually
> >> migrate.
> >>
> >> Maybe that's what we should target (as always, totally untested):
> >>
> >> -----8<-----
> >> @@ -9131,18 +9144,16 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >>         } else
> >>                 sd->nr_balance_failed = 0;
> >>
> >> -       if (likely(!active_balance)) {
> >> -               /* We were unbalanced, so reset the balancing interval */
> >> -               sd->balance_interval = sd->min_interval;
> >> -       } else {
> >> +       if (unlikely(active_balance && (env.flags & LBF_ALL_PINNED))) {
> >
> > So it's not exactly LBF_ALL_PINNED but also some pinned tasks
> >
>
> Wouldn't LBF_ALL_PINNED cover all relevant cases? It's set at the very top
> of the 'if (busiest->nr_running > 1)' block and cleared whenever we find
> at least one task we could pull, even if we don't pull it because of
> other reasons in can_migrate_task() (e.g. cache hotness).
>
> If we have LBF_SOME_PINNED but not LBF_ALL_PINNED, we currently don't
> increase the balance_interval, which is what we would want to maintain.

But there are several other UC to do active migration and increase the interval
like all except running tasks are pinned

>
> > but IIUC, you would like to extend the reset of balance  interval  to
> > all the "good" reasons to trig active load balance
>
> Right
>
> > In fact the condition used in need_active_balance except the last
> > remaining one. Good reasons are:
> > - asym packing
> > - /*
> > * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> > * It's worth migrating the task if the src_cpu's capacity is reduced
> > * because of other sched_class or IRQs if more capacity stays
> > * available on dst_cpu.
> > */
> > - misfit task
> >
> > I can extend the test for these conditions
>
> So that's all the need_active_balance() cases except the last
> sd->nr_balance_failed one. I'd argue this could also be counted as a
> "good" reason to active balance which shouldn't lead to a balance_interval
> increase. Plus, it keeps to the logic of increasing the balance_interval
> only when task affinity gets in the way.

But this is some kind of affinity, the hotness is a way for the
scheduler to temporarily pinned the task on a cpu to take advantage of
cache hotness.

I would prefer to be conservative and only reset the interval when we
are sure that active load balance is really what we want to do.
Asym packing is one, we can add the misfit case and the move task on
cpu with more available capacity as well. For the other case, it's
less obvious and I would prefer to keep current behavior
