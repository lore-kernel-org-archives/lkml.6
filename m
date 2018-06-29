Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693DE27D21
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="FsPUSl4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693DE27D21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936513AbeF2T0N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:26:13 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43589 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935370AbeF2TZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:56 -0400
Received: by mail-qt0-f169.google.com with SMTP id c8-v6so8819812qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NHcNBLt5ikQuPglpTXQpEK1D++BE2qcXd62TWaCzit4=;
        b=FsPUSl4SmLNQYf2LFMqsv1grq2OXdZAK7BVW8lY3qyw2JwNnKI5bzQF68pZpwwBpph
         HJG9VutjPq9TZyQrkYs5ewSCSeZk/sDe+NXF+EcrM1E2/kr7vRqnv7QVLEoYNL/BeZ3b
         +pGy5+ZgIImN21LfD2LeOid/XPj7GhDilBKChiAPCdfHZ+jOka7AL8VTYnFeRyStb5+V
         wu8o/hgV72xWr8nIeZCD5N5kLkyOXcR/ROPSwdRo1GjOxMGiGKdgVXMmw4gZHEUMkM1R
         CdDnm2uq9Ewz3yLK1VqeMpmQIeYeD1f5TBHL0hMKWVdZ6AUMakKSiPfiF5V+OZX2CYJ5
         yCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NHcNBLt5ikQuPglpTXQpEK1D++BE2qcXd62TWaCzit4=;
        b=Ac/WbuQI1iBrNz9UWj+qdCRi6Q+0x9hHxM73+DKZyFJMBWMogg4qygAwOKWPa2t/Uk
         pXohc1uqBlvbh1YbMkUqMwCfS50ILt0kVZQpG9Uh4zflwxmOlSPgSJbe3peFz048F0l1
         V+DtyeksFfrlyBrntKmaoqb1jLWQyFbvmwCB3yLPU+vCiOQgMMluCV0H0e5vOFKO3JWN
         ugcMpmjLPk3o7BE+soi3ReSBFdaKePNMZOU4V+9AC7xUx3m2730ULt0lI/Jbq67/v4ws
         R+cMWyrpRyOE29kmz0GEIQiGXORJZFjf4OTnuNc/1xKpRgwG3BDKosqexCu0/3shmpsN
         j1xg==
X-Gm-Message-State: APt69E0JNWhy6EM8kmU6lMCHHHzLaMu2g4QZkORPH+ldsLdxlfPhoXCj
        rvGOMcQz/8JvrVX4ChIIySGq1A==
X-Google-Smtp-Source: AAOMgpe+4mQAoWijSzOil4Si1k+LhpmRE5zlO5z3C5ohSSQu6ILeJZljbEue4X29WvKk/3NdlUJKPA==
X-Received: by 2002:ac8:2541:: with SMTP id 1-v6mr3890394qtn.248.1530300355064;
        Fri, 29 Jun 2018 12:25:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q13-v6sm8293955qkl.97.2018.06.29.12.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/14] memcontrol: schedule throttling if we are congested
Date:   Fri, 29 Jun 2018 15:25:35 -0400
Message-Id: <20180629192542.26649-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

Memory allocations can induce swapping via kswapd or direct reclaim.  If
we are having IO done for us by kswapd and don't actually go into direct
reclaim we may never get scheduled for throttling.  So instead check to
see if our cgroup is congested, and if so schedule the throttling.
Before we return to user space the throttling stuff will only throttle
if we actually required it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 13 +++++++++++++
 include/linux/swap.h       | 11 ++++++++++-
 mm/huge_memory.c           |  6 +++---
 mm/memcontrol.c            | 13 +++++++++++++
 mm/memory.c                | 11 ++++++-----
 mm/shmem.c                 | 10 +++++-----
 mm/swapfile.c              | 31 +++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..4d2e7f35f2dc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -290,6 +290,9 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
 			  bool compound);
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound);
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 			      bool lrucare, bool compound);
 void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
@@ -745,6 +748,16 @@ static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mem_cgroup_try_charge_delay(struct page *page,
+					      struct mm_struct *mm,
+					      gfp_t gfp_mask,
+					      struct mem_cgroup **memcgp,
+					      bool compound)
+{
+	*memcgp = NULL;
+	return 0;
+}
+
 static inline void mem_cgroup_commit_charge(struct page *page,
 					    struct mem_cgroup *memcg,
 					    bool lrucare, bool compound)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2417d288e016..12725a4d82f0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -629,7 +629,6 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 
 	return memcg->swappiness;
 }
