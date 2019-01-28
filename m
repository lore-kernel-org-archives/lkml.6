Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75052C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E521738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX/3otaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfA1WUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:20:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38486 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1WUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:20:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so15741231wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KL00Sa2jpsdtnOzo+vdaTApEMKPIHpzH6AXyKLdmUs=;
        b=dX/3otaTF6JVUyYit9Cinh1tJMT8xRUc95pXev0rJVPoAnHUmiof8C1f6w1202apHA
         gVFM6gVL+w70Nb1hWpEPUJCPyC25BPInQuRCwojKYrrtu+mf1bknYpSnIhaZniDORHI5
         6VUZq0WN2LQ/O+oB+yGySavLM0sXKE6VzOxX04qpeS3C/WICKAKdYUuuuOpcENTX+Ajl
         yE+JAstjC/5e2ncSmlioeHh6xitn6Ae6YWgxsMEt4ltGYF2TJAUqcEctw3S/TwVxweqz
         +2qgvZUUFHFJiIsypLGufvT/FDu4cWcr3O/48hUxs2XUody1guDzaKlQBBvacQ9Kab8u
         OAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KL00Sa2jpsdtnOzo+vdaTApEMKPIHpzH6AXyKLdmUs=;
        b=fz9sYhPhX26CFi+cCguCFsI+GiEtKcdahwyCIHq6Vnf/8ujkCIFT5e/5mTWvNKsUXd
         pqq7GncFj3mmgWtlOnEtCDrZ+JNOyS4HCosmmWcwEy/e9LDF1RbaFZAT1i84XWnrMBbo
         BL/d989WnKerbWs+otO9Z3LzAsiohdpcmZX0aQ3Xw+g5sU1OHKYVeZ1HS96I2Kxkl8O6
         u4I4+yjF0zBUtkaa+q41G0i2reSmC5Ki4vfOPu4aiu7z79CY2Fb975BoiBhKwGV9daDh
         HpvRQCTEL6Se3r9UxgO+7+FP+RJ/BXs0Q+lNOEGDySuzESr2wUtoVQPVIpinXwmkvK/p
         IfDw==
X-Gm-Message-State: AJcUukcMrBDNpWFVoD2c+SLHOMTLI0mienumM1zsl6ZIhrPDd8uoFNtC
        5zKpkwrGvUqbSmc8ekfgNm4QrQahFghheglOGbqq2g==
X-Google-Smtp-Source: ALg8bN4XIKvq/wm++crmJSjRkvwCxeLdqzj8TrbXYZueXL0kxFV4OAJXK1Dsi55UmTYmsV7OBBDCNFPbsgMgjemBR3k=
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr17354530wmc.133.1548714036793;
 Mon, 28 Jan 2019 14:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20190116193501.1910-1-hannes@cmpxchg.org> <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
In-Reply-To: <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 28 Jan 2019 14:20:25 -0800
Message-ID: <CAJuCfpFp_1O8YhEyBjg5mLeRALQDafyv0f7tfSGLxMbp-XQ6dQ@mail.gmail.com>
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

On Mon, Jan 28, 2019 at 2:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
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
>
> Did we ever hear back from Suren about the testing?
>
> Some words here about the new wq_worker_last_func() would be
> appropriate.
>
> It's an ugly-looking thing :(  Tejun, did you check this change?

Yes, sorry for the delay. I tried the patch as is and with some
tweaking of my local setup was able to see the cases when this
mechanism prevents the system from unnecessary reactivation. I
encountered some weird things in my traces (some state transitions
were missing in the trace) and wanted to investigate further, however
did not get a chance to do that yet. Overall looks like the patch is
doing what it's supposed to do. Just wanted to get the full picture
before reporting the results.

> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -124,6 +124,7 @@
> >   * sampling of the aggregate task states would be.
> >   */
> >
> > +#include "../workqueue_internal.h"
>
> "Only to be included by workqueue and core kernel subsystems"
>
> I'm not sure that psi qualifies.  Perhaps wq_worker_last_func() should
> be declared in include/linux/workqueue.h.
>
> And perhaps implemented there as well.  It's similar to
> current_wq_worker(), which is inlined and wq_worker_last_func() is
> small enough to justify inlining.
>
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -909,6 +909,26 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
> >       return to_wakeup ? to_wakeup->task : NULL;
> >  }
> >
> > +/**
> > + * wq_worker_last_func - retrieve worker's last work function
> > + *
> > + * Determine the last function a worker executed. This is called from
> > + * the scheduler to get a worker's last known identity.
> > + *
> > + * CONTEXT:
> > + * spin_lock_irq(rq->lock)
> > + *
> > + * Return:
> > + * The last work function %current executed as a worker, NULL if it
> > + * hasn't executed any work yet.
> > + */
> > +work_func_t wq_worker_last_func(struct task_struct *task)
> > +{
> > +     struct worker *worker = kthread_data(task);
> > +
> > +     return worker->last_func;
> > +}
>
> The semantics are troublesome.  What guarantees that worker->last_func
> won't change under the caller's feet?  The caller should hold some lock
> (presumably worker->pool->lock) in order to stabilize the
> wq_worker_last_func() return value?
>
> Also, the comment isn't really true - this is called from PSI, which is
> hardly "the scheduler"?
>
>
