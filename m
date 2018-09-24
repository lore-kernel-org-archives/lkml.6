Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3845C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F23A21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D752C2+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F23A21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeIXGp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:45:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35652 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:45:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so8342928plo.2;
        Sun, 23 Sep 2018 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30ufeD3CxV7WsB0liotdolVz3OINlqOzVXL8Z3r3AF4=;
        b=D752C2+zYXdrEGyBS1CaGDPnyR2WiP83TdZzYlE4iwOINfoFAp+BTJg/M5Kgx0rD0n
         Nr2oGDcuvJlH+3TIffIBf3/3TMMbdlg1axumXN6HoDG9cStJk1kbJd2cbArLrmQKYo0S
         LmOIwhYDoDqCwCMzzDmAiIWuOU2+15FkUWDNNImrVSHzzdCCpmv0ZZdMjpvezTOfI2Si
         ladq0CE1SYrXyFTWopD1Eb7NOFWoHuROgtbkzm2TAaUzsgY2Hr67BiTC3dLNLpBdAlpv
         3xoNvNlS+lXBytC0SynXx7QM+Z96DZelsHYxxLqzjQ8PSqYqj2MNSwsQ90AB84B/VbOG
         GEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30ufeD3CxV7WsB0liotdolVz3OINlqOzVXL8Z3r3AF4=;
        b=RPUQDoTsoz0a62wfUXKsRQg3JE05vi2mtqDLQDA2DxmiMU6WL0kzYqc5s0a2YF6Poj
         +QiZqvG5h+NNwej9OGsuj6zhBEsyn0j825EKydm73Deymv7QrDTlSSbvDzsSQD2gnPqU
         vuTNIIt85qBJRYyRH0GDcprUxeTxf1Z6hZd6A096E4qVgV1a+3qeeFuKiZspUQjjP9Nv
         FLCMeRfhh3h5WO8iBOgsPWWCdmkCf+LbuGvkAtSWsw9vpaNOsC3MhY7bHSK7e2140qVe
         AlZQvlTlAjyyl57Kym9aK0gKsbk/EPmishnTGoz4JjUYAug0tC3VTUtmpQBCeE3o+OVj
         jhdg==
X-Gm-Message-State: ABuFfog9sNRkHbA1vZ0/GjyjBc2UMxIP29SrEFgz4rSZtRj/MMbtXTxM
        GPNrHEA59udZe/iqhyadqzI=
X-Google-Smtp-Source: ACcGV62jtkcyNjseSBZAncl7Lf0FtclScoEv6DkzNmkTfQdc2POLzni7Uasx5rjxauVQh2FUunVlwg==
X-Received: by 2002:a17:902:784a:: with SMTP id e10-v6mr8239165pln.197.1537749981458;
        Sun, 23 Sep 2018 17:46:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/20] iommu: Introduce iotlb_sync_map callback
Date:   Mon, 24 Sep 2018 03:41:37 +0300
Message-Id: <20180924004153.8232-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..8979b16caf61 100644
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
index 87994c265bf5..4c488eb69752 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -202,6 +202,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.19.0

