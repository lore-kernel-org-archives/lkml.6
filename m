Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55290C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D90214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCk/B2fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D90214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeHBPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:10:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43075 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbeHBPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:10:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1295906pfi.10;
        Thu, 02 Aug 2018 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2vzQXCsiE8PuLnNZu34sY/6jMMftxW9L1acSr/qU3MU=;
        b=OCk/B2fAjAVeKuVb2s+Q7x89M61yKgKHSjt/GrvAqZPmbYs2EB9crqH4SnzX1Z6qsT
         47fGEVVPlpeUrOJ2+SOohaUDx1sia1G3O+85LpivUOl/z/SF8f4cR8eJqBM//aZAYKWW
         Q2hdywTBoxlFcYZxmIRV4ObsHJvu7p4gSv7n6mObgH1BmzODqGK+TrH8tSg32TkbF3FZ
         3K9cSIBq971zQk06Vwja725mtBbJ26c3B8oTMjA7GG1cl92dlLauyL5ClPjc1Cr+j4TU
         XWe6lYWIpyxjV2p1tJqHprDN/ynlwquthr1qbLAQzT4ZFUjobHJm1wNOhgouxHyyFZcv
         C0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2vzQXCsiE8PuLnNZu34sY/6jMMftxW9L1acSr/qU3MU=;
        b=WtfikJTFVmDt6WpI89XMNEWEydbyPOXBGeSnkIb9H/fOYPnB9bedouHI/dkXsP8WVw
         Wu1d2boUSoLhj3SRRynteWoWDIbanBH/j8jEZl9pA3dlGxS+6rfUARenyiv1unxdeha6
         IOAVUlO0VTvgXQh9hG66D0TU1tOsK+S1ipjR17yD1/a9XMMV0X5AwCWmTbMEn2Cy5c86
         J4fQZNqzZr6jFfjRGhcalA2I/dgglxgogT1bX1XrYQwNmJme8COGiUFJBBXOsxeqphw8
         bBzQLUv9Lpy8RRSCK3RIZ4jThOHPPwHbxmbsXvOGYx+QPSj65n9mVlw7Q95HSJJT6/3I
         A67w==
X-Gm-Message-State: AOUpUlHqrw1NypLoxxJLkaPRPVaqaq/DtEcp9hnnpOgzf16nvlWvU3U0
        EMNGIsooZu8niWrjuvyU/1XFJjXT
X-Google-Smtp-Source: AAOMgpenX6Y3ouzp5muve8RPf77iOaav6h/lalPdc5jMq6fNFf8JcZ0pJS/MGpeta9iUYGCvw7q/iA==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr2963432pfa.197.1533215953543;
        Thu, 02 Aug 2018 06:19:13 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.237])
        by smtp.gmail.com with ESMTPSA id u1-v6sm6723974pgk.25.2018.08.02.06.19.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 06:19:11 -0700 (PDT)
Date:   Thu, 2 Aug 2018 18:51:53 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        m.szyprowski@samsung.com, ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180802132152.GA2833@jordon-HP-15-Notebook-PC>
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

Remove suspend_state from exynos_drm_private
struct as it is no more useful.

Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2: Address Inki Dae's comment. Remove ret variable
    from both suspend/resume function.

v3: Tested by Marek. Updated the change log.

 drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
 4 files changed, 2 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index b599f74..d86dd81 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
 static int exynos_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
-
-	if (!drm_dev)
-		return 0;
-
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
 
-	return 0;
+	return  drm_mode_config_helper_suspend(drm_dev);
 }
 
 static void exynos_drm_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct exynos_drm_private *private;
-
-	if (!drm_dev)
-		return;
 
-	private = drm_dev->dev_private;
-	drm_atomic_helper_resume(drm_dev, private->suspend_state);
-	exynos_drm_fbdev_resume(drm_dev);
-	drm_kms_helper_poll_enable(drm_dev);
+	return drm_mode_config_helper_resume(drm_dev);
 }
 
 static const struct dev_pm_ops exynos_drm_pm_ops = {
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index c737c4b..7349e7c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -195,7 +195,6 @@ struct drm_exynos_file_private {
  */
 struct exynos_drm_private {
 	struct drm_fb_helper *fb_helper;
-	struct drm_atomic_state *suspend_state;
 
 	struct device *g2d_dev;
 	struct device *dma_dev;
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

