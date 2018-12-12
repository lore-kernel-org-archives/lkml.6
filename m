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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45EEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751732080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJyG5eQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751732080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeLLUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37238 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeLLUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so9157153plr.4;
        Wed, 12 Dec 2018 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTNlGZU9inIb5w7gPDwEa+MxY0Vrr9+k5li1fWVyioc=;
        b=YJyG5eQhu70ECWvydYtPnRSE6oTbcdHgrnX7uuJ82DTJDcNYVsvx+Xy3ig9O1kBHI4
         SrbR4Msb25Vqv6XvHxxdWyrDNhMabEbdq0J4/1iZjbHao5lmntPLsIjomEBA6xIfeH3o
         YYqRcHPfNjarj/aik7AJhkX6Pnk3eay5iKw0gLu2E9AgUs7XV8XDb8MJ/3HZepBgKfjD
         QEjc/rVf7SPIdRX2xcLNdRmtTwg1PEm5cZ/NGnQrAIjD7MOfu0LpelUz4ktOSI5A0vfg
         ln0AQYfWnbCn9eqzum90dMEBxXFr10AHqI56KyHRSyfZad7YHwZ7P+6IEk1uSZMi9qgl
         iRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTNlGZU9inIb5w7gPDwEa+MxY0Vrr9+k5li1fWVyioc=;
        b=GNBRE9AK7FlidLIYSnV329qWrbYur/G4nYEip/8BOfvfBRgPvJQ0I08Zh0yrh4Jv4d
         zEGm217M83ipYUeH9d4R33nxGjTnIo8IQr/OTzqlLzT2clbAqfKUI3w8JwcZEA2u7Laa
         9d27fKGRKosD8u++8H5kRMxHTNFbmb3zbjT/AsV4MowTNJ1D3s0yQaA4Z2sSfAZsK9Yr
         C7pWQ8xjBmehBo7IlQGU/4Sm+QYqK32JXF1SViHgmP0yo+y1G6D2f3GcK8ceC2y1JDND
         Xu/A1Pdh0qRpgstGDZw6G+liUA4nZdLHFejpy7d/eZiclTwO16DrKhizkrWo0tyBCAg8
         v3lA==
X-Gm-Message-State: AA+aEWY1hhIzYfMVIJ61cT8H93g+kjdBoeUOASK/hjtibbq27pDQlcoo
        6AH3ksDQ80DUimHjqwOXvWM=
X-Google-Smtp-Source: AFSGD/WhELHkKn6okVjCJPwH6Xg2JjaNE/3McvrEar/CFgB2eQZzvHhdi5RS2CxBRIGqACCzxXKDLA==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr21234390plb.115.1544648025352;
        Wed, 12 Dec 2018 12:53:45 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/24] iommu/tegra: gart: Fix spinlock recursion
Date:   Wed, 12 Dec 2018 23:39:00 +0300
Message-Id: <20181212203907.23461-18-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spinlock recursion bug that happens on IOMMU domain destruction if
any of the allocated domains have devices attached to them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index b35ffa312a83..a7a9400e0cd8 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -197,25 +197,33 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
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
 
@@ -255,7 +263,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 			struct gart_client *c;
 
 			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
+				__gart_iommu_detach_dev(domain, c->dev);
 		}
 		spin_unlock(&gart->client_lock);
 	}
-- 
2.20.0

