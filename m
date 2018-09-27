Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F6CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A32521547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elytriaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32521547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeI0Heo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:34:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44527 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0Hen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:34:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so751168oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+lwzSIZ0+bzYGaZf7fwnmOxPhPWd2pTFfV4nsnha3o=;
        b=elytriaqsjL0/+IO5D0LJGsXS+E3+BTgc0uGW6+uOXRW3GtVxi2z9heguTNooRTBP8
         IbwAbV/6HcA54AlsY701+QaJn0A7Rilw1WRGQPoi5zq4gBdsUQY2EkwbsKTQZ2sGAk2D
         hPzxVUNjYbwdXoYSUHsWclwvLM2MBPi1x9Hc+xXn8Mvh7Xd/vWv3Ar60TKd8GfBf6h/r
         BjvY2V+KfyPm3SrpLRMaeqxbpa0uVvtEYrDR7KRFkOz+0Fiv8+6GMJ/+nkdS+2Llk6lj
         AxAWTNqlyrSMu4HEUH5to9e8ZZAveMw7PgD/hmlhd3U4dYtQRPNUXnvUiYIRzhr3US9q
         vgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+lwzSIZ0+bzYGaZf7fwnmOxPhPWd2pTFfV4nsnha3o=;
        b=Dgk23hV2LIdWQ7w/FE2GaKf6p3ZDeD5IAt94dY+nJ/VsNSFYvxAzN0f+X6TBJ5tlKf
         +W4r/7k30lqUQZUA5D6sjsjP8w8pc5aZq9tAL+peAt4mMk7h0aAoIS2Yr0OkM1P4dJug
         VmTwEKjAto52J2iAn699wiYZjeutHlCi96wQodholA+XG0LCDzgGVyurEdWNJqIgh2tL
         fcWWgjRZzRlE50jY5smzz5VPy6oeA6VPAxxENk05PugOWcq7PjaWZ2Zz3ADIJcWrmH05
         ZxLXM1JNlu353wjDXVRs4qVV2g9e1LasIisGlVu3OeToyDLuTV8mPx0wu6A5LxZoq+pl
         0LbA==
X-Gm-Message-State: ABuFfogNp+CbscGOgAwmIStA/orEOycC48jVCwaMkcCdAJ1zBrWq5hUv
        NZO0lAeKCv58ZuwAPwisdrlFG56P11gT9BDAOoc=
X-Google-Smtp-Source: ACcGV62nU7uGCo0y+LA5/arVdakgqoDG64MBx5t0Y5QR7qCV0RLVIKvFLofmBbbN293JXD5mYcKFl+ELgSgTbnxV4OQ=
X-Received: by 2002:aca:c5c4:: with SMTP id v187-v6mr2152599oif.348.1538011142465;
 Wed, 26 Sep 2018 18:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com> <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com>
In-Reply-To: <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 27 Sep 2018 09:19:00 +0800
Message-ID: <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steve Muckle <smuckle@google.com>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 at 06:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Hi,
>
> On 09/26/2018 11:50 AM, Wanpeng Li wrote:
> > Hi Dietmar,
> > On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
> >>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
> >>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
> >>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>
> [...]
>
> >>>>>>>> - later, when the prio is deboosted and the task is moved back
> >>>>>>>>       to the fair class, the fair rq's min_vruntime is added to
> >>>>>>>>       the task's vruntime, even though it wasn't subtracted earlier.
> >
> > Could you point out when the fair rq's min_vruntime is added to the
> > task's vruntime in your *later* scenario? attach_task_cfs_rq will not
> > do that the same reason as detach_task_cfs_rq. fair task's
> > sched_remote_wakeup is false which results in vruntime will not be
> > renormalized in enqueue_entity.
>
> The cfs_rq->min_vruntime is still added to the se->vruntime in
> enqueue_task_fair().

I understand what your patch done,

On your CPU4:
scheduler_ipi()
 -> sched_ttwu_pending()
      -> ttwu_do_activate()    => p->sched_remote_wakeup should be
false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
           -> ttwu_activate()
                -> activate_task()
                     -> enqueue_task()
                          -> enqueue_task_fair()
                               -> enqueue_entity()
                                    bool renorm = !(flags &
ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
so renorm is false in enqueue_entity(), why you mentioned that the
cfs_rq->min_vruntime is still added to the se->vruntime in
enqueue_task_fair()?

Regards,
Wanpeng Li
