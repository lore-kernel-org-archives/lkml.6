Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FF12085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoZPt7z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FF12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJZWqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:46:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35627 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJZWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:46:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id a10-v6so1342381qtp.2;
        Fri, 26 Oct 2018 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Rbv6flR+9gHxN0WGViV7400flOdEju6hVfXP6x8s38=;
        b=EoZPt7z5PsC8yHcAd0Fdtw9VtF4l3GR40CQytufngqeELjrfO4H3mZapUOwXEXT4dN
         3mAyOxwbHTJpHqe9TV+HUgrAzUnE9ih4CnUeQ/1oWDDXPiAykzAEQcpKJpz6PGaumPG4
         YVCbtssOannuSrGWao30nDBNFF+ylS42zQ1pGFd9sGPC6r8m7sxa9AUwlrcFQP54pD6/
         AuVE4xmKTt0nUo0hOyliexYUlzXfPVZn5C7WM4Qgp6bSgGS1Z911oY7VGCePHhxDek6W
         9F0Uofeo67JQ1SQlYDwMwu/Njpq/ZH+UYzFd5mvMFQaZywJLIKWjHkCnMKoZs3ZkHLAu
         hdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Rbv6flR+9gHxN0WGViV7400flOdEju6hVfXP6x8s38=;
        b=Twbltt7mRIvt798+676AX7waDH04C9mA5xj/S6pVdWV/+NTU23L3bBJUoIO0+0B0fY
         u66kYPcfZv0ak+tRkZkzbe9gIv1+bV9lCGgdfImcohG8dJ+W1WgAskDTV2o7ln1zjTSv
         IQlW2/R05PEV5xzxNTcnepnBgZs9sjs3F8cQ6zoQ9ITJjk6291QnwNl+Vvv+n8c2zEQM
         THxypH4jZIdsuQN5lloJNRzvuwLwQ3fXAkKjchsOsW2z/Zqg7c2bBuOT6+SU7vfwFDo3
         d/kbAWm5y6IYEC35RD1Hjs6xawACBvSEKoQY/q1yzyLNRzOKKkiio6cufN0GbtsTuUhR
         c3Hg==
X-Gm-Message-State: AGRZ1gL2CNayLfCiYUjsYMTyzxv0taQLM2L16SPTvXkdOztzYwqllOln
        ZihmbHmSdiKOhgb36gbg8U8=
X-Google-Smtp-Source: AJdET5fKJY1+7CZj4kDZyevSN0ekiVKcYRY+9Iw0MBy6wEq3aUXeWEa6uyjbW06yHSVIImtSzUdXtQ==
X-Received: by 2002:a0c:a912:: with SMTP id y18mr3330252qva.39.1540562975225;
        Fri, 26 Oct 2018 07:09:35 -0700 (PDT)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id s71-v6sm8903205qkl.86.2018.10.26.07.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:09:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Date:   Fri, 26 Oct 2018 10:09:13 -0400
Message-Id: <20181026140931.15771-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
FB_BACKLIGHT prevents it from being built as a module.  There
doesn't seem to be any particularly good reason for this, so
switch FB_BACKLIGHT over to tristate.

Signed-off-by: Rob Clark <robdclark@gmail.com>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove IS_ENABLED() from UABI headers.  Userspace doesn't
    know the kernel config, so just remove the ifdef guard

 drivers/video/fbdev/Kconfig        | 2 +-
 drivers/video/fbdev/core/fbsysfs.c | 8 ++++----
 include/linux/fb.h                 | 2 +-
 include/uapi/linux/fb.h            | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 591a13a59787..146ab2c347f8 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -198,7 +198,7 @@ config FB_MACMODES
        default n
 
 config FB_BACKLIGHT
-	bool
+	tristate
 	depends on FB
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index e31a182b42bf..44cca39f2b51 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -60,7 +60,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
 #endif
 
@@ -429,7 +429,7 @@ static ssize_t show_fbstate(struct device *device,
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 static ssize_t store_bl_curve(struct device *device,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
@@ -510,7 +510,7 @@ static struct device_attribute device_attrs[] = {
 	__ATTR(stride, S_IRUGO, show_stride, NULL),
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
 #endif
 };
@@ -551,7 +551,7 @@ void fb_cleanup_device(struct fb_info *fb_info)
 	}
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 /* This function generates a linear backlight curve
  *
  *     0: off
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a3cab6dc9b44..7cdd31a69719 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -485,7 +485,7 @@ struct fb_info {
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	/* assigned backlight device */
 	/* set before framebuffer registration, 
 	   remove after unregister */
diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index 6cd9b198b7c6..b6aac7ee1f67 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -393,11 +393,9 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
-#ifdef CONFIG_FB_BACKLIGHT
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
-#endif
 
 
 #endif /* _UAPI_LINUX_FB_H */
-- 
2.17.2

