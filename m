Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C90C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C067B20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWmkbCrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C067B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLFWAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:00:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32886 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeLFWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:00:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so749769pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=i4WHwLL8nrvBGhlnmQBClzLxgWS8npDJmDeSthaOXuM=;
        b=pWmkbCrFbsrKoKRgg0z3r/jwHC+uR2TrHaiiQVcD//VHjZTgVv+xu2bXu5O24Hksed
         Tr6rSK4tlHzjwUMTKv5bVkGPGKuAhNFoz3Pb7ZpsY4CrzJ/NCNotMqLEB/qgfeOnCpRw
         lF00o0HZp484GWAL27rgzrWFZMsD4yzr+NQJ5S3g24JJJhlWQHWbL0ODLjwlilQpmNRv
         qGuIYXnK79evLEaT2o9oIrwn1ZyJ/ZHSiBTrrEYd4oGkaF+dtBOQG3iNrl0Q8G5Fkag0
         M3slbQYT+AT+MRKiTp5ZpHhr37G8KQKkCh1q4hZWSY/meH5AnZvmryoUaU5a9DnupAeS
         GRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=i4WHwLL8nrvBGhlnmQBClzLxgWS8npDJmDeSthaOXuM=;
        b=Ad+Q5pgrZu1VLa/irXobtJTD8osTTqdC0K7q4H/VdcLFjAvj3g+pGJyefkDCl5g7T4
         fzJhlLIKpCuz6aGZJEfkteZOuHH7W6xvVcSF/7oqRnJ3wkEmaCmaUrvK3NWijf/BrgX2
         s8qqQSKeXe6zLPhs9vgW/Nw542YfsHCY/Qgmu4kihxjt4r13qupxwM5v1OFAYRfusmuS
         4/3g+C2VF8S03eW6cw3ucGSFvDocxj5ytJMq11TKaaf8LVEL3QDsK1dEdgjL6gQ4ghL3
         5ybXbKcFFsmQSADucPnZueHBWAioHQuzcmPlou+snLr72lk4g4tIeyLX1oshoQ/Dc8uO
         E3VA==
X-Gm-Message-State: AA+aEWbxlhC/XVy+KXwY3Kz3DaCRBWP6RX9OGXYtBOfOWXeS/eWLXZnN
        CUp+mfTzX92XrPnKab0eiqeW5w==
X-Google-Smtp-Source: AFSGD/XcqGiA5CtiiGGGY3YqNxr5e06tjqM/K3vJ+ibWwpwlWEa1UVlPjrnRZJl6/qhFargrtVRYWg==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr25297768pgl.274.1544133622308;
        Thu, 06 Dec 2018 14:00:22 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d11sm1321251pgi.25.2018.12.06.14.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:00:21 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:00:20 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: [patch for-4.20] Revert "mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask"
In-Reply-To: <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1812061343240.144733@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com> <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 89c83fb539f95491be80cdd5158e6f0ce329e317.

There are a couple of issues with 89c83fb539f9 independent of its partial 
revert in 2f0799a0ffc0 ("mm, thp: restore node-local hugepage 
allocations"):

Firstly, the interaction between alloc_hugepage_direct_gfpmask() and 
alloc_pages_vma() is racy wrt __GFP_THISNODE and MPOL_BIND.  
alloc_hugepage_direct_gfpmask() makes sure not to set __GFP_THISNODE for 
an MPOL_BIND policy but the policy used in alloc_pages_vma() may not be 
the same for shared vma policies, triggering the WARN_ON_ONCE() in 
policy_node().

Secondly, prior to 89c83fb539f9, alloc_pages_vma() implemented a somewhat 
different policy for hugepage allocations, which were allocated through 
alloc_hugepage_vma().  For hugepage allocations, if the allocating 
process's node is in the set of allowed nodes, allocate with 
__GFP_THISNODE for that node (for MPOL_PREFERRED, use that node with 
__GFP_THISNODE instead).  This was changed for shmem_alloc_hugepage() to 
allow fallback to other nodes in 89c83fb539f9 as it did for new_page() in 
mm/mempolicy.c which is functionally different behavior and removes the 
requirement to only allocate hugepages locally.

The latter should have been reverted as part of 2f0799a0ffc0 as well.

Fully revert 89c83fb539f9 so that hugepage allocation policy is fully 
restored and there is no race between alloc_hugepage_direct_gfpmask() and 
alloc_pages_vma().

Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
Fixes: 2f0799a0ffc0 ("mm, thp: restore node-local hugepage allocations")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/gfp.h | 12 ++++++++----
 mm/huge_memory.c    | 27 +++++++++++++--------------
 mm/mempolicy.c      | 32 +++++++++++++++++++++++++++++---
 mm/shmem.c          |  2 +-
 4 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -510,18 +510,22 @@ alloc_pages(gfp_t gfp_mask, unsigned int order)
 }
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
-			int node);
+			int node, bool hugepage);
+#define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
+	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)
 #else
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
-#define alloc_pages_vma(gfp_mask, order, vma, addr, node)\
+#define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
+	alloc_pages(gfp_mask, order)
+#define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
 	alloc_pages(gfp_mask, order)
 #endif
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id())
+	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
 #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, node)
