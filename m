Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD85C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683442083D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+B1LuK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683442083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeGaFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:10:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36438 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGaFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:10:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so25316266oig.3;
        Mon, 30 Jul 2018 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lOjUy1TkEaoDnWGD0SY+vArFlkVZWuzFedM0ZXNf6I=;
        b=G+B1LuK6Yeo9KMT1TYTQjYoS0FDQUOnozF5CSzdtuQVmbEaMUsNcDMM6go6QOOlk3P
         pdaxxdtcJ52mh6joBaUey/LDDp5+hoEyUqI30Ho9OQlyTq7s8NgafZer51ypyr2i1QOp
         z2qeGJmeyk1Lv7oSpw+3uraEomLsg5bTVYVc87zuyzAbt8EA2yioB7g1NtfnBRY/hp4P
         TDQ5wfAHQrXBvpODSEdxShnaCY8tea7FiVlpVxIb6nA3nNACZwmHOaWZdFpFqp5KcEDf
         IbU2opcq7BoXeZ8uYvFIjRxSrEi09Pe8brqS0ooKdaxPSliiS2Zkigsz9V8qJEn8IOQX
         ebSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lOjUy1TkEaoDnWGD0SY+vArFlkVZWuzFedM0ZXNf6I=;
        b=aMWFm224uZ2Q+kjY+p7QWMplGkTzzn8EcxYX914vSgvJbzq1H9uTVZnzBf/0ZsPEMD
         o754qqK/lgjrtYqo2dlAvZVd0cPcwmhZ6GiTTh4Fe/X7gIK1kEv/lZqj2XhgxRWGWoIy
         9Yg9P2hkOkjyPv2lxVyHefi9zhlxxfrsKajh3b24waBHcthxShdjOzGVpCC7HXzw7vk2
         13LxE9tJ659vaHMRPkjI44duyUcZbQRJI0uqwUt1PsrZ8YJSvA+3QuyuTSAeuRQZF9Qh
         eoAFCaTkUDu6nddQFrqhPgoyRb+G+qoupezP0h0IdjmGDbNgYYmWu+8x7wgnZ/pkke/+
         9H/Q==
X-Gm-Message-State: AOUpUlHtbAiRCGS2Z+lvQwdku8D2D/Bp0j5uhnITmp++oqoydGc1xvUo
        nPfb433v/o60dnJ5DApgKRy0t3DwOdm67kGmc14=
X-Google-Smtp-Source: AAOMgpdTyGqVBXoiCEMnAbps8TYI4dHdXQ7NCTSEfxJyE1oD++BU44liWVz8BB/7nUje4S5OvDseG+y7AHuQ7GKpS2E=
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr21630113oib.186.1533007964019;
 Mon, 30 Jul 2018 20:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org>
 <CANRm+Cz0-61-WOT8CLf02G-aHEwrff6WVWd6mp0DKV+GfFyvWw@mail.gmail.com> <CAKfTPtBMSvfLYAZz6p+uj0G2uq87QzXBOnTHMmzV=niwd0nMjA@mail.gmail.com>
In-Reply-To: <CAKfTPtBMSvfLYAZz6p+uj0G2uq87QzXBOnTHMmzV=niwd0nMjA@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 31 Jul 2018 11:32:38 +0800
Message-ID: <CANRm+Cw7Rg1mFgqAzbS-72z=RZ4mBV_vp=0obC7YPyR5ZdqXVA@mail.gmail.com>
Subject: Re: [PATCH 06/11] sched/irq: add irq utilization tracking
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, juri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        valentin.schneider@arm.com,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        joel@joelfernandes.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@arm.com, Luca Abeni <luca.abeni@santannapisa.it>,
        claudio@evidence.eu.com, Ingo Molnar <mingo@redhat.com>,
        kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 00:43, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Wanpeng,
>
> On Thu, 26 Jul 2018 at 05:09, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > Hi Vincent,
> > On Fri, 29 Jun 2018 at 03:07, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > interrupt and steal time are the only remaining activities tracked by
> > > rt_avg. Like for sched classes, we can use PELT to track their average
> > > utilization of the CPU. But unlike sched class, we don't track when
> > > entering/leaving interrupt; Instead, we take into account the time spent
> > > under interrupt context when we update rqs' clock (rq_clock_task).
> > > This also means that we have to decay the normal context time and account
> > > for interrupt time during the update.
> > >
> > > That's also important to note that because
> > >   rq_clock == rq_clock_task + interrupt time
> > > and rq_clock_task is used by a sched class to compute its utilization, the
> > > util_avg of a sched class only reflects the utilization of the time spent
> > > in normal context and not of the whole time of the CPU. The utilization of
> > > interrupt gives an more accurate level of utilization of CPU.
> > > The CPU utilization is :
> > >   avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq
> > >
> > > Most of the time, avg_irq is small and neglictible so the use of the
> > > approximation CPU utilization = /Sum avg_rq was enough
> > >
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/core.c  |  4 +++-
> > >  kernel/sched/fair.c  | 13 ++++++++++---
> > >  kernel/sched/pelt.c  | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  kernel/sched/pelt.h  | 16 ++++++++++++++++
> > >  kernel/sched/sched.h |  3 +++
> > >  5 files changed, 72 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 78d8fac..e5263a4 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -18,6 +18,8 @@
> > >  #include "../workqueue_internal.h"
> > >  #include "../smpboot.h"
> > >
> > > +#include "pelt.h"
> > > +
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/sched.h>
> > >
> > > @@ -186,7 +188,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> > >
> > >  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > >         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> > > -               sched_rt_avg_update(rq, irq_delta + steal);
> > > +               update_irq_load_avg(rq, irq_delta + steal);
> >
> > I think we should not add steal time into irq load tracking, steal
> > time is always 0 on native kernel which doesn't matter, what will
> > happen when guest disables IRQ_TIME_ACCOUNTING and enables
> > PARAVIRT_TIME_ACCOUNTING? Steal time is not the real irq util_avg. In
> > addition, we haven't exposed power management for performance which
> > means that e.g. schedutil governor can not cooperate with passive mode
> > intel_pstate driver to tune the OPP. To decay the old steal time avg
> > and add the new one just wastes cpu cycles.
>
> In fact, I have kept the same behavior as with rt_avg, which was
> already adding steal time when computing scale_rt_capacity, which is
> used to reflect the remaining capacity for FAIR tasks and is used in
> load balance. I'm not sure that it's worth using different variables
> for irq and steal.
> That being said, I see a possible optimization in schedutil when
> PARAVIRT_TIME_ACCOUNTING is enable and IRQ_TIME_ACCOUNTING is disable.
> With this kind of config, scale_irq_capacity can be a nop for
> schedutil but scales the utilization for scale_rt_capacity

Yeah, this is what in my mind before, you can make a patch for that. :)

Regards,
Wanpeng Li
