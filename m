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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF5C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476A2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga163BcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2476A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeLLUwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37345 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so9443798pfb.4;
        Wed, 12 Dec 2018 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmJLG8/4S02Vk83xdfor+8cYOiPQL97wonxSbJV1350=;
        b=ga163BcJXr9u5EjngUdZ3pUTdUQaCvKYDpE+BjMRc8Yxx46MBsD+ixAA9mlgWXQXYy
         E3w87DOJR06/9F8/ObIkY6fi1adWgKHlpL+Pzy0isF5d5GwySWp4CcQqH0UB/JZmcCP4
         Xkq50sjqd8Y7qh4xi12yEAcFWGczhPSQDMnDvYzgFMM/1Ti2XbWe7bewkmicYo384jvu
         qb4UQ+9RsvP2BGCiDZtQg6aIRI358Pk9ysJAfN7Cvwjn8bnQ5UNOgs3xjpYELIoGMKzG
         ZDBI17n90PtUJh/imCU9JPPYvKdLTOyxFtazQ2yPOIMh2YVeacH+qu3oTZHrhPQFXRhw
         T2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmJLG8/4S02Vk83xdfor+8cYOiPQL97wonxSbJV1350=;
        b=hLYVwFSv2QdhXW66RqU++F1YsSqT722Q8Y+P5YJxf1DQSATp5hIVG0NYYZhXKuKQrY
         BZs7KEYlqw7aYpBW0Qh+q6U5MvFKsLPYtWOmQ5rimr8uga3YgQe4lwc20gbWI7PT45Lu
         5tcPFefp+lfEg7xLkCxVbVJ7Cx6GbtTg/G6wuloTUlNQw6ei56EBoM93Rn7o/V086MkM
         V5cFkh99+m+HbSZSJ175kohQUVl6dW8j6RjYyJoGJODU5BiLFsUQfR00nSN7xQfPvXz9
         Vukrgi46znOODSzE3DhgvRrg8KTuzw/ROuwvUzA4xGPb5urWcv5LUs+yyOpUZcMfKrbF
         Nm6w==
X-Gm-Message-State: AA+aEWYEMY1RL640aPBmSfoD0GX8m7n4qP/45khue1s0BJaQPzoe1FpR
        0HiadHRbdTxjaPGPHSc5md3qSNfS
X-Google-Smtp-Source: AFSGD/W/WnkPT7eW9459QalIVJd1X9QiI8krsRWpu3VrJNSVsU1bQIwPhfHzrKd/Bg6wh2t11FxTtw==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr19728980pgb.101.1544647931326;
        Wed, 12 Dec 2018 12:52:11 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/24] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Wed, 12 Dec 2018 23:38:45 +0300
Message-Id: <20181212203907.23461-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly clean up allocated resources on the drivers probe failure and
remove unneeded checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ff75cf60117b..1cd470b2beea 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -411,9 +411,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (gart_handle)
-		return -EIO;
-
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
 	/* the GART memory aperture is required */
@@ -448,8 +445,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU\n");
-		iommu_device_sysfs_remove(&gart->iommu);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	gart->dev = &pdev->dev;
@@ -463,7 +459,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto unregister_iommu;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -472,6 +469,13 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart_handle = gart;
 
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
2.20.0

