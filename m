Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9261C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706FB217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7zyT8u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706FB217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeHDQgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33913 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeHDQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so3146863eds.1;
        Sat, 04 Aug 2018 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CcvGzir+Pc3Rkt408mXoZUbFXaWdaiMloQs3Ib+E+Y=;
        b=F7zyT8u++JrS/+sUbBjeNvWFGzu1jdedwtBN8YgrLKpYPGuzy46GuYDfTCeJD3yj3g
         HI1YAijwxtkkTviRFv80RhjbmtXqGQZuWCzqrftRcN+TsC0ayycuX3ZpsL/Feb++qX9r
         4W4CN3gSKKc+49lXz8jatY1CAFJTQ1fFxTWbk0PgkK2dCExKOe8uZhrzpR1VAkc1FBk7
         hqhdH1I2ncfWe+Mx38HrEp37my3bOA/aHE/pmkdPaWMDC1ks0Tvmj0LbQ1KTFSLzAkmQ
         CH1aqz2ajXoHlZT6nKolPiefvwRwDAMMXtEqPmsj11JjioyzHbjllZGJdgKm9pqKtPlr
         VjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CcvGzir+Pc3Rkt408mXoZUbFXaWdaiMloQs3Ib+E+Y=;
        b=Q3BL2Us3do2xQkjKWmOVySQYvZR4MgKmgsREZQzi1AOLqJw3TRfenEGik6l+kxPtRo
         HOC7fTaoOuu8NFmbQPmDkDdMS1P+G9lGPP1hM1/AgYAhUrDD4Z0y6v5yPtEdle5UE/72
         IEQ26JQlYYTIU2wLjXlYFDkevD8CMkJ6aWQ9M/38MqzhXMpSMX2f3ePm8xQrZPZiMBYX
         6HDMcyRnY+quALhs0uxA0KdFzAgbTwVbgg545QBxP4L240OvxXc/crRNeBTFrIHswcTP
         6Pq8re8oEAJubv+xiBSx72CKW4Ptiq1RUZdD0EusCyucSEBDH3QRWeRI2ErIl7ZHlvMa
         APHg==
X-Gm-Message-State: AOUpUlFgjRmTyCC3YsvgJpFoeFjqWAXp6wkTObrM0Hwx19R51D7ny7+1
        aL+1FINXE4rwzVez8wqhrQOgKLCN
X-Google-Smtp-Source: AAOMgpd3dV1/KAC7ys1Vsee+clKBhjfdN7BvT9BbwxSI6x6NDG4dWV9riP/tNOvGA2nXYYK8z+gl6A==
X-Received: by 2002:a50:81c6:: with SMTP id 64-v6mr11413868ede.89.1533393335301;
        Sat, 04 Aug 2018 07:35:35 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] iommu: Introduce iotlb_sync_map callback
Date:   Sat,  4 Aug 2018 17:30:02 +0300
Message-Id: <20180804143003.15817-8-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
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
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f3698006cb53..056282f23b10 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1545,13 +1545,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
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
 
@@ -1580,7 +1581,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1589,6 +1590,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7447b0b0579a..7ed115526fb5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -206,6 +206,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.18.0

