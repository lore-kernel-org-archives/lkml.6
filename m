Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68416C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2BC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2BC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeILWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:50:37 -0400
Received: from foss.arm.com ([217.140.101.70]:36694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeILWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:50:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406437A9;
        Wed, 12 Sep 2018 10:45:02 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7183B3F557;
        Wed, 12 Sep 2018 10:44:59 -0700 (PDT)
Date:   Wed, 12 Sep 2018 18:44:56 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180912174456.GJ1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
 <20180912173421.GX24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912173421.GX24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Sep 19:34, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 72df2dc779bc..513608ae4908 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -764,6 +764,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
> >  #endif
> >  #endif /* CONFIG_SMP */
> >  
> > +#ifdef CONFIG_UCLAMP_TASK
> > +/**
> > + * struct uclamp_group - Utilization clamp Group
> > + * @value: utilization clamp value for tasks on this clamp group
> > + * @tasks: number of RUNNABLE tasks on this clamp group
> > + *
> > + * Keep track of how many tasks are RUNNABLE for a given utilization
> > + * clamp value.
> > + */
> > +struct uclamp_group {
> > +	int value;
> > +	int tasks;
> > +};
> 
> We could use bit fields again to compress in 10:22 bits I suppose. 4M
> tasks is quite a lot to have runnable on a single CPU ;-)

If you say saw, it's ok with me... my Android phone can (yet) run so
many ;)

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
