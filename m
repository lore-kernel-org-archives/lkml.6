Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeFENdI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:33:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeFEN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:29:56 -0400
Date: Tue, 5 Jun 2018 15:29:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        will.deacon@arm.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        dvyukov@google.com, glider@google.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, parri.andrea@gmail.com
Subject: Re: [PATCH 0/7] atomics: generate atomic headers
Message-ID: <20180605132949.GL12258@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180746.29684-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:07:39PM +0100, Mark Rutland wrote:
> Longer-term, I think things could be simplified if we were to rework the
> headers such that we have:
> 
> * arch/*/include/asm/atomic.h providing arch_atomic_*().
> 
> * include/linux/atomic-raw.h building raw_atomic_*() atop of the
>   arch_atomic_*() definitions, filling in gaps in the API. Having
>   separate arch_ and raw_ namespaces would simplify the ifdeffery.
> 
> * include/linux/atomic.h building atomic_*() atop of the raw_atomic_*()
>   definitions, complete with any instrumentation. Instrumenting at this
>   level would lower the instrumentation overhead, and would not require
>   any ifdeffery as the whole raw_atomic_*() API would be available.
> 
> ... I've avoided this for the time being due to the necessary churn in
> arch code.

I'm not entirely sure I get the point of raw_atomic, we only need to
instrument the arch_atomic bits, right? When those are done, everything
that's build on top will also automagically be instrumented.
