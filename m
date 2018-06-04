Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeFDNkA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:40:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeFDNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:39:59 -0400
Date: Mon, 4 Jun 2018 15:39:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
Message-ID: <20180604133953.GU12217@hirez.programming.kicks-ass.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604122336.GS12217@hirez.programming.kicks-ass.net>
 <20180604125939.GB38574@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604125939.GB38574@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 05:59:40AM -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-06-04 14:23:36]:
> 
> > OK, the above matches the description, but I'm puzzled by the remainder:
> >
> > >
> > > -		if (ng->active_nodes > 1 && numa_is_active_node(env.dst_nid, ng))
> > > -			sched_setnuma(p, env.dst_nid);
> > > +		if (nid != p->numa_preferred_nid)
> > > +			sched_setnuma(p, nid);
> > >  	}
> >
> > That seems to entirely loose the active_node thing, or are you saying
> > best_cpu already includes that? (Changelog could use a little help there
> > I suppose)
> 
> I think checking for active_nodes before calling sched_setnuma was a
> mistake.
> 
> Before this change, we may be retaining numa_preferred_nid to be the
> source node while we select another node with better numa affinity to
> run on. So we are creating a situation where we force a thread to run on
> a node which is not going to be its preferred_node. So in the course of
> regular load balancing, this task might then be moved to set
> preferred_node which is actually not the preferred_node.

Then your Changelog had better explain all that, no?
