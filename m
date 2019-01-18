Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D48C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66720652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkBpfn4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAROGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:06:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38094 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfAROGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:06:41 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so5904361ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYo1/LrA3p7SI0Dg4nWcXfrbKIa82o3YNuRGLWd3ibQ=;
        b=GkBpfn4R22r5Wp8LkeIqzcpeoEgwC2x8tfx9nml9UAwQ/KmrJF1o6ipP6dtGaNCQwm
         U68sYX2FlLi+sRFWpiXQLxb+Z/397R+ha2i1qEdaleohyOV2dZR8/+x/gTeG0tmv7klE
         xnQSloJ7Q++RpQitSKmApqASm6fQUq/37IoNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYo1/LrA3p7SI0Dg4nWcXfrbKIa82o3YNuRGLWd3ibQ=;
        b=cUQFmzquyEn8Z5KMCwBIZt4xcf0hCIiLV/VVyyDBSYOQAGWYhuw20rig2m/USvPzs5
         UxquWRulVNF1rSIYvUzxtlSvDG+0ZTPcpPbCVJlxgTnP3VRDNH0hNxh+tanHvOLRixsZ
         +pQwIPpG6sFS+ZtP3PLpp6u5sJ6NYAR07Fy3KFqAQcWZfg5WUJGP6eKaWPolFrj5ZP8e
         8665T6L3c+WwSclONvk39NFlRzhCXlbPMuME2Qj7/hsFkmkIjAOgGv4etUcyxplxAVrs
         W7soIxWAz85IGZ8z1jncw624c379fyKKf4c5KP8LBI9q67Q/Lmtkoh86hMsCl7wakGvT
         axbQ==
X-Gm-Message-State: AJcUukcIoxtkp3B0Z1XX/65GqWePWk9q2lRsy+gWT0a2AEIhv4w67cMG
        LJMVAXt0CpSb5RaGbmiguy+5NOoSCdftH+swx/7V2w==
X-Google-Smtp-Source: ALg8bN6F9hP9fgDYt+k7K+yNHjyzjX0vKuwc1k//iGmN4cyq9rd5Pm3DN9gTrXn4682uNvA3fgIOFaiYw8wzMTqYZig=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr11388139itf.14.1547820400004;
 Fri, 18 Jan 2019 06:06:40 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com> <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
In-Reply-To: <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Jan 2019 15:06:28 +0100
Message-ID: <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Gabriel Hartmann <ghartmann@netflix.com>,
        Gabriel Hartmann <gabriel.hartmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 11:16, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > >
> > > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
> > > infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
> > > and put it on top of 4.19.13. In addition to this, I uninlined
> > > list_add_leaf_cfs_rq for debugging.

With the fix above applied, the code that manages the leaf_cfs_rq_list
is the same since v4.9.
Have you noticed similar problem on other older kernel version between
v4.9 and v4.19 ? The problem might have been introduce while modifying
other part of the scheduler like the sequence for adding/removing
cgroup.

Knowing the most recent kernel version without the problem could help
to narrow the problem

Thanks,
Vincent

> > >
> > > This revealed a new bug that we didn't get to because we kept getting
> > > crashes from the previous issue. When we are running with cgroups that
> > > are rapidly changing, with CFS bandwidth control, and in addition
> > > using the cpusets cgroup, we see this crash. Specifically, it seems to
> > > occur with cgroups that are throttled and we change the allowed
> > > cpuset.
>
> Thanks for the context, I will try to reproduce the problem and
> understand how we can stop in the middle of walking to the
> sched_entity branch with a parent not already added
>
> How many cgroup level have you got in you setup ?
>
> > >
> >
> > This patch from Gabriel should fix the problem:
> >
> >
> > [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
> >
> > When a child cfs_rq is added to the leaf cfs_rq list before its parent
> > tmp_alone_branch is set to point to the child in preparation for the
> > parent being added.
> >
> > If the child is deleted before the parent is added then tmp_alone_branch
> > points to a freed cfs_rq. Any future reference to tmp_alone_branch will
> > result in a use after free.
>
> So, the patch below is a temporary fix that helps to recover from the
> situation where tmp_alone_branch doesn't finished back to
> rq->leaf_cfs_rq_list
> But this situation should not happened at the beginning
>
> >
> > Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
> > Reported-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7137bc343b4a..0987629cbb76 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct
> > cfs_rq *cfs_rq)
> >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >      if (cfs_rq->on_list) {
> > +        struct rq *rq = rq_of(cfs_rq);
> > +
> > +        if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> > +            rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> > +
> >          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> >          cfs_rq->on_list = 0;
> >      }
