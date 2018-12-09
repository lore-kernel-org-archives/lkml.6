Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E472082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaCJINMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E472082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeLIUbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44365 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so6482539lfe.11;
        Sun, 09 Dec 2018 12:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KROOJ4+zTlc7KCwk20hN1Vfb/+p4i3alU9eDRo23WI=;
        b=KaCJINMiUJg4HD+yDpECX7oW/8LpBPy4yWzNKjJu2DH1D+AQB159lOi4EHHiElyyJM
         q+U7VtUyUL4PBJq6M7RvLKsC+twm6NgeI6vmYR3zSAgGXLfz26JXNFifUxBJehrPuhwV
         +WNsP8HM7z9DsTkNsjJc92uOlhI1ZiqUZSjf3GLHbKz2DD3jq3Cm/2Nt5Z2ddQWjRcZG
         4ZqFAsUy1i3Ctlf6sH7JdxtdeHe93lzRbO0Z/qilggJHbquSiLNUTr9ujgH/Z2kOpDNg
         GAWqPaaVVeWZGPiYD8RK1ZvtUmO122yvACNY3fcfCP1duU9yCvyVvbcYSMPVH1kv/fi/
         mfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KROOJ4+zTlc7KCwk20hN1Vfb/+p4i3alU9eDRo23WI=;
        b=FOebi968269b21gRYq34bBkvNQm2xvZ/x/KzMajDOnkmFh4XP1Rpac/pDVPBlE1gow
         Z57G7jc4giJa1QZMRVjGcHcto8uPjAEJ5SdeZY9b55LDNBzf4DyzkPuyVk3WBlUH5Oth
         WhaK8CzhdPSyyVNI19PLr2IxkErewEuDxz8iU6OAHRlQGfFrowvixBwlzB8z4FcvK2pN
         fZEzHhkiVgIQr0/H4XUZSKSpP5s8tSaMn7H3AeTJJsxl7JLng/uJ2gB6ViWdPiDMm79P
         T3xBKOYxXurM92GTK65QAqXMSyXFEuoBIbntnAQbEBUqu/R71UvRPQXNctwKvhRBzWKJ
         zwQQ==
X-Gm-Message-State: AA+aEWa1NKwan8hV5sNH4hGbkRZu5ahs+yr6a8v8FvKvfXvG4eAWx/H2
        4ZuNf8PUMPIi64vHxLzcO+8=
X-Google-Smtp-Source: AFSGD/X5uYtcIeBLrXeAnxjsSSI/iuBP64uiJH2DWUATeMNXPJ+33Irri3b2z73MFkh0RHfm6D1kwg==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr5549654lfg.36.1544387461550;
        Sun, 09 Dec 2018 12:31:01 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/21] iommu: Introduce iotlb_sync_map callback
Date:   Sun,  9 Dec 2018 23:29:33 +0300
Message-Id: <20181209202950.31486-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
2.19.1

