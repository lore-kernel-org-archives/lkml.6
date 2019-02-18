Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09527C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1845218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUqY7fpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfBRIEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:04:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39403 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:04:25 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so26190695iti.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KOtcsx1XK96yGAM5VvRvRBSxh3hvaTbLNrbN2PUWJeE=;
        b=vUqY7fpfnAv/+eYL+3CwztPMqGJVTmQMCnFmMIyfJlgICYGYvatLYSWYb1cmVV+inr
         HdDB51DwQhy8o57I0/L4LxtUUKhbpXwYNjXu6ZwojwWDZ6AHaTRGs4j0DRlK3MissV+I
         a8lpO6dNGSUUvYvD0veIXX68WfUChZ5HOfloHJ2W7apXaICE3aZYCFtw6GUR0ZGrONKE
         LgjmW6UUJAE4BcqB/+wWhHjX8kJGVp+MNAMa3xKFn0i/4fg8qnNbjtRSeMnRc8YFUWv5
         UUWRsHmTml7ci/iq9wgEtSdrCjUUbJU4O5cBXbbfVtifiOLZq7aweKNLie6R6HM7Kerr
         p5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KOtcsx1XK96yGAM5VvRvRBSxh3hvaTbLNrbN2PUWJeE=;
        b=IEYfUDXivVJuwC/7gsP/FNb3DMUsr3txr4FcbFqMTFcxQztr8RNngM5rPx9LsHS+zc
         lvxpgGRzMMQDFhD9mKxf6olibKp8PnAGS+gKhEMrcTSFubD7JNusqIRUTo6eIVwXWPZb
         FgZ2sYhm6wFYyj8vcM6NNPuBCVPavlD6YS0JF724Nb4ugtn7VsACtTco06pj7Nh3m2wq
         kt7v2oo17GFAEmZ5UC70bciPBkkkN/7vD/oeNnNIdR+ShvqujFTFpuVl6Tbp8rE0k/IU
         qDzZXUJhiuaLpPwjKbpZV4idGtLLRTtZiIfxUOtsXCNN+e0f/yHaRI99nPdME95CivIJ
         WqHw==
X-Gm-Message-State: AHQUAubm9a4j1SJnO2VLhUq85n1TEIvA2xJWLSVk2B3C883qYhLPujY1
        MwVrgoRm4VkNzFRAUr5ldQZU84D7JaNnCQaDnA6reg==
X-Google-Smtp-Source: AHgI3IbVVSznctPJ0NDrUoRVJ/ZZ6cyCKphHa1wrdMfGSJOkRtkYgWp5hpi+22RpXgP/E4C9dIzK0DIX7NQ4QAuW/0o=
X-Received: by 2002:a24:6705:: with SMTP id u5mr10853107itc.114.1550477063453;
 Mon, 18 Feb 2019 00:04:23 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
 <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
 <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com>
 <20190121144628.GA28655@linaro.org> <CAKfTPtCPfRikC2gdZ9m3E3tWE810CfFqoDaNm3FgFVXSMpxqEg@mail.gmail.com>
 <CAJBJEU2gPM+arLpA6bNOqdFRMOO75z6jneGv2EqMxYhhKvS83g@mail.gmail.com>
In-Reply-To: <CAJBJEU2gPM+arLpA6bNOqdFRMOO75z6jneGv2EqMxYhhKvS83g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Feb 2019 09:04:12 +0100
Message-ID: <CAKfTPtAytCk4ZTrhkODCdKkMzif7kjWo4y4i3=YQdjT1v=CD7A@mail.gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     Gabriel Hartmann <gabriel.hartmann@gmail.com>
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

Hi Gabriel,

On Sat, 16 Feb 2019 at 00:06, Gabriel Hartmann
<gabriel.hartmann@gmail.com> wrote:
>
> Hi Vincent,
>
> Apologies for the slow turn around on this.  We have tried both approache=
s to fixing the bug now.  In both cases for a particularly long duration CP=
U intensive workload we are seeing ~33% slowdown.

This was somehow expected because the unused cfs_rq are not removed
anymore but at least the list is correctly ordered with my patch.
the official version of this patch is there:  https://lkml.org/lkml/2019/2/=
4/121
Then, more patches have been queued that removed unused cfs_rq and
keep a correct list ordering: https://lkml.org/lkml/2019/2/6/499

With these 3 patches, the slowdown should disappear and the list
ordering will stay correct

Regards,
Vincent

>
> -- Gabriel
>
> On Fri, Jan 25, 2019 at 6:31 AM Vincent Guittot <vincent.guittot@linaro.o=
rg> wrote:
>>
>> Hi Sargun,
>>
>> On Mon, 21 Jan 2019 at 15:46, Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>> >
>> > Hi Sargun,
>> >
>> > Le Friday 18 Jan 2019 =C3=A0 15:06:28 (+0100), Vincent Guittot a =C3=
=A9crit :
>> > > On Fri, 18 Jan 2019 at 11:16, Vincent Guittot
>> > > <vincent.guittot@linaro.org> wrote:
>> > > >
>> > > > On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wro=
te:
>> > > > >
>> > > > > On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me>=
 wrote:
