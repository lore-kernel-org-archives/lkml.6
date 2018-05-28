Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeE1QLM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:11:12 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:59148 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeE1QLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:11:05 -0400
Date: Mon, 28 May 2018 09:10:17 -0700
From: Paul Burton <paul.burton@mips.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] sched: Make select_task_rq() require cpu_active()
 for user tasks
Message-ID: <20180528161017.ttgdusrzypvkga5w@pburton-laptop>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-2-paul.burton@mips.com>
 <20180528144924.GE12217@hirez.programming.kicks-ass.net>
 <20180528154516.c54b37ygekcn3p4g@pburton-laptop>
 <20180528155306.GU12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180528155306.GU12180@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527523818-637137-26662-297717-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193454
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, May 28, 2018 at 05:53:06PM +0200, Peter Zijlstra wrote:
> On Mon, May 28, 2018 at 08:45:16AM -0700, Paul Burton wrote:
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1562,7 +1562,7 @@ int select_task_rq(struct task_struct *p
> > >  	 *   not worry about this generic constraint ]
> > >  	 */
> > >  	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> > > -		     !cpu_online(cpu)))
> > > +		     (is_per_cpu_kthread(p) ? !cpu_online(cpu) : !cpu_active(cpu)))
> > >  		cpu = select_fallback_rq(task_cpu(p), p);
> > >  
> > >  	return cpu;
> > 
> > Yes this looks good to me.
> > 
> > Are you planning to submit your change to introduce
> > is_per_cpu_kthread(), or shall I?
> 
> I've got the lot; I just need to write a better changelog for my old
> (now rebased) patch and make a small note in your patch, but will feed
> them to Ingo when done.

Thanks a bunch!

Paul
