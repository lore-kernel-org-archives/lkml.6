Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1734DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC1020870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcYnM5fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfA3RkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:40:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50514 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfA3RkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:40:15 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so584014iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urdFLpwv0GrRunGhonLWDShWyTr8hx1Kry6uC6z8Isk=;
        b=BcYnM5fSbOTw/Jrg9N3wUAwLlR4jaCNwcnbp9qGm4v9SedPnHVxn7WuMNlVO1CSHzr
         PGCIxUabO0yAeL4XRRhF/Wd4AJ4cXxjxdNmPVJriGPG5T4z3YtqRfWcIF5XfBLsvxHSQ
         egQJuTSxLY1OcpHRj8EnAjglm6g/wUoUtu2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urdFLpwv0GrRunGhonLWDShWyTr8hx1Kry6uC6z8Isk=;
        b=O27nQIvQWm03E2M9Rs6HlkT+R2xMWz47w2wMO20aaxaGpIbkCjBFdjpzYOQu8ZTil8
         RR7BDH79O/NVcASSFoLEGzvhfVbGAearc4cMty1G6RPXgLL0BpGSXz2e7UHQ6EDhi8Pe
         1KH7P/VXS7Rzzgc9YQerXTFxSb2C0AUdOBRcOevkzyaXwSwaEMs7ZYdjwrcfBkMAmlgT
         LZYw+ZLAuz1tg27rvJiIRMAO/PbG6cEyXuS2TuJEHEvYSqgwkLg9sWrIlx8AXBRbCtwV
         cBT0uBkCkaoa+19r9u6evlFndB9BswV+KM+koGXWnuU4fzQiOX3xqRK2J9NaLfUQconf
         rf7A==
X-Gm-Message-State: AJcUukdRCOUl4WpOZXrQl7szaxFZ4IGk09h9RpuZxhor9twamiiUDtZo
        Hry8HyqN2Zy4nRsz6vZks4symrTaHbHEo3eq+bGTLA==
X-Google-Smtp-Source: ALg8bN56MENFr3D4gZa0VhZgw7wyysTVtyuuWLF/ND+6PdCI858dapURVHfG8Ld7MX80u9MsQu35zt7caWEJCNBgu6Q=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr16847750itf.14.1548870013742;
 Wed, 30 Jan 2019 09:40:13 -0800 (PST)
MIME-Version: 1.0
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130140104.GB2296@hirez.programming.kicks-ass.net> <20190130140144.GD3103@hirez.programming.kicks-ass.net>
 <CAKfTPtAaHx9g7Gg54GYO+JS6Z18OQbX2P2k3O7K6LMXUv1Beew@mail.gmail.com>
In-Reply-To: <CAKfTPtAaHx9g7Gg54GYO+JS6Z18OQbX2P2k3O7K6LMXUv1Beew@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 18:40:02 +0100
Message-ID: <CAKfTPtDHrA=YQ_Zm0wVJnwhdGAh14wXEm=HPWKU0UvSp_mpA4Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 15:27, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 30 Jan 2019 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 03:01:04PM +0100, Peter Zijlstra wrote:
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -282,13 +282,15 @@ static inline struct cfs_rq *group_cfs_r
> > >       return grp->my_q;
> > >  }
> > >
> > > -static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > > +static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > >  {
> > >       struct rq *rq = rq_of(cfs_rq);
> > >       int cpu = cpu_of(rq);
> > >
> > >       if (cfs_rq->on_list)
> > > -             return;
> > > +             return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
> >
> > And I'm almost certain that can be: return true, but got my brain in a
> > twist.
>
> Yes this can return true
>
> If cfs_rq->on_list) then a child not already on the list used the path :
>
> if (cfs_rq->tg->parent &&
>            cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
>
> which does rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;

In fact tests show that we must keep:
  return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;

Because the 1st sched_entity that will be used in the newly added
for_each_sched_entity loop, can be the sched_entityof the cfs_rq that
we just added in the list so cfs_rq->on_list == 1 but we must continue
to add parent

Apart from that, tests are ok

>
> >
> > > +
> > > +     cfs_rq->on_list = 1;
> > >
> > >       /*
> > >        * Ensure we either appear before our parent (if already
