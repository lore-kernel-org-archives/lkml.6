Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeC2OBa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:01:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeC2OB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:01:27 -0400
Date: Thu, 29 Mar 2018 16:01:11 +0200
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
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
Message-ID: <20180329140111.GC4043@hirez.programming.kicks-ass.net>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
 <1522290425-22844-11-git-send-email-frederic@kernel.org>
 <20180329071619.GO4082@hirez.programming.kicks-ass.net>
 <20180329134745.GA12958@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329134745.GA12958@lerouge>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 03:47:46PM +0200, Frederic Weisbecker wrote:
> On Thu, Mar 29, 2018 at 09:16:19AM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 29, 2018 at 04:27:05AM +0200, Frederic Weisbecker wrote:
> > > The last user of __ARCH_SET_SOFTIRQ_PENDING has been converted to generic
> > > per-cpu softirq mask. We can now remove this conditional.
> > 
> > This seems like half a cleanup; who still has local_softirq_pending()
> > after this?
> 
> Only s390 because it uses lowcore to store such cpu data.

Is it worth keeping it there? It seems an aweful shame to keep this
stuff special cased for just the one arch. At the very least this
should've mentioned s390 is special and why.

And I don't see s390 people on Cc either.
