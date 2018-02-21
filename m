Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeBUQwN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:52:13 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41659 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754404AbeBUQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:51:47 -0500
X-Google-Smtp-Source: AH8x2246RtZaSa+5iw8yaUGOUirp5ihnKW2QOq1CgLIVw15vtkgHOPznRBue5guvZP4RtRdLuSZ6pQ==
Date: Wed, 21 Feb 2018 17:51:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180221165143.gf5hhhrddediubdx@gmail.com>
References: <20180217003959.GR3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802210958520.2032-100000@iolanthe.rowland.org>
 <20180221160602.GD3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221160602.GD3617@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Feb 21, 2018 at 10:00:20AM -0500, Alan Stern wrote:
> > On Fri, 16 Feb 2018, Paul E. McKenney wrote:
> > 
> > > On Fri, Feb 16, 2018 at 05:22:55PM -0500, Alan Stern wrote:
> > > > Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> > > > smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
> > > > kernel, it has not been necessary to use smp_read_barrier_depends().
> > > > Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
> > > > lockless_dereference()") removed lockless_dereference() from the
> > > > kernel.
> > > > 
> > > > Since these primitives are no longer part of the kernel, they do not
> > > > belong in the Linux Kernel Memory Consistency Model.  This patch
> > > > removes them, along with the internal rb-dep relation, and updates the
> > > > revelant documentation.
> > > > 
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > I queued this, but would welcome an update that addressed Akira's
> > > feedback as appropriate.
> > 
> > Is it too late to send a v2 of this patch?  I didn't want to do it 
> > before now because the issue raised by Andrea wasn't settled.  (Some 
> > could claim that it still isn't fully settled...)
> 
> Would you be willing to send a delta patch?  I can then place it directly
> on top of your original patch, and once it settles out, I can ask Ingo
> if he is willing to update the patch in -tip.

It would be better to have followup fixes as separate patches. I applied the 
current set of fixes/improvements today to help move things along - it's all 
advancing very nicely!

Thanks,

	Ingo
