Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCNN3H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:29:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCNN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:29:05 -0400
Date: Wed, 14 Mar 2018 14:29:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180314132900.GN4064@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com>
 <20180312082741.GD4064@hirez.programming.kicks-ass.net>
 <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com>
 <20180314094519.GD4082@hirez.programming.kicks-ass.net>
 <CALyZvKzbLi6K9DFwOXu7h--MdxWFv9A3==0xORuQ=KwtJx3ZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALyZvKzbLi6K9DFwOXu7h--MdxWFv9A3==0xORuQ=KwtJx3ZrQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:55:20PM +0000, Jason Vas Dias wrote:
> > You could read the time using the group_fd's mmap() page. That actually
> > includes the TSC mult,shift,offset as used by perf clocks.
> >
> 
> Yes, but as mentioned earlier, that presupposes I want to use the mmap()
> sample method - I don't - I want to use the Group FD method, so
> that I can be sure the measurements are for the same code sequence
> over the same period of time.

You can use both, you can use the data from the mmap page to convert the
times obtained from the read() syscall back to raw TSC ticks for all I
care (in fact, that's what some people do).

Then your userspace can use saw RDTSC instructions and not worry about
scaling anything.
