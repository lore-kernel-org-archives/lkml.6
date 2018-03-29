Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeC2HQk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:16:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeC2HQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:16:35 -0400
Date: Thu, 29 Mar 2018 09:16:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
Message-ID: <20180329071619.GO4082@hirez.programming.kicks-ass.net>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
 <1522290425-22844-11-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522290425-22844-11-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 04:27:05AM +0200, Frederic Weisbecker wrote:
> The last user of __ARCH_SET_SOFTIRQ_PENDING has been converted to generic
> per-cpu softirq mask. We can now remove this conditional.

This seems like half a cleanup; who still has local_softirq_pending()
after this?

>  
>  #else /* local_softirq_pending */
>  
> -#ifndef __ARCH_SET_SOFTIRQ_PENDING
>  #define set_softirq_pending(x) (local_softirq_pending() = (x))
>  #define or_softirq_pending(x)  (local_softirq_pending() |= (x))
> -#endif
>  
>  #endif /* local_softirq_pending */
