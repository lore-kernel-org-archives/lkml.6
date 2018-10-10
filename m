Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF40C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58894214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF8YaiOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58894214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJJWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:40:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34266 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:40:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id p6-v6so3390030qkg.1;
        Wed, 10 Oct 2018 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VOXSbdEt0OVCDUP0MpkXy8V73PRTpYDhkG9mvt9lii0=;
        b=UF8YaiOIozOCnrtsYvCDx/v8TFe9E8/QHi1a35yxqw/YrXodyZVCsZzfX/a7ZmF7M3
         R4EAP44aECk6fjCeKxk3JSp3RifpCg5PKb6r787Q/qPI8eWckmpFD3Kzf4Ft6TPeNx+5
         TYzoConFj+pBN728ptcVNPsg9ZoIQA2WgRfvkG2qtVIn5yHH1KXgh/Un+oMK6UzMvCvm
         mqxJyUJgpSdhPZ207zBGTOjkDEQXEIb5875LZ4Op6lQsQC8VuExx2+b4s2wxq3bOG/8+
         /qRG7z/XvRRzYo4NQiPmcfgrrJTRSpSob5XCplKDP4JATr8J4MCzCDw0+jUXqxOA4B9P
         UNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VOXSbdEt0OVCDUP0MpkXy8V73PRTpYDhkG9mvt9lii0=;
        b=k0ZcIB3nG/mQwhHt4xxIzJWS8zZIOET5hYkr8K4fr/zSVkMDwINeRxRm7Knsi7ezJM
         3W7dn3em7W0iH9/QRtWl7WcFwSzRR7me5UlxCx943ulk7h8ctO9BQHDraXg4vCDTaXy5
         tKbvG8a3dDwkW4wFuACMEvBdMWlH3pjc5QANknIqSEi48cq8CalvsL0XWm7OEM/O30Qs
         76nmIfxPO0eBP2LhpkvDGWhTuHmm/nHmLYn1pO4u57xe5caWIajSpW7Tnose9uLeJ+JQ
         uVGc9ZAFP+ES4ZcCi8CZnAhJ54URgnjhxhxp0zRfMUy0iRpBdUyUhO0A0UOsMbS1z3If
         2PHg==
X-Gm-Message-State: ABuFfoioAyIIaRiPXBFJnpuARaQYOpwmzspNmoxa8/o8i3Esr24YxXY7
        pFbKtWDOpMt3qCkuAC0BtLY=
X-Google-Smtp-Source: ACcGV63t4TdgMucQbaVJ1dVwZgXx4rfs712LR12CTUB+jDpm1RwbzWcf/ElkNgywWCVkgbPtFQIbYQ==
X-Received: by 2002:a37:444b:: with SMTP id r72-v6mr13844909qka.332.1539184688262;
        Wed, 10 Oct 2018 08:18:08 -0700 (PDT)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id h49-v6sm14717056qth.32.2018.10.10.08.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 08:18:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Date:   Wed, 10 Oct 2018 11:17:41 -0400
Message-Id: <20181010151801.21489-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
FB_BACKLIGHT prevents it from being built as a module.  There
doesn't seem to be any particularly good reason for this, so
switch FB_BACKLIGHT over to tristate.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/Kconfig        | 2 +-
 drivers/video/fbdev/core/fbsysfs.c | 8 ++++----
 include/linux/fb.h                 | 2 +-
 include/uapi/linux/fb.h            | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

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
index 6cd9b198b7c6..07f14cd6791a 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -393,7 +393,7 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
-- 
2.17.1

