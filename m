Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E76C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910EB20645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="KKpAV1Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910EB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbeKVMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45652 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbeKVMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so5986621qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=otHAAoJeXEc/P3G/AXr3bWGwZWsjr5VuAddyjFBEbz8=;
        b=KKpAV1GkmetbHGiwp0OzSUYh514ZNd0QG51SBJeqpdjuN+AVbP4lr9c0JXDIR3+eB9
         Ozl52zGTJQkbq2U+LLgDf2b7yKlLKwyBIdgvxrqMbGF+prUdBo/3pQTV618912x1IUFk
         yfu4nYjw6KLPSA6pQFtPzIA+hHr/L5b4EEwXnAowHTBdtj92+3WSblBq4wHt1+sEAiNf
         qF53EUQeTst6VBmvzPHKIgVg33mTScCY+pOizB9yQAQSWEcE2PU322ixjTZ8XjP0QtSW
         fUdCcaB6VSvgs6x5UgrP/Lo+iXQZKuR7bXL0GBLcG9ppUO3WTYGMQIEJwJE9xdmJwT1u
         twiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otHAAoJeXEc/P3G/AXr3bWGwZWsjr5VuAddyjFBEbz8=;
        b=oyuTZ4suz7300GqtjOR3UlJSW89qol40IX2/ZxPNXiQ8yIqMHfdLsx8eSN+oe+laSE
         uhV3NydS7opPtixEj7IZprKx+rm/PirGXUz3HTCs00Z0b/GBq+9DTunLqxVIwCFbqkPk
         8nqtvzigYcQDNvdmPjBizTjyVtaUx4SkkcxYjCiNqePjf2d3F5OkA2Xfjfdwurhgfz4m
         LyUtsUlkf/+2KjsZ85R3zRMSjwf4yP29aOvX+Hf1iqdC0mhxoxJVaifo1nd7Yf7Z3HL6
         UzZQtCTtfM2/JL8NhTs3tW5HJIofq2Obc4uu/J2neQo3Ve7v0Z7sVUGnsgs1gp+Hk15J
         +MKw==
X-Gm-Message-State: AA+aEWa17SSgoJugUAE7JJ80RhT45drhGMq1D68JHAzPIEVygNQ0Ddgr
        sBAoodK3g4chi1zgqh1FyAVHKg==
X-Google-Smtp-Source: AJdET5e8mp0HmzxFBoyL6cqoVVRAnKcEk7lUgE+171rY4RXN7cqIMBsVrwGHuXGl6xOVCuhQcA03YA==
X-Received: by 2002:ac8:1a38:: with SMTP id v53mr8008865qtj.362.1542851724451;
        Wed, 21 Nov 2018 17:55:24 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:23 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Steve Kowalik <steven@wedontsleep.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/9] drm/msm/mdp4: only use lut_clk on mdp4.2+
Date:   Wed, 21 Nov 2018 20:52:27 -0500
Message-Id: <20181122015237.14534-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index ae25d763cd8c..8f765f284d11 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -206,7 +206,8 @@ int mdp4_disable(struct mdp4_kms *mdp4_kms)
 	clk_disable_unprepare(mdp4_kms->clk);
 	if (mdp4_kms->pclk)
 		clk_disable_unprepare(mdp4_kms->pclk);
-	clk_disable_unprepare(mdp4_kms->lut_clk);
+	if (mdp4_kms->lut_clk)
+		clk_disable_unprepare(mdp4_kms->lut_clk);
 	if (mdp4_kms->axi_clk)
 		clk_disable_unprepare(mdp4_kms->axi_clk);
 
@@ -220,7 +221,8 @@ int mdp4_enable(struct mdp4_kms *mdp4_kms)
 	clk_prepare_enable(mdp4_kms->clk);
 	if (mdp4_kms->pclk)
 		clk_prepare_enable(mdp4_kms->pclk);
-	clk_prepare_enable(mdp4_kms->lut_clk);
+	if (mdp4_kms->lut_clk)
+		clk_prepare_enable(mdp4_kms->lut_clk);
 	if (mdp4_kms->axi_clk)
 		clk_prepare_enable(mdp4_kms->axi_clk);
 
@@ -472,12 +474,13 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	if (IS_ERR(mdp4_kms->pclk))
 		mdp4_kms->pclk = NULL;
 
-	// XXX if (rev >= MDP_REV_42) { ???
-	mdp4_kms->lut_clk = devm_clk_get(&pdev->dev, "lut_clk");
-	if (IS_ERR(mdp4_kms->lut_clk)) {
-		dev_err(dev->dev, "failed to get lut_clk\n");
-		ret = PTR_ERR(mdp4_kms->lut_clk);
-		goto fail;
+	if (mdp4_kms->rev >= 2) {
+		mdp4_kms->lut_clk = devm_clk_get(&pdev->dev, "lut_clk");
+		if (IS_ERR(mdp4_kms->lut_clk)) {
+			dev_err(dev->dev, "failed to get lut_clk\n");
+			ret = PTR_ERR(mdp4_kms->lut_clk);
+			goto fail;
+		}
 	}
 
 	mdp4_kms->axi_clk = devm_clk_get(&pdev->dev, "bus_clk");
@@ -488,7 +491,8 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	}
 
 	clk_set_rate(mdp4_kms->clk, config->max_clk);
-	clk_set_rate(mdp4_kms->lut_clk, config->max_clk);
+	if (mdp4_kms->lut_clk)
+		clk_set_rate(mdp4_kms->lut_clk, config->max_clk);
 
 	pm_runtime_enable(dev->dev);
 	mdp4_kms->rpm_enabled = true;
-- 
2.17.1

