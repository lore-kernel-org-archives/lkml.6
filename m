Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7B9214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik1fb4qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7B9214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeIRWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:09:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45376 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbeIRWJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:09:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id x26-v6so1288022pge.12;
        Tue, 18 Sep 2018 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0zR4KHU25tOQmG70BAyRXZ6j1Aub72aKlrcCY7jrN0M=;
        b=Ik1fb4qQ6Kh8D89HyLYP2BYC/CNJgrcQz4VOLEZXue1qqm7+Fanw88/VS7hkbnrh2E
         NiNIPA0+V/RVKNZ0HSa78xiPSwzT+YlmDVnXBmVkbdArVZ6IfE1MfDcb4vwMzLKUPTuv
         4ZoKc9ntM4H34gbObb6cTz+9vO00Y4s0+1s6HzDo8/ff77SjUr/uIqD8RE3J/LP2QfaK
         yU7Xq0vpPa7CpEI335fvP2FMv3xs+ukQkAiL6sl1jWRnPCUObdgof+yKITFwjGAi2YW/
         YxJchmNuYMmzH7lDD88n2EJVDnrJUBTOzX3+SW+8f5puubGX4ZFeP/VoVDEOQwNk5agh
         uHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0zR4KHU25tOQmG70BAyRXZ6j1Aub72aKlrcCY7jrN0M=;
        b=Y/jyDWo0yO9A565QTSonpBKkBQ2uHL8wDy1KGpthrY9dBUTbKd7dEbHQ710Se6PsEg
         lTQsdOEfXw0bW2UhTsWtyLB2BqxFDuTmczKzRUC2qaPDZh9DaKtYQkJcm8xylxP59JUD
         70mxYotcHw7puuWQiub0KJce++RbXjC5Ez3R0Y2mUXWepRJrVbD+aRLDpSvZVa5hqopl
         rV6VI/qK4UxoXeoSs6N4/HzqI3UfpHgyJL9f8Q1XzTkcwgzvRhqi8hE/A/mCbRRrCMxV
         pAMJCklTwE/9I+DpQFZmPeR3TKI98xrI6vqm7ulxM2bbWcWv4gWIIEQqKm7KmrzfsUAS
         fApA==
X-Gm-Message-State: APzg51DHn0rLc/grEXDRWKKBuH8zsKocZqHtVz92pJ0xVXF2W8YTRaFs
        c8Jdbymw7hUHrhh9Qh9Lnl9qb/hP
X-Google-Smtp-Source: ANB0VdaC/lgM84YcbtkY3oeYgXnFgGs023EZE54xJD8ono2wBOP39fZeVi4WByfEfh149nJF8oPvvQ==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr31533439pfz.85.1537288553619;
        Tue, 18 Sep 2018 09:35:53 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm26198491pgg.7.2018.09.18.09.35.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 09:35:52 -0700 (PDT)
Date:   Tue, 18 Sep 2018 22:09:03 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie,
        laurent.pinchart@ideasonboard.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
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

remove suspend_state field from the rcar_du_device
structure as it is no more required.

With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
will left with no consumer. So this function can be removed.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
 include/drm/drm_fb_cma_helper.h       |  2 --
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 47e0e2f..96efc88 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma)
 		drm_fb_helper_hotplug_event(&fbdev_cma->fb_helper);
 }
 EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
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
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index b3a25e8..ff25c8d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -78,7 +78,6 @@ struct rcar_du_device {
 
 	struct drm_device *ddev;
 	struct drm_fbdev_cma *fbdev;
-	struct drm_atomic_state *suspend_state;
 
 	struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index 4a65f0d..8dbbe1e 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
 
 void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
 void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
-void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
-					bool state);
 
 struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
 	unsigned int plane);
-- 
1.9.1

