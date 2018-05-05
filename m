Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEEJ3S (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:29:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEEJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:29:15 -0400
Date: Sat, 5 May 2018 11:29:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
Message-ID: <20180505092911.GC12217@hirez.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090903.ebsf5vosgwckxooy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505090903.ebsf5vosgwckxooy@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:09:03AM +0200, Ingo Molnar wrote:
> > >  # ifndef atomic_fetch_dec_acquire
> > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  # ifndef atomic_fetch_dec_release
> > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  # ifndef atomic_fetch_dec
> > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_dec, __VA_ARGS__)
> > >  # endif
> > >  #endif
> > > 
> > > The new variant is readable at a glance, and the hierarchy of defines is very 
> > > obvious as well.
> > 
> > It wraps and looks hideous in my normal setup. And I do detest that indent
> > after # thing.
> 
> You should use wider terminals if you take a look at such code - there's already 
> numerous areas of the kernel that are not readable on 80x25 terminals.
> 
> _Please_ try the following experiment, for me:
> 
> Enter the 21st century temporarily and widen two of your terminals from 80 cols to 
> 100 cols - it's only ~20% wider.

Doesn't work that way. The only way I get more columns is if I shrink my
font further. I work with tiles per monitor (left/right obv.) and use
two columns per editor. This gets me a total of 4 columns.

On my desktop that is slightly over 100 characters per column, on my
laptop that is slightly below 100 -- mostly because I'm pixel limited on
fontsize on that thing (FullHD sucks).

If it wraps it wraps.
