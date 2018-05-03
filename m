Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeECRzN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:55:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:55:11 -0400
Date: Thu, 3 May 2018 19:54:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503175456.GI12217@hirez.programming.kicks-ass.net>
References: <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
 <20180503161231.GI26088@linux.vnet.ibm.com>
 <20180503164508.GG12217@hirez.programming.kicks-ass.net>
 <20180503171850.GL26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503171850.GL26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 10:18:50AM -0700, Paul E. McKenney wrote:
> > +	if (per_cpu(rcu_cpu_started, cpu))
> 
> I would log a non-splat dmesg the first time this happened, just for my
> future sanity, but otherwise looks fine.  I am a bit concerned about
> calls to rcu_cpu_starting() getting sprinkled all through the code.
> Or am I being excessively paranoid?

Don't think so, but lets first see if this at all works. If not we'll
need to figure out something else anyway.
