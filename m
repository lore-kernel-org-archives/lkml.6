Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42ED21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdwMsmrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42ED21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIXGrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:47:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33435 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:47:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id b97-v6so8365091plb.0;
        Sun, 23 Sep 2018 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjyPpVgh8JPgBd4foNBHdpus9o2eboUImRoamRxidwU=;
        b=DdwMsmrdPo2mImFkM+pIOgT4eHJyfCOCc3dQqpZ5HXCp+WajAGUJYiI/Z9VjcfQoRF
         bYyTk7v6nEUmX5CXFgAj7Xnk4hC4KDn0HKGGNARaW1dJvHXcQHIHpKWfVW5fOfYkTptr
         xnEvYu4s616d2s+DUi8rLKG1GjV+i2SaOVeqbr+MZ4+680+P32GJEErXdDGi/+R8V0Kf
         zRTWNKMHuoEFVG/NK40fxYtkIPENS15y8tr7UMmQM/nPLyJWUuUmBhklZhrdGf8wt6rj
         vWpFQ8sdba1J7rBWLCHzi4w5kyNGChFYTyPMTUo4iqqJ0A/sV0w6D/YElq+7u0ylPdGf
         dAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjyPpVgh8JPgBd4foNBHdpus9o2eboUImRoamRxidwU=;
        b=jZbabWY6FsPkjArFjjqCaxtDXrh1zKOGapWEnujZc/7DsQWaT4+1iiL0LKHhbMwus4
         GZFfP1VRVB2zRbGquUptrEqDkG1Sv6cu8NO4UbNCxy1zGuUWl53EfjF2OxxeXPT1d2PR
         QoLYNviYkNBWx4/uiA3GmktsnWvJGv09oztC9m/eAZ7LYo2XLmYYem7VQZIYSC0Qegsa
         DZx1x/Ti7MrBHplyVPHTXGLvZ875/f1BVrWvaEfF3dsyUJ0xVG0NgxvhkXCoWBkWAsxZ
         vvDSpJzER2NWh8kbAgoScJlc1YV39Fhvq/Yv6bmoqRSov0XZRuV7nU2JKybj/b/7sWEB
         KNLw==
X-Gm-Message-State: ABuFfogB5WU0JePvJ6CVCKjNTSs0rTXtbq/Asv4GZt4MXyhnSdZ21/38
        qpPKIawbORpTTPjPbJUeyCY=
X-Google-Smtp-Source: ACcGV63pA+LdvVp0aBymEcQwTRRVszD2ZENhIA+tuesPYKPyudoQQuQdmqNTsTGK3bwYgPkdCMTKBg==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr4680072pll.310.1537750058576;
        Sun, 23 Sep 2018 17:47:38 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/20] iommu/tegra: gart: Prepend error/debug messages with "GART:"
Date:   Mon, 24 Sep 2018 03:41:50 +0300
Message-Id: <20180924004153.8232-18-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "GART:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d019ae8ecfc9..284cddf90888 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -96,7 +96,7 @@ static inline void gart_set_pte(struct gart_device *gart,
 	writel(offs, gart->regs + GART_ENTRY_ADDR);
 	writel(pte, gart->regs + GART_ENTRY_DATA);
 
-	dev_dbg(gart->dev, "%s %08lx:%08x\n",
+	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
 		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
 }
 
@@ -134,7 +134,7 @@ static void gart_dump_table(struct gart_device *gart)
 
 		pte = gart_read_pte(gart, iova);
 
-		dev_dbg(gart->dev, "%s %08lx:%08lx\n",
+		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
 			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
 			iova, pte & GART_PAGE_MASK);
 	}
@@ -179,21 +179,22 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	spin_lock(&gart->client_lock);
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
+			dev_err(gart->dev, "GART: %s is already attached\n",
+				dev_name(dev));
 			err = -EINVAL;
 			goto fail;
 		}
 	}
 	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev, "Only one domain can be active at a time\n");
+		dev_err(gart->dev,
+			"GART: Only one domain can be active at a time\n");
 		err = -EINVAL;
 		goto fail;
 	}
 	gart->active_domain = domain;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
+	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
 	return 0;
 
 fail:
@@ -215,12 +216,14 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
+			dev_dbg(gart->dev, "GART: Detached %s\n",
+				dev_name(dev));
 			return;
 		}
 	}
 
-	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
+		dev_name(dev));
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
@@ -293,7 +296,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
+		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
@@ -301,7 +304,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pte = gart_read_pte(gart, iova);
 		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
 			spin_unlock_irqrestore(&gart->pte_lock, flags);
-			dev_err(gart->dev, "Page entry is in-use\n");
+			dev_err(gart->dev, "GART: Page entry is in-use\n");
 			return -EBUSY;
 		}
 	}
@@ -344,7 +347,7 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = (pte & GART_PAGE_MASK);
 	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08llx:%pa\n",
+		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
 			 (unsigned long long)iova, &pa);
 		gart_dump_table(gart);
 		return -EINVAL;
@@ -455,19 +458,17 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	res_remap = platform_get_resource(to_platform_device(dev),
 					  IORESOURCE_MEM, 1);
 	if (!res_remap) {
-		dev_err(dev, "GART memory aperture expected\n");
+		dev_err(dev, "GART: Memory aperture resource unavailable\n");
 		return ERR_PTR(-ENXIO);
 	}
 
 	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
-	if (!gart) {
-		dev_err(dev, "failed to allocate gart_device\n");
+	if (!gart)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU in sysfs\n");
+		dev_err(dev, "GART: Failed to register IOMMU sysfs\n");
 		goto free_gart;
 	}
 
@@ -476,7 +477,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU\n");
+		dev_err(dev, "GART: Failed to register IOMMU\n");
 		goto remove_sysfs;
 	}
 
@@ -491,7 +492,6 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
-		dev_err(dev, "failed to allocate context save area\n");
 		ret = -ENOMEM;
 		goto unregister_iommu;
 	}
-- 
2.19.0

