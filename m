Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98895C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600520879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcPW/+GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4600520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeLEWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:46:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35353 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLEWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:46:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so10730096pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=yGfgcwRGAlQUzInDvDMYZlup7dWVY1TstkoREPb0IGM=;
        b=fcPW/+GAzq+Ld3dRLPoj27pBQPtmKXPQTdZI0kbfGAvbT6dZO9M4ydFJg+oZMEJ60V
         TMI2lSU4pp/AT8QGzrdKFGleKW3Xwp7HZH1Q8QwY/I9abT5TwXqgBTTFhGJZAr7BKz+u
         FJJRgl/r7QjfXHhd7l5xEKRNQgqbwvhKu18ab/hkcuJwTednAE+iKVi31qeD1Dv3dJ+L
         t16FPDwDbKE3IV+v8//9XmJcIGbdIbpBOraTbiflnX6n+39RImehs7E1GAUBmxnW6GPt
         9xQodqlzQPxf8s3dz4fj1lniBX4xao+pTuCKsC4GVeypZUwvHwYwzxZ79oIYrXT4i10v
         9+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=yGfgcwRGAlQUzInDvDMYZlup7dWVY1TstkoREPb0IGM=;
        b=uZrv+k+QwpH/v3P0ZmynNB01WgSworj+d3d/6QSPJUl6J5j/PM9RHpelZZFlI0AgOp
         2mo0kc9Wv7c0uGa9rOoQ3o6oRSG7nzNkjv3XYg5LQpvKEAspX8IgelSGR33g9jJFgx0y
         LleoFpRtDruhHvNIipCwHmTRjrEuYJPZDzX35A8fhw7eQib0k71dsG++lyoyO/q91Gie
         Ns1WSHabLWJlF3OukvwliZj2ThiWlCIpLCCaSOHX0VIGGok8n/wa5hZlu9R4KzQ1mTGe
         Ss+QYNtrSIxIbpzso5XdQEz9Jxk57PQN8BfWS2TLLsr36q+UyXq0Roq52X0ofvaxjTqm
         Ih6A==
X-Gm-Message-State: AA+aEWZ+uO1Mnv/9yj3SMFbkvnPeTL0KOizd35b6TwSOqH4qWdYIl8aS
        P/FeRuFNOe3oxwOV4ecIGhbVRg==
X-Google-Smtp-Source: AFSGD/XAvYEsATA4VFxfnxhg+imFMswaSIzkryErzk8+B4OMSB4f133eixW9VHfJtYdMSVgmZ0UOoQ==
X-Received: by 2002:a65:560e:: with SMTP id l14mr22122260pgs.168.1544050012017;
        Wed, 05 Dec 2018 14:46:52 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e86sm28884951pfb.6.2018.12.05.14.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:46:51 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:46:50 -0800 (PST)
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
Subject: [patch v2 for-4.20] mm, thp: restore node-local hugepage
 allocations
Message-ID: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").

By not setting __GFP_THISNODE, applications can allocate remote hugepages
when the local node is fragmented or low on memory when either the thp
defrag setting is "always" or the vma has been madvised with
MADV_HUGEPAGE.

Remote access to hugepages often has much higher latency than local pages
of the native page size.  On Haswell, ac5b2c18911f was shown to have a
13.9% access regression after this commit for binaries that remap their
text segment to be backed by transparent hugepages.

The intent of ac5b2c18911f is to address an issue where a local node is
low on memory or fragmented such that a hugepage cannot be allocated.  In
every scenario where this was described as a fix, there is abundant and
unfragmented remote memory available to allocate from, even with a greater
access latency.

If remote memory is also low or fragmented, not setting __GFP_THISNODE was
also measured on Haswell to have a 40% regression in allocation latency.

Restore __GFP_THISNODE for thp allocations.

Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/mempolicy.h |  2 --
 mm/huge_memory.c          | 42 +++++++++++++++------------------------
 mm/mempolicy.c            |  2 +-
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,8 +139,6 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
-struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
-						unsigned long addr);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -632,37 +632,27 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
-	gfp_t this_node = 0;
-
-#ifdef CONFIG_NUMA
-	struct mempolicy *pol;
-	/*
-	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
-	 * specified, to express a general desire to stay on the current
-	 * node for optimistic allocation attempts. If the defrag mode
-	 * and/or madvise hint requires the direct reclaim then we prefer
-	 * to fallback to other node rather than node reclaim because that
-	 * can lead to excessive reclaim even though there is free memory
-	 * on other nodes. We expect that NUMA preferences are specified
-	 * by memory policies.
-	 */
-	pol = get_vma_policy(vma, addr);
-	if (pol->mode != MPOL_BIND)
-		this_node = __GFP_THISNODE;
-	mpol_cond_put(pol);
-#endif
+	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
 
+	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | __GFP_THISNODE |
+		       (vma_madvised ? 0 : __GFP_NORETRY);
+
+	/* Kick kcompactd and fail quickly */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM | this_node;
+		return gfp_mask | __GFP_KSWAPD_RECLAIM;
+
+	/* Synchronous compaction if madvised, otherwise kick kcompactd */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     __GFP_KSWAPD_RECLAIM | this_node);
+		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
+						  __GFP_KSWAPD_RECLAIM);
+
+	/* Only do synchronous compaction if madvised */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     this_node);
-	return GFP_TRANSHUGE_LIGHT | this_node;
+		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
+
+	return gfp_mask;
 }
 
 /* Caller must hold page table lock. */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1662,7 +1662,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
