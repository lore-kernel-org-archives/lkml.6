Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADBE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEKjLenX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADBE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeIZQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:03:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40425 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:03:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id g14-v6so13910792otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UNz3oRZjb+c2BUIGIK4jcLgE/3H08EPW634lvVLcUw=;
        b=bEKjLenXjS+lvqvSKkXx276Bj92q3k3BTFZjfsUR/hNFyHvTVj6qlmmR/BRz6G0kks
         86ETbCimkL5GaQa6FDv0op+R8NYOS5nJY5wVHyzMGJmxa2mQHlJCaQqljNct5PWxSuv0
         CrLAtr0BIuWlk8yUy1iKcLTlVRzLXKXbIlIiHcpYbQ7l4WIz814kKf6b98wP8ulV7yJ1
         0CqZHMjheGb40uL48B/WU2mWPOjUKBtr/uFKHt4uQvMpHkP2WJOA3izoJtHicE8l6QNw
         Ori/l83c6w+VAHR+FiZI2dUwlkb/HdTN1QDcmg/A5PGGFZDjSan9JtoTODOFYaP1yJq4
         +/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UNz3oRZjb+c2BUIGIK4jcLgE/3H08EPW634lvVLcUw=;
        b=ocwEJ+rH0m239K6DOCtp5UpoRtF8Ex1R0ZhtxyQcdTd2AA03YX6yPttKT6J90QvUuc
         mtkWR1TT5q4Y4wgaWjF+DNI52zpGC1W1ricPLjmFeeb8S81CIaVX4d4qAGIPYxsL1pVq
         OYcwcpw3XDbmdNaT9TQUH8Tp7AYjyqWlFL/L9htt096Srb05e+vdiWTwDzZkUBhRwOM3
         iFvm6ODysj57Xk6U9NCTZGywfX8JT6niQDGVR1Nt2J1qcNZR8H2pKTiBWDmmCrVSnBvM
         upzmvynnzV0MCn5msviUWXb2PYaXRq0hyiYd1r33WHL78UhBCk/2XtLS75QDL1d4sYWI
         /EFw==
X-Gm-Message-State: ABuFfohayqNJnxuRpKj96HC3+RsbrjzZwyut4tXCv4KT94nonx2aFkg7
        +jah4MgNBGyt5k+aZEW3PxaAvxE6gtQxZ1sje4o=
X-Google-Smtp-Source: ACcGV62DkWaUqz4YB+3bvKSDXydETw7mQAPk1y98IpHURsEqAYpEiYEHHWau/lDEam+2M0wmiQOxhzNvmDkGGeos+kc=
X-Received: by 2002:a9d:5d7:: with SMTP id 81-v6mr3814152otd.262.1537955456558;
 Wed, 26 Sep 2018 02:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
In-Reply-To: <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 26 Sep 2018 17:50:52 +0800
Message-ID: <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, smuckle@google.com,
        migueldedios@google.com, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        joaodias@google.com, Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,
On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
> > On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
> >> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
> >>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
> >>>
> >>>>>> When rt_mutex_setprio changes a task's scheduling class to RT,
> >>>>>> we're seeing cases where the task's vruntime is not updated
> >>>>>> correctly upon return to the fair class.
> >>>
> >>>>>> Specifically, the following is being observed:
> >>>>>> - task is deactivated while still in the fair class
> >>>>>> - task is boosted to RT via rt_mutex_setprio, which changes
> >>>>>>      the task to RT and calls check_class_changed.
> >>>>>> - check_class_changed leads to detach_task_cfs_rq, at which point
> >>>>>>      the vruntime_normalized check sees that the task's state is TASK_WAKING,
> >>>>>>      which results in skipping the subtraction of the rq's min_vruntime
> >>>>>>      from the task's vruntime

> >>>>>> - later, when the prio is deboosted and the task is moved back
> >>>>>>      to the fair class, the fair rq's min_vruntime is added to
> >>>>>>      the task's vruntime, even though it wasn't subtracted earlier.

