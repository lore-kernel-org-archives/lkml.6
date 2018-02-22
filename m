Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeBVS11 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:27:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933521AbeBVS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:27:25 -0500
Date: Thu, 22 Feb 2018 19:27:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Daniel Lustig <dlustig@nvidia.com>,
        Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20180222182717.GS25181@hirez.programming.kicks-ass.net>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222181317.GI2855@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
> So we have something that is not all that rare in the Linux kernel
> community, namely two conflicting more-or-less concurrent changes.
> This clearly needs to be resolved, either by us not strengthening the
> Linux-kernel memory model in the way we were planning to or by you
> strengthening RISC-V to be no weaker than PowerPC for these sorts of
> externally viewed release-acquire situations.
> 
> Other thoughts?

Like said in the other email, I would _much_ prefer to not go weaker
than PPC, I find that PPC is already painfully weak at times.
