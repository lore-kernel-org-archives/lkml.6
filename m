Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA83DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640FA20867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbRVvCuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640FA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeH1Stp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeH1Stn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9tBcS1QRQOB96RExgqPwsrGxCmJ5quUecq8Bctt4nyY=; b=pbRVvCuRqgWeE8eThkiSJUGOU
        0tGJ4MEa0VLyU0TeVTIpGmKyvTeR/wCdJAePZXYUat97fFyeh9/o47ljBZ8fdjCp30jfa50Pc9/Im
        sHHuvnMOJMpiHrYykf9eN8TqbFFX51oJEyLQ5gBPIWF5oZrdBTEkBkkHJZqWmgrvtmncnf3b20vcS
        8wC8Nu117GUJ3lO+CcSTqxxTf5eiyMn/E6TU8FGmXpNkdiSAJtV2tElE6lJBKeSHOH+qyuL5qIThA
        WmDim6UMO28VblH5IT1p7+l3I9Y2gaHsoHSyTOFGcFxUPfW0yI7X9cjkWNMQYqxuMIvkQNLGRQF7T
        9+UaGGUiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR5-0003Ba-6p; Tue, 28 Aug 2018 14:57:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] mm: Make vm_insert_pfn_prot static
Date:   Tue, 28 Aug 2018 07:57:23 -0700
Message-Id: <20180828145728.11873-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now this is no longer used outside mm/memory.c, make it static.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 50 +++++++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8bc1a16d44c..1552c67c835e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2480,8 +2480,6 @@ int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
-int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 8c116c0f64d8..8392a104a36d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1819,31 +1819,7 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	return retval;
 }
 
-/**
- * vm_insert_pfn - insert single pfn into user vma
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- *
- * Similar to vm_insert_page, this allows drivers to insert individual pages
- * they've allocated into a user vma. Same comments apply.
- *
- * This function should only be called from a vm_ops->fault handler, and
- * in that case the handler should return NULL.
- *
- * vma cannot be a COW mapping.
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- */
-int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn)
-{
-	return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
-}
-EXPORT_SYMBOL(vm_insert_pfn);
-
-int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+static int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
 	int ret;
@@ -1873,6 +1849,30 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
+/**
+ * vm_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_insert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return NULL.
+ *
+ * vma cannot be a COW mapping.
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ */
+int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn)
+{
+	return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(vm_insert_pfn);
+
 /**
  * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
-- 
2.18.0

