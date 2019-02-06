Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F67C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955FA2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yomxc3ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfBFCvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:51:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34039 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:51:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so714507wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 18:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KpckL251BnDQ49dTdykZYRulEXUqhwHnii8N+nrLDg=;
        b=Yomxc3nimH1mOtkYijpjOJCMQSYXAYvp0kMusntYfM7tGBabX7kuF6UXnjRzjvWWOa
         80/3plFrHSRKZ6ghgyR2Pw0hh7rUnPIbuT9sd2MNAR7h6RsyWqGWPlbo5sUR4jp7bALQ
         t/U9NJTOvUHoqa8ycY+DlXy2gYpLXRuRqVfTVkGULOBrOB8FhgQydl1IrsCE6qpCV+ZM
         SPRUtTStO6EFv947MQIbrdrNjJv8AmH62026R7QWOQouH2TMOGUL5kJTcpykocye+Qka
         u7V55VonPFGFQFpTmSaLeCIq0V6iv90ukUf+E00wpl3UdYToXtG6mfyVxC3waByOS3GV
         4s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KpckL251BnDQ49dTdykZYRulEXUqhwHnii8N+nrLDg=;
        b=cMJScFaPC6GgrpWhrdO2FwtIL7IffJ8r8N2UY8oCPde0J4kLaA4JqqKcgxFklGeJ7D
         VohKnBwGVCn3cG8+1TXk0THNPe81WR/FQ+oJXZZQ+yepX9UlyYZqa1VQnWL4Yson36F2
         ymjtyeWTVmBeFX1C4dPFN8PDcrHJM3SANW/SDReJo8X/KzJlPwtjDWd6IiXXZGKDOUfu
         Qiz/b13d73oUIKdipm/Z1hyCewLnfF1m9GCozTXBl/AGqxo1zIPozp0149UgsGS3/8BE
         cWLhivqTPbgUu/KD382dIBPRNn9IwC1H9bVaq5ZBR4bQbrGa5PnmNyslv2cNBXQJHaDP
         EAdw==
X-Gm-Message-State: AHQUAua3/mciNTVAW9Ex0BHdFwYjjs4TqAVK6LS7Wbdryb5czVHgIagb
        5OtCjzoED1AqfZqs+LshkU6sp9SwfFiT12+CQQhqMA==
X-Google-Smtp-Source: AHgI3IaITE/fS1JrKQeZ1Rszba8NWMV9uYHbyWeBNAJNjhRbtJbKYaC76vFr9a2Z18ipMI0xwn36ywPD83HhEMbh0GQ=
X-Received: by 2002:a1c:c7:: with SMTP id 190mr1239785wma.74.1549421471121;
 Tue, 05 Feb 2019 18:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20190116193501.1910-1-hannes@cmpxchg.org> <20190128150635.c22842034ab7e271c6416d2f@linux-foundation.org>
In-Reply-To: <20190128150635.c22842034ab7e271c6416d2f@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 5 Feb 2019 18:50:59 -0800
Message-ID: <CAJuCfpHzMit4w4jEboSdJSZ=ETRoCH_buFmUomuu+m===Yv1iA@mail.gmail.com>
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

Hi Andrew,

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

I resolved the conflict with "psi: introduce psi monitor" patch and
posted v4 at https://lore.kernel.org/lkml/20190206023446.177362-1-surenb@google.com,
however please be advised that it also includes additional cleanup
changes yet to be reviewed.
The first 4 patches in this series are already in linux-next, so this
one should apply cleanly there. Please let me know if it creates any
other issues.
Thanks,
Suren.
