Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426787AbeBOQ7w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:59:52 -0500
Received: from foss.arm.com ([217.140.101.70]:57856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423536AbeBOQ7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:59:50 -0500
Date: Thu, 15 Feb 2018 16:59:43 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180215165943.GA21994@e110439-lin>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
 <20180215152247.GA25247@e110439-lin>
 <20180215165028.GA25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165028.GA25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Feb 17:50, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 03:22:47PM +0000, Patrick Bellasi wrote:
> > > >  static struct {
> > > >  	cpumask_var_t idle_cpus_mask;
> > > >  	atomic_t nr_cpus;
> > > > +	int has_blocked;		/* Idle CPUS has blocked load */
> > 
> > Why not "bool"?
> > 
> Because then he gets me yelling that sizeof(_Bool) is undefined and the
> whole structure layout goes out the window :-)

Now I know...

> Never use bool in a composite type.

... got a note ;-)

-- 
#include <best/regards.h>

Patrick Bellasi
