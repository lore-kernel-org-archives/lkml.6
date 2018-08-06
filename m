Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6272A21A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmL6rUjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6272A21A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeHFQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:55:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeHFQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:55:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so6321200pgq.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eQwj5isHeQ9gI+aneM2JDEHNLTC2hIfHAKk1f6sDIDk=;
        b=MmL6rUjFcnS+erhI52bHd8DP4Eb9Ybg5eZ8NNNC6Z/kjgjByaD0ebgw8VylP3Ce/KT
         K9CcaCaK2pkFX+gN8ZQvbfhacbNPuPV7rACO3aiLIjuqgB1n+ro8DN84kX1u24AkEnIg
         Y/LJSy9050b3EoBvns0W1+z4ECKTVxV8K+iJYk/Mu+IZYAOzoHSWA9HO/B981YwGOpFV
         epVpY68FbNwbPSQWHmcciJvAa46ev32zKOqjj700HRTYl+DlbIP4oFVdwBL1IyR+OLUu
         0lwRUWhLZRt9NDaloWMpmm1//at1Cz4Lxf++2lP3yW6yxCj8MC4NKV1Veds/K4OCRry0
         lftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eQwj5isHeQ9gI+aneM2JDEHNLTC2hIfHAKk1f6sDIDk=;
        b=AWAevZ7ZaucgaMt1o2Udj2p+6BPqJPIjzsafhIoYVAbG9BGUmBGAz3Ge53ZXi6CEfE
         reNOg53+r4mmQYWo9iUNsDDh/BB29rFHs4DbRd/MYDM8sVSs15PICcKMM06a5FMw2Oet
         8gbYQhm9z9bvXgzz+R+kaGt4WtKjahug0I9qE9Tl1q0C02vBrGd6gU9GCov0KVIx1xgS
         5dSLGSJqYDPJ5x1Ih+pWkJKdRe9vJZv1AfY9enOd3a/5WXFhp1bQoWjQoyh7bl9tntbn
         YRNBWsAX13nAj2SDw8s/cA5BrNMae9JbhPmjceZyWj0qJRkbraSj7Oe8YembYG+EReoU
         kyAg==
X-Gm-Message-State: AOUpUlHpMKtIbkF4dllNncm+aICBIv6kl7fxKuN2cBdgpeVbha6lsXuq
        QYuzbFE4b0th90z/F4PrJlY=
X-Google-Smtp-Source: AAOMgpcGvSVj1oJGT66jLMbBpB3Qt/PuHJHWTJz6R9uQ7qCU5SNe47UnaKaAtNE8gvJsL9lnymWL9w==
X-Received: by 2002:a63:df50:: with SMTP id h16-v6mr14027672pgj.300.1533566772698;
        Mon, 06 Aug 2018 07:46:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.203])
        by smtp.gmail.com with ESMTPSA id s66-v6sm11860812pgc.67.2018.08.06.07.46.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 07:46:11 -0700 (PDT)
Date:   Mon, 6 Aug 2018 20:19:01 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com,
        daniel@ffwll.ch
Subject: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180806144900.GA13925@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

Fixed one sparse warning by making hibmc_drm_interrupt
static.

Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
---
v2: remove ret variable from both suspend and resume.
    remove suspend_state from hibmc_drm_private struct.

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 20 +++-----------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index d4f6f1f..ee24480 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -37,7 +37,7 @@
 	.llseek		= no_llseek,
 };
 
-irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
+static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv =
@@ -74,30 +74,16 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct hibmc_drm_private *priv = drm_dev->dev_private;
-
-	drm_kms_helper_poll_disable(drm_dev);
-	priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
-	if (IS_ERR(priv->suspend_state)) {
-		DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
-			  PTR_ERR(priv->suspend_state));
-		drm_kms_helper_poll_enable(drm_dev);
-		return PTR_ERR(priv->suspend_state);
-	}
 
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int  __maybe_unused hibmc_pm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct hibmc_drm_private *priv = drm_dev->dev_private;
 
-	drm_atomic_helper_resume(drm_dev, priv->suspend_state);
-	drm_kms_helper_poll_enable(drm_dev);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 
 static const struct dev_pm_ops hibmc_pm_ops = {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index e195521..45c25a4 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -47,7 +47,6 @@ struct hibmc_drm_private {
 	/* drm */
 	struct drm_device  *dev;
 	bool mode_config_initialized;
-	struct drm_atomic_state *suspend_state;
 
 	/* ttm */
 	struct drm_global_reference mem_global_ref;
-- 
1.9.1

