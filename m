Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766B3C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20515215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIgAgguX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20515215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHRTDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37202 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeHRTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so6111897eds.4;
        Sat, 18 Aug 2018 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yD2pLhYbA5LzbYbzFrw6/+GVuHxs4vnjQv6iZuDs3Hk=;
        b=sIgAgguXOz1aHI/a3QLYlSch1w4/TdpFeprUhobw3D0st9oUFwfCWZbZ0J7NlEtH+S
         aIDr1vTgWmHAVlxEJ8xrakxmkFUxQuW3hFEwq/fafkQgi9Ew16e1Kgb20U0dmflOdO/G
         vSpbpFWgzN8ZQDY3dNTaVIP02wgctD6uQ7umde0CN68nmJAvQEcMiLFr7VM3D8BgH9QN
         sqoEFQMQLHim+ur7Ggwkpw93aW6SFLZ7nEVNGX3fxpFYwYssfe8JMEvKi5Mt3uvagEG5
         6YpM7s/8iPReGmbYbbkFr15Znl5jdEjKbtjDlWCu9VFTJ1mbc4w+LVfaXmEG/hlsCwoX
         hyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yD2pLhYbA5LzbYbzFrw6/+GVuHxs4vnjQv6iZuDs3Hk=;
        b=MEUaBi/80Ub1kbbnFFVjgyvTHJi6nq8jLp7/ccO3YpCbJ8J5TD6MQ5PvswXl8xmZji
         XSaOsZNtpamkO5bRrYmRXbKGIF7qyqDybP0mHkVK1/AdbVW6+5/P1ofZdKdE8f4Ev1wI
         cserT3QVPgt/hO4W8cPsS6MyjgAGxZzc14Gny7IlCVzdigejYaoIUJe5Brs6g0W66vYD
         FSdZpagwynP2oHmWNgk9bOwuCSK+SU2j8uJr5QqYufg+OquywlnH2glkgenrQytFuH0S
         ivXRcsg+DaZ20StA2+Z4NZGMYfyacDuo2fG21prK0faaf+mK3M+NbiAWShDNjJRFeMs+
         ftyg==
X-Gm-Message-State: AOUpUlFWZbDSecpg4YPaoI8NPIOse1NOSfLe3PzfClxOGlJL4zM91H4C
        V0+UCtdeP9Y1WMexWCf7y9A=
X-Google-Smtp-Source: AA+uWPzSglpotHVhpuzF6XifzPq8qZA7KIZQ09TkBzbqbOGysA9JzOzac+CGSQ0HO9gKUhq8lCrBhg==
X-Received: by 2002:a50:8bc5:: with SMTP id n5-v6mr4271745edn.216.1534607739132;
        Sat, 18 Aug 2018 08:55:39 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/19] iommu/tegra: gart: Clean up driver probe errors handling
Date:   Sat, 18 Aug 2018 18:54:13 +0300
Message-Id: <20180818155430.5586-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
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
2.18.0

