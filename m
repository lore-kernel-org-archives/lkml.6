Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0678FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E692075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqbDQ8pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E692075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeGRV07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:26:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41655 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbeGRV06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:26:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so2518966pgu.8;
        Wed, 18 Jul 2018 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sArlYhHE0ht3rYmY1PBkXgKCIRhIlweZX/pOCKxQkMg=;
        b=kqbDQ8pf/TdbZsKpeb1aoFucsNa5ZrnA1y9bswUS6kt+Tp56qtwmcAOyJK/S7b9SgT
         VBvzcO3np1zNWJb/jkw3IUGwjTEQC3SNhAF3Bg/L/gleO6GmDE1QB+et5mQQYtd6Azt5
         atlfh/gEdXEskZWh37m3FOHbr5Pnq54ZL4rE/C147b8LX69oW5+XW1ODokEJtN0BRgdf
         gOPfwXbYA7mDxizcD12etZdT9PMzcgedSQ1f33pzoImu/5yEGN7DHV+hw7cn55kCDWfj
         DHHNiuzaM0ClXuErqCf15KdRwETx4mmqlKy4g/RKa5sSwU4wyUzWM/pigio8ZKt4bS64
         WWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sArlYhHE0ht3rYmY1PBkXgKCIRhIlweZX/pOCKxQkMg=;
        b=Bp54hPNieWRSloLxAfVNKlSQmRTu5V9tGeAkSQQMxM3bNeccECYSdpnhiZiQ2AiF95
         X/KvFGhrtcsIUn0iF7gbdevFHSvUfRph8xrklEZWW6Yh3D1T5PL1PWhmEyBnxr53TjVy
         oGhg4TLYZlY4jGfvsD9aXrh5T3TmO0xh7C/Sm2A7KHUP5fR+k7c0Tu3txvMC2N1Y75gp
         fLPqGX3YksUvCaQpSHj+jPRXotbn6qsNtAAOXixI16jPtUwDP+BthOyA5PdTJh00MI2W
         6lnrrUQNFZXu97KBXS36LUvxFVnAQLOEpaCg5Gf/urfKBIlpBoF7KFYwdJgRCiMuyNyy
         Li3Q==
X-Gm-Message-State: AOUpUlEsJtI5Z97kA3Z8cRRSHy5lVFmCV5mZ2u+cmhKwvY3aPRjjPp3R
        /gdDPDPzIoq/HiBxPGswes9phA==
X-Google-Smtp-Source: AAOMgpd7bWVAL21abZTIE4IQnYyIJR39tveel9jBQlS6BLV5uJaV5CBZ9/1Y5zExCvH6otmw+NxABw==
X-Received: by 2002:a63:aa44:: with SMTP id x4-v6mr7328392pgo.120.1531946840705;
        Wed, 18 Jul 2018 13:47:20 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.142])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5676211pgs.17.2018.07.18.13.47.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 13:47:19 -0700 (PDT)
Date:   Thu, 19 Jul 2018 02:19:57 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180718204957.GA14132@jordon-HP-15-Notebook-PC>
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
 drivers/gpu/drm/exynos/exynos_drm_drv.c   | 32 ++++++++++---------------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 ----------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
 3 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index a81b4a5..1996ff7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -151,39 +151,27 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
 static int exynos_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
+	int ret = 0;
 
-	if (pm_runtime_suspended(dev) || !drm_dev)
-		return 0;
+	if (pm_runtime_suspended(dev))
+		return ret;
 
-	private = drm_dev->dev_private;
+	ret = drm_mode_config_helper_suspend(drm_dev);
 
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
+	return ret;
 }
 
 static int exynos_drm_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
+	int ret = 0;
 
-	if (pm_runtime_suspended(dev) || !drm_dev)
-		return 0;
+	if (pm_runtime_suspended(dev))
+		return ret;
 
-	private = drm_dev->dev_private;
-	drm_atomic_helper_resume(drm_dev, private->suspend_state);
-	exynos_drm_fbdev_resume(drm_dev);
-	drm_kms_helper_poll_enable(drm_dev);
+	ret = drm_mode_config_helper_resume(drm_dev);
 
-	return 0;
+	return ret;
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

