Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCNNQg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:16:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37106 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeCNNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:16:34 -0400
Date: Wed, 14 Mar 2018 14:16:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180314131626.GM4064@hirez.programming.kicks-ass.net>
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
> > If you want to correlate to CLOCK_MONOTONIC_RAW you have to read
> > CLOCK_MONOTONIC_RAW and not some random other clock value.
> >
> 
> Exactly ! Hence the need for the patch so that users can get
> CLOCK_MONOTONIC_RAW values with low latency and correlate them
> with PERF CPU_CLOCK values.

No, you _CANNOT_ correlate CLOCK_MONOTONIC_RAW with CPU_CLOCK, that is
_BROKEN_.

Yes it 'works', but that's mostly a happy accident. There is no
guarantee that CLOCK_MONOTONIC_RAW runs off the TSC, and even if both
CPU_CLOCK and CLOCK_MONOTONIC_RAW use the TSC, they need not use the
same rate (and they didn't for a long time).

Do not mix clocks.
