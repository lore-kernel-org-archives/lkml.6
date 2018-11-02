Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1741C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A9B2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeKCAeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:34:16 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKCAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:34:16 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpUQm-1fkbtv0co8-00psVf; Fri, 02 Nov 2018 16:26:27 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpUQm-1fkbtv0co8-00psVf; Fri, 02 Nov 2018 16:26:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hide unused swiotlb functions
Date:   Fri,  2 Nov 2018 16:26:07 +0100
Message-Id: <20181102152624.1189250-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:nCNobV5nkfMsmcJ90ROBj8orktsO+6LRBsyBptMRjN1OTdoTmzO
 qXwwZq/400SznBVzzHF1Jp8oFMF+UWbR8c1Ayr78PaXDee4gwzvfDYwiydcl1Te1so9lLZd
 x6n0926Pw9z7utu69cTtEN2MCJC7GIWKNixTHcpJuBWCvBt340lI5ooa8eHrz49w/ByH9d0
 1/AuAKklLf4CIK2eSk/Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZoGz1/CV6KA=:XrGZ25MPya55RcATpawBlL
 AnL6gekBndH7pDvAHsAaWkCVMD5vfvl0TfnCUtE3rblrhNHtxJHXsWhGpGtxba+8XdCI/N+vt
 PgwfOluK25Ot84QPfGkvoq4HVS5Iy9frnr/GYcPWPuRAFqgAscTdui6ww8k500KSWBMCstdIp
 55s9YopowXBeG+tky4hECO0CozWktmkU5NbBwbRUPIpXbLkZ2mmCYexlnf+AqKz/bG50Un1fX
 H4PhlUsFDMsdsFZwxfFEvC1m0HSTl1TQvpBvJbcRM3Lzv5wd2xwK+eORCPfWdS4cS0A82J1/8
 DnK/2Y7FuCIZOWHMyJYt1914yzhWYLJAT23Fltj00OjNYgzs9voMS0cutuibLFaCJaA3ZUthB
 wDpwn4ubMvncx3uxOWAQAZL4Tp58o1GeJYhTebCIXisl3+2KeYfQVydKyBA9Xd3Mdxjxlw1QX
 2mtf1JZIYjKCDGAVCMLX1BvLis++IWGkXjqSsJWG/1PhWnPGOSe3Y4doz6X83wM8fWPdocsro
 EhnKoXzrVFh0zVvQH9PwiSnSx7xnUe/bDuKb485keKVU/3inlmEQ6IYzYDfF9HZoYUtEgA9+n
 Gxz6QZgI6DP6rU1XHDwGsPTUV9zeWO8VeOXKFB+iZzmqzGu3an30BLhTYkXrmlmivY8ReqVL0
 3E/7vbYQcKTtbbe5drviAWO74O2NomSMeN2ZSSV6y+CPICpmAFI9PunsFmd8ZBVP/9rQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a good chunk of the swiotlb code has been replaced with the generic
version, two functions are only used from inside of an #ifdef:

arch/arm64/mm/dma-mapping.c:174:12: error: '__swiotlb_mmap_pfn' defined but not used [-Werror=unused-function]
 static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
            ^~~~~~~~~~~~~~~~~~
arch/arm64/mm/dma-mapping.c:163:12: error: '__swiotlb_get_sgtable_page' defined but not used [-Werror=unused-function]
 static int __swiotlb_get_sgtable_page(struct sg_table *sgt,

Move them into the same #ifdef section to avoid that warning.

Fixes: 886643b76632 ("arm64: use the generic swiotlb_dma_ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3a703e5d4e32..62356c64e180 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
 
-static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
-				      struct page *page, size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-
-	return ret;
-}
-
-static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
 static int __init atomic_pool_init(void)
 {
 	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
@@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
+static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
+				      struct page *page, size_t size)
+{
+	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
+}
+
+static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
+			      unsigned long pfn, size_t size)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = vma_pages(vma);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 /* Thankfully, all cache ops are by VA so we can ignore phys here */
 static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 {
-- 
2.18.0

