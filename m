Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeEKImZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:42:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeEKImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:42:24 -0400
Date: Fri, 11 May 2018 09:42:19 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180511084219.GD30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180511054315.6jhvg4pveyyeqkws@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511054315.6jhvg4pveyyeqkws@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-May 11:13, Viresh Kumar wrote:
> On 10-05-18, 16:05, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > -static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> >  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
> >  
> > @@ -3762,7 +3736,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  
> >  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
> >  
> > -	cfs_rq_util_change(cfs_rq, flags);
> 
> Was leaving a blank line at the end of routine intentional ?

No, good catch. Will fix this, thanks!

> 
> >  }
> >  
> >  /**
> > @@ -3781,7 +3754,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  
> >  	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
> >  
> > -	cfs_rq_util_change(cfs_rq, 0);
> 
> Here too.
> 
> >  }
> -- 
> viresh

-- 
#include <best/regards.h>

Patrick Bellasi