Could you point out when the fair rq's min_vruntime is added to the
task's vruntime in your *later* scenario? attach_task_cfs_rq will not
do that the same reason as detach_task_cfs_rq. fair task's
sched_remote_wakeup is false which results in vruntime will not be
renormalized in enqueue_entity.

Regards,
Wanpeng Li

> >>>
> >>> I'm thinking that is an incomplete scenario; where do we get to
> >>> TASK_WAKING.
> >>
> >> Yes there's a missing bit of context here at the beginning that the task to
> >> be boosted had already been put into TASK_WAKING.
> >
> > See, I'm confused...
> >
> > The only time TASK_WAKING is visible, is if we've done a remote wakeup
> > and it's 'stuck' on the remote wake_list. And in that case we've done
> > migrate_task_rq_fair() on it.
> >
> > So by the time either rt_mutex_setprio() or __sched_setscheduler() get
> > to calling check_class_changed(), under both pi_lock and rq->lock, the
> > vruntime_normalized() thing should be right.
> >
> > So please detail the exact scenario. Because I'm not seeing it.
>
> Using Steve's test program (https://lkml.org/lkml/2018/8/24/686) I see the
> issue but only if the two tasks (rt_task, fair_task) run on 2 cpus which
> don't share LLC (e.g. CPU0 and CPU4 on hikey960).
>
> So the wakeup goes the TTWU_QUEUE && !share_cache (ttwu_queue_remote) path.
>
> ...
> rt_task-3579  [000] 35.391573: sched_waking:     comm=fair_task pid=3580 prio=120 target_cpu=004
> rt_task-3579  [000] 35.391580: bprint:           try_to_wake_up: try_to_wake_up: task=fair_task pid=3580 task_cpu(p)=4 p->on_rq=0
> rt_task-3579  [000] 35.391584: bprint:           try_to_wake_up: ttwu_queue: task=fair_task pid=3580
> rt_task-3579  [000] 35.391588: bprint:           try_to_wake_up: ttwu_queue_remote: task=fair_task pid=3580
> rt_task-3579  [000] 35.391591: bprint:           try_to_wake_up: ttwu_queue_remote: cpu=4 smp_send_reschedule
> rt_task-3579  [000] 35.391627: sched_pi_setprio: comm=fair_task pid=3580 oldprio=120 newprio=19
> rt_task-3579  [000] 35.391635: bprint:           rt_mutex_setprio: task=fair_task pid=3580 prio=120->19 queued=0 running=0 state=0x200 vruntime=46922871 cpu=4 cfs_rq->min_vruntime=7807420844
> rt_task-3579  [000] 35.391641: bprint:           rt_mutex_setprio: p->prio set: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
> rt_task-3579  [000] 35.391646: bprint:           rt_mutex_setprio: queued checked: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
> rt_task-3579  [000] 35.391652: bprint:           rt_mutex_setprio: running checked: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
> rt_task-3579  [000] 35.391657: bprint:           rt_mutex_setprio: fair_class=0xffff000008da2c80 rt_class=0xffff000008da2d70 prev_class=0xffff000008da2c80 p->sched_class=0xffff000008da2d70 oldprio=120 p->prio=19
> rt_task-3579  [000] 35.391661: bprint:           detach_task_cfs_rq: task=fair_task pid=3580 cpu=4 vruntime_normalized=1
> rt_task-3579  [000] 35.391706: sched_switch:     rt_task:3579 [19] D ==> swapper/0:0 [120]
>  <idle>-0     [004] 35.391828: bprint:           ttwu_do_activate: ttwu_do_activate: task=fair_task pid=3580
>  <idle>-0     [004] 35.391832: bprint:           ttwu_do_activate: ttwu_activate: task=fair_task pid=3580
>  <idle>-0     [004] 35.391833: bprint:           ttwu_do_wakeup: ttwu_do_wakeup: task=fair_task pid=3580
>  <idle>-0     [004] 35.391834: sched_wakeup:     fair_task:3580 [19] success=1 CPU:004
>
> It doesn't happen on hikey960 when I use two cpus of the same LLC or on my
> laptop (i7-4750HQ).
