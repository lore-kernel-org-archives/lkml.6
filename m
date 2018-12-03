Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF1120864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmS0Lz+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF1120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeLCXuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:50:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44076 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeLCXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:50:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so7271149pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T5rIjhLQ4stys0+TCyJHyOn0Ld01LDgoTWpjXbRKG0I=;
        b=kmS0Lz+FUCFImUjiMzzAMvPH9SDaCcijUEb3OtIX0B0AHfRNJEJB5Z0lEMrUNDVsta
         SV1aHT1uvyV1o8FPNZr1PU/VZXiUQccnYK0s0zfQZs4Kbv41+wYPGdmmyAS4FWIy1+pD
         hg2nKRqz4OKszVVvFR92g1Z/vDgICbVWOTL0pkmPrykvWkwlp9E+yrui7QzZE54uJsgP
         rSBNPBRmeVKqiTdG9QU+kxdnGpcaTnwM2bAbfCBXc7r28R69kHIl0IeqCXarLiYD2fFc
         OL2T3cv8X822lAbwJp6ACRN8wR489gsvnl+2pwZSEIULHNcXFjqLksPrW1D6OqRqPbde
         ttGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T5rIjhLQ4stys0+TCyJHyOn0Ld01LDgoTWpjXbRKG0I=;
        b=Y0eEsUnmc5ilkbb0H+kV78E9xOoY1UjEBhOs1kWrzQp2T+QMD2V7b/oauy6MkT40jm
         pPD5/cikEAfRgt9NCFHNPIS51Z/rh/FU2Ahsw9tr4P8SAz9ztTkzGyx8ONJMLZOUTLb8
         6N7ZigZedfrZloIwtuEmTg03VVKhN+M/BxmvKoK7WtAyf6Jvvprd2oly6gAcaTM+eaxx
         e2v7S26CO2h90HujnNOrFOhPxn5Wj8QjGuyGmbDVEjzhYBZ/3PMEn2qsbLk+F5LC4PwZ
         7LFpspXgdRz7D27Yf0kxU7VQjRCz7mpCOD/7vSfEgjJ6jqLoNBD0vguZRx0CNFG2uMSF
         LOHw==
X-Gm-Message-State: AA+aEWa7vwuxlXkdQOCGJMjmeUHh12VvfG9wvCDwNdrIE6LcMa2u2OwV
        avKdAvcINSUepNrc2PXM9CEEDw==
X-Google-Smtp-Source: AFSGD/WFxerY9ewj+pJg7Q4RYnTJUw0WzmmjdzF5VO05aXccRNp7gGduY95rZHuOGPomDcdlgC0pVQ==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr3080673pla.129.1543881023156;
        Mon, 03 Dec 2018 15:50:23 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w11sm15585480pgk.16.2018.12.03.15.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:50:22 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:50:21 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
cc:     ying.huang@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: [patch 2/2 for-4.20] mm, thp: always fault memory with
 __GFP_NORETRY
In-Reply-To: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1812031546230.161134@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If memory compaction initially fails to free a hugepage, reclaiming and
retrying compaction is more likely to be harmful rather than beneficial.

For reclaim, it is unlikely that the pages reclaimed will form contiguous
memory the size of a hugepage without unnecessarily reclaiming a lot of
memory unnecessarily.  It is also not guaranteed to be beneficial to
compaction if the reclaimed memory is not accessible to the per-zone
freeing scanner.  For both of these reasons independently, all reclaim
activity may be entirely fruitless.

With these two issues, retrying compaction again is not likely to have a
different result.  It is better to fallback to pages of the native page
size and allow khugepaged to collapse the memory into a hugepage later
when the fragmentation or availability of local memory is better.

If __GFP_NORETRY is set, which the page allocator implementation is
expecting in its comments, this can prevent large amounts of unnecesary
reclaim and swapping activity that can cause performance of other
applications to quickly degrade.

Furthermore, since reclaim is likely to be more harmful than beneficial
for such large order allocations, it is better to fail earlier rather
than trying reclaim of SWAP_CLUSTER_MAX pages which is unlikely to make
a difference for memory compaction to become successful.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |  8 ++++----
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  3 +--
 include/linux/gfp.h                      |  3 ++-
 mm/huge_memory.c                         |  3 +--
 mm/page_alloc.c                          | 16 ++++++++++++++++
 5 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -860,8 +860,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
 			while (npages >= HPAGE_PMD_NR) {
 				gfp_t huge_flags = gfp_flags;
 
-				huge_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
-					__GFP_KSWAPD_RECLAIM;
+				huge_flags |= GFP_TRANSHUGE_LIGHT |
+					      __GFP_KSWAPD_RECLAIM;
 				huge_flags &= ~__GFP_MOVABLE;
 				huge_flags &= ~__GFP_COMP;
 				p = alloc_pages(huge_flags, HPAGE_PMD_ORDER);
@@ -978,13 +978,13 @@ int ttm_page_alloc_init(struct ttm_mem_global *glob, unsigned max_pages)
 				  GFP_USER | GFP_DMA32, "uc dma", 0);
 
 	ttm_page_pool_init_locked(&_manager->wc_pool_huge,
-				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				  (GFP_TRANSHUGE_LIGHT |
 				   __GFP_KSWAPD_RECLAIM) &
 				  ~(__GFP_MOVABLE | __GFP_COMP),
 				  "wc huge", order);
 
 	ttm_page_pool_init_locked(&_manager->uc_pool_huge,
-				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				  (GFP_TRANSHUGE_LIGHT |
 				   __GFP_KSWAPD_RECLAIM) &
 				  ~(__GFP_MOVABLE | __GFP_COMP)
 				  , "uc huge", order);
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -863,8 +863,7 @@ static gfp_t ttm_dma_pool_gfp_flags(struct ttm_dma_tt *ttm_dma, bool huge)
 		gfp_flags |= __GFP_ZERO;
 
 	if (huge) {
-		gfp_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
-			__GFP_KSWAPD_RECLAIM;
+		gfp_flags |= GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
 		gfp_flags &= ~__GFP_MOVABLE;
 		gfp_flags &= ~__GFP_COMP;
 	}
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -298,7 +298,8 @@ struct vm_area_struct;
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
-			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
+			 __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN) & \
+			 ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
 
 /* Convert GFP flags to their corresponding migrate type */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -636,8 +636,7 @@ static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, un
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | __GFP_THISNODE |
-		       (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | __GFP_THISNODE;
 
 	/* Kick kcompactd and fail quickly */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4139,6 +4139,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 			if (compact_result == COMPACT_DEFERRED)
 				goto nopage;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			/*
+			 * When faulting a hugepage, it is very unlikely that
+			 * thrashing the zonelist is going to help compaction in
+			 * freeing such a high-order page.  Reclaim would need
+			 * to free contiguous memory itself or guarantee the
+			 * reclaimed memory is accessible by the compaction
+			 * freeing scanner.  Since there is no such guarantee,
+			 * thrashing is more harmful than beneficial.  It is
+			 * better to simply fail and fallback to native pages.
+			 */
+			if (order == HPAGE_PMD_ORDER &&
+					!(current->flags & PF_KTHREAD))
+				goto nopage;
+#endif
+
 			/*
 			 * Looks like reclaim/compaction is worth trying, but
 			 * sync compaction could be very expensive, so keep
