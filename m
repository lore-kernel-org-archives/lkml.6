Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A693DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617712192D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO2jZ6hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfBPAMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:12:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39552 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfBPAMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:12:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so13020063qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z1/WRW0y4TjN1SSj9d8EuJ+RuC2x+L/pN2vr155QooE=;
        b=IO2jZ6hUC1/PvesSwC3LL8nngfajaH3M50LsS001KzQGhptNSPNG2izloDnbyYM8sh
         JvrnWV6SY8rBKhv3P2GOmDA5i4ix5KUGrNUS/JREx3ZWE5MDpFo5jUvp66nufPC2TRvt
         /Gz7fZqMUWljBcmZWR75JbpIcOCMeA45Y247Fcopm3kHcZ+xdJA3G+ieQMOh127xiRQh
         KOJrAEoHR25fFmMRleolDpj5cOd/gSBKf0A001UmgAA190bPScyuICsG/ZO7lNi+0g/s
         mfYrGqCcuQDXhrOhfBcpTFHPBAtKtcYuRna2nhp6ds6o+pT2qImYlicOqIZpZdBHC0dO
         XKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z1/WRW0y4TjN1SSj9d8EuJ+RuC2x+L/pN2vr155QooE=;
        b=r7THjIhTFZt+CQh45oaSudrqfMn87e21+hfBz7Ch/1EPmI8H/16q3g2qhvr5WXiDC1
         GRu0nk/06sJs6grE+LCTfq4yiiGBnDmpDIQasOHfOLxB3swHZkPodx2ZLrho1nbV/NJC
         3L1bfr4kPvfkqwsKnqtlr6Huhdu/0pg4v5yGZobvNFqiFnUtCaPzSc9gtuz8DiJ3MKLh
         PzSXoOUyYfIeBkh3N8ARRRXo49chNS/laz4T7lRKxRCdukolJUukVeuF3l34gTRyr2EX
         HB99vxo+8Kyx5ogWc+HNpdtZzdwN3L3Pr4CgocO2tg9BJzIjmrnhFWiamFImmG4FafSg
         Xapw==
X-Gm-Message-State: AHQUAuYrEcaN452iLO4zX2sXbabdsYrmhl+buXFlL8aJoq3W16fql/DJ
        c6R6H6OHNNl7VqKmktlyXC/sOvIxE4AfgcvXuC4=
X-Google-Smtp-Source: AHgI3IZi4uTcQtdLif5DmbzWm+UyE5F82CSQsgSi8/UveeswXnRFGrEEH6Ci+KT4ErA+HgHGOEJZrqltXdsMqSohrh4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr9586306qtl.343.1550275968219;
 Fri, 15 Feb 2019 16:12:48 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
 <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
 <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com>
 <20190121144628.GA28655@linaro.org> <CAKfTPtCPfRikC2gdZ9m3E3tWE810CfFqoDaNm3FgFVXSMpxqEg@mail.gmail.com>
