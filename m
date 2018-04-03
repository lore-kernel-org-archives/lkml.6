Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbeDCImQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:42:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755133AbeDCImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:42:15 -0400
Date: Tue, 3 Apr 2018 10:42:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
Message-ID: <20180403084201.GX4082@hirez.programming.kicks-ass.net>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
 <1522290425-22844-11-git-send-email-frederic@kernel.org>
 <20180329071619.GO4082@hirez.programming.kicks-ass.net>
 <20180329134745.GA12958@lerouge>
 <20180329140111.GC4043@hirez.programming.kicks-ass.net>
 <20180329140748.GB12958@lerouge>
 <20180329165343.39f4486f@mschwideX1>
 <20180329180836.GS4082@hirez.programming.kicks-ass.net>
 <20180403075225.69ad3d25@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403075225.69ad3d25@mschwideX1>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 07:52:25AM +0200, Martin Schwidefsky wrote:
> On Thu, 29 Mar 2018 20:08:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Mar 29, 2018 at 04:53:43PM +0200, Martin Schwidefsky wrote:
> > > The lowcore optimization for softirq_pending field is not really needed,
> > > just nice to have. But if there is a strong reason to make a common
> > > definition for it we can certainly do that.  
> > 
> > A slightly related question; would it make sense to move all kernel
> > static per-cpu stuff into lowcore, or is that asking for too much
> > trickery?
>  
> The space in lowcore is quite limited, for zArch the structure is 8K with
> many pre-defined fields. I fear that putting all of the static per-cpu
> stuff in there is too much. 
> 
> So far I used the lowcore as optimization for selected per-cpu fields
> which are performance relevant.

Fair enough; and yes 8k isn't much. Thanks for the info.
