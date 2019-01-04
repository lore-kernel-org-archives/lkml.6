Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6588C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835C0217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="b0ptUDYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfADCgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:36:55 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25370 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfADCgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:36:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546569402; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=FgXrBR8dOCwBA240JdnPdaxIbMOqRlBDkLZug/eXm4Idyo9SDjqo9vZoySQYbFrVmcIjlpdaepMNtR50TCm7A2Msv4cZZN46rR00rwur6W3I4bc7ZR+/p9tHkp82So9/g3h7MolQFidGzzBqCCzLO+P+a9lWzX54WvCZYcJt9cM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546569402; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=RNdT9hHJUIBe5h6GKo3k1W21mmcp9iVGrfmktxuzfac=; 
        b=jVT4jHnWqLZiBxITzIjNOty2JwFrmEbFUTxcmcHxGIgZxPkGxzshCeN6XC2SAJV7f3QMj8+WGfSzA3ijrq8cXtZCxxMdeF2qY+nTIEyqobwg7lKu18TTjUuBjDN+lgGmnWTjxfTpQTEoy1NZmItLcWcLjYDHxmlJ70hdAcnNXkE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=Ke4KUt3a5zUQqInpQ4P/JSA87x6tll9vPvJlbHWMyuMtfgzGdrKnfR+qYk7fT5fuMoKj/OKes/fk
    jFPGhr3uTRccsJOJjT+HsvnZ/ufQVdwqxmV4vytxNXvg2ktB92sy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546569402;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=2407;
        bh=RNdT9hHJUIBe5h6GKo3k1W21mmcp9iVGrfmktxuzfac=;
        b=b0ptUDYkPHxi+pZsGx0VQzXHoJ6jI99hDx+bB68CojKlViJxRAGTZGqkMsEeJkKW
        aP0/vhEv4s4Qzgx7ZuNAffkiw4qvBEaymuRzPPw+a6pBM67lmWSVheESkk3N6VHVO1G
        oUyLzhY8cwXtkSrxG2NYojzDTJ+hAB8aLHEAmglI=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1546569400994382.32869328245397; Thu, 3 Jan 2019 18:36:40 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     hch@lst.de, sstabellini@kernel.org
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, chengnt@lenovo.com,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dma-mapping: remove unused attrs parameter to dma_common_get_sgtable
Date:   Fri,  4 Jan 2019 10:36:25 +0800
Message-Id: <20190104023625.6960-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

dma_common_get_sgtable has parameter attrs which is not used at all.
Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/swiotlb-xen.c   | 2 +-
 include/linux/dma-mapping.h | 2 +-
 kernel/dma/mapping.c        | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 989cf87..b8cb1da 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -677,7 +677,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 							   handle, size, attrs);
 	}
 #endif
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ba521d5..f9e7c2a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -523,7 +523,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs);
+		dma_addr_t dma_addr, size_t size);
 
 int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d7c34d2..0c28b71 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -203,8 +203,7 @@ void dmam_release_declared_memory(struct device *dev)
  * Create scatter-list for the already allocated DMA buffer.
  */
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	struct page *page;
 	int ret;
@@ -234,8 +233,7 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 	if (!dma_is_direct(ops) && ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
-			attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
 }
 EXPORT_SYMBOL(dma_get_sgtable_attrs);
 
-- 
1.8.3.1


