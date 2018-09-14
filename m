Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05ECECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E3320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E3320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeINWLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:11:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:11:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C2B380D;
        Fri, 14 Sep 2018 09:56:26 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A8A83F557;
        Fri, 14 Sep 2018 09:56:26 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id EB59D1AE2F82; Fri, 14 Sep 2018 17:56:43 +0100 (BST)
Date:   Fri, 14 Sep 2018 17:56:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 02/11] asm-generic/tlb: Provide
 HAVE_MMU_GATHER_PAGE_SIZE
Message-ID: <20180914165643.GH6236@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.955706111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092811.955706111@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:21:12AM +0200, Peter Zijlstra wrote:
> Move the mmu_gather::page_size things into the generic code instead of
> powerpc specific bits.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig                   |    3 +++
>  arch/arm/include/asm/tlb.h     |    3 +--
>  arch/ia64/include/asm/tlb.h    |    3 +--
>  arch/powerpc/Kconfig           |    1 +
>  arch/powerpc/include/asm/tlb.h |   17 -----------------
>  arch/s390/include/asm/tlb.h    |    4 +---
>  arch/sh/include/asm/tlb.h      |    4 +---
>  arch/um/include/asm/tlb.h      |    4 +---
>  include/asm-generic/tlb.h      |   25 +++++++++++++------------
>  mm/huge_memory.c               |    4 ++--
>  mm/hugetlb.c                   |    2 +-
>  mm/madvise.c                   |    2 +-
>  mm/memory.c                    |    4 ++--
>  mm/mmu_gather.c                |    5 +++++
>  14 files changed, 33 insertions(+), 48 deletions(-)

Looks fine to me, but I hope we can remove this option altogether in future:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
