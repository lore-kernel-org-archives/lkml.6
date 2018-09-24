Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9ECECE567
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70B21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Rir0dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C70B21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIXGpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:45:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37759 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:45:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id a18-v6so1501756pfo.4;
        Sun, 23 Sep 2018 17:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIv3vTRv+J8tb4vjEUWUp/YU2ZUCcpaHFqa4rq9cf38=;
        b=a1Rir0dY76KCXqWSZolEfGqrXWRB0upz0oeGy99pJ6d3nOVmmrxd14gvgrZnLL/JCC
         owdm26ozcHC3u9azx0e6PNVeoeUly6iARoKub63ffERkGAKBSeR/RJd4QqUXhGXE5Ret
         KzezqCTVZkNS12N/59x1wOJif2XjYP7cIVYyWulNiOhFR35sco48Vi3E0lp7nYx0zLQM
         hjsjafVSoam8qALwYPAiklDcYyqxX00t17Uk3YwGKXaWDoi0R/2iAhtQR7YjAb5pfmSG
         5MSrFQgajWBFqDzdM9zu5m0fhri157TQyDrCwRn1Bt7jljKCUAlzJmJnpe4iqIS0IA60
         8jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIv3vTRv+J8tb4vjEUWUp/YU2ZUCcpaHFqa4rq9cf38=;
        b=t6gsyl+ihONGY+9/GJhkvt97Yl4zg473Fd+k/PyPjfrEiyWj6yk25Ac/WTT4YynpFb
         5bkmN1f3ATiMNcIjxhkwjZKkIpWLb8wPXwZlxzP/nCMX2KdOxLNZpPMd+Ak3hYOOMERh
         CEvLJ6gZhrzlOnv8BwmzMrJ1PeRQ3sy2hREB7FOOgviQbHati6BrLUhlHSqPxHZEei8B
         lnagPqsNdTnUprf7gwl7BydMDPOKwP4oAhTvZ83V0lHHK2847N4R7z/J+GQieWMMeH5B
         VVzV9fIN34F9plFZjiHGibUeKAlxnhdo7OlTIwKDMpSU65K91Uv1jfwSW9LGxox+IfgL
         vTBA==
X-Gm-Message-State: APzg51BRSVxBcG3E9/Mo58ReR7r9fAj2xg2sunpQMLtBmLDPYyro/NOA
        WIci61iVHY6uGFDzC+J23CTFboLL
X-Google-Smtp-Source: ANB0VdbEBmJ8+VqIRnpwutWLPp5bQ1OlcWQn/AzAESi7dGVK5+DpatCHojpmP0mJgdlkcOx7N1J0eg==
X-Received: by 2002:a62:174a:: with SMTP id 71-v6mr8161209pfx.217.1537749969573;
        Sun, 23 Sep 2018 17:46:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/20] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Mon, 24 Sep 2018 03:41:35 +0300
Message-Id: <20180924004153.8232-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

