Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C35D217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srRVqRKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C35D217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeHDQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46856 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbeHDQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so3122565edt.13;
        Sat, 04 Aug 2018 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p9f7+bTeEOkg8XRkqOUBiqJ6fPDcBxOcvvzdDkZq8Do=;
        b=srRVqRKbAkDrGIZoJvuddzJx8bu1hI0XQT8IF0NtokTh9xH00yPoVj6OCRWwmjwYLm
         QeCenNR4pr+nF/d03IaeSnCInr94CCWEG77xVnQR29TS5aaccvyjEK30DuXGNl2MJP1o
         +o5pxx1Tea1h8KlpgXLn0rJBvgVcxf0/Y807nQTgOWdeTiXTOsVMFdGuNN6rkvEaLBHb
         cTHdvNEJwVYC8cneWhTzWa3IeRXkMORiQu5dLU86IQCilz0uPBe5NfectDKZsEU/93nv
         02Z/43EyuDY/WV348wtAOiXngvBZit5nQPeFE4Tki4/DOLvrhOBayljKquC+nCuQdLlR
         1fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p9f7+bTeEOkg8XRkqOUBiqJ6fPDcBxOcvvzdDkZq8Do=;
        b=UQZHGqNuHVBpGywZ1Cb2I9zMWoRb0WuMeTdZtUxsw9GlXS82XH7NvlDJVgP1LPQ0ju
         1dOsfRRRhrZ0mYZehRRfx6SMcfNlz+I54KDYRL3LyQB5kYC8ZE0LkWoXktz70Zb32plQ
         /K3KJvoqmJjvOYHLIP+IZxBKx3b0H61Mbo8MWbQ3cP4pD1HutTiUEm2y6DUa6h04Ejw2
         P1PejLeZwfMRwkbjeZitt5GKr+SNA1BG+xdWsOQyS3UL0o4kTZEzmXfIbnjsaK3bXFR4
         xUzSWbTMwtnSX+H59XZXoGkzWdL0qojXVv9H+73gncHzAt7LYeqOce1dm5LSw6PhXe6z
         BWPA==
X-Gm-Message-State: AOUpUlF/9bAD7ZNxNOEfw8cE7smoggOxxhQXt0ajqkS+B1pWyUcNWErX
        LOAZSKvD7DFApMMjM7EbzMc=
X-Google-Smtp-Source: AAOMgpdGptUu68mmzJ5qEf31Wyp77mp2KHwWGBCjtTWkMGMDRFlSEaSCglYmCGEwtsz8SV8CkVuGDw==
X-Received: by 2002:a50:97fc:: with SMTP id f57-v6mr10932317edb.21.1533393336407;
        Sat, 04 Aug 2018 07:35:36 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Sat,  4 Aug 2018 17:30:03 +0300
Message-Id: <20180804143003.15817-9-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GART writes one page entry at a time. More optimal would be to
aggregate the writes and flush BUS buffer in the end, this gives map/unmap
10-40% performance boost (depending on size of mapping) in comparison to
flushing after each page entry update.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index bcdb8973a0ad..5e3fd32fce4a 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -293,7 +293,6 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return 0;
 }
@@ -310,7 +309,6 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return bytes;
 }
@@ -376,6 +374,14 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
+static void gart_iommu_sync(struct iommu_domain *domain)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	FLUSH_GART_REGS(gart);
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -391,6 +397,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
+	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync	= gart_iommu_sync,
 };
 
 static int tegra_gart_suspend(struct device *dev)
-- 
2.18.0