-
 #else
 static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 {
@@ -637,6 +636,16 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 }
 #endif
 
+#if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+extern void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
+					 gfp_t gfp_mask);
+#else
+static inline void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg,
+						int node, gfp_t gfp_mask)
+{
+}
+#endif
+
 #ifdef CONFIG_MEMCG_SWAP
 extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
 extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3a1815f8e11..9812ddad9961 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,7 +555,7 @@ static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp, &memcg, true)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1145,7 +1145,7 @@ static int do_huge_pmd_wp_page_fallback(struct vm_fault *vmf, pmd_t orig_pmd,
 		pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
-			     mem_cgroup_try_charge(pages[i], vma->vm_mm,
+			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
 				     GFP_KERNEL, &memcg, false))) {
 			if (pages[i])
 				put_page(pages[i]);
@@ -1315,7 +1315,7 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, vma->vm_mm,
+	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
 					huge_gfp, &memcg, true))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..5fffd28477c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5458,6 +5458,19 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 	return ret;
 }
 
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp, compound);
+	memcg = *memcgp;
+	mem_cgroup_throttle_swaprate(memcg, page_to_nid(page), gfp_mask);
+	return ret;
+}
+
 /**
  * mem_cgroup_commit_charge - commit a page charge
  * @page: page to charge
diff --git a/mm/memory.c b/mm/memory.c
index 01f5464e0fd2..d0eea6d33b18 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2494,7 +2494,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 		cow_user_page(new_page, old_page, vmf->address, vma);
 	}
 
-	if (mem_cgroup_try_charge(new_page, mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
 		goto oom_free_new;
 
 	__SetPageUptodate(new_page);
@@ -2994,8 +2994,8 @@ int do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL,
-				&memcg, false)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL,
+					&memcg, false)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
@@ -3156,7 +3156,8 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg,
+					false))
 		goto oom_free_page;
 
 	/*
@@ -3652,7 +3653,7 @@ static int do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
+	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
 				&vmf->memcg, false)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
diff --git a/mm/shmem.c b/mm/shmem.c
index 9d6c7e595415..a96af5690864 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1219,8 +1219,8 @@ int shmem_unuse(swp_entry_t swap, struct page *page)
 	 * the shmem_swaplist_mutex which might hold up shmem_writepage().
 	 * Charged back to the user (not to caller) when swap account is used.
 	 */
-	error = mem_cgroup_try_charge(page, current->mm, GFP_KERNEL, &memcg,
-			false);
+	error = mem_cgroup_try_charge_delay(page, current->mm, GFP_KERNEL,
+					    &memcg, false);
 	if (error)
 		goto out;
 	/* No radix_tree_preload: swap entry keeps a place for page in tree */
@@ -1697,7 +1697,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 				goto failed;
 		}
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				false);
 		if (!error) {
 			error = shmem_add_to_page_cache(page, mapping, index,
@@ -1803,7 +1803,7 @@ alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, inode,
 		if (sgp == SGP_WRITE)
 			__SetPageReferenced(page);
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				PageTransHuge(page));
 		if (error)
 			goto unacct;
@@ -2276,7 +2276,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
-	ret = mem_cgroup_try_charge(page, dst_mm, gfp, &memcg, false);
+	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
 	if (ret)
 		goto out_release;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cc2cf04d9018..2a74c76dec1f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3725,6 +3725,37 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 	}
 }
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
+				  gfp_t gfp_mask)
+{
+	struct swap_info_struct *si, *next;
+	if (!(gfp_mask & __GFP_IO) || !memcg)
+		return;
+
+	if (!blk_cgroup_congested())
+		return;
+
+	/*
+	 * We've already scheduled a throttle, avoid taking the global swap
+	 * lock.
+	 */
+	if (current->throttle_queue)
+		return;
+
+	spin_lock(&swap_avail_lock);
+	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
+				  avail_lists[node]) {
+		if (si->bdev) {
+			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
+						true);
+			break;
+		}
+	}
+	spin_unlock(&swap_avail_lock);
+}
+#endif
+
 static int __init swapfile_init(void)
 {
 	int nid;
-- 
2.14.3

