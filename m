Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeDFQXt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:23:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeDFQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:23:47 -0400
Date: Fri, 6 Apr 2018 18:23:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: sched_rt_period_timer causing large latencies
Message-ID: <20180406162342.GL4082@hirez.programming.kicks-ass.net>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
 <20180405082701.GL4082@hirez.programming.kicks-ass.net>
 <1522917620.5593.5.camel@gmx.de>
 <20180405200859.19fceb95@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405200859.19fceb95@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 08:08:59PM +1000, Nicholas Piggin wrote:
> On Thu, 05 Apr 2018 10:40:20 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Thu, 2018-04-05 at 10:27 +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 05, 2018 at 09:11:38AM +1000, Nicholas Piggin wrote:  
> > > > Hi,
> > > > 
> > > > I'm seeing some pretty big latencies on a ~idle system when a CPU wakes
> > > > out of a nohz idle. Looks like it's due to the taking a lot of remote
> > > > locks and cache lines. irqoff trace:  
> > > 
> > > On RT I think we default RT_RUNTIME_SHARE to false, maybe we should do
> > > the same for mainline.  
> > 
> > Probably.  My very first enterprise encounter with the thing was it NOT
> > saving a box from it's not so clever driver due to that.
> 
> Well I would think a simpler per-cpu limiter might actually stand a
> better chance of saving you there. Or even something attached to the
> softlockup watchdog.
> 
> I'm still getting a lot of locks coming from sched_rt_period_timer
> with RT_RUNTIME_SHARE false, it's just that it's now down to about
> NR_CPUS locks rather than 3*NR_CPUS.

Argh, right you are. I had a brief look at what it would take to fix
that, and while it's not completely horrible, it takes a bit of effort.

I'm currently a bit tied up with things, but I'll try not to forget.
