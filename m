Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4294218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKOJ4pwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAYOb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:31:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39638 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:31:55 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so9844376itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t9i4bOBLGTAvNS6M38apgzthf/lmEx7fFpXcnbxk9Yg=;
        b=SKOJ4pwp5B/7u/ji5UhMDJzbTj+tY9nExd9hSZYcHWWGPMOWD5f+fgDxOdFPxc9c1p
         uZ5scGeIVdc8JnKwYF6jQFekZxaC1T0jujfELGf0iRjAo9la9kwTewUojhcbZkQO+GsR
         JPj0pdiy+jeyu/zFvpRbdiBaVDinA+yYWbweA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t9i4bOBLGTAvNS6M38apgzthf/lmEx7fFpXcnbxk9Yg=;
        b=mlj4s3MPzziqAC+KROCkq3yd+WM27HYPQITUoQXojj8UsPtaNcvTHBmt4xh2ufHWpN
         iihvVsAbTUdZuIDsbyqA6yildvJwMIbDlEyqTYvCZgwFoDqbF72ajSxWpm099fdm1A3B
         YD9VizISkeKtGHZFqHVOahDZgRBCgBtXWSRcBKOVFCZ2m5otnMdGFJU8h/1RC9seRjMj
         aajfed51D6lQt3kZrVkAUrLjyX7aSXv2KqSmztfjTaFGr35Cu7eRuLjl2o6s5t1pVTuc
         CAHCpkrRzbTK6yqbcfSOcm/jVPPy02ua5l8nFY778wxms8Kx1+2ZJttDGLgkcWTrr9dD
         wJhA==
X-Gm-Message-State: AJcUuketb4bVjUzof03zy83O2fHd7xVq2nFga2QtJIxK8rnijjVMbqdB
        oAB+8D2ALGo4XOPNvoZ3bxfmnLTzo33FewcEvommGidsCfg=
X-Google-Smtp-Source: ALg8bN5eaPZ7aYnAf/tuuouaRVgbC7wqULTX/r0oSefopsjuA8SyS5IgANqVaut/80pAlZT59TLrH4LApPEMVbS8xq8=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr4184470itk.114.1548426714130;
 Fri, 25 Jan 2019 06:31:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
 <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
 <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com> <20190121144628.GA28655@linaro.org>
In-Reply-To: <20190121144628.GA28655@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Jan 2019 15:31:43 +0100
Message-ID: <CAKfTPtCPfRikC2gdZ9m3E3tWE810CfFqoDaNm3FgFVXSMpxqEg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sargun,

On Mon, 21 Jan 2019 at 15:46, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Sargun,
>
> Le Friday 18 Jan 2019 =C3=A0 15:06:28 (+0100), Vincent Guittot a =C3=A9cr=
it :
> > On Fri, 18 Jan 2019 at 11:16, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wrote:
> > > >
> > > > On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> wr=
ote:
> > > > >
> > > > > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: =
Fix
> > > > > infinite loop in update_blocked_averages() by reverting a9e7f6544=
b9c
> > > > > and put it on top of 4.19.13. In addition to this, I uninlined
> > > > > list_add_leaf_cfs_rq for debugging.
> >
> > With the fix above applied, the code that manages the leaf_cfs_rq_list
> > is the same since v4.9.
> > Have you noticed similar problem on other older kernel version between
> > v4.9 and v4.19 ? The problem might have been introduce while modifying
> > other part of the scheduler like the sequence for adding/removing
> > cgroup.
> >
> > Knowing the most recent kernel version without the problem could help
> > to narrow the problem
> >
> > Thanks,
> > Vincent
> >
> > > > >
> > > > > This revealed a new bug that we didn't get to because we kept get=
ting
> > > > > crashes from the previous issue. When we are running with cgroups=
 that
> > > > > are rapidly changing, with CFS bandwidth control, and in addition
> > > > > using the cpusets cgroup, we see this crash. Specifically, it see=
ms to
> > > > > occur with cgroups that are throttled and we change the allowed
> > > > > cpuset.
> > >
> > > Thanks for the context, I will try to reproduce the problem and
> > > understand how we can stop in the middle of walking to the
> > > sched_entity branch with a parent not already added
> > >
> > > How many cgroup level have you got in you setup ?
> > >
> > > > >
> > > >
> > > > This patch from Gabriel should fix the problem:
> > > >
> > > >
> > > > [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
> > > >
> > > > When a child cfs_rq is added to the leaf cfs_rq list before its par=
ent
> > > > tmp_alone_branch is set to point to the child in preparation for th=
e
> > > > parent being added.
> > > >
> > > > If the child is deleted before the parent is added then tmp_alone_b=
ranch
> > > > points to a freed cfs_rq. Any future reference to tmp_alone_branch =
will
> > > > result in a use after free.
> > >
> > > So, the patch below is a temporary fix that helps to recover from the
> > > situation where tmp_alone_branch doesn't finished back to
> > > rq->leaf_cfs_rq_list
> > > But this situation should not happened at the beginning
>
> I have been able to reproduce the situation where tmp_alone_branch doesn'=
t
> point to rq->leaf_cfs_rq_list after enqueuing a task.
>
> Can you try the patch below which ensures all cfs_rq of a cgroup branch w=
ill
> be added in the list even if throttled ?

Did you get a chance to test this patch ?

Regards,
Vincent

>
> The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
> it will walk down to root the 1st time a cfs_rq is used and we will finis=
hed
> to add either a cfs_rq without parent or a cfs_rq with a parent that is a=
lready
> on the list. But this is not always true in presence of throttling.
> Because a cfs_rq can be throttled even if it has never been used but othe=
r CPUS
> of the cgroup have already used all the bandwdith, we are not sure to go =
down to
> the root and add all cfs_rq in the list.
>
> Ensure that all cfs_rq will be added in the list even if they are throttl=
ed.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6483834..ae468ab 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cfs_r=
q *cfs_rq)
>         }
>  }
>
> +static inline void list_add_branch_cfs_rq(struct sched_entity *se, struc=
t rq *rq)
> +{
> +struct cfs_rq *cfs_rq;
> +
> +       for_each_sched_entity(se) {
> +               cfs_rq =3D cfs_rq_of(se);
> +               list_add_leaf_cfs_rq(cfs_rq);
> +
> +               /* If parent is already in the list, we can stop */
> +               if (rq->tmp_alone_branch =3D=3D &rq->leaf_cfs_rq_list)
> +                       break;
> +       }
> +}
> +
>  /* Iterate through all leaf cfs_rq's on a runqueue: */
>  #define for_each_leaf_cfs_rq(rq, cfs_rq) \
>         list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_r=
q_list)
> @@ -5177,6 +5191,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>
>         }
>
> +       /* Ensure that all cfs_rq have been added to the list */
> +       list_add_branch_cfs_rq(se, rq);
> +
>         hrtick_update(rq);
>  }
>
>
>
> > >
> > >
> > > >
> > > > Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
> > > > Reported-by: Sargun Dhillon <sargun@sargun.me>
> > > > ---
> > > >  kernel/sched/fair.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 7137bc343b4a..0987629cbb76 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct
> > > > cfs_rq *cfs_rq)
> > > >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > > >  {
> > > >      if (cfs_rq->on_list) {
> > > > +        struct rq *rq =3D rq_of(cfs_rq);
> > > > +
> > > > +        if (rq->tmp_alone_branch =3D=3D &cfs_rq->leaf_cfs_rq_list)
> > > > +            rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
> > > > +
> > > >          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> > > >          cfs_rq->on_list =3D 0;
> > > >      }
