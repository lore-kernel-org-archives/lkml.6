Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72156C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3483C206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0IF/Gpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJAFXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45346 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJAFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id m80-v6so8417053lfi.12;
        Sun, 30 Sep 2018 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2rZwH/XwnabcsPxGZnLBANVf0arslSHMnEggB4t49o=;
        b=Z0IF/GpecPsrASp21a23gHfR1wI6iQxN/brZhLY++rGST9bK8xRFC9Z7NAVlHlHG3f
         oae17wF+MVNRW+pcD+J1njrr5+qh+WHCdAxuuIs+y8qLcwK/e93TCD65q5wvd/bEwyEQ
         RlxzQ0ol+jEueP0VMWZOmr5e+MjUROdrF9zufdIjk1BnWBgVXwXUHRSGpRGCwQ5owk4N
         WwiTCayhGQdfR8dY8po7dFcfo7G/xjp/ESDdt8pAJxO3a2TtSHVHK8DEasBfRN0Qjb8y
         yjq+f8K35HqyKGgyQPWQbZ17sJCGGCde1jymg8If5HI7uP4Ug4xUc4HkYVTTPnsWvsFX
         zEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2rZwH/XwnabcsPxGZnLBANVf0arslSHMnEggB4t49o=;
        b=k6QnP8Hlt8ihKlXqVamcleY7lhW4OJvGi0IQfHTaB6znRkfhHIGUe8kzLLOu2oBmQR
         vmCQMg84wdjyZVJNWiJl4T1lD4jkhDnKypCH3C0m4aXl9G4uinFnRTYNnXfkv51k0t4G
         U5Ao3S5gMgSg1xSsDvo29212P7taXRdpNQ6iiIxkQIbePTHA8swYWKLbVMWKSENQ8wQ9
         1VzwEYVT1dlxg1oTkrGoJVBncJqFRcQYB+ENqdp6/a9K9SS1YdUtHwEY31FF2ctuB8yf
         59uuUyMEw/oQV4pw8C18XH7U+C5w0X095c7k8Av9IpITQaDcWyRHGoEv1z4aIShxGlqQ
         7w2g==
X-Gm-Message-State: ABuFfoiWPEKYfVA+yQHH0I5rUb2BD1yiL9vsiUSP0/cfmzORT17w9oPY
        Whvbeo/UOfXrnoYYy+z9070=
X-Google-Smtp-Source: ACcGV62ncIfFIOKD0YfCNnkGhlATKwB0SswZbSrZgcra7pD0rb1UH1Y1BDGF+UyCe7UQ94EOtQuzYQ==
X-Received: by 2002:a19:9209:: with SMTP id u9-v6mr4249340lfd.26.1538347736003;
        Sun, 30 Sep 2018 15:48:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/21] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Mon,  1 Oct 2018 01:48:14 +0300
Message-Id: <20180930224833.28809-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
index 6dda7ee1d36c..e9524ed264cf 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -408,9 +408,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (gart_handle)
-		return -EIO;
-
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
 	/* the GART memory aperture is required */
@@ -445,8 +442,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU\n");
-		iommu_device_sysfs_remove(&gart->iommu);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	gart->dev = &pdev->dev;
@@ -460,7 +456,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto unregister_iommu;
 	}
 
 	platform_set_drvdata(pdev, gart);
@@ -469,6 +466,13 @@ static int tegra_gart_probe(struct platform_device *pdev)
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
 
 static int tegra_gart_remove(struct platform_device *pdev)
-- 
2.19.0

