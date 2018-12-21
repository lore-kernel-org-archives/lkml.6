Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8921924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOOalt98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404031AbeLUOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:49:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39811 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbeLUOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:49:35 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so6863536itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajXD0D2eRmVhS3o1tEd/YhHeSKFGBsvzlDSiHq+YYZU=;
        b=gOOalt98tkgOT7ER1HCCvB2hlNu3dkQqkHGopVg6oGQPypNGS14jjzikrMBq3CCf8A
         zEFljV1SsHahQK+HeUkFougFfBL5mrBf7RdrG/zBtYagNysnhQGHw97yDeFeJVhIUIzW
         h7LKXzOYsXruRkLHTMkCkgh9pc1EfbFeCsx7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajXD0D2eRmVhS3o1tEd/YhHeSKFGBsvzlDSiHq+YYZU=;
        b=tBDJdHCPrFXGwbmHf3eniNDkZehAFu1b2Xg4WJ3kkRKdUYqAdn6UuyGhgYQEJmX/dt
         OX2wdUgBvHYZSIInIFMQ9iqTp41EI8ePANRDny0xfN0RYtNOmIrJl3TvldTlCdOCzHzA
         Ne5QOHBXePG6tCxrAf4z0ah3Ds5hldXNabPwmHhM55Cd2MyHrPe1iwbYlDmidZNUqbfv
         hcaqfRMfyECC4SlH6Ts1cRZLfJlelmnFpNIncr5Vy2J/tJGgsuW/nSaz6gINL7FnWbOI
         7rSboxNOWjDL45KlmJ72ZbjOdA8Ra7GTF9FhZPrd5Rxqp6Zhduh+lGtVY9rxtxUU+9xw
         cv3A==
X-Gm-Message-State: AA+aEWZ3wvQP3xEB0tNzYbq4XAT2/F+3pHKvRoERDq5gT3wBTUPvO3Kp
        heG+MqB4fgZfS3YQvx3WAsigUlY4vkVZNn2hMPBFLA==
X-Google-Smtp-Source: ALg8bN7+OW4UZr1RWba9QRggj9LEsaFQPG8mI8dR/moTDMxDYo2aoVlHDUtm5X04J+EGw3/+VTgxsYPyUWOVzkOT5L0=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr2092306itk.114.1545403774021;
 Fri, 21 Dec 2018 06:49:34 -0800 (PST)
MIME-Version: 1.0
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
 <c482361e-cfb4-d172-32c3-4d82ceb1e7d2@arm.com> <CAKfTPtCQTMs=6yGbrfuUGyhwPHWvMODcyyDROVjbURHFxLTxCQ@mail.gmail.com>
 <d87cba1f-fa5c-3d82-ec7f-f2c72d40cb30@arm.com>
In-Reply-To: <d87cba1f-fa5c-3d82-ec7f-f2c72d40cb30@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Dec 2018 15:49:22 +0100
Message-ID: <CAKfTPtBh5tFgSLfTtKafUMjtHMrFLKj1Ep9YwNn5hZS=p756aQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
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

On Thu, 20 Dec 2018 at 18:24, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 20/12/2018 14:50, Vincent Guittot wrote:
> [...]
> >> So now  we reset the interval for all active balances (expect last active
> >> balance case), even when it is done as a last resort because all other
> >> tasks were pinned.
> >>
> >> Arguably the current code isn't much better (always increase the interval
> >> when active balancing), but at least it covers this case. It would be a
> >> waste not to take this into account when we can detect this scenario
> >
> > So i'd like to remind the $subject of this patchset: fix some known
> > issues for asym_packing.
> > While looking at this, we have added few other voluntary active
> > balances because it was "obvious" that this active migration were
> > voluntary one. But in fact, we don't have any UC which show a problem
> > for those additional UC so far.
> >
> > The default behavior for active migration is to increase the interval
> > Now you want to extend the exception to others active migration UC
> > whereas it's not clear that we don't fall in the default active
> > migration UC and we should not increase the interval.
>
> Well if we stick to the rule of only increasing balance_interval when
> pinned tasks get in the way, it's clear to me that this use case shouldn't
> be segregated from the others.
>
> I do agree however that it's not entirely clear if that balance_interval
> increase was also intended to slow down the nr_balance_failed migrations.
>
> I had a look at the history and stumbled on:
>
>         8102679447da ("[PATCH] sched: improve load balancing pinned tasks")
>
> Which explains the reasoning behind the active_balance balance_interval
> increase:
>
>         """
>         this one attempts to work out whether the balancing failure has
>         been due to too many tasks pinned on the runqueue.  This allows it
>         to be basically invisible to the regular blancing paths (ie. when
>         there are no pinned tasks).
>         """
>
> So AFAICT that is indeed the rule we should be following, and I would only
> increase the balance_interval when there are pinned tasks, not because
> of active_balance categories. So here it's a matter of fixing that
> condition into what it was meant to be doing.

After looking at shed.c at this sha1,  (sd->nr_balance_failed >
sd->cache_nice_tries+2) was the only condition for doing active
migration and as a result it was the only reason for doubling
sd->balance_interval.
My patch keeps exactly the same behavior for this condition
'sd->nr_balance_failed > sd->cache_nice_tries+2). And, I'm even more
convinced to exclude (sd->nr_balance_failed > sd->cache_nice_tries+2)
condition because it's the condition that has introduced the doubling
of the interval.

As said previously, you can argue that this behavior is not optimal
and discuss its validity, but the sha1 that you mentioned above,
introduced the current policy for (sd->nr_balance_failed >
sd->cache_nice_tries+2) condition.
Reverting such behavior would need more studies, tests and cares which
are out of the scope of this patchset and more related to a whole
refactoring of load_balance and calculte_imbalance; FYI, I have
submitted a topic on the subject for the next OSPM

>
> > What you want is changing the behavior of the scheduler for UC that
> > haven't raised any problem where asym_packing has known problem/
> >
> > Changing default behavior for active migration is not subject of this
> > patchset and should be treated in another one like the one discussed
> > with peter few days ago
> > >> (I'll reiterate my LBF_ALL_PINNED suggestion).
> >>
> >>>               /* We were unbalanced, so reset the balancing interval */
> >>>               sd->balance_interval = sd->min_interval;
> >>>       } else {
> >>>
