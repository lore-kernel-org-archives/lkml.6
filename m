Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97A02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRLTJ7D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfBHPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:45:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52202 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfBHPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:45:05 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so3448563itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLhArNA71CLwmG6sf/hSHkTSXFYjsyaE7TLGjaTvLjY=;
        b=dRLTJ7D21kk+8nLj/Rmcspul7/Btal5Ps+s5p0/ScjCqVxcYr3CeSU9dg+eF0M+754
         TxOK2dvONvyT0VUl0/AIaaeWyMDkTbTv3gB00ypQ1cpw9ZcRMNNYxdPL7bm3UunjTl9U
         dNmg0R3wWwBYGML/LGQgVA1aG3mF7SsMc1/RuUoRsCjnaYceQoH3WF0IfOIlc/DvYoC5
         BR658hYhnraEFJNZjy0eisJVh8FIgu5HpvIsDLEQXyd+MdzsGnQdse4FzJJvq9OuA6Ft
         fBWJrDBgXz5VIlZdWJCR2t5FtYipka5aaq4Tz2hm1bR1095K1eRDcclSdlA/Y/Nb6uXn
         4dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLhArNA71CLwmG6sf/hSHkTSXFYjsyaE7TLGjaTvLjY=;
        b=Qi8byaleBsywoASKy4lXoAn+3r4dXoSdTMHugfODJu476vvK8Bqhbzhx3j62k+KPuQ
         Ty4k90KvZxeToL6N4ZpOLD/nnnLBKgZTVV1ZGo9sbNyDHSxvra5dpVjwPgeYe2TlIcVL
         mtVIqetTrnXKug5Box4OwUdrF01awaSWwQwqnPg0fJTeBkD9MbcxG8cFEBCM9jf0QeY8
         1JEnau2w/C1DOjLswwzMrbDWACOTQNlWWjiIO65MbOGcmwg2bCXf66Wk7OwnrWHW2FXK
         xNCeNeF//3eUhfjChucVvh18/8E6g+OWsxTdFa8LjR3pT2PZv+tTn2XaAbgHerNVCCkz
         lgzQ==
X-Gm-Message-State: AHQUAuaG8BwvLgy33B5AWc3RgNuNZjGIwAmgHiWUK3vJp+76dr2PoM3x
        16k3QKvdLJuYPvNONK7sI87o8pyMCZtx8N1246Abuw==
X-Google-Smtp-Source: AHgI3IbpLeJvzW26Y2qqAxB1ScxTnltfw1fCUwowhmJLXfNbH3oSDP+ThxfYDRo869tONG/b+wMcmtcrrPEnmbHTtds=
X-Received: by 2002:a5e:8417:: with SMTP id h23mr5568798ioj.183.1549640704744;
 Fri, 08 Feb 2019 07:45:04 -0800 (PST)
MIME-Version: 1.0
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org> <20190208154009.GK32511@hirez.programming.kicks-ass.net>
In-Reply-To: <20190208154009.GK32511@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Feb 2019 16:44:53 +0100
Message-ID: <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
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

On Fri, 8 Feb 2019 at 16:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Argh head hurts!!
>
> On Wed, Feb 06, 2019 at 05:14:21PM +0100, Vincent Guittot wrote:
> > @@ -4438,6 +4450,10 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
> >               /* adjust cfs_rq_clock_task() */
> >               cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
> >                                            cfs_rq->throttled_clock_task;
> > +
> > +             /* Add cfs_rq with already running entity in the list */
> > +             if (cfs_rq->nr_running >= 1)
> > +                     list_add_leaf_cfs_rq(cfs_rq);
> >       }
> >
> >       return 0;
>
> Do we want the below to go with the above change?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 38d4669aa2ef..0bd80a891025 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4536,6 +4536,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         /* update hierarchical throttle state */
>         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
>
> +       assert_list_leaf_cfs_rq(rq);
> +

Good point but this should go after the for_each_sched_entity() loop

>         if (!cfs_rq->load.weight)
>                 return;
>
