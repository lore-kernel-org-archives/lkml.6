Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2484C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7805320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqbKUvUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7805320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeGaVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:46:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45798 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGaVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:46:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so6617701pfo.12;
        Tue, 31 Jul 2018 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sEE9CUkse8pz+BACRudKwfsWTWfB2imbK5IEGi39cUs=;
        b=BqbKUvUeQIRQIOVG2XwBWM9iRRq7MMlsqCdBgi5umvleAisF3dShFs5FamXAzzHhz7
         BsOSqyPfyIOj1yCnRT9IJG+vysr9DBOaLZ9fbeAhRDa87H08D2i50L1VEGMdRvtW0akZ
         Du5jFFN4BhfDdAl30w7qDyAKAOVl9iecBUUnhj5VeL3NaVREMr2nFp4ajStuVF+ArDWk
         YOC3WgDCcAjtX/o1/LcgHjs1VPD3qqf4Jzhi7ey6Ms67GNwtYehuVcXyYkUsI3Ur+lQK
         rVZYxwBs/I4HlduE5htxZ1+eml/CCaPXqVOvE8jsXy1ylTZG+g6a+cqfFCCzLaioZGt6
         zrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sEE9CUkse8pz+BACRudKwfsWTWfB2imbK5IEGi39cUs=;
        b=CtsHIXiV5J3yLBvtGlRCK2Fz5AEZEm1oX30WddAGpmBaEvJ1t1ADqQzOhSLPndQhCM
         YT3XtxDldE5tAZ8R1ei+LZ8DxEo3dLh9A1J3YnPPIqCfHgre0UoK31E768j1lthFQjxh
         kn70kmvHy7PRE10iHOSTeynuf9MmrL6KfPNBHZF4CWMGkNNvQp7azm39uOTbujuGyqCj
         NCJOxG6Vgph+X/w7zVbeIug0kRJdQK+IhF/nJW+qodlosmdLMvtV2a8WfhEGQoP1Geff
         sPfvx299DtfMFBne8CEkoMlGfs8SLgV+EXzKq1HQa9b3CIJPNnEDFDcxS609By4eKnFt
         RZgg==
X-Gm-Message-State: AOUpUlEF39krEBPBRsZwXmtqscksXVZcMAnRbJ7ScDTreRmCMuCQYGUZ
        P88tfJh5bGDiw7D3gDb1n+wqglrR
X-Google-Smtp-Source: AAOMgpcjdhaGLZWVoWNYF0CHFbzMru3Xr+L8n0k93z6A22wrrHqtup9q3ZvoXmRJArWRzhw1FlMFxg==
X-Received: by 2002:a62:d94a:: with SMTP id s71-v6mr23431943pfg.164.1533067459958;
        Tue, 31 Jul 2018 13:04:19 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.188])
        by smtp.gmail.com with ESMTPSA id h132-v6sm22007969pfc.100.2018.07.31.13.04.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 13:04:18 -0700 (PDT)
Date:   Wed, 1 Aug 2018 01:37:05 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, jonathanh@nvidia.com,
        ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
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

With this conversion, tegra_drm_fb_suspend() and
tegra_drm_fb_resume() wil not be used anymore.
Both of these functions can be removed.

Also, in tegra_drm struct's member state will not be
used anymore. So this can be removed forever.

Fixed one sparse warning.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/tegra/drm.c | 20 ++------------------
 drivers/gpu/drm/tegra/drm.h |  4 ----
 drivers/gpu/drm/tegra/fb.c  | 24 +-----------------------
 3 files changed, 3 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index a2bd587..9a0efce 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1212,31 +1212,15 @@ static int host1x_drm_remove(struct host1x_device *dev)
 static int host1x_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct tegra_drm *tegra = drm->dev_private;
-
-	drm_kms_helper_poll_disable(drm);
-	tegra_drm_fb_suspend(drm);
-
-	tegra->state = drm_atomic_helper_suspend(drm);
-	if (IS_ERR(tegra->state)) {
-		tegra_drm_fb_resume(drm);
-		drm_kms_helper_poll_enable(drm);
-		return PTR_ERR(tegra->state);
-	}
 
-	return 0;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static int host1x_drm_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct tegra_drm *tegra = drm->dev_private;
 
-	drm_atomic_helper_resume(drm, tegra->state);
-	tegra_drm_fb_resume(drm);
-	drm_kms_helper_poll_enable(drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm);
 }
 #endif
 
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 92d2487..1012335 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -60,8 +60,6 @@ struct tegra_drm {
 	unsigned int pitch_align;
 
 	struct tegra_display_hub *hub;
-
-	struct drm_atomic_state *state;
 };
 
 struct tegra_drm_client;
@@ -186,8 +184,6 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 void tegra_drm_fb_free(struct drm_device *drm);
 int tegra_drm_fb_init(struct drm_device *drm);
 void tegra_drm_fb_exit(struct drm_device *drm);
-void tegra_drm_fb_suspend(struct drm_device *drm);
-void tegra_drm_fb_resume(struct drm_device *drm);
 
 extern struct platform_driver tegra_display_hub_driver;
 extern struct platform_driver tegra_dc_driver;
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 4c22cdd..b947e82 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -356,7 +356,7 @@ static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
 		/* Undo the special mapping we made in fbdev probe. */
 		if (bo && bo->pages) {
 			vunmap(bo->vaddr);
-			bo->vaddr = 0;
+			bo->vaddr = NULL;
 		}
 
 		drm_framebuffer_remove(fbdev->fb);
@@ -412,25 +412,3 @@ void tegra_drm_fb_exit(struct drm_device *drm)
 	tegra_fbdev_exit(tegra->fbdev);
 #endif
 }
-
-void tegra_drm_fb_suspend(struct drm_device *drm)
-{
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	struct tegra_drm *tegra = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&tegra->fbdev->base, 1);
-	console_unlock();
-#endif
-}
-
-void tegra_drm_fb_resume(struct drm_device *drm)
-{
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	struct tegra_drm *tegra = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&tegra->fbdev->base, 0);
-	console_unlock();
-#endif
-}
-- 
1.9.1

