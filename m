Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C96C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaheRkGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBHQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:48:42 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33424 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:48:42 -0500
Received: by mail-it1-f194.google.com with SMTP id q78so9185430itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWtYRXFDWFL7s7fHYtJEWFR2BuCPdjsjJL57meZUaVo=;
        b=TaheRkGHRleKV9QmnGqLqv6tjQLYSlSn7BZzvs8wi37ZrfdxnuXnGm/C2YK1YyYlpC
         LmkEngn1WMcHjgDrgluQkLXxNHuRLnfAYBdyEYo6Syj29itvH+dP9oKMzYuUZ7yZ2CP8
         UN1WTjDsuVqeRjJTNLj9ICc7CDcKYI035+5S+yJuMhgzcsn4tLqPUEXBDvfXfKiZ7nd4
         Bs2ri40d8G8dJqLig8YB/ITlLSzX137GTk+sZ0U83exlGTTVS+Cf8vg2XY3iiB2t4HqW
         Gar7Fne6TjAUqp/Rj2WUYGPrj/LNkY5AnQUjFgiHQ4t8ldE15KBB36JXloANn8fePV2l
         WAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWtYRXFDWFL7s7fHYtJEWFR2BuCPdjsjJL57meZUaVo=;
        b=bYsJAl/YXn7eFWb1cA84qKv9jHFNuWLdj5E+sZtPYUI8Uokj4VlH797CnXR+cgYbb2
         hMOncflk4McMkQF1/8+RZ0EwoBe1YA/cp1s7wRButLxA/WmMgkK+W6QLAG3XJ0p8V2Y7
         JlhnznaT1NSMWsl9lEEbze1Rvu5SUojxuu81NqCNier5V/wAT+DpaA2PfOj4mWODE1EL
         zJAG+05qc6+b2PQ28Xq0mkWf8pbae6TbpWdNlHmsHE/qHuBd4FongWlsYhW8XYYFAwUu
         +ORbmb+jm9DGez5vU/5C15bv/Fo6Rn7rMmHKZinlPtZmIXpeALS48vxz2KHM630WxmeQ
         kApA==
X-Gm-Message-State: AHQUAubDJuTyAUdwTZVHFzQies2opoi0FmvlGvBKYfHPzq3jmnSsEHpb
        XcWgWJ8K2Mp3iPk5vbo40FF0drncsGKUyHDXNbxYpQ==
X-Google-Smtp-Source: AHgI3IYoK649iFZqY6TQEF7kEMbhZebjeFj2lSxDfl8cIAhgAAr2lLetYUqDnCGXsizG0o4DIHnIfRhw/qTwR/FL4Fg=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr8716655itf.14.1549644520939;
 Fri, 08 Feb 2019 08:48:40 -0800 (PST)
MIME-Version: 1.0
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org> <20190208163058.GL32511@hirez.programming.kicks-ass.net>
In-Reply-To: <20190208163058.GL32511@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Feb 2019 17:48:30 +0100
Message-ID: <CAKfTPtAV7zkoq-LknTihHiRgmdCzE+a2mSkiTd=Mcx7H4B1=hg@mail.gmail.com>
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

On Fri, 8 Feb 2019 at 17:31, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 06, 2019 at 05:14:21PM +0100, Vincent Guittot wrote:
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -346,6 +346,18 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >       if (cfs_rq->on_list) {
> > +             struct rq *rq = rq_of(cfs_rq);
> > +
> > +             /*
> > +              * With cfs_rq being unthrottled/throttled during an enqueue,
> > +              * it can happen the tmp_alone_branch points the a leaf that
> > +              * we finally want to del. In this case, tmp_alone_branch moves
> > +              * to the prev element but it will point to rq->leaf_cfs_rq_list
> > +              * at the end of the enqueue.
> > +              */
> > +             if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> > +                     rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
> > +
> >               list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> >               cfs_rq->on_list = 0;
> >       }
>
> So that is:
>
>   enqueue_task_fair()
>     enqueue_entity()
>       list_add_lead_cfs_rq()
>       check_enqueue_throttle()
>         throttle_cfs_rq()
>           walk_tg_tree_from()
>             tg_throttle_down()
>               list_del_leaf_cfs_rq()
>
> Which can try and remove a cfs_rq which we just added.
>
> And because the list is a bottom-up order, and the deletion is a
> downward operation, we must go back (prev) in the list.

yes exactly

>
> So far so good I suppose.
>
> > @@ -4449,8 +4465,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
> >       struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> >
> >       /* group is entering throttled state, stop time */
> > -     if (!cfs_rq->throttle_count)
> > +     if (!cfs_rq->throttle_count) {
> >               cfs_rq->throttled_clock_task = rq_clock_task(rq);
> > +             list_del_leaf_cfs_rq(cfs_rq);
> > +     }
> >       cfs_rq->throttle_count++;
> >
> >       return 0;
>
>
