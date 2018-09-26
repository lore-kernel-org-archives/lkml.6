Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB64E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPL6d7yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB64E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeIZSHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbeIZSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+tA8Q9MFdkLFV7zO6AF9h18nDDBKm/mt3m8i8F4mU94=; b=gPL6d7ySVlX1zkspubHdYLYPPz
        JHNxtySC9tV/OnbUzT6l4g+T3kBT2fitMK+ZiClHOw0emzwyjxzEDHSe2UH4uWMHoGP7qWHWMvAgD
        nFcN2lTgWPw6KID9r7/0OYTX7UZX+yU1CH95xdBrnNNXlPVr4ppS67PmWHJSj2Nu+FC2DBJenM0dT
        cVWSHt2hK6JcFCHnoluO349hwPyOBDYV1FtiuQ+elXrVjldiUoAynH6geYfjMIftHVAIP/SbWFK4A
        kvGmUJ1NKA13olh4n+56yj/aXI5D/y9jWCQlIzbOg+giilYTkIjOjbi0HgenjOcXFoQ3/zX9phbN2
        vloLJK2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58OM-0005vc-71; Wed, 26 Sep 2018 11:54:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7577F206F1800; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114800.561468800@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 01/18] asm-generic/tlb: Provide a comment
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write a comment explaining some of this..

Cc: Nick Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |  119 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 3 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -22,6 +22,118 @@
 
 #ifdef CONFIG_MMU
 
+/*
+ * Generic MMU-gather implementation.
+ *
+ * The mmu_gather data structure is used by the mm code to implement the
+ * correct and efficient ordering of freeing pages and TLB invalidations.
+ *
+ * This correct ordering is:
+ *
+ *  1) unhook page
+ *  2) TLB invalidate page
+ *  3) free page
+ *
+ * That is, we must never free a page before we have ensured there are no live
+ * translations left to it. Otherwise it might be possible to observe (or
+ * worse, change) the page content after it has been reused.
+ *
+ * The mmu_gather API consists of:
+ *
+ *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
+ *
+ *    Finish in particular will issue a (final) TLB invalidate and free
+ *    all (remaining) queued pages.
+ *
+ *  - tlb_start_vma() / tlb_end_vma(); marks the start / end of a VMA
+ *
+ *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
+ *    there's large holes between the VMAs.
+ *
+ *  - tlb_remove_page() / __tlb_remove_page()
+ *  - tlb_remove_page_size() / __tlb_remove_page_size()
+ *
+ *    __tlb_remove_page_size() is the basic primitive that queues a page for
+ *    freeing. __tlb_remove_page() assumes PAGE_SIZE. Both will return a
+ *    boolean indicating if the queue is (now) full and a call to
+ *    tlb_flush_mmu() is required.
+ *
+ *    tlb_remove_page() and tlb_remove_page_size() imply the call to
+ *    tlb_flush_mmu() when required and has no return value.
+ *
+ *  - tlb_remove_check_page_size_change()
+ *
+ *    call before __tlb_remove_page*() to set the current page-size; implies a
+ *    possible tlb_flush_mmu() call.
+ *
+ *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly() / tlb_flush_mmu_free()
+ *
+ *    tlb_flush_mmu_tlbonly() - does the TLB invalidate (and resets
+ *                              related state, like the range)
+ *
+ *    tlb_flush_mmu_free() - frees the queued pages; make absolutely
+ *			     sure no additional tlb_remove_page()
+ *			     calls happen between _tlbonly() and this.
+ *
+ *    tlb_flush_mmu() - the above two calls.
+ *
+ *  - mmu_gather::fullmm
+ *
+ *    A flag set by tlb_gather_mmu() to indicate we're going to free
+ *    the entire mm; this allows a number of optimizations.
+ *
+ *    - We can ignore tlb_{start,end}_vma(); because we don't
+ *      care about ranges. Everything will be shot down.
+ *
+ *    - (RISC) architectures that use ASIDs can cycle to a new ASID
+ *      and delay the invalidation until ASID space runs out.
+ *
+ *  - mmu_gather::need_flush_all
+ *
+ *    A flag that can be set by the arch code if it wants to force
+ *    flush the entire TLB irrespective of the range. For instance
+ *    x86-PAE needs this when changing top-level entries.
+ *
+ * And requires the architecture to provide and implement tlb_flush().
+ *
+ * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
+ * use of:
+ *
+ *  - mmu_gather::start / mmu_gather::end
+ *
+ *    which provides the range that needs to be flushed to cover the pages to
+ *    be freed.
+ *
+ *  - mmu_gather::freed_tables
+ *
+ *    set when we freed page table pages
+ *
+ *  - tlb_get_unmap_shift() / tlb_get_unmap_size()
+ *
+ *    returns the smallest TLB entry size unmapped in this range
+ *
+ * Additionally there are a few opt-in features:
+ *
+ *  HAVE_RCU_TABLE_FREE
+ *
+ *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
+ *  for page directores (__p*_free_tlb()). This provides separate freeing of
+ *  the page-table pages themselves in a semi-RCU fashion (see comment below).
+ *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
+ *  and therefore doesn't naturally serialize with software page-table walkers.
+ *
+ *  When used, an architecture is expected to provide __tlb_remove_table()
+ *  which does the actual freeing of these pages.
+ *
+ *  HAVE_RCU_TABLE_INVALIDATE
+ *
+ *  This makes HAVE_RCU_TABLE_FREE call tlb_flush_mmu_tlbonly() before freeing
+ *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
+ *  architecture uses the Linux page-tables natively.
+ *
+ */
+#define HAVE_GENERIC_MMU_GATHER
+
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
  * Semi RCU freeing of the page directories.
@@ -89,14 +201,17 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-/* struct mmu_gather is an opaque type used by the mm code for passing around
+/*
+ * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
  */
 struct mmu_gather {
 	struct mm_struct	*mm;
+
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
+
 	unsigned long		start;
 	unsigned long		end;
 	/*
@@ -131,8 +246,6 @@ struct mmu_gather {
 	int page_size;
 };
 
-#define HAVE_GENERIC_MMU_GATHER
-
 void arch_tlb_gather_mmu(struct mmu_gather *tlb,
 	struct mm_struct *mm, unsigned long start, unsigned long end);
 void tlb_flush_mmu(struct mmu_gather *tlb);


