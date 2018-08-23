Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC16C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF79208A6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTA1fJ2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF79208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeHWHNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:13:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHWHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:13:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so1874405pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i035Tkkf20U58u3KM2ssD8F0uNMkiAtpjbIkK2Z/H/E=;
        b=rTA1fJ2N7wkYayOknaRPza0CzeH6TG1Wrrl4LQsumU4zL+L7L2jmlmmnZPF5KZ7N2H
         fo9U5aKEyBK5GPqCStI/BbWTeFnAkNdr4VEa8UaNJ3tuH0tVKDYaDg9l+8FVMRzzlmEP
         CIBLiEHn+MvWt8lNRl3bxUR73rCJHpfZ+Qsfh9eKIqMkrP9nn4o2DSpMFcx7LrtH9jPj
         j9a7Zo08qFuF73aD9QCMmSp+Ycr3BTnAFWBgsj/eKD/TnVdYi/rcqINXN81mf05VLpxq
         dNK5cFlS+zqaFfgSrBeR9oNwBIDRBVPdionVFoNr65mE2AwSfTZR4LMgm4MUbJMZpGIh
         O0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i035Tkkf20U58u3KM2ssD8F0uNMkiAtpjbIkK2Z/H/E=;
        b=MocCJF8St0x8dDiNEJ+2eMM991n/dWoBPMLtzsz66fmrH45LCmy8KkIkGbdBN5bWiI
         +Ajhj2DUQRma+Jq+4G+k7OfG6G0pt337nhkf1ZJJY1b7sCKje5iTdPkVjzkOLb3cl2AH
         njTtTVhLvqIn1RkCqYm5KLEPJryKT/cSXH2PifXMpahE2lMNn2C6xE1dBMO0RFS6/pPm
         t4fDztWFQ3nE4cToZooLamqUdQJ32MmkfVt+PJ/C+Za5hVAYYP0LffvoJ6AAHwKxJNtQ
         jB4w6qUMwJQs18VzxsSzXyxIkdBsZpzgVwj3U1LnuHeehGyA5nCfnj4zhGbFZpgqHkBY
         47sw==
X-Gm-Message-State: AOUpUlHJcskDQTzvu89j0O3g1h8wq9AyFB+PRwmLzzgKwoP7zNKCcsSp
        Qn2AODJTvNgMxyr1H8PQ+xcMPNN/
X-Google-Smtp-Source: AA+uWPz38zv0qJTaEh4gCiW5L4ATP3lcKcsQSrYhfIqYnISi03AJpOHDkijZXwcYeCZF5uU0Af7c4Q==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr60663478pfd.233.1534995933015;
        Wed, 22 Aug 2018 20:45:33 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id u11-v6sm6094731pfd.117.2018.08.22.20.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 20:45:32 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:45:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
In-Reply-To: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 17:55:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Aug 22, 2018 at 05:30:15PM +0200, Peter Zijlstra wrote:
> > ARM
> > which later used this put an explicit TLB invalidate in their
> > __p*_free_tlb() functions, and PowerPC-radix followed that example.  
> 
> > +/*
> > + * If we want tlb_remove_table() to imply TLB invalidates.
> > + */
> > +static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> > +{
> > +#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
> > +	/*
> > +	 * Invalidate page-table caches used by hardware walkers. Then we still
> > +	 * need to RCU-sched wait while freeing the pages because software
> > +	 * walkers can still be in-flight.
> > +	 */
> > +	__tlb_flush_mmu_tlbonly(tlb);
> > +#endif
> > +}  
> 
> 
> Nick, Will is already looking at using this to remove the synchronous
> invalidation from __p*_free_tlb() for ARM, could you have a look to see
> if PowerPC-radix could benefit from that too?

powerpc/radix has no such issue, it already does this tracking.

We were discussing this a couple of months ago, I wasn't aware of ARM's
issue but I suggested x86 could go the same way as powerpc. Would have
been good to get some feedback on some of the proposed approaches there.
Because it's not just pwc tracking but if you do this you don't need
those silly hacks in generic code to expand the TLB address range
either.

So powerpc has no fundamental problem with making this stuff generic.
If you need a fix for x86 and ARM for this merge window though, I would
suggest just copying what powerpc already has. Next time we can
consider consolidating them all into generic code.

Thanks,
Nick


> 
> Basically, using a patch like the below, would give your tlb_flush()
> information on if tables were removed or not.
> 
> ---
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -96,12 +96,22 @@ struct mmu_gather {
>  #endif
>  	unsigned long		start;
>  	unsigned long		end;
> -	/* we are in the middle of an operation to clear
> -	 * a full mm and can make some optimizations */
> -	unsigned int		fullmm : 1,
> -	/* we have performed an operation which
> -	 * requires a complete flush of the tlb */
> -				need_flush_all : 1;
> +	/*
> +	 * we are in the middle of an operation to clear
> +	 * a full mm and can make some optimizations
> +	 */
> +	unsigned int		fullmm : 1;
> +
> +	/*
> +	 * we have performed an operation which
> +	 * requires a complete flush of the tlb
> +	 */
> +	unsigned int		need_flush_all : 1;
> +
> +	/*
> +	 * we have removed page directories
> +	 */
> +	unsigned int		freed_tables : 1;
>  
>  	struct mmu_gather_batch *active;
>  	struct mmu_gather_batch	local;
> @@ -136,6 +146,7 @@ static inline void __tlb_reset_range(str
>  		tlb->start = TASK_SIZE;
>  		tlb->end = 0;
>  	}
> +	tlb->freed_tables = 0;
>  }
>  
>  static inline void tlb_remove_page_size(struct mmu_gather *tlb,
> @@ -269,6 +280,7 @@ static inline void tlb_remove_check_page
>  #define pte_free_tlb(tlb, ptep, address)			\
>  	do {							\
>  		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> +		tlb->freed_tables = 1;			\
>  		__pte_free_tlb(tlb, ptep, address);		\
>  	} while (0)
>  #endif
> @@ -276,7 +288,8 @@ static inline void tlb_remove_check_page
>  #ifndef pmd_free_tlb
>  #define pmd_free_tlb(tlb, pmdp, address)			\
>  	do {							\
> -		__tlb_adjust_range(tlb, address, PAGE_SIZE);		\
> +		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> +		tlb->freed_tables = 1;			\
>  		__pmd_free_tlb(tlb, pmdp, address);		\
>  	} while (0)
>  #endif
> @@ -286,6 +299,7 @@ static inline void tlb_remove_check_page
>  #define pud_free_tlb(tlb, pudp, address)			\
>  	do {							\
>  		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> +		tlb->freed_tables = 1;			\
>  		__pud_free_tlb(tlb, pudp, address);		\
>  	} while (0)
>  #endif
> @@ -295,7 +309,8 @@ static inline void tlb_remove_check_page
>  #ifndef p4d_free_tlb
>  #define p4d_free_tlb(tlb, pudp, address)			\
>  	do {							\
> -		__tlb_adjust_range(tlb, address, PAGE_SIZE);		\
> +		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> +		tlb->freed_tables = 1;			\
>  		__p4d_free_tlb(tlb, pudp, address);		\
>  	} while (0)
>  #endif

