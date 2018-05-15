Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeEOSPV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:15:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeEOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:15:19 -0400
Date: Tue, 15 May 2018 20:15:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515181510.GM12235@hirez.programming.kicks-ass.net>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
 <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
 <20180515171021.GI12217@hirez.programming.kicks-ass.net>
 <20180515175307.m4xbkbicdrzo4qhb@lakrids.cambridge.arm.com>
 <20180515181136.GR12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515181136.GR12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:11:36PM +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 06:53:08PM +0100, Mark Rutland wrote:

> > > > # name	meta	args...
> > > > #
> > > > # Where meta contains a string of:
> > > > # * B - bool: returns bool, fully ordered
> > > > # * V - void: returns void, fully ordered
> > > > # * I - int: returns base type, all orderings
> > > > # * R - return: returns base type, all orderings
> > > > # * F - fetch: returns base type, all orderings
> > > > # * T - try: returns bool, all orderings
> > > 
> > > Little more verbose than mine, I think we can get there with X and XB
> > > instead of I and T, but whatever :-)
> > 
> > Mhmm. I found it easier to do switch-like things this way, but it works
> > regardless.
> 
> I'm a minimalist, but yeah whatever ;-)

Although; by having X we only have a single I. You currently have I as
meta and argument type, which is prone to confusion or something.

Alternatively we could use 'p' for the argument pointer thing.

> > > > # Where args contains list of type[:name], where type is:
> > > > # * v - pointer to atomic base type (atomic or atomic64)
> > > > # * i - base type (int or long)
> > > > # * I - pointer to base type (int or long)
> > > > #
