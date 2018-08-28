Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58399C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0964720867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jdK7t+GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0964720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeH1SuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:50:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeH1Sto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yIwb6uEk5/hv3Tvm4Xff2KDOLO6LMMPMM9lI85j8icw=; b=jdK7t+GJO9QxRmlulZaY5yL/W
        OdR3fcQJKAtlhRmv5uVYKENCdMZbmVFAny4B1K51WA1i0sI/Yn7KEV9G+H93xvEzgwvL/B6KUCPVI
        /+nXfAIcAKWgJnMOG5i2nRBz/V2Kz6Zc920fR+886fWGd+Qu7+sKLDhfSVFP7Vf4xgkhXvgLF2ND1
        XGgy7/e7rciYG6915eCcateQmg42qd/7s6MtJNs0vjeZPLjlNH7eZlDQAmfCLIS5z2tvWfogIx4TX
        LrVEy2yxzm0+51aPCOBM0EPUXXWwQiD0PxT/Itcs/5+fAtVjDinGzVGXs7L9bMWTF5sIy71VvMO4W
        qkyTiFWBA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR6-0003Bz-1X; Tue, 28 Aug 2018 14:57:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] mm: Remove references to vm_insert_pfn
Date:   Tue, 28 Aug 2018 07:57:24 -0700
Message-Id: <20180828145728.11873-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation and comments.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 Documentation/x86/pat.txt     | 4 ++--
 include/asm-generic/pgtable.h | 4 ++--
 include/linux/hmm.h           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
index 2a4ee6302122..481d8d8536ac 100644
--- a/Documentation/x86/pat.txt
+++ b/Documentation/x86/pat.txt
@@ -90,12 +90,12 @@ pci proc               |    --    |    --      |       WC         |
 Advanced APIs for drivers
 -------------------------
 A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
-vm_insert_pfn
+vmf_insert_pfn
 
 Drivers wanting to export some pages to userspace do it by using mmap
 interface and a combination of
 1) pgprot_noncached()
-2) io_remap_pfn_range() or remap_pfn_range() or vm_insert_pfn()
+2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
 
 With PAT support, a new API pgprot_writecombine is being added. So, drivers can
 continue to use the above sequence, with either pgprot_noncached() or
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc6102c7c..5657a20e0c59 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -757,7 +757,7 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 /*
  * Interfaces that can be used by architecture code to keep track of
  * memory type of pfn mappings specified by the remap_pfn_range,
- * vm_insert_pfn.
+ * vmf_insert_pfn.
  */
 
 /*
@@ -773,7 +773,7 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 
 /*
  * track_pfn_insert is called when a _new_ single pfn is established
- * by vm_insert_pfn().
+ * by vmf_insert_pfn().
  */
 static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 				    pfn_t pfn)
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4c92e3ba3e16..dde947083d4e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -107,7 +107,7 @@ enum hmm_pfn_flag_e {
  * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
  * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
  * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
- *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
+ *      result of vmf_insert_pfn() or vm_insert_page(). Therefore, it should not
  *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
  *      set and the pfn value is undefined.
  *
-- 
2.18.0

