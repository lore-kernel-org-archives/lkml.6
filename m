Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22A1860555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeFFKZJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:25:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932304AbeFFKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:25:08 -0400
Date: Wed, 6 Jun 2018 12:25:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
cc: Dan Williams <dan.j.williams@intel.com>, mingo@kernel.org,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/spectre_v1: Disable compiler optimizations over
 array_index_mask_nospec()
In-Reply-To: <20180530060546.jnjoltsturoduohh@salmiak>
Message-ID: <alpine.DEB.2.21.1806061223560.1579@nanos.tec.linutronix.de>
References: <152726886796.10827.14538693708255560877.stgit@dwillia2-desk3.amr.corp.intel.com> <20180530060546.jnjoltsturoduohh@salmiak>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On Wed, 30 May 2018, Mark Rutland wrote:
> > diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> > index 042b5e892ed1..41f7435c84a7 100644
> > --- a/arch/x86/include/asm/barrier.h
> > +++ b/arch/x86/include/asm/barrier.h
> > @@ -38,10 +38,11 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
> >  {
> >  	unsigned long mask;
> >  
> > -	asm ("cmp %1,%2; sbb %0,%0;"
> > +	asm volatile ("cmp %1,%2; sbb %0,%0;"
> >  			:"=r" (mask)
> >  			:"g"(size),"r" (index)
> >  			:"cc");
> > +	barrier();
> >  	return mask;
> >  }
> 
> What does the barrier() prevent?
> 
> I don't think that inhibits the insertion of branches, and AFAIK the volatile
> is sufficient to prevent elision of identical array_idx_nospec() calls.
> 
> I don't have an objection to it, regardless.
> 
> So long as the example is updated in the commit message, feel free to add:

Any update on this?

Thanks,

	tglx
