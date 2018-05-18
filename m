Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeERKRq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:17:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47208 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbeERKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:17:43 -0400
Date: Fri, 18 May 2018 11:17:38 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, yuyang.du@intel.com, pjt@google.com,
        bsegall@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
Message-ID: <20180518101738.GM30654@e110439-lin>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
 <20180518093638.GL12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518093638.GL12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-May 11:36, Peter Zijlstra wrote:
> 
> Replying to the latest version available; given the current interest I
> figure I'd re-read some of the old threads and look at this stuff again.
> 
> On Fri, Apr 28, 2017 at 04:23:55PM +0200, Vincent Guittot wrote:
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0978fb7..f8dde36 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -313,6 +313,7 @@ struct load_weight {
> >   */
> >  struct sched_avg {
> >  	u64				last_update_time;
> > +	u64				stolen_idle_time;
> >  	u64				load_sum;
> >  	u32				util_sum;
> >  	u32				period_contrib;
> 
> Right, so sadly Patrick stole that space with the util_est bits.

Sorry :(

However, I remember we already talked about the idea to
update load_avg and runnable_load_avg to use u32:

   https://marc.info/?l=linux-kernel&m=151334269426419&w=2

-- 
#include <best/regards.h>

Patrick Bellasi
