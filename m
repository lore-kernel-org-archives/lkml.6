Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2698890-1527628671-2-17122677882616232801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527628671; b=IXpUP6kWBFkcEJC09loMGUpEYUDv6I/CXlVmSqbolpB7qNcZ1I
    8nQVDwtIrJVvyuwR75dh0jD+u+SH3othqLF48WHcaHojX8o0ajcPm0LWETdDxM27
    TlYaKo2i9/YWs8svAGYh/pf3dBfTzraH/l840TNMYvmFhumICK3EnZZrbFX7M64q
    ASOePb1g8SOwjV4g7dLyJwPRZ//5E6FgDWUwvBkVB5AM8tw7Er9Y4Wo0AGg7eUOi
    lUNr/AdSPRXWQlborCSkMwA0I0J4OcW3u/tdcevdd7UG/cYLWgh0uUNugqcPpfCe
    2TPNoScxLQWl6u79HEhhRPF2ulKyqVD7tWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527628671; bh=
    OnLfniKgYvskwWLXSUKc15Ogio1wVy7+KmfqXSJANSw=; b=fkGv2hiEoq/hVp13
    3WVK5AAfURZyrbt68K35RgTdqbSx/AMjeWD3XNVp7THRCkWg1+SBd1PD9LUy83IW
    nBw7xBcushKbtigHsCe2m+9ZzjDn0jx+cLmgDvxLw8vm7tbX88RMbAC1+868GWMP
    DobWs12Y+kvaeDJAAgFplLDp4h63xe8gatWNWxjCk7OrNtWyq8zdK3bZqLfpsplg
    kk5BZ1GyRzRK2PQcHj9DK2ednZI//g0z76FhJrGIwTBTGtKmU9ScstCgM2FjxT3q
    61jHxamMqTO8XnXUhMucBMIm+HCUz5Udv7fKgHb1ZPbCdm/24cFLndXk+ddyk6mR
    cSY66A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=ba/vFuCJ
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=aKnjv6iA;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=ba/vFuCJ
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=aKnjv6iA;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEyNmU6JBZ8ChAqvUliFBrLWxF+4S4JM/7+RBBayKsGj7KR3fb0ReUPv4q8QvuXYCYiuUl0Y14pz/9RBNSmqDtbIWMBDdDO6Kgh2w8zHTcbWGmm2zlo+
    8Y42JN7dvSHBLe6G6IFzPAGXMQkni0NdLOgJQxfoJ0wd2YFLOoXFl3Pd4Kp5N2aSKWLOzwQArO5Powpn0rjsQrCLxX9SVQeGnxxVO07JCgfP4ryIj+P51e7t
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=aZCaZX4_P84BxEb25-sA:9 a=rEMekQRoeU6-jLhe:21
    a=FrbFlGMskBydMvSd:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967228AbeE2VRr (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 17:17:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45872 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966847AbeE2VRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 17:17:38 -0400
X-Google-Smtp-Source: ADUXVKKIvwUqU7vC0+vLDAA2I7uxeDDG1pW5+MNyzUxb6vg+Xyw9a5GM95vjIYEHesdo2tuTAhi7zQ==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/13] memcontrol: schedule throttling if we are congested
Date: Tue, 29 May 2018 17:17:18 -0400
Message-Id: <20180529211724.4531-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529211724.4531-1-josef@toxicpanda.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tejun Heo <tj@kernel.org>

Memory allocations can induce swapping via kswapd or direct reclaim.  If
we are having IO done for us by kswapd and don't actually go into direct
reclaim we may never get scheduled for throttling.  So instead check to
see if our cgroup is congested, and if so schedule the throttling.
Before we return to user space the throttling stuff will only throttle
if we actually required it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/memcontrol.h | 13 +++++++++++++
 mm/huge_memory.c           |  6 +++---
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 mm/memory.c                | 11 ++++++-----
 mm/shmem.c                 | 10 +++++-----
 5 files changed, 51 insertions(+), 13 deletions(-)

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
index 2bd3df3d101a..81f61b66d27a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5458,6 +5458,30 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 	return ret;
 }
 
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound)
+{
+	struct mem_cgroup *memcg;
+	struct block_device *bdev;
+	int ret;
+
+	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp, compound);
+	memcg = *memcgp;
+
+	if (!(gfp_mask & __GFP_IO) || !memcg)
+		return ret;
+#if defined(CONFIG_BLOCK) && defined(CONFIG_SWAP)
+	if (atomic_read(&memcg->css.cgroup->congestion_count) &&
+	    has_usable_swap()) {
+		map_swap_page(page, &bdev);
+
+		blkcg_schedule_throttle(bdev_get_queue(bdev), true);
+	}
+#endif
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
 
-- 
2.14.3
