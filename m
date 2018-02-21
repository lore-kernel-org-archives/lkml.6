Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938137AbeBUPAX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:00:23 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:32962 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933065AbeBUPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:00:21 -0500
Date: Wed, 21 Feb 2018 10:00:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep, smp_read_barrier_depends,
 and lockless_dereference
In-Reply-To: <20180217003959.GR3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802210958520.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Paul E. McKenney wrote:

> On Fri, Feb 16, 2018 at 05:22:55PM -0500, Alan Stern wrote:
> > Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> > smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
> > kernel, it has not been necessary to use smp_read_barrier_depends().
> > Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
> > lockless_dereference()") removed lockless_dereference() from the
> > kernel.
> > 
> > Since these primitives are no longer part of the kernel, they do not
> > belong in the Linux Kernel Memory Consistency Model.  This patch
> > removes them, along with the internal rb-dep relation, and updates the
> > revelant documentation.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> I queued this, but would welcome an update that addressed Akira's
> feedback as appropriate.

Is it too late to send a v2 of this patch?  I didn't want to do it 
before now because the issue raised by Andrea wasn't settled.  (Some 
could claim that it still isn't fully settled...)

Alan