In-Reply-To: <CAKfTPtCPfRikC2gdZ9m3E3tWE810CfFqoDaNm3FgFVXSMpxqEg@mail.gmail.com>
From:   Gabriel Hartmann <gabriel.hartmann@gmail.com>
Date:   Fri, 15 Feb 2019 16:12:37 -0800
Message-ID: <CAJBJEU0NgXZn=HyARd28t_8qzooGvC7XBh7yhVpDbejFFoM9JQ@mail.gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Gabriel Hartmann <ghartmann@netflix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Jan 25, 2019 at 6:31 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Sargun,
>
> On Mon, 21 Jan 2019 at 15:46, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Sargun,
> >
> > Le Friday 18 Jan 2019 =C3=A0 15:06:28 (+0100), Vincent Guittot a =C3=A9=
crit :
> > > On Fri, 18 Jan 2019 at 11:16, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wrot=
e:
> > > > >
> > > > > On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> =
wrote:
> > > > > >
> > > > > > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair=
: Fix
> > > > > > infinite loop in update_blocked_averages() by reverting a9e7f65=
44b9c
> > > > > > and put it on top of 4.19.13. In addition to this, I uninlined
> > > > > > list_add_leaf_cfs_rq for debugging.
> > >
> > > With the fix above applied, the code that manages the leaf_cfs_rq_lis=
t
> > > is the same since v4.9.
> > > Have you noticed similar problem on other older kernel version betwee=
n
> > > v4.9 and v4.19 ? The problem might have been introduce while modifyin=
g
> > > other part of the scheduler like the sequence for adding/removing
> > > cgroup.
> > >
> > > Knowing the most recent kernel version without the problem could help
> > > to narrow the problem
> > >
> > > Thanks,
> > > Vincent
> > >
> > > > > >
> > > > > > This revealed a new bug that we didn't get to because we kept g=
etting
> > > > > > crashes from the previous issue. When we are running with cgrou=
ps that
> > > > > > are rapidly changing, with CFS bandwidth control, and in additi=
on
> > > > > > using the cpusets cgroup, we see this crash. Specifically, it s=
eems to
> > > > > > occur with cgroups that are throttled and we change the allowed
> > > > > > cpuset.
> > > >
> > > > Thanks for the context, I will try to reproduce the problem and
> > > > understand how we can stop in the middle of walking to the
> > > > sched_entity branch with a parent not already added
> > > >
> > > > How many cgroup level have you got in you setup ?
> > > >
> > > > > >
> > > > >
> > > > > This patch from Gabriel should fix the problem:
> > > > >
> > > > >
> > > > > [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
> > > > >
> > > > > When a child cfs_rq is added to the leaf cfs_rq list before its p=
arent
> > > > > tmp_alone_branch is set to point to the child in preparation for =
the
> > > > > parent being added.
> > > > >
> > > > > If the child is deleted before the parent is added then tmp_alone=
_branch
> > > > > points to a freed cfs_rq. Any future reference to tmp_alone_branc=
h will
> > > > > result in a use after free.
> > > >
> > > > So, the patch below is a temporary fix that helps to recover from t=
he
> > > > situation where tmp_alone_branch doesn't finished back to
> > > > rq->leaf_cfs_rq_list
> > > > But this situation should not happened at the beginning
> >
> > I have been able to reproduce the situation where tmp_alone_branch does=
n't
> > point to rq->leaf_cfs_rq_list after enqueuing a task.
> >
> > Can you try the patch below which ensures all cfs_rq of a cgroup branch=
 will
> > be added in the list even if throttled ?
>
> Did you get a chance to test this patch ?
>
> Regards,
> Vincent
>
> >
> > The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
> > it will walk down to root the 1st time a cfs_rq is used and we will fin=
ished
> > to add either a cfs_rq without parent or a cfs_rq with a parent that is=
 already
> > on the list. But this is not always true in presence of throttling.
> > Because a cfs_rq can be throttled even if it has never been used but ot=
her CPUS
> > of the cgroup have already used all the bandwdith, we are not sure to g=
o down to
> > the root and add all cfs_rq in the list.
> >
> > Ensure that all cfs_rq will be added in the list even if they are throt=
tled.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6483834..ae468ab 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cfs=
_rq *cfs_rq)
> >         }
> >  }
> >
> > +static inline void list_add_branch_cfs_rq(struct sched_entity *se, str=
uct rq *rq)
> > +{
> > +struct cfs_rq *cfs_rq;
> > +
> > +       for_each_sched_entity(se) {
> > +               cfs_rq =3D cfs_rq_of(se);
> > +               list_add_leaf_cfs_rq(cfs_rq);
> > +
> > +               /* If parent is already in the list, we can stop */
> > +               if (rq->tmp_alone_branch =3D=3D &rq->leaf_cfs_rq_list)
> > +                       break;
> > +       }
> > +}
> > +
> >  /* Iterate through all leaf cfs_rq's on a runqueue: */
> >  #define for_each_leaf_cfs_rq(rq, cfs_rq) \
> >         list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs=
_rq_list)
> > @@ -5177,6 +5191,9 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
> >
> >         }
> >
> > +       /* Ensure that all cfs_rq have been added to the list */
> > +       list_add_branch_cfs_rq(se, rq);
> > +
> >         hrtick_update(rq);
> >  }
> >
> >
> >
> > > >
> > > >
> > > > >
> > > > > Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
> > > > > Reported-by: Sargun Dhillon <sargun@sargun.me>
> > > > > ---
> > > > >  kernel/sched/fair.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 7137bc343b4a..0987629cbb76 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(stru=
ct
> > > > > cfs_rq *cfs_rq)
> > > > >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > > > >  {
> > > > >      if (cfs_rq->on_list) {
> > > > > +        struct rq *rq =3D rq_of(cfs_rq);
> > > > > +
> > > > > +        if (rq->tmp_alone_branch =3D=3D &cfs_rq->leaf_cfs_rq_lis=
t)
> > > > > +            rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
> > > > > +
> > > > >          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> > > > >          cfs_rq->on_list =3D 0;
> > > > >      }

Apologies for the slow turn around on this.  We have tried both
approaches to fixing the bug now.  In both cases for a particularly
long duration CPU intensive workload we are seeing ~33% slowdown.

-- Gabriel
