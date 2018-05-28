Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425196AbeE1PxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:53:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425182AbeE1PxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:53:19 -0400
Date: Mon, 28 May 2018 17:53:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] sched: Make select_task_rq() require cpu_active()
 for user tasks
Message-ID: <20180528155306.GU12180@hirez.programming.kicks-ass.net>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-2-paul.burton@mips.com>
 <20180528144924.GE12217@hirez.programming.kicks-ass.net>
 <20180528154516.c54b37ygekcn3p4g@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528154516.c54b37ygekcn3p4g@pburton-laptop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:45:16AM -0700, Paul Burton wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1562,7 +1562,7 @@ int select_task_rq(struct task_struct *p
> >  	 *   not worry about this generic constraint ]
> >  	 */
> >  	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> > -		     !cpu_online(cpu)))
> > +		     (is_per_cpu_kthread(p) ? !cpu_online(cpu) : !cpu_active(cpu)))
> >  		cpu = select_fallback_rq(task_cpu(p), p);
> >  
> >  	return cpu;
> 
> Yes this looks good to me.
> 
> Are you planning to submit your change to introduce
> is_per_cpu_kthread(), or shall I?

I've got the lot; I just need to write a better changelog for my old
(now rebased) patch and make a small note in your patch, but will feed
them to Ingo when done.
