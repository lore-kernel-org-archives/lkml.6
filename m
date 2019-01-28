Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D700C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D72D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4Wmij+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfA1XLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:11:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32986 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1XLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:11:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so20074301wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLzsVhMnW180bMhupK9gGFeM1Lcu8y9rNNOTmdWbJ8U=;
        b=v4Wmij+7KbgBG9U7bWPnCDkA7fd4rQk9Qc/nvmM/cgtbmouHXI/PAB37Zbf5xZxNV+
         OOBW7PLK7oyT/8M7T+6TCslS+Tqx4bNddguefM80gwX13NN/bpEHSkROcyk2uVmitNrS
         dSIw6HteEqpv0ULPoasUJaDN1yC8ST5v0P3c4TTfHoiYBuCEifDRK7k3RHiZX2RNUBl2
         ZVfYV6+RKhbw83PeoG81iUOt6fKS15QaX3Dh26k45xzns40EzqgdJ39oBD/Tlvgw/nYU
         wctzNyw+kjIoAApReMdpnjty6+z2aV8IUJMOBlL8bX9Y6zTB8A3JwZgulQU/YVYqYLvV
         h9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLzsVhMnW180bMhupK9gGFeM1Lcu8y9rNNOTmdWbJ8U=;
        b=W9S0V/Q9eW6lHU7yb9LqsGazt6l/AbL+V9Pd+2YCV0PVK4NcNif/dFRA0RMDRAvO7r
         Glos2cjDJkXNKMeCENQaBQT2QHfFqd9boI2GbCxSsuOBsYUaO6yG2ZeG5qacF4Bwu9gO
         BCkMKCEMMD9CA/qQZR8IPipLg0S98LFj7nv+GWo4zGAiQb5rb4menuHfjL4xkd8EL8+K
         7s9Ad7ainfJVHSn3oLP3upVGgEpfxMOE8b9/1jxBh0g7EZt+WRkV98SEg840fnKIcfdA
         jB7NxRxaSqjGqpPzQsrJpY461E1lkLrFCQZTCvb6ysQehYMCHpJ6ezKcYoXnTuaNreaU
         q3qg==
X-Gm-Message-State: AJcUuke8G7rffGLM/E9z+BxIxAqJ/JvLmIMSshtOOSceUk0ARf073/za
        9TsOy9s8/aFLoAoGng0RFGdEh+sRq6+A7ReqQyYHNlfaPR1TFA==
X-Google-Smtp-Source: ALg8bN4AsaRiwRTa4wA3BNaqO6t5vaK58ZRbV6yjkIFm22nJZUg8IcDwK0YsFS0BJQv+sxYeAaHNMneMZ9IPpVIhyP4=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr22991452wru.291.1548717066355;
 Mon, 28 Jan 2019 15:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20190116193501.1910-1-hannes@cmpxchg.org> <20190128150635.c22842034ab7e271c6416d2f@linux-foundation.org>
In-Reply-To: <20190128150635.c22842034ab7e271c6416d2f@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 28 Jan 2019 15:10:55 -0800
Message-ID: <CAJuCfpGJ=MzQf1vs2pAL=b6u+ZcyNBSNCwxcv_zTmFuvQgmgzg@mail.gmail.com>
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 16 Jan 2019 14:35:01 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> > psi has provisions to shut off the periodic aggregation worker when
> > there is a period of no task activity - and thus no data that needs
> > aggregating. However, while developing psi monitoring, Suren noticed
> > that the aggregation clock currently won't stay shut off for good.
> >
> > Debugging this revealed a flaw in the idle design: an aggregation run
> > will see no task activity and decide to go to sleep; shortly
> > thereafter, the kworker thread that executed the aggregation will go
> > idle and cause a scheduling change, during which the psi callback will
> > kick the !pending worker again. This will ping-pong forever, and is
> > equivalent to having no shut-off logic at all (but with more code!)
> >
> > Fix this by exempting aggregation workers from psi's clock waking
> > logic when the state change is them going to sleep. To do this, tag
> > workers with the last work function they executed, and if in psi we
> > see a worker going to sleep after aggregating psi data, we will not
> > reschedule the aggregation work item.
> >
> > What if the worker is also executing other items before or after?
> >
> > Any psi state times that were incurred by work items preceding the
> > aggregation work will have been collected from the per-cpu buckets
> > during the aggregation itself. If there are work items following the
> > aggregation work, the worker's last_func tag will be overwritten and
> > the aggregator will be kept alive to process this genuine new activity.
> >
> > If the aggregation work is the last thing the worker does, and we
> > decide to go idle, the brief period of non-idle time incurred between
> > the aggregation run and the kworker's dequeue will be stranded in the
> > per-cpu buckets until the clock is woken by later activity. But that
> > should not be a problem. The buckets can hold 4s worth of time, and
> > future activity will wake the clock with a 2s delay, giving us 2s
> > worth of data we can leave behind when disabling aggregation. If it
> > takes a worker more than two seconds to go idle after it finishes its
> > last work item, we likely have bigger problems in the system, and
> > won't notice one sample that was averaged with a bogus per-CPU weight.
> >
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -480,9 +481,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >                       groupc->tasks[t]++;
> >
> >       write_seqcount_end(&groupc->seq);
> > -
> > -     if (!delayed_work_pending(&group->clock_work))
> > -             schedule_delayed_work(&group->clock_work, PSI_FREQ);
> >  }
> >
> >  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>
> This breaks Suren's "psi: introduce psi monitor":
>
> --- kernel/sched/psi.c~psi-introduce-psi-monitor
> +++ kernel/sched/psi.c
> @@ -752,8 +1012,25 @@ static void psi_group_change(struct psi_
>
>         write_seqcount_end(&groupc->seq);
>
> -       if (!delayed_work_pending(&group->clock_work))
> -               schedule_delayed_work(&group->clock_work, PSI_FREQ);
> +       /*
> +        * Polling flag resets to 0 at the max rate of once per update window
> +        * (at least 500ms interval). smp_wmb is required after group->polling
> +        * 0-to-1 transition to order groupc->times and group->polling writes
> +        * because stall detection logic in the slowpath relies on groupc->times
> +        * changing before group->polling. Explicit smp_wmb is missing because
> +        * cmpxchg() implies smp_mb.
> +        */
> +       if ((state_mask & group->trigger_mask) &&
> +               atomic_cmpxchg(&group->polling, 0, 1) == 0) {
> +               /*
> +                * Start polling immediately even if the work is already
> +                * scheduled
> +                */
> +               mod_delayed_work(system_wq, &group->clock_work, 1);
> +       } else {
> +               if (!delayed_work_pending(&group->clock_work))
> +                       schedule_delayed_work(&group->clock_work, PSI_FREQ);
> +       }
>  }
>
> and I'm too lazy to go in and figure out how to fix it.
>
> If we're sure about "psi: fix aggregation idle shut-off" (and I am not)
> then can I ask for a redo of "psi: introduce psi monitor"?

Yes, I'll redo it after applying "psi: fix aggregation idle shut-off".
I have to repost it anyway to address the comment from Johannes.
