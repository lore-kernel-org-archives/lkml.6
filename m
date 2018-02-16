Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeBPJt3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:49:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBPJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:49:28 -0500
Date: Fri, 16 Feb 2018 10:49:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] sched: Rename root_domain->overload to
 should_idle_balance
Message-ID: <20180216094922.GY25201@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-7-git-send-email-morten.rasmussen@arm.com>
 <20180216091402.GF8032@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216091402.GF8032@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:14:02AM +0100, Juri Lelli wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 7d324b706e67..4215438667e5 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -650,8 +650,12 @@ struct root_domain {
> >  	cpumask_var_t span;
> >  	cpumask_var_t online;
> >  
> > -	/* Indicate more than one runnable task for any CPU */
> > -	bool overload;
> > +	/*
> > +	 * Indicate whether the idle balance can be used to solve
> > +	 * imbalance within the root domain.
> > +	 * e.g. There is more than one runnable task for any CPU
> > +	 */
> > +	bool should_idle_balance;
> 
> Current name is however consistent with RT/DL's naming convention

Yeah, not a fan either. We've consistently used the term to mean
nr_running>1. The thing to fix there is the stupid bool, not the name.
