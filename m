Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A48C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63FE215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQNBJJ57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63FE215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHRTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33401 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeHRTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so6115709edr.0;
        Sat, 18 Aug 2018 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5D0mfuAvSzidhSfd9PaUke0v52qdEd2FBljRpBUlI1I=;
        b=aQNBJJ57sRpIOLbcS5zGx/zxsW2QtEfQ+NLeRj5IU/rgUbJPTaV5yrkAmcJb06iDYQ
         qvjq42Ad/vXarGiMsVyUa9GviHxJzr8D0sLTIEYHtGhInV4laAOLTJC5HIIjaGfyhaKE
         Glq83v8b5hkJErV73UP2cY4bPr0aXLpCB6UlD10V2yfnQPT+vLOevbtc76p+AGbJ6lZE
         6n1ZVaT52vD2QCiJ9J/e+gJii6KjGK0CfVovNJaKA9aq+ButQCuSHvgiOFvNC4UIFb0d
         Mx5rTrCGcEpenGoizPZRiSj7k3Mi0N+Igu0oz5gK/ZB4g231tHhhPHlRvwOrKHG+ZiHp
         1baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5D0mfuAvSzidhSfd9PaUke0v52qdEd2FBljRpBUlI1I=;
        b=cvTy0d3+5DL0kTa4c0OHa6JUPrV/E+YzKG6kPPLh9P/S2H6msSgYJGJ4LKAImiWFm7
         5grl4Sr21iYc7a/dn/ria1FuXnFuqs9W1Uczkxmozumf4oKVg9RlzKrer1AmkviUOxBV
         a52UoqcOz7lQE6vyba58rPcVyiivf2z++Jpjq2UUMXhQqJtzjzocXrqJL+O6ekB3OVaF
         6e/tcdXNahqjoZ9ikjfYDB8N2IH2gF8pHyh9+qLWa8SXKnIJ9jI0tGsZKN8W6D17/lBe
         YyxbxYSEaWG0M65CgjLlJselEwKtY7twwssku519g0USNEclzZXH1kNesapeamcM+Be9
         UHwA==
X-Gm-Message-State: AOUpUlErX6n9altS60L3+pX+4VbepE2+55rKpZsSvTCpROc/PQ9U/mHf
        q6KO78MtgmcJu9i0AeK2XMs=
X-Google-Smtp-Source: AA+uWPwGhtOvWsyimWo9K6v0tG3WRXTNZg99Omqq26Ag11sKGwK+1eyN+C2MybfVF0IdKPkHtCAKOA==
X-Received: by 2002:a50:9622:: with SMTP id y31-v6mr46490090eda.141.1534607742818;
        Sat, 18 Aug 2018 08:55:42 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/19] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Sat, 18 Aug 2018 18:54:16 +0300
Message-Id: <20180818155430.5586-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
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
index f6cf5cd5aaca..86a855c0d031 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -287,7 +287,6 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return 0;
 }
@@ -304,7 +303,6 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return bytes;
 }
@@ -370,6 +368,14 @@ static int gart_iommu_of_xlate(struct device *dev,
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
@@ -384,6 +390,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
+	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync	= gart_iommu_sync,
 };
 
 static int tegra_gart_suspend(struct device *dev)
-- 
2.18.0

