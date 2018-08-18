Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE77C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044D5217BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbwKVHVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044D5217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHRTED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42260 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHRTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so6094650edp.9;
        Sat, 18 Aug 2018 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sKkDvZdHA4hmjM4+mQDUabnQxTNKjwVkJIBgb8oSU2Y=;
        b=sbwKVHVirDtctWnKcmOo/eI0Ev2+tgIXugFn/dCmPE0Nxbw51HteR4FoW0PMKEDEuL
         PFXoZc2nSHAIIano0RsAhnHL9KAAgqCxwcypM3CLxVzsMIdexqfWIjS5zpZuFB2EYqg0
         Bz+sEIRs/FpJ4POaGVHa1uftkacgeFt9lIMgerMa3fAJcnke2fcBPs22kSbnIdl1yakz
         W6twoH5DTAem5u3GhT5aX3KL9sbcPir8ppP/KGUm1ceELFWcX6BZcmf17jRDNEjNP24W
         hWUegwOVRqSKMM/DDQWYTGoUwps08qhN1w8OAphzKE1WhvHfwdxYL5hZ7Y8KLCYAulOV
         DpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sKkDvZdHA4hmjM4+mQDUabnQxTNKjwVkJIBgb8oSU2Y=;
        b=GqRtyLHuqoCj08t5nklY40fbAlJXXXGTupKEuGdDLn72jFiSRWPQyDytH7ywrs8/Wb
         b4xMa2aXAu+62QbPSl6imuLRLSCmPB9LPii+LLMHoFhOxvBaaXYIqRejuJ8k6l4lKVdv
         7zjXsskLN+mxK1KbJF2Vwcd+Y4MaotInAEeXcJQhsWlO4hjWlL9/8hZ9Y80jwiv8r77g
         p2toRbl1J5C4MZNVamUyj7h+JcKpPGA5yHDjLmDoM1hacjFx/ZRlFV21qv79s4HSMKd3
         p94xqtM30jEbIajFTw1i7PeYU4U1cJQtLQk9z9bohvz+Epak6QBvMauDehzE3nLV92ZN
         WQ6A==
X-Gm-Message-State: AOUpUlEElvB7DSOXIe2MCcNPJbV0n7Doh5FCuHpIGdfPT0/ZIV8mPrxe
        vKX36OIj5pioorc95F2ybg1ncEWd
X-Google-Smtp-Source: AA+uWPxFWVyvHuh19qIyjpVuy984uSs7iVXCe3tTJ8ipIkBUXjEEf+xUfsDQK/uviSGYpaHzImX+8w==
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr48281158edw.295.1534607751727;
        Sat, 18 Aug 2018 08:55:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/19] iommu/tegra: gart: Fix spinlock recursion
Date:   Sat, 18 Aug 2018 18:54:23 +0300
Message-Id: <20180818155430.5586-13-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spinlock recursion bug that happens on IOMMU domain destruction if
any of the allocated domains have devices attached to them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1c89b20ba4bb..e6fe139576c3 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -195,25 +195,33 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return err;
 }
 
-static void gart_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void __gart_iommu_detach_dev(struct iommu_domain *domain,
+				    struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_domain->gart;
 	struct gart_client *c;
 
-	spin_lock(&gart->client_lock);
-
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
 			devm_kfree(gart->dev, c);
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			goto out;
+			return;
 		}
 	}
-	dev_err(gart->dev, "Couldn't find\n");
-out:
+
+	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+}
+
+static void gart_iommu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	spin_lock(&gart->client_lock);
+	__gart_iommu_detach_dev(domain, dev);
 	spin_unlock(&gart->client_lock);
 }
 
@@ -253,7 +261,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 			struct gart_client *c;
 
 			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
+				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
 	}
-- 
2.18.0

