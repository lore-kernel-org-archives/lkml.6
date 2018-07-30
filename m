Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if+BoOwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG3UfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:35:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34958 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG3UfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:35:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7-v6so4929705pff.2;
        Mon, 30 Jul 2018 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sUP6fllJB0AaT3Td7EbbT7la/FEUXO2A5AE2XJFUeo8=;
        b=if+BoOwFSWD2GHUE9uoE8MeLm0fg8iPDZBqakVIIeTtkCO3h5yn0wL5LsOWBaXfYno
         /l7Yq4cLYP4qhfAT8GX++kSoxlxjtM4xEa3Ck1v3wc4kwZJx1zt8p0kSCARV34qqoFuZ
         dBlMeVQcHdByi+c2vJqYqvjkqNDMhO+2mraLAKp9BLjhFZkugemn0zOBPSD1JGDbezbG
         M1chvQSWCI+V/RqJSkepxH2QOWIei8UstI+S+PUvPnmbE3gce65iocf/Vu+v0JTbnpyb
         X147F63dsDDsEtDOGRLiFi7Nd4tFGpfaorp160ch3uHYyMLLzaCc1XjrpXcFkNx7J7r/
         z1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sUP6fllJB0AaT3Td7EbbT7la/FEUXO2A5AE2XJFUeo8=;
        b=k8Tenhl+Lb8Z4VMlBqf0oLVt0WxDyydqRs1DRgX9KBqSiwwHoydhZNkqKxzRnXGuAy
         CHet8QVB/61P3/sYifX63kR+E5FDAs+fUiKtuEQG3ReQEJ6PZG/UhHP7JexUAQZX3u86
         z+yN3P6o6MPvLUFI5zuJYOureCs3Lg5hSE9aLgoj0RuCbL/fi7pik6Kdo9MrZcgvJ3NH
         kfe4/tR4+h0iyoklkQAuPz7NuqqeBQNY2NERVPw+QdYsPxfu/ui+b4TdlkNOLjWZaFBf
         HRImwBhP3f/fo/37oKWEtTknvpRJf5Jhv9mpwTQE0kk7ntMFi5bXt8OeB31vAXRp4EV2
         I9Xw==
X-Gm-Message-State: AOUpUlEEZ4fkjupy4TUBUyd/jAp1CAAz/slezNfdqS3/yUKeEQIlMSMG
        2oou+9AOZe2Tp31yFJ8dmAefGb6E
X-Google-Smtp-Source: AAOMgpfjIx5FaKXdrEEXalzO4G1A/yTLXeJGOCvPDOe9hbBqZGIFcWZFlRjG+Wwu4oJNIO5SPBLFUg==
X-Received: by 2002:a63:5f50:: with SMTP id t77-v6mr16553805pgb.300.1532977134942;
        Mon, 30 Jul 2018 11:58:54 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.188])
        by smtp.gmail.com with ESMTPSA id e73-v6sm30813262pfb.153.2018.07.30.11.58.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 11:58:53 -0700 (PDT)
Date:   Tue, 31 Jul 2018 00:31:37 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        laurent.pinchart@ideasonboard.com, ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180730190137.GA25420@jordon-HP-15-Notebook-PC>
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

With this conversion, drm_fbdev_cma_set_suspend_unlocked()
will left with no consumer. So this function can be removed.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c       | 26 ++------------------------
 drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
 include/drm/drm_fb_cma_helper.h       |  2 --
 4 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index feaa8bc..4e617e0 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -427,37 +427,15 @@ static int hdlcd_remove(struct platform_device *pdev)
 static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
 
-	if (!hdlcd)
-		return 0;
-
-	drm_kms_helper_poll_disable(drm);
-	drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 1);
-
-	hdlcd->state = drm_atomic_helper_suspend(drm);
-	if (IS_ERR(hdlcd->state)) {
-		drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
-		drm_kms_helper_poll_enable(drm);
-		return PTR_ERR(hdlcd->state);
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static int __maybe_unused hdlcd_pm_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
-
-	if (!hdlcd)
-		return 0;
 
-	drm_atomic_helper_resume(drm, hdlcd->state);
-	drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
-	drm_kms_helper_poll_enable(drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm);
 }
 
 static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resume);
diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 186d00a..f604a84 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -529,21 +529,3 @@ void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state)
 		drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
 }
 EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
-
-/**
- * drm_fbdev_cma_set_suspend_unlocked - wrapper around
- *                                      drm_fb_helper_set_suspend_unlocked
- * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
- * @state: desired state, zero to resume, non-zero to suspend
- *
- * Calls drm_fb_helper_set_suspend, which is a wrapper around
- * fb_set_suspend implemented by fbdev core.
- */
-void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
-					bool state)
-{
-	if (fbdev_cma)
-		drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
-						   state);
-}
-EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 02aee6c..288220f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
 static int rcar_du_pm_suspend(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
-	struct drm_atomic_state *state;
 
-	drm_kms_helper_poll_disable(rcdu->ddev);
-	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
-
-	state = drm_atomic_helper_suspend(rcdu->ddev);
-	if (IS_ERR(state)) {
-		drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
-		drm_kms_helper_poll_enable(rcdu->ddev);
-		return PTR_ERR(state);
-	}
-
-	rcdu->suspend_state = state;
-
-	return 0;
+	return drm_mode_config_helper_suspend(rcdu->ddev);
 }
 
 static int rcar_du_pm_resume(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
 
-	drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
-	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
-	drm_kms_helper_poll_enable(rcdu->ddev);
-
-	return 0;
+	return drm_mode_config_helper_resume(rcdu->ddev);
 }
 #endif
 
diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index d532f88a..15c4569 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
 void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
 void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
 void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
-void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
-					bool state);
 
 struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
 	unsigned int plane);
-- 
1.9.1