>> > > > > >
>> > > > > > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fai=
r: Fix
>> > > > > > infinite loop in update_blocked_averages() by reverting a9e7f6=
544b9c
>> > > > > > and put it on top of 4.19.13. In addition to this, I uninlined
>> > > > > > list_add_leaf_cfs_rq for debugging.
>> > >
>> > > With the fix above applied, the code that manages the leaf_cfs_rq_li=
st
>> > > is the same since v4.9.
>> > > Have you noticed similar problem on other older kernel version betwe=
en
>> > > v4.9 and v4.19 ? The problem might have been introduce while modifyi=
ng
>> > > other part of the scheduler like the sequence for adding/removing
>> > > cgroup.
>> > >
>> > > Knowing the most recent kernel version without the problem could hel=
p
>> > > to narrow the problem
>> > >
>> > > Thanks,
>> > > Vincent
>> > >
>> > > > > >
>> > > > > > This revealed a new bug that we didn't get to because we kept =
getting
>> > > > > > crashes from the previous issue. When we are running with cgro=
ups that
>> > > > > > are rapidly changing, with CFS bandwidth control, and in addit=
ion
>> > > > > > using the cpusets cgroup, we see this crash. Specifically, it =
seems to
>> > > > > > occur with cgroups that are throttled and we change the allowe=
d
>> > > > > > cpuset.
>> > > >
>> > > > Thanks for the context, I will try to reproduce the problem and
>> > > > understand how we can stop in the middle of walking to the
>> > > > sched_entity branch with a parent not already added
>> > > >
>> > > > How many cgroup level have you got in you setup ?
>> > > >
>> > > > > >
>> > > > >
>> > > > > This patch from Gabriel should fix the problem:
>> > > > >
>> > > > >
>> > > > > [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
>> > > > >
>> > > > > When a child cfs_rq is added to the leaf cfs_rq list before its =
parent
>> > > > > tmp_alone_branch is set to point to the child in preparation for=
 the
>> > > > > parent being added.
>> > > > >
>> > > > > If the child is deleted before the parent is added then tmp_alon=
e_branch
>> > > > > points to a freed cfs_rq. Any future reference to tmp_alone_bran=
ch will
>> > > > > result in a use after free.
>> > > >
>> > > > So, the patch below is a temporary fix that helps to recover from =
the
>> > > > situation where tmp_alone_branch doesn't finished back to
>> > > > rq->leaf_cfs_rq_list
>> > > > But this situation should not happened at the beginning
>> >
>> > I have been able to reproduce the situation where tmp_alone_branch doe=
sn't
>> > point to rq->leaf_cfs_rq_list after enqueuing a task.
>> >
>> > Can you try the patch below which ensures all cfs_rq of a cgroup branc=
h will
>> > be added in the list even if throttled ?
>>
>> Did you get a chance to test this patch ?
>>
>> Regards,
>> Vincent
>>
>> >
>> > The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes tha=
t
>> > it will walk down to root the 1st time a cfs_rq is used and we will fi=
nished
>> > to add either a cfs_rq without parent or a cfs_rq with a parent that i=
s already
>> > on the list. But this is not always true in presence of throttling.
>> > Because a cfs_rq can be throttled even if it has never been used but o=
ther CPUS
>> > of the cgroup have already used all the bandwdith, we are not sure to =
go down to
>> > the root and add all cfs_rq in the list.
>> >
>> > Ensure that all cfs_rq will be added in the list even if they are thro=
ttled.
>> >
>> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > ---
>> >  kernel/sched/fair.c | 17 +++++++++++++++++
>> >  1 file changed, 17 insertions(+)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 6483834..ae468ab 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cf=
s_rq *cfs_rq)
>> >         }
>> >  }
>> >
>> > +static inline void list_add_branch_cfs_rq(struct sched_entity *se, st=
ruct rq *rq)
>> > +{
>> > +struct cfs_rq *cfs_rq;
>> > +
>> > +       for_each_sched_entity(se) {
>> > +               cfs_rq =3D cfs_rq_of(se);
>> > +               list_add_leaf_cfs_rq(cfs_rq);
>> > +
>> > +               /* If parent is already in the list, we can stop */
>> > +               if (rq->tmp_alone_branch =3D=3D &rq->leaf_cfs_rq_list)
>> > +                       break;
>> > +       }
>> > +}
>> > +
>> >  /* Iterate through all leaf cfs_rq's on a runqueue: */
>> >  #define for_each_leaf_cfs_rq(rq, cfs_rq) \
>> >         list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cf=
s_rq_list)
>> > @@ -5177,6 +5191,9 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
>> >
>> >         }
>> >
>> > +       /* Ensure that all cfs_rq have been added to the list */
>> > +       list_add_branch_cfs_rq(se, rq);
>> > +
>> >         hrtick_update(rq);
>> >  }
>> >
>> >
>> >
>> > > >
>> > > >
>> > > > >
>> > > > > Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
>> > > > > Reported-by: Sargun Dhillon <sargun@sargun.me>
>> > > > > ---
>> > > > >  kernel/sched/fair.c | 5 +++++
>> > > > >  1 file changed, 5 insertions(+)
>> > > > >
>> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > > > > index 7137bc343b4a..0987629cbb76 100644
>> > > > > --- a/kernel/sched/fair.c
>> > > > > +++ b/kernel/sched/fair.c
>> > > > > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(str=
uct
>> > > > > cfs_rq *cfs_rq)
>> > > > >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>> > > > >  {
>> > > > >      if (cfs_rq->on_list) {
>> > > > > +        struct rq *rq =3D rq_of(cfs_rq);
>> > > > > +
>> > > > > +        if (rq->tmp_alone_branch =3D=3D &cfs_rq->leaf_cfs_rq_li=
st)
>> > > > > +            rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
>> > > > > +
>> > > > >          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
>> > > > >          cfs_rq->on_list =3D 0;
>> > > > >      }
