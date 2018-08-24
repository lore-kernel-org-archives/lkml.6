Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D04AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AF208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48AF208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHXSAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:00:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeHXSAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:00:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B5AED1;
        Fri, 24 Aug 2018 07:25:40 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFBF3F5BC;
        Fri, 24 Aug 2018 07:25:36 -0700 (PDT)
Date:   Fri, 24 Aug 2018 15:25:33 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824142532.GG11868@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
 <20180824132419.GA9983@roeck-us.net>
 <20180824133427.GC11868@brain-police>
 <20180824135048.GF11868@brain-police>
 <7d0111f4-c369-43a8-72c6-1a7390cdebdd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0111f4-c369-43a8-72c6-1a7390cdebdd@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 07:06:51AM -0700, Guenter Roeck wrote:
> On 08/24/2018 06:50 AM, Will Deacon wrote:
> 
> >>-#include <asm-generic/tlb.h>
> >>+struct mmu_gather;
> >>  static inline void tlb_flush(struct mmu_gather *tlb)
> >>  {
> >>  	flush_tlb_mm(tlb->mm);
> >
> >Bah, didn't spot the dereference so this won't work either. You basically
> >just need to copy what I did for arm64 in d475fac95779.
> >
> 
> Yes, this seems to work. It doesn't really need "struct mmu_gather;" -
> I assume that is included from elsewhere - but I added it to be safe.

struct mmu_gather comes in via asm-generic/tlb.h.

> Can you send a full patch, or do you want me to do it ?

I'm evidently incapable of writing code today, so please go ahead :)

Will