+	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -629,30 +629,30 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
+static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
-	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | __GFP_THISNODE |
-		       (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
 
 	/* Kick kcompactd and fail quickly */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | __GFP_KSWAPD_RECLAIM;
+		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
 
 	/* Synchronous compaction if madvised, otherwise kick kcompactd */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-						  __GFP_KSWAPD_RECLAIM);
+		return GFP_TRANSHUGE_LIGHT |
+			(vma_madvised ? __GFP_DIRECT_RECLAIM :
+					__GFP_KSWAPD_RECLAIM);
 
 	/* Only do synchronous compaction if madvised */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
+		return GFP_TRANSHUGE_LIGHT |
+		       (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
 
-	return gfp_mask;
+	return GFP_TRANSHUGE_LIGHT;
 }
 
 /* Caller must hold page table lock. */
@@ -724,8 +724,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			pte_free(vma->vm_mm, pgtable);
 		return ret;
 	}
-	gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
-	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, vma, haddr, numa_node_id());
+	gfp = alloc_hugepage_direct_gfpmask(vma);
+	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1295,9 +1295,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 alloc:
 	if (transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow()) {
-		huge_gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
-		new_page = alloc_pages_vma(huge_gfp, HPAGE_PMD_ORDER, vma,
-				haddr, numa_node_id());
+		huge_gfp = alloc_hugepage_direct_gfpmask(vma);
+		new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
 	} else
 		new_page = NULL;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1116,8 +1116,8 @@ static struct page *new_page(struct page *page, unsigned long start)
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-		thp = alloc_pages_vma(GFP_TRANSHUGE, HPAGE_PMD_ORDER, vma,
-				address, numa_node_id());
+		thp = alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
+					 HPAGE_PMD_ORDER);
 		if (!thp)
 			return NULL;
 		prep_transhuge_page(thp);
@@ -2011,6 +2011,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  * 	@vma:  Pointer to VMA or NULL if not available.
  *	@addr: Virtual Address of the allocation. Must be inside the VMA.
  *	@node: Which node to prefer for allocation (modulo policy).
+ *	@hugepage: for hugepages try only the preferred node if possible
  *
  * 	This function allocates a page from the kernel page pool and applies
  *	a NUMA policy associated with the VMA or the current process.
@@ -2021,7 +2022,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  */
 struct page *
 alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr, int node)
+		unsigned long addr, int node, bool hugepage)
 {
 	struct mempolicy *pol;
 	struct page *page;
@@ -2039,6 +2040,31 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		int hpage_node = node;
+
+		/*
+		 * For hugepage allocation and non-interleave policy which
+		 * allows the current node (or other explicitly preferred
+		 * node) we only try to allocate from the current/preferred
+		 * node and don't fall back to other nodes, as the cost of
+		 * remote accesses would likely offset THP benefits.
+		 *
+		 * If the policy is interleave, or does not allow the current
+		 * node in its nodemask, we allocate the standard way.
+		 */
+		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+			hpage_node = pol->v.preferred_node;
+
+		nmask = policy_nodemask(gfp, pol);
+		if (!nmask || node_isset(hpage_node, *nmask)) {
+			mpol_cond_put(pol);
+			page = __alloc_pages_node(hpage_node,
+						gfp | __GFP_THISNODE, order);
+			goto out;
+		}
+	}
+
 	nmask = policy_nodemask(gfp, pol);
 	preferred_nid = policy_node(gfp, pol, node);
 	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1439,7 +1439,7 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
 	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id());
+			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
