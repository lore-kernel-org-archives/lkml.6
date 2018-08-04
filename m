Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CDC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D08217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlieawVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D08217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeHDQg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHDQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so3124909edp.9;
        Sat, 04 Aug 2018 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qOQ2ykxdzgVaEjxf8lF/JmSRzKKzX8E1UBCHBgHjsjU=;
        b=NlieawVc4gAxP7oAxofIgt4Gc4TT8szcaTyTuwQeUFmr7C+I87P0ioYMBhkpPg3AUu
         F+8K5Xz2BsIm7TbOMDIgisrKD4Ze/eTnjr4EQoD90sIq9GRIJGC4nxZKuh1/rgKx1IK7
         hJhvEb609Ii5r1rXPqYkEYsmyB6xoynDmUK/7EAU7nhB7McBfL5aZFjjz+keB1Jo74ut
         RrE3asLYdT/1uzpE7F5/xzTe3sFom/+MF26Iu0XAl+yn6BZC3sKtFl9hluaAfr1uYPRl
         q1Pd48i7W1G9na+UD85gstm3/+ZsXmZX2cLi0S9WKUu2FUETcvj5XOETaEIoiflu0pWa
         npSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qOQ2ykxdzgVaEjxf8lF/JmSRzKKzX8E1UBCHBgHjsjU=;
        b=Ew+3mHtwOSvocTEF7ynwiOOWVvL7iame66DWmyGhbZuEH2/q6CGHqsE/dPVcY2Ky8B
         wHQIxETCpQnaFq0v1iEuwE0YDyME7Z9u5CjrXBKGto64SwPPktdjggj0gjmoRpysl/Y5
         FXr2Ald7T1GSlKWk7EJeZR7A4+2gmf8xWEzw0i7klTtuqEd08yiQ4DY/rC81bj3OUavI
         j9Pn0RmKY01pp/qDsbsft2hrKLr6Zx+soCzw7qFGAF6P60ZlU8uq59HBKn7OqskKFcLh
         jku3079mHxJjbkMgCqLUujAElLO82KgPIpZ33ZcXp2ITHO6uCjcKQ6TK+k6RlfqqwOs/
         Gxgw==
X-Gm-Message-State: AOUpUlHKTtQuGxhfFkGc+UTzE6aQmGB58GUaX3aIGsBBc1DVM7boIcTB
        GEaBgd6FpggmFqLm3hfgC44=
X-Google-Smtp-Source: AAOMgpdJ2tNHjEPEBOv3/UnxN0X7ig1RUZIOKWJZZeFo1i+Tw9OpXoROuazqLNO1lmbF20bOjBWNIw==
X-Received: by 2002:a50:82c7:: with SMTP id 65-v6mr11161574edg.114.1533393333034;
        Sat, 04 Aug 2018 07:35:33 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Sat,  4 Aug 2018 17:30:00 +0300
Message-Id: <20180804143003.15817-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly clean up allocated resources on the drivers probe failure and
remove unneeded checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 9a427cb35340..def570bc88c4 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -429,9 +429,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (gart_handle)
-		return -EIO;
-
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
 	/* the GART memory aperture is required */
@@ -466,8 +463,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU\n");
-		iommu_device_sysfs_remove(&gart->iommu);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	gart->dev = &pdev->dev;
@@ -483,7 +479,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto unregister_iommu;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -493,6 +490,13 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	tegra_mc_register_gart(&gart->mc_gart_handle);
 
 	return 0;
+
+unregister_iommu:
+	iommu_device_unregister(&gart->iommu);
+remove_sysfs:
+	iommu_device_sysfs_remove(&gart->iommu);
+
+	return ret;
 }
 
 static const struct dev_pm_ops tegra_gart_pm_ops = {
-- 
2.18.0

