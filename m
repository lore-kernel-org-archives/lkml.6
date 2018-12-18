Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C13D21874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyzvxQwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeLRNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:23:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33024 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeLRNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:23:48 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so8255441itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YPqw90N2rIV4uMrjzHub2HxaDHhqjxG3rH9jd06+FM=;
        b=VyzvxQwPCHWLEpv17UdDWo5cWpABpUFOjGAz9kSuJ+ZfMj2BJTYi10LhCYNNvzwU8j
         wP6QVQE6OTCC1wdhQ5ceWyxkqWNQtA82ye10vdv/iv+IB4XhezILkxkdDX9GaDB3Bbp0
         184aGNwRcl6HwXERXEPxzn0tEXaZ+vGbxnU9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YPqw90N2rIV4uMrjzHub2HxaDHhqjxG3rH9jd06+FM=;
        b=mYm+05OxTQK1CrXsR04uHbIOflFCuUORtxAG637JSAW/rJoof5QcRRXEIRKD+8xeH7
         dO9hZpQjLripwNZ6NVXn2LBizGMm8knj4gvxlf30aMlgsl/lRCzlI7Xy/zWGwCSF8IAR
         31HSDwAnMX9CemkcxXUQ7ezTMV5E50ccdW1ZAc9Gztho4vYx8gF/WlFD/xY9LykdUOAs
         2HMNbIPhb4k/jazmDW/SScjyJYIDxD3epNM+GVyHxBe3yLTnxzWsgSjrbMyrPIJlmnAj
         tEPygO9rH8zQTYdeHSdV9uzrNen6HkMP/oJGXyDDbSQRmTfJ0X6L6+YS75HKTUxLlrm2
         2Jlg==
X-Gm-Message-State: AA+aEWbQCiJRfZFOlhURshMJkJVhXwM8xuTkY+q6vY6yy4OHb6NLV8hC
        ofb/94+Xubf7P3pdk28ZVLnYT8bQSZR5Aw+GaFlWjw==
X-Google-Smtp-Source: AFSGD/WSKJe/vyJQVSCteYcPaoqdkFbmYf7v1aNwq2+okv4KikeUiEt7MxQ3yT/abGi6BIfJLPtGw2lDWwyff0Z/q+k=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr14773500jak.11.1545139427285;
 Tue, 18 Dec 2018 05:23:47 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com> <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com>
In-Reply-To: <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Dec 2018 14:23:36 +0100
Message-ID: <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
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

On Tue, 18 Dec 2018 at 12:46, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 18/12/2018 09:32, Vincent Guittot wrote:
> [...]
> > In this asym packing case, It has nothing to do with pinned tasks and
> > that's the root cause of the problem:
> > the active balance triggered by asym packing is wrongly assumed to be
> > an active balance due to pinned task(s) and the load balance interval
> > is increased without any reason
> >
> [...]> hmm the increase of balance interval is not linked to cpu stopper but
> > to increase the load balance interval when we know that there is no
> > possible load balance to perform
> >
> > Regards,
> > Vincent
>
> Ah, I think I get it: you're saying that this balance_interval increase
> is done because it is always assumed we do an active balance with
> busiest->nr_running > 1 && pinned tasks, and that all that is left to
> migrate after the active_balance is pinned tasks that we can't actually
> migrate.
>
> Maybe that's what we should target (as always, totally untested):
>
> -----8<-----
> @@ -9131,18 +9144,16 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>         } else
>                 sd->nr_balance_failed = 0;
>
> -       if (likely(!active_balance)) {
> -               /* We were unbalanced, so reset the balancing interval */
> -               sd->balance_interval = sd->min_interval;
> -       } else {
> +       if (unlikely(active_balance && (env.flags & LBF_ALL_PINNED))) {

So it's not exactly LBF_ALL_PINNED but also some pinned tasks

but IIUC, you would like to extend the reset of balance  interval  to
all the "good" reasons to trig active load balance
In fact the condition used in need_active_balance except the last
remaining one. Good reasons are:
- asym packing
- /*
* The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
* It's worth migrating the task if the src_cpu's capacity is reduced
* because of other sched_class or IRQs if more capacity stays
* available on dst_cpu.
*/
- misfit task

I can extend the test for these conditions


>                 /*
> -                * If we've begun active balancing, start to back off. This
> -                * case may not be covered by the all_pinned logic if there
> -                * is only 1 task on the busy runqueue (because we don't call
> -                * detach_tasks).
> +                * We did an active balance as a last resort (all other tasks
> +                * were pinned), start to back off.
>                  */
>                 if (sd->balance_interval < sd->max_interval)
>                         sd->balance_interval *= 2;
> +       } else {
> +               /* We were unbalanced, so reset the balancing interval */
> +               sd->balance_interval = sd->min_interval;
>         }
>
>         goto out;
> ----->8-----
>
> can_migrate_task() called by detach_tasks() in the
> 'if (busiest->nr_running > 1)' block should clear that LBF_ALL_PINNED flag
> if there is any migratable task (even if we don't end up migrating it),
> and it's not set if (busiest->nr_running == 1), so that *should* work.
>
> I believe the argument that this applies to all kinds of active balances
> is still valid - this shouldn't be changed just for asym packing active
> balance.
