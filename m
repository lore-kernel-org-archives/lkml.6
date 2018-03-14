Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeCNNMo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:12:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeCNNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:41 -0400
Date: Wed, 14 Mar 2018 14:12:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180314131237.GL4064@hirez.programming.kicks-ass.net>
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
> > While CPU_CLOCK is TSC based, there is no guarantee it has any
> > correlation to CLOCK_MONOTONIC_RAW (even if that is also TSC based).
> >
> > (although, I think I might have fixed that recently and it might just
> > work, but it's very much not guaranteed).
> 
> Yes, I believe the CPU_CLOCK is effectively the converted TSC -
> it does appear to correlate well with the new CLOCK_MONOTONIC_RAW
> values from the patched VDSO.

It (now) runs at the same rate, but there is no guarantee for this, in
fact it didn't for a very long time.

Relying on this is broken.
