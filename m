Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7406C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1DD2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN+kS7A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1DD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbeGZRJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:09:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbeGZRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:09:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so720932pff.9;
        Thu, 26 Jul 2018 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AeDt/GpAfzOMrkrlRIMneLTkkm1bS5veHSM4fjYpZTA=;
        b=CN+kS7A2AEziQpBlyFP0yMZpXv2ntazyJJh8oi5MOkcCS+YC0huSleuVA9zOmg74zR
         FtAC1GUMRqujYXY/vHZ4X8hFGM1v0Kp9ZyxIlf6JohJOAR7XlAAvid4xSDWPT2JBiiWQ
         Z6sXpEXJQrXaA1nIcUvQGetR7TpcKlvITnruKeSB9ioFz6Ex9P9hETdULU440bkm9haJ
         /aoLFsNh2DAEVpzMS2AVCETRWOZAi91DFfwKsSegRA48OTsd0e2QEMkZ6OhmIhoBsjhM
         H6IY3FP/J0r3jYMc0eLnKge6mnxDLy8IEkv/KLIHnHCLJ4D7I+0vLL9W4fwf0/pgRfTh
         3gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AeDt/GpAfzOMrkrlRIMneLTkkm1bS5veHSM4fjYpZTA=;
        b=FK3u/twk05Pic1iVR1ewTJSw5+zkoij3gVuXzwAlKVujXBB8rDMf5J0OQ5UKexlmVV
         dftvsXrefoB4A8NOl8MfZZlqL3spwcmDw4BhIH4bYUb9r3i5xu6WVc+vCK4QqgrrrhVY
         QhLrVKKgm/cCVIfdNpjIfwEozBxyMPrR+oosr8fgZpG1e8frS2Y1RZqQiXfb6zh6VLdU
         mAreLfpe1pTZkLfkSaXZPFsLZs2xgVt49Nq3n/8N0CnpI6rt+8t5VwoXdVDJ87NgXs27
         ERfrmpmbdtWi0i2fSNrHunCDD8rD5u1nlv16Q/zs6khzcp4j+ffp0AMKBRvlq+wPfnJC
         opjQ==
X-Gm-Message-State: AOUpUlEbsVqiune/Aaac7EJthUMyADuP7x56v7qKTAMv8Ps5IbZxEg3N
        hmcfs9JvwyZ6uggbmn958Tk=
X-Google-Smtp-Source: AAOMgpdfDcBFV1l6CP80ibBtsXAx/Xwt3HO3hXfmJR7DLT7H02armsEHoBeTWU3+rQWV3C3nd0OTZQ==
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr2661102pfy.227.1532620336936;
        Thu, 26 Jul 2018 08:52:16 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.162])
        by smtp.gmail.com with ESMTPSA id v3-v6sm8771309pgb.54.2018.07.26.08.52.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 08:52:15 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:24:59 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com
Subject: [PATCH v2] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
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

exynos_drm_fbdev_suspend/resume can be removed
as drm_mode_config_helper_suspend/resume has
implement the same in generic way.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
v2: Address Inki Dae's comment. Remove
    ret variable from both suspend/resume
    function.

 drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
 3 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index a81b4a5..46d28cd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
 static int exynos_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
 
-	if (pm_runtime_suspended(dev) || !drm_dev)
+	if (pm_runtime_suspended(dev))
 		return 0;
 
-	private = drm_dev->dev_private;
-
-	drm_kms_helper_poll_disable(drm_dev);
-	exynos_drm_fbdev_suspend(drm_dev);
-	private->suspend_state = drm_atomic_helper_suspend(drm_dev);
-	if (IS_ERR(private->suspend_state)) {
-		exynos_drm_fbdev_resume(drm_dev);
-		drm_kms_helper_poll_enable(drm_dev);
-		return PTR_ERR(private->suspend_state);
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int exynos_drm_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
 
-	if (pm_runtime_suspended(dev) || !drm_dev)
+	if (pm_runtime_suspended(dev))
 		return 0;
 
-	private = drm_dev->dev_private;
-	drm_atomic_helper_resume(drm_dev, private->suspend_state);
-	exynos_drm_fbdev_resume(drm_dev);
-	drm_kms_helper_poll_enable(drm_dev);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 132dd52..918dd2c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
 	private->fb_helper = NULL;
 }
 
-void exynos_drm_fbdev_suspend(struct drm_device *dev)
-{
-	struct exynos_drm_private *private = dev->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(private->fb_helper, 1);
-	console_unlock();
-}
-
-void exynos_drm_fbdev_resume(struct drm_device *dev)
-{
-	struct exynos_drm_private *private = dev->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(private->fb_helper, 0);
-	console_unlock();
-}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
index b338472..6840b6a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
@@ -19,8 +19,6 @@
 
 int exynos_drm_fbdev_init(struct drm_device *dev);
 void exynos_drm_fbdev_fini(struct drm_device *dev);
-void exynos_drm_fbdev_suspend(struct drm_device *drm);
-void exynos_drm_fbdev_resume(struct drm_device *drm);
 
 #else
 
@@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
 
 #define exynos_drm_output_poll_changed (NULL)
 
-static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
-{
-}
-
-static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
-{
-}
-
 #endif
 
 #endif
-- 
1.9.1

