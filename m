Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7820894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piE2p9yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D7820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeGaWNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:13:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeGaWNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:13:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so9633135pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FQiyQ0vCg+5LOSTEbnQABBEQ95HMKLY6NZOuxHOY8II=;
        b=piE2p9ypc3EUPZS9AjPcNJ6B3HF5LU9sF4wmJI5CxQyYkMK0aHkadRFonela1HHbl0
         ggxRSooDdZ7Hq7xvxDtuiEJ9DwdLw68lk597BHSfhmz2pTzKUqmcHl4zqJMz/w1FUks7
         +8efOyklcqyXmG+6CvknS/vcmxIs9wg766YR4iWZkpKzjVTNtULfaZcd3Jx2bMRA6tb8
         JMiOHxuxHuyMnBGCojY90XsMJe+zzmdRMIdWJzubqHVNRrHndzn7EnWIPKPQcjix2M6D
         wyJiFT2TiTNT/kS1dKm/zA5J8Xhbxx4Y03oNHhAHILLVSr+MhKTipbEdpldnBdcEMIf8
         hfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FQiyQ0vCg+5LOSTEbnQABBEQ95HMKLY6NZOuxHOY8II=;
        b=I0osiPpCEBGKl2ThGphSjosEL+77Xcb4RgIVGTZhbbVi8q9prumqsDp5jnSmL8AVsP
         VENVHr7yT8s4ReQIP/FywnSC70c1Vj9TwBTmSBiTKo4SsE0Y3CL0VhHIyDG7Bd2FbaQj
         huAAtU6RgSsBQW+3s97dy4ywScRAUzgK47HIlxJ2YRGOMlesBxCgW9V8/j0u4E+0GgOs
         6MpRGe7wpcHk+9z4zUjdnZlBIeGslmh9N/gHhFu0LFsZ0U34arKfG/gKVBOdbQoSYxao
         P6UgMhU9FC2q2VMJAkSvzvasrJ4ER6OU4w3lxe65fm4yWqvpAnSFFXFATX6nglayKlDN
         Gh8g==
X-Gm-Message-State: AOUpUlHQXdFX3nBiFG4ZtC0RO3hXzbZFevo5XPjMvSmIGJ1bxS8VSBT5
        zKb2QoNjA3KfKYRISLgZYLqWy8L1
X-Google-Smtp-Source: AAOMgpc1mw8o+Xyd+KTmrNMLTUFn+qfAYvUFMTC3nA9b3pJt0Uh6lUcPGuj4T6H28IU+95Ew21av7Q==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr24146584pfj.143.1533069105055;
        Tue, 31 Jul 2018 13:31:45 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.188])
        by smtp.gmail.com with ESMTPSA id h4-v6sm16225103pgp.13.2018.07.31.13.31.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 13:31:43 -0700 (PDT)
Date:   Wed, 1 Aug 2018 02:04:30 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        ajitn.linux@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
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

With this conversion, rockchip_drm_fb_resume() and
rockchip_drm_fb_suspend() will not be used anymore.
Both of these functions can be removed.

Also, in struct rockchip_drm_private state will not be
used anymore. So this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 46 ++---------------------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 -
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f814d37..dd12390 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -243,60 +243,18 @@ static void rockchip_drm_unbind(struct device *dev)
 };
 
 #ifdef CONFIG_PM_SLEEP
-static void rockchip_drm_fb_suspend(struct drm_device *drm)
-{
-	struct rockchip_drm_private *priv = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 1);
-	console_unlock();
-}
-
-static void rockchip_drm_fb_resume(struct drm_device *drm)
-{
-	struct rockchip_drm_private *priv = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 0);
-	console_unlock();
-}
-
 static int rockchip_drm_sys_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv;
-
-	if (!drm)
-		return 0;
-
-	drm_kms_helper_poll_disable(drm);
-	rockchip_drm_fb_suspend(drm);
 
-	priv = drm->dev_private;
-	priv->state = drm_atomic_helper_suspend(drm);
-	if (IS_ERR(priv->state)) {
-		rockchip_drm_fb_resume(drm);
-		drm_kms_helper_poll_enable(drm);
-		return PTR_ERR(priv->state);
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static int rockchip_drm_sys_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv;
 
-	if (!drm)
-		return 0;
-
-	priv = drm->dev_private;
-	drm_atomic_helper_resume(drm, priv->state);
-	rockchip_drm_fb_resume(drm);
-	drm_kms_helper_poll_enable(drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm);
 }
 #endif
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3a6ebfc..d67ad0a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -51,7 +51,6 @@ struct rockchip_crtc_state {
 struct rockchip_drm_private {
 	struct drm_fb_helper fbdev_helper;
 	struct drm_gem_object *fbdev_bo;
-	struct drm_atomic_state *state;
 	struct iommu_domain *domain;
 	struct mutex mm_lock;
 	struct drm_mm mm;
-- 
1.9.1

