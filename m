Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B130C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B6E206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4HnaOxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B6E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeJAFZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:25:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39499 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJAFXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id 5-v6so10357989lju.6;
        Sun, 30 Sep 2018 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2SNuz3f4J6XDnDwsOkJ4o+pkAYUTn1HjmW4OTdv0ow=;
        b=o4HnaOxMHw7H1EtOvxpswmMEtz/9jx9YVwdqqY8In6WK+eT5r8oTtZ3nOER28UDRqc
         gX8rENH5Qqm8CotyRhWtw6xGPrE5x/sxnYFh8KX4zrgRzyEqu8jzIS6NRQaJK9a8jogR
         6eQ18EO7fhgIul2OY5KuUSMROxme2cTxqD3EJWr0OUDyYvp2Z8Iime91G9z+11+cjKbR
         Y6w0snpDulHl9IYo5f18mcf+6qcEQVkt3+7selg0QQE8npzgo4rHzi40q1nOzfGPckX2
         i3Mez7ExDaWx3YZ55OEbKR+2BJJhHrC0+GhKaGsAEr809lvVX7LwlzKbTFak8z6P+9y+
         xgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2SNuz3f4J6XDnDwsOkJ4o+pkAYUTn1HjmW4OTdv0ow=;
        b=uY4Q08nZSBerPS5V0qqKHD8CHFK65VppTKVyermled9xJ5DzKSi95ABlnDWAdMpUBp
         RLIEuBCeEMawZzvv8EyVH16YLu7yMgUKRG0y+EjbJK971xKslx4t3SijG8UolCEMJ2sp
         kxLg0eXk3jDfuGBSrcRq+OX+c3JA/5JCBFMW3CrPG7LPPSEZz7FnzAsQ+0upVc/lJEuG
         zVI/t9sKgjbQG+16Tf/Czg6v76xJh5cx6c7yfaGI9yxYRhrSpHZIsap1u2NHrccLP7i1
         nIpX36RnqqaFu2PqSx496DFXt3ZLExCKrfFlQ6KFKV18RgsYcY7L9d/qzo30aJrVNFRL
         9F5g==
X-Gm-Message-State: ABuFfoglL/XXdJ2mSoMZJVLXtsLdcyPjCp76nXHC1CC1bZRoNn8P+H06
        h40VrlZpSzzt20uPdItmGDs=
X-Google-Smtp-Source: ACcGV60HYGw6rPr589cy8b1y6EqqDHQKHLGwY9y1Xo3GsTqzqmm9IOm92hFTUMAJVjJT1f1HWO8n/A==
X-Received: by 2002:a2e:140c:: with SMTP id u12-v6mr4488119ljd.76.1538347737810;
        Sun, 30 Sep 2018 15:48:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/21] iommu: Introduce iotlb_sync_map callback
Date:   Mon,  1 Oct 2018 01:48:16 +0300
Message-Id: <20180930224833.28809-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
index 007d593b7398..3af193ca5fa2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1567,13 +1567,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
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
 
@@ -1602,7 +1603,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1611,6 +1612,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6b80b0ddc697..3843d6cc5393 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -200,6 +200,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.19.0

