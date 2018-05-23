Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeEWRSt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:18:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933741AbeEWRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:18:46 -0400
Date: Wed, 23 May 2018 19:18:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCH 00/13] atomics: API cleanups
Message-ID: <20180523171817.GV12198@hirez.programming.kicks-ass.net>
References: <20180523133533.1076-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523133533.1076-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:35:20PM +0100, Mark Rutland wrote:
> This series contains a few cleanups of the atomic API, fixing an
> inconsistency between atomic_* and atomic64_*, and minimizing repetition
> in arch code. This is nicer for arch code, and the improved regularity
> will help when generating the atomic headers in future.
> 
> The bulk of the patches reorganise things so architectures consistently
> provide <atomic>_fetch_add_unless(), with atomic_fetch_add_unless()
> provided as a wrapper by core code. A generic fallback is provided for
> <atomic>_fetch_add_unless(), based on <atomic>_read() and
> <atomic>_try_cmpxchg().
> 
> Other patches in the series add common fallbacks for:
> 
> * atomic64_inc_not_zero() 
> * <atomic>_inc_and_test()
> * <atomic>_dec_and_test()
> * <atomic>_sub_and_test()
> * <atomic>add_negative()
> 
> ... as almost all architectures provide identical implementation of
> these today.
> 
> The end result is a strongly negative diffstat, though <linux/atomic.h>
> grows by a reasonable amount. When we generate the headers, we can halve
> this by templating the various fallbacks for atomic{,64}_t.
> 

Thanks for this Mark,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ingo, can you magic this into tip somewhere?
