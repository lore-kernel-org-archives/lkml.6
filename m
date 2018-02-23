Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeBWLQN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:16:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51981 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWLQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:16:11 -0500
X-Google-Smtp-Source: AH8x226xJd0mikLFa2DkcZyEfHz0K6q3a4Pa3sZ+BXxCfiYykjbPzCAAjJaQFOhySrFuXbcSiIlkSw==
Date: Fri, 23 Feb 2018 12:16:01 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Message-ID: <20180223111601.GA449@andrea>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
 <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:47:57AM -0800, Daniel Lustig wrote:
> On 2/22/2018 10:27 AM, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
> >> So we have something that is not all that rare in the Linux kernel
> >> community, namely two conflicting more-or-less concurrent changes.
> >> This clearly needs to be resolved, either by us not strengthening the
> >> Linux-kernel memory model in the way we were planning to or by you
> >> strengthening RISC-V to be no weaker than PowerPC for these sorts of
> >> externally viewed release-acquire situations.
> >>
> >> Other thoughts?
> > 
> > Like said in the other email, I would _much_ prefer to not go weaker
> > than PPC, I find that PPC is already painfully weak at times.
> 
> Sure, and RISC-V could make this work too by using RCsc instructions
> and/or by using lightweight fences instead.  It just wasn't clear at
> first whether smp_load_acquire() and smp_store_release() were RCpc,
> RCsc, or something else, and hence whether RISC-V would actually need
> to use something stronger than pure RCpc there.  Likewise for
> spin_unlock()/spin_lock() and everywhere else this comes up.

Thank you for the confirmations.

The hope was indeed that this thread helped clarify what the (current)
LKMM "expectations" are, and how these are likely to evolve in a near
future.  And Yes, I'm definitely with you and Paul on "let us (try to)
keep LKMM and RISC-V synchronized"! ;-)

  Andrea


> 
> 
> Dan
