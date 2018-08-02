Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4485FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD3D21527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHNp8ihX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD3D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbeHBReQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:34:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38113 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbeHBReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:34:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so1204804plq.5;
        Thu, 02 Aug 2018 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i26qRoRztjK7/bDF0wdcQSNKEOSb9rfFuQma4tN1EM8=;
        b=CHNp8ihXZz0q5toujNHpgHBHFrdc/5D4iiuay5zNwbJhxGgta7Sdabta3WVlsHygP6
         rTt3cq9fr7eRswBXNjojGSGM9vdCcMH7eWks8jJ2H4yjMBSO2tICNdzlJC1CdYeA953t
         O/dcTxNJHkn3CVW8moSIi/Le3p5qUfRRmnjuR2Bh+qYqq/E22KJH+h5aRAUTvD6Wy0OL
         zMNKuqOhFewoXhy/SL7UH139gP/uKOrynI7O0gco2hFE/q7Y/u7W2lICgiPUkczTI54K
         vUCJStCTYQWN+2MVfg6chhREnbN3AmfnKfA+5Srs4SZraMAG6gRH5QNNj9RDgilGh9fb
         brWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i26qRoRztjK7/bDF0wdcQSNKEOSb9rfFuQma4tN1EM8=;
        b=f+KCGj29V8xOW1IzdYwIqtYgnJB97nUFtTgwaM4yDzr9+ZJvhi9jn5Iwaj6doNCCr1
         KhTI7tlTT8l/7iHZznJfIlGp22LG5eI/LZo/YKJVmrTcMny7Ewn6JQgM315RN+w2/aWW
         hHD6zIWHffzGX0L2v8Qkkh0IxcRGLxB/SB1QRfpYgMO+/oMnAsoTCm+JEY/a29lJ96T/
         od9aoWJjlve+IFrmqXp6Uk/Zzx5oZrbP0ktpGZxmefwM/NvdFKWaBPa/19gg66IATBd8
         8QkqMcAZAYgEcF5ksw/GNvJ3J6IykttsCTRjmJnkxh/QdXuD/RC/ZGk9Yb1qZOwHPjE9
         ZFSA==
X-Gm-Message-State: AOUpUlEagde3Rz2vSSj5OUZ2uOWjLucrwofhWYnFuLev4oVx6mI0FtfD
        3CaL9Ek9puqZNQaC/ORIhsPFlWVn
X-Google-Smtp-Source: AAOMgpfid5sdap9FnX76Ie/MdUKzszK8zExlZxl/Q6BtpkBlpMgWg2YgWVez0xuEkSuZI/LlMXl6WQ==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr2833201pld.15.1533224552399;
        Thu, 02 Aug 2018 08:42:32 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.237])
        by smtp.gmail.com with ESMTPSA id d19-v6sm5451301pfe.42.2018.08.02.08.42.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 08:42:30 -0700 (PDT)
Date:   Thu, 2 Aug 2018 21:15:17 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        ajitn.linux@gmail.com, m.szyprowski@samsung.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180802154517.GA10593@jordon-HP-15-Notebook-PC>
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

v4: removing the return as exynos_drm_resume()
    now returns void.

 drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
 4 files changed, 2 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index b599f74..6f76baf 100644
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
+	drm_mode_config_helper_resume(drm_dev);
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

