Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F616C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B0A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2tLO/5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B0A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLIUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:33:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42723 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeLIUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so7756381lja.9;
        Sun, 09 Dec 2018 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8zEUgX4a8J2cNkJXLbNNOJsQrSudg+v+E4H0iBG8o4=;
        b=L2tLO/5frf+FmDHilL7lkklum0tOADGKNrlbPEImy7rTdW6dIFbq+/iTCN3MM+XyMM
         zF6qDVDQEDAIIOJCgMiVwVQrW+D1BVFdYQuHMdn9D4NSTZmxVhOmzBzBcxIk+La97G6N
         LWtQVlVqJI3mxWIjanVCiWLkDms0z0eajiOW66KwLSlqnlFqKN44Re8qjNCJtl6VCRo7
         wR2fLU+gMhZKgAixeA6LHltr85W8VLc3ORwtgcZgQHbKvk2vDLI3+j0umcbodaZo9/GD
         nxQh984onV/xxWF4ii/zSzjdbcXl6pGrVKx9Pr+8lhdjRqVG37AdkqTDj7GzNwFMNJdJ
         MJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8zEUgX4a8J2cNkJXLbNNOJsQrSudg+v+E4H0iBG8o4=;
        b=U8g+ClYb1T0mnV6mA0FcczdiE4Iv8iBD8CTjUogAT7wu25s+joLwYfXdMJJi95EsSM
         q/adrJdIzBkvVUU35y59fGWdxzaruhnet6AOAvNfi3tTPn1SdnU2vrybvsTebIeH0k6E
         f3uXHX1w0EEZPf7cEM59kqbY4NfX2CW2Al2Xy9+2WqNOcdgogl7hhDQ2N87lx4P7U32x
         s/FHeaym2Qbndu4oWG3PhYedI8Wz/6yvGAWSGuUbrfY/nLIL41pwyXMApRzA8qskgEsa
         kNxdjC6L3oFN+aNRrEdeWqECYAw7IzLVS4VflVGfu0FuSCRqCx/7VSzvMK0EmNro2iZD
         Ickw==
X-Gm-Message-State: AA+aEWYKDS8Nv3UAYGMCvTzYrQ681Z/a+yJx30FUMLRL6B1yHLeP3ODX
        8JaP/ePTvYy0+tvUlrHyFYk=
X-Google-Smtp-Source: AFSGD/Vl7fz3bDhb7ehdKLU5LYLO5fa8AnIK3dl8FW3WZVyP+S0iUU3YeWfebvRF427nVuO5gyf65A==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr5417998ljj.146.1544387459440;
        Sun, 09 Dec 2018 12:30:59 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:30:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/21] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Sun,  9 Dec 2018 23:29:31 +0300
Message-Id: <20181209202950.31486-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
2.19.1

