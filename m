Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeBTNCO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:02:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeBTNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:12 -0500
Date: Mon, 19 Feb 2018 21:28:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180219202844.GW25201@hirez.programming.kicks-ass.net>
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
 <20180219194123.GZ3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219194123.GZ3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:41:23AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> > This leaves us with a question: Do we want to change the kernel by
> > adding memory barriers after unsuccessful RMW operations on Alpha, or
> > do we want to change the model by excluding such operations from
> > address dependencies?
> 
> I vote for adding the barrier on Alpha.  However, I don't know of any
> code in the Linux kernel that relies on read-to-read address dependency
> ordering headed by a failing RMW operation, so I don't feel all that
> strongly about this.

Right, but not knowing doesn't mean doesn't exist, and most certainly
doesn't mean will never exist.

> > Note that operations like atomic_add_unless() already include memory 
> > barriers.
> 
> And I don't see an atomic_add_unless_relaxed(), so we are good on this
> one.  So far, anyway!  ;-)

Not the point, add_unless() is a conditional operation, and therefore
doesn't need to imply anything when failing.
