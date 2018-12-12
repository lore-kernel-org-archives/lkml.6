Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97864C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7282080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX4FGEC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7282080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeLLUw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33779 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeLLUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so8894588pgu.0;
        Wed, 12 Dec 2018 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTGPE9YNACJvCR+fV/r+m5dOzoRDSwugBy/hHkWDi6w=;
        b=jX4FGEC3iTuYfWluKCBm4wXIIYakuq3oXrslTKMMIOLs9Reqpsz1sSbJj9katxvwaZ
         C7trbLUtMbv2wmNJb2hBmEWjfrzBIymlrFHgKOwLEu5Av+VKuqNu5mqfXjLvUc/We0R0
         w8QBvLXAyJ2w6tbEI9BqZz0OizIlYp9SAqMBaFy9VCG1WbW9VQuWfBWuH/1XRs0EEdRZ
         08L279G1MzSGLpBH7LyJCGXjvsH3HuI+Wkd4VR4gsVI427gq77KPqe4kswYrZtA9IwC8
         zMlUjMu1T/y4kcci63OImlR+zpkHCkRAK0S7zU0nYnkzQs7Uix8nIaxt79lJvjh9ekyH
         yX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTGPE9YNACJvCR+fV/r+m5dOzoRDSwugBy/hHkWDi6w=;
        b=Vpp9Y8H+xKhAvZbjfusrY90sZgJShxCSE8L8kfar6BJdh/4dWz31QJmbF+HkF9WVt5
         2PfLYbJZCM85Y8wB2wonCqAZ0JuFXuSIWv84Y3zja4wIoFXl00tMkzY+GMeUEXv0dWL2
         oW3UmZR/5UDVDJnd/ImuDeiiWMti+sSdGzd4smQx6Gn2kFie+xhqAN+0cgsYwoZfSChS
         lpS6dvnuQlmQyESZiIMe+HRRoiNhExI1VuF5LpKuP3aE/qOREGCpYizAfIyV/TVDd12L
         4ti9XSYZMHLExO99sn6w8AkF6PgPNPpXC4VKy+WbVWEjIewViAVObZXv0vLV05wloTOW
         wy8A==
X-Gm-Message-State: AA+aEWYqfwbJ2ZcN4qUARL7fnHD37f6RgikZlYfy8+rNIvBfKdiLCHzN
        6PDHR6BN9mHlreqvPH7cSz8=
X-Google-Smtp-Source: AFSGD/VekcQKnyF/dM3TNcCNcFQ+vf4ZiOWVIbDTDp6hqgDM0O2XERGVlmpc+HnC9y51QUl84R5XCQ==
X-Received: by 2002:a62:9683:: with SMTP id s3mr21452065pfk.60.1544647943871;
        Wed, 12 Dec 2018 12:52:23 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:23 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/24] iommu: Introduce iotlb_sync_map callback
Date:   Wed, 12 Dec 2018 23:38:47 +0300
Message-Id: <20181212203907.23461-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce iotlb_sync_map() callback that is invoked in the end of
iommu_map(). This new callback allows IOMMU drivers to avoid syncing
after mapping of each contiguous chunk and sync only when the whole
mapping is completed, optimizing performance of the mapping operation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cc25ec6d4c06..79e7c49ed16a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1582,13 +1582,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
+	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 	size_t orig_size = size;
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL ||
+	if (unlikely(ops->map == NULL ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -1617,7 +1618,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1626,6 +1627,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 11db18b9ffe8..0e90c5cc72db 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -201,6 +201,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.20.0

