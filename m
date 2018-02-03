Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeBCWKQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 17:10:16 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51667 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752465AbeBCWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 17:10:07 -0500
Date: Sat, 3 Feb 2018 17:10:06 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <parri.andrea@gmail.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <boqun.feng@gmail.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <elena.reshetova@intel.com>, <mhocko@suse.com>,
        <akiyks@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
In-Reply-To: <20180203084809.GE3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018, Paul E. McKenney wrote:

> Please see below for an initial patch to this effect.  This activity
> proved to be more productive than expected for these tests, which certainly
> supports our assertion that locking needs more testing...
> 
> MP+polocks.litmus
> MP+porevlocks.litmus
> 
> 	These are allowed by the current model, which surprised me a bit,
> 	given that even powerpc would forbid them.  Is the rationale
> 	that a lock-savvy compiler could pull accesses into the lock's
> 	critical section and then reorder those accesses?  Or does this
> 	constitute a bug in our model of locking?
> 
> 	(And these were allowed when I wrote recipes.txt, embarrassingly
> 	enough...)
> 
> Z6.0+pooncelock+poonceLock+pombonce.litmus
> 
> 	This was forbidden when I wrote recipes.txt, but now is allowed.
> 	The header comment for smp_mb__after_spinlock() makes it pretty
> 	clear that it must be forbidden.  So this one is a bug in our
> 	model of locking.

I just tried testing these under the most recent version of herd, and 
all three were forbidden.

Alan
