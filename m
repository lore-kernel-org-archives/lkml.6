Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3199EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F332080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4R9bPJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBHQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:48:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37186 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:48:05 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so10421440iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAfeZLLlE/pUVk+JnELzFYtrQ52bBULXUj34gHoPUsU=;
        b=z4R9bPJqXgzIVs52DrZhc4Snad0zfMTWVr/A/rfVO64Q+FAyYGiaY/pI2eh66a83xz
         bTfVIhPj6HoYOkCUXGqfuWtr1oU2010oP+8Bwl3shvDzSix6oaZ+V7QYb884/mzUBchR
         U5iscOHNmCcxojw0Av+rD6nymQYACqyizeJs+dsV4OnPZxw8QaSv8kT2kyvBwHOEQOIA
         LXLH+G4WY+mn240itP5lxs6RdXf2eHXe5DHCYyT/WaESeGkc4NwoTy3jm9o4yfEya0Gh
         FOuNwoxDfdJo67e9tKwGG+7HZzoN6tzR9ZqNEEhIouXt1WYPywV6uCrg/Z4KTWw8itTM
         IiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAfeZLLlE/pUVk+JnELzFYtrQ52bBULXUj34gHoPUsU=;
        b=d0Fxy/3mtaOGqnbdmgLzDYgLMURJGbK1ELulJiLRIap4r5AdFEWHkRnmhV45WNELol
         c3oZXpXOjL98n3XHBtosWWdZKpLuUJDVDpFyYqOBo3bNz8Cgzj+S9rprVLpcV/UGMOLT
         nHxF9Vr0JL2Hoav4FNFrhadt8Aki8Dss1Yig5VvhK8IW8BuRqi48boj8j3lI6fvDkQAQ
         Vcwp4jhDKa7PQ3FH3EIwT1g3680Mt3nHeVeuNSjyZstsN4BTXibXWumYMrTb91fGu85e
         p0pUKOOsKsVITnkNrQm1x/pJd2I11mLXsYWOF/YxU5ZG1X4zmZk9hRPe2pCj9y3sELP+
         MUjw==
X-Gm-Message-State: AHQUAuYWg4GJhFAU8Mh8OITMOswGXnXXrHk5pd3uZnstBpoQnaWx5O+3
        f6gpkhpDk9BcPZVZL++LMR4mQtFwWVFxnCqzCHfOOQ==
X-Google-Smtp-Source: AHgI3IYkJF4I21lLEy66lwh33boPKhMtMi0dUt8jF8OkC+oaqnLWo9PuxHknzcN1uEDrepTb4Svi9+QSdCnaElLKG44=
X-Received: by 2002:a5e:d804:: with SMTP id l4mr5409519iok.18.1549644484152;
 Fri, 08 Feb 2019 08:48:04 -0800 (PST)
MIME-Version: 1.0
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
 <20190208154009.GK32511@hirez.programming.kicks-ass.net> <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
 <20190208163045.GD32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190208163045.GD32494@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Feb 2019 17:47:53 +0100
Message-ID: <CAKfTPtDjS4sL-ijVgGsN9Z1yEsCi87CZfpYsZCr2n3KTLV=ByA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 at 17:30, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 08, 2019 at 04:44:53PM +0100, Vincent Guittot wrote:
> > On Fri, 8 Feb 2019 at 16:40, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > >
> > > Argh head hurts!!
> > >
> > > On Wed, Feb 06, 2019 at 05:14:21PM +0100, Vincent Guittot wrote:
> > > > @@ -4438,6 +4450,10 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
> > > >               /* adjust cfs_rq_clock_task() */
> > > >               cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
> > > >                                            cfs_rq->throttled_clock_task;
> > > > +
> > > > +             /* Add cfs_rq with already running entity in the list */
> > > > +             if (cfs_rq->nr_running >= 1)
> > > > +                     list_add_leaf_cfs_rq(cfs_rq);
> > > >       }
> > > >
> > > >       return 0;
> > >
> > > Do we want the below to go with the above change?
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 38d4669aa2ef..0bd80a891025 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4536,6 +4536,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> > >         /* update hierarchical throttle state */
> > >         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
> > >
> > > +       assert_list_leaf_cfs_rq(rq);
> > > +
> >
> > Good point but this should go after the for_each_sched_entity() loop
>
> Indeed, but that loop does enqueue and can throttle again, should that
> not also get that additional list_add_leaf_cfs_rq() loop we added to
> enqueue_task_fair() to finish the add?

Initially, I added this additional loop but finally removed it because
I didn't hit it during my tests. IIRC, we are protected by
throttle_count in such case, which is not the case when we enqueue a
task
