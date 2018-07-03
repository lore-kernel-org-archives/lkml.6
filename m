Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02CDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5651A2101A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ka40s8Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5651A2101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbeGCPSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:18:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46365 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbeGCPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id o2-v6so1163232qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8+Op0cOVGDr+flcVsvXsJA1s5FSZo8o6CJIsY1IGKeg=;
        b=ka40s8Hbo0LSLY75T1H+AmYaZgYb28AOueXJJa5NggPzO33JzSdnTQkl3u5EJPDhEL
         RFsyUaB8pfbvHsU6Wttxl7gMn0RG6xxKM/r2rn6SySAMSn1vmMqn7eIQUsXVf4baw089
         SXGIHOqzJMFcJ16V3i6p9t/ERq0n4p6yQYqmtqZtA8zWHwKCXkwz+MN3D+QgxsUILlpf
         Vus5sgewd4FVN0u8aZnrOW536pu7vbyUR2tG7JjdavTULwOSqRjkO/XcqEIB0HOTJ9Ib
         ycjNkMgItun8XFQd2t3eaUge72/d/pLFG2pnP/5PJnH+ni+yMDMbtiNH8yPDF8SA3HmB
         mk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8+Op0cOVGDr+flcVsvXsJA1s5FSZo8o6CJIsY1IGKeg=;
        b=X84NCoDjpoF5+ZYj23302tLzCUPMYP6dkFhaGtP4OHfiISeUZonO89n7FaBddJerIv
         OA3ulwVX++DfGhT17nhEWZvWg5O//3xDSykwcOJ6+R2II7AExJKx8gA8nnhen7AyeBRU
         o7f7pW7/hwiFwb/PCdAaAGDMy6j/P1Xq57gxCsqajEuwgivmsKkHSt7geBboVv4Y8r5y
         RKEAGqNRWZiGmH57k1PGBn9o3ioj1di5Boxj3uP/ChMjHHl1tuv34/01njcPwc3Nc+Fo
         6t9ObEInudlRG3JMKYXQcYhCGtWcoFDOF0hspOVP1AZqNHSvKQZ/uUvoOhrzzTQL/p9Q
         pYkQ==
X-Gm-Message-State: APt69E2eEL7x6zF9qA/yIpcWfLFNmrYAbYaHMgHgAQzwwz3gsQNf6jVF
        DKCbMYJWsqh5Mt4MtWHeogAYTQ==
X-Google-Smtp-Source: AAOMgpfnKjfGokmnOoBgtLOraNy4XPZm6aEP0cZdPZYfw4YLdPRJsDSLk3RMxtLdNi4+01vnWP6OJw==
X-Received: by 2002:a37:c249:: with SMTP id j9-v6mr23020650qkm.157.1530630917247;
        Tue, 03 Jul 2018 08:15:17 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h38-v6sm960868qth.85.2018.07.03.08.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 07/14] memcontrol: schedule throttling if we are congested
Date:   Tue,  3 Jul 2018 11:14:56 -0400
Message-Id: <20180703151503.2549-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
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
Acked-by: Andrew Morton <akpm@linux-foundation.org>
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
index 4f52ec755725..d8e06a316e98 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -316,6 +316,9 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
 			  bool compound);
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound);
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 			      bool lrucare, bool compound);
 void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
@@ -771,6 +774,16 @@ static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
index c063443d8638..1a8bd05a335e 100644
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
index ba8fdc0b6e7f..bb1f43eef292 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -552,7 +552,7 @@ static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp, &memcg, true)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1142,7 +1142,7 @@ static int do_huge_pmd_wp_page_fallback(struct vm_fault *vmf, pmd_t orig_pmd,
 		pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
-			     mem_cgroup_try_charge(pages[i], vma->vm_mm,
+			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
 				     GFP_KERNEL, &memcg, false))) {
 			if (pages[i])
 				put_page(pages[i]);
@@ -1312,7 +1312,7 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, vma->vm_mm,
+	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
 					huge_gfp, &memcg, true))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1e64d60ed02..5c8e1c931f75 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5587,6 +5587,19 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
index 7206a634270b..dfe80c574282 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2503,7 +2503,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 		cow_user_page(new_page, old_page, vmf->address, vma);
 	}
 
-	if (mem_cgroup_try_charge(new_page, mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
 		goto oom_free_new;
 
 	__SetPageUptodate(new_page);
@@ -3003,8 +3003,8 @@ int do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL,
-				&memcg, false)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL,
+					&memcg, false)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
@@ -3165,7 +3165,8 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg,
+					false))
 		goto oom_free_page;
 
 	/*
@@ -3661,7 +3662,7 @@ static int do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
+	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
 				&vmf->memcg, false)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
diff --git a/mm/shmem.c b/mm/shmem.c
index e9a7ac74823d..5d0fb6fda94e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1239,8 +1239,8 @@ int shmem_unuse(swp_entry_t swap, struct page *page)
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
@@ -1712,7 +1712,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 				goto failed;
 		}
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				false);
 		if (!error) {
 			error = shmem_add_to_page_cache(page, mapping, index,
@@ -1818,7 +1818,7 @@ alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, inode,
 		if (sgp == SGP_WRITE)
 			__SetPageReferenced(page);
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				PageTransHuge(page));
 		if (error)
 			goto unacct;
@@ -2291,7 +2291,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
-	ret = mem_cgroup_try_charge(page, dst_mm, gfp, &memcg, false);
+	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
 	if (ret)
 		goto out_release;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78a015fcec3b..641be3d7798a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3730,6 +3730,37 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
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

