Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367220841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRXKq7Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9367220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbeGaVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:07:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:07:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so9554127pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ikNDl+7elGUJ2d3kCdplxvF3vjVOSBtnYK2Ma/4s7Bg=;
        b=rRXKq7VfHylXLBV9c0roKQ/7+9TxLpWXcyXrBPr1qPen9rGfkcT4AcMKvUc8Rj2JXY
         +cW0gkJNfhYTOmpvkK/NqidVF2RdJFaDRIBAjP5/AWZX2JL8k/J/0NU06mfkT8MH6RJO
         +AtfL6NUf9m0d5qunwFcW2gKsVQjTYQOZRBSwoR+2tDIpn8uBxHNkb0sMJm9s9iRuzmr
         DSwq/N4yS0aGcwOefeFr++2h8ckqsV8ZZoZawp56hENDVQxOx8dK6o5VfehVoQrZrH0d
         pSvc4h91xbwfcV11+F+v/avXrXPYrZUi08EJ2LN0JI22x4OKkfas/67mYEaSQ0rtCWyj
         wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ikNDl+7elGUJ2d3kCdplxvF3vjVOSBtnYK2Ma/4s7Bg=;
        b=JpG8UnVkgX44sYLmJH+kGP+klZIbHIvxX7r7+WHxWmw6ZGDY6hykDOhMhp0yWT8nyY
         IAHFxk8oVkFNgQ24YJn04Pin1fV+JbRO1lMU7sTL+bMG9Z1dfFRue4TJMKGFaohxN47P
         ga+T2vMuaz0Jg9+jzsXujG2NPvN/uuEOR6TzOP3DTs9rm2IIhyk6UQCwrAZJt4ZdSJmx
         EeIQHa0w8Tb5hxhOL1WxLOeTU2cWgYoK04pVUzGMjgC5/HTJMpT16hR6RS2otjFXHhtX
         OKfU5x6TT1VcORK95RGnxLYAxUvl6gN3W37sr8WZyRxIp77OalD0Nh6zutUX/bh10idw
         70WA==
X-Gm-Message-State: AOUpUlHPCI7Hq7wSSuE+auG10338LE3EkR0bf4hAJhs5xkVtenWBwafd
        Nz7gWjcuzZNm8f//X73F/5E=
X-Google-Smtp-Source: AAOMgpcRJii1MmLfQ7dJDit/m97xn8nF56RbW1kO4ELK1l99gWq0zDaBGxGFTQ9uA6NdhCycWF3tCQ==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr23446947pfi.2.1533065148071;
        Tue, 31 Jul 2018 12:25:48 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.188])
        by smtp.gmail.com with ESMTPSA id o4-v6sm40300611pgq.16.2018.07.31.12.25.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 12:25:46 -0700 (PDT)
Date:   Wed, 1 Aug 2018 00:58:33 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     p.zabel@pengutronix.de, airlied@linux.ie, ajitn.linux@gmail.com,
        leonard.crestez@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch
Subject: [PATCH v2] drm/imx: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180731192832.GA12073@jordon-HP-15-Notebook-PC>
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

with this conversion, both the members of struct
imx_drm_device pipes and state will be no more
useful and it could be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
v2: Address Philipp's comment. Remove
    struct imx_drm_device.

 drivers/gpu/drm/imx/imx-drm-core.c | 43 ++------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 1d053bb..a692d68 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -35,12 +35,6 @@
 
 #define MAX_CRTC	4
 
-struct imx_drm_device {
-	struct drm_device			*drm;
-	unsigned int				pipes;
-	struct drm_atomic_state			*state;
-};
-
 #if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
 static int legacyfb_depth = 16;
 module_param(legacyfb_depth, int, 0444);
@@ -219,22 +213,12 @@ static int compare_of(struct device *dev, void *data)
 static int imx_drm_bind(struct device *dev)
 {
 	struct drm_device *drm;
-	struct imx_drm_device *imxdrm;
 	int ret;
 
 	drm = drm_dev_alloc(&imx_drm_driver, dev);
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
 
-	imxdrm = devm_kzalloc(dev, sizeof(*imxdrm), GFP_KERNEL);
-	if (!imxdrm) {
-		ret = -ENOMEM;
-		goto err_unref;
-	}
-
-	imxdrm->drm = drm;
-	drm->dev_private = imxdrm;
-
 	/*
 	 * enable drm irq mode.
 	 * - with irq_enabled = true, we can use the vblank feature.
@@ -306,7 +290,6 @@ static int imx_drm_bind(struct device *dev)
 	component_unbind_all(drm->dev, drm);
 err_kms:
 	drm_mode_config_cleanup(drm);
-err_unref:
 	drm_dev_unref(drm);
 
 	return ret;
@@ -355,37 +338,15 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
 static int imx_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct imx_drm_device *imxdrm;
-
-	/* The drm_dev is NULL before .load hook is called */
-	if (drm_dev == NULL)
-		return 0;
-
-	drm_kms_helper_poll_disable(drm_dev);
 
-	imxdrm = drm_dev->dev_private;
-	imxdrm->state = drm_atomic_helper_suspend(drm_dev);
-	if (IS_ERR(imxdrm->state)) {
-		drm_kms_helper_poll_enable(drm_dev);
-		return PTR_ERR(imxdrm->state);
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int imx_drm_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct imx_drm_device *imx_drm;
 
-	if (drm_dev == NULL)
-		return 0;
-
-	imx_drm = drm_dev->dev_private;
-	drm_atomic_helper_resume(drm_dev, imx_drm->state);
-	drm_kms_helper_poll_enable(drm_dev);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
 
-- 
1.9.1

