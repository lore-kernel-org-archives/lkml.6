Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3944463-1519939007-2-11673246854732370803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519939006; b=MaY5hzBctSbyNdyQRQ4PN62WOx2h4W6bOEHPB+g/gVd/Mjx
    G+VOMRg8SRgF7S587wlpCC2yqez5eC/rs4HK6wdRktLE5HbCXfCMgIfceRABqPE6
    xxUPzxRtWLPmYM01UOYqDE3mUBltkRWf3UnmYJPHRVznxD7iec2sd424KUWp/doC
    3d/O6BL5+dBw3NBwiSO42uS0Ib7VoNpNVqnu1v4ukmxUdOIDR8dJ1NN1JgMRTnrW
    LsFPFGAoB7rWmhy/eqZFPR9oyaSr7J7wVef9KwROipScw/uccz6R85K9we9qe6tN
    YOZ3z0ugVqT1IC3VV/ZQQ8TOYwwyCoeO2GTWVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519939006;
    bh=G5v2JpPvaPIXZl675mzsoXFe3MAXuhfa7DcjDHWL/dI=; b=IIj28dXl6rKo
    Zv2ceYTulKRCTI67+FjoLiIhg5Gom0MYrEVw8GRY8LTjYe4mRziIYxhRlbEMPbiE
    nL0XYruYaS+65g2qMKRQU/Z+eGP/Gf6ipEoYZb1SmvmdA8nG6jZmy39H5ZqtPlpr
    HiC0wrMYA7H2ad/GN0iRHkBIUio+OvtH3ZYmOs4KqCkFAjTnlQGDVqwNEFIWiyXD
    r1t52O+vvjdyENEMSPd68mY/87di6MnoysmyaJmJ/uHeGWQ/AH214EZpeon942Nr
    yWKJksPTDqbjgIDB0AWErrm8jSBYveoIgAK3WHrsXPYBHd4wJPoedyY9BL2Iy16Q
    /Cv+9hD+PQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jL3Z22F2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jL3Z22F2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161848AbeCAVQB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 16:16:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034173AbeCAVPc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Mar 2018 16:15:32 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v4 3/4] mm: Mark pages allocated through vmalloc
Date: Thu,  1 Mar 2018 13:15:22 -0800
Message-Id: <20180301211523.21104-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301211523.21104-1-willy@infradead.org>
References: <20180301211523.21104-1-willy@infradead.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Use a bit in page_type to mark pages which have been allocated through
vmalloc.  This can be helpful when debugging crashdumps or analysing
memory fragmentation.  Add a KPF flag to report these pages to userspace
and update page-types.c to interpret that flag.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/proc/page.c                         | 2 ++
 include/linux/page-flags.h             | 6 ++++++
 include/uapi/linux/kernel-page-flags.h | 2 +-
 mm/vmalloc.c                           | 2 ++
 tools/vm/page-types.c                  | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 1491918a33c3..c9757af919a3 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -154,6 +154,8 @@ u64 stable_page_flags(struct page *page)
 
 	if (PageBalloon(page))
 		u |= 1 << KPF_BALLOON;
+	if (PageVmalloc(page))
+		u |= 1 << KPF_VMALLOC;
 
 	if (page_is_idle(page))
 		u |= 1 << KPF_IDLE;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d151f590bbc6..8142ab716e90 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -643,6 +643,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_buddy	0x00000080
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
+#define PG_vmalloc	0x00000400
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -681,6 +682,11 @@ PAGE_TYPE_OPS(Balloon, balloon)
  */
 PAGE_TYPE_OPS(Kmemcg, kmemcg)
 
+/*
+ * Pages allocated through vmalloc are tagged with this bit.
+ */
+PAGE_TYPE_OPS(Vmalloc, vmalloc)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index fa139841ec18..5f1735ff05b3 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -35,6 +35,6 @@
 #define KPF_BALLOON		23
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
-
+#define KPF_VMALLOC		26
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729cc956..3bc0538fc21b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1536,6 +1536,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			__ClearPageVmalloc(page);
 			__free_pages(page, 0);
 		}
 
@@ -1705,6 +1706,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			area->nr_pages = i;
 			goto fail;
 		}
+		__SetPageVmalloc(page);
 		area->pages[i] = page;
 		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
 			cond_resched();
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index a8783f48f77f..116f59eff5e2 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -131,6 +131,7 @@ static const char * const page_flag_names[] = {
 	[KPF_KSM]		= "x:ksm",
 	[KPF_THP]		= "t:thp",
 	[KPF_BALLOON]		= "o:balloon",
+	[KPF_VMALLOC]		= "V:vmalloc",
 	[KPF_ZERO_PAGE]		= "z:zero_page",
 	[KPF_IDLE]              = "i:idle_page",
 
-- 
2.16.1

