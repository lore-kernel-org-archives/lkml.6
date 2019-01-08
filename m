Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E33C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D949F20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjpdWWph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfAHT4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:56:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34502 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfAHTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so4430974lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aiWAX05aZOuCgHu5HWLvtq1Rin9a5xD1WbyxPTzSqY=;
        b=WjpdWWphhU7vuYWRyBtOtyNj1pJ1aS0ZCNp6qUADuya7N3OlhlLGKUXVhJcuOGZyGf
         Be+xOtUMz6WPIv5nUgDQqA2tf2TAAqfuVxjTvATkm/AQGRFrCyReAS+0fwa9/UQJtuGQ
         fUZ0HkUsuLnu+2HaBjSB+3mR15gIjVC6lsnCA/Gu3aMhN29ucvb5V6ewcFPc6FfyKanR
         7XWPKv7lmabYfkA3Wz+HzMmnSc1l9TBDs9r7lXjK9XPhYmev4SLrAhCsOJ1kd8KQDKQL
         poE+3DuEDvUBw9yslLHFl+nbY4D6OqyG3i2TsbizNtedShQTWr+Yd5p/fekvoN1dgqpH
         0YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2aiWAX05aZOuCgHu5HWLvtq1Rin9a5xD1WbyxPTzSqY=;
        b=Tx18CkD0k7KUyGQ3ZN3yjNrWHb+HXx+c5ToZL4iYcoElwkHl3CjX+L9iqsqZSfqxIB
         7XWW1M7vxQHuUCtaKW96/UgNGR10xFgaDaIdN5SlxlEY9H1ermP5s7IV5CAGKPIXZxbt
         MX5OR6ninCVT2aQfrR18eTqqT64zJmfNKoMD01D/4AqY4YYIM6Ti5IJuNwaLyRUND0uc
         KbUVLsK9aQ6Kn/JTeUguqLzFrufrosZG6Yyq6GxES6aeaYNyV/ZldH0xHetwVDCbu5C5
         gPbFMnBdltE+pDSROn95SOzTcYMW61oGK1WsLGksz4w10lGMa5Qqbo5ZyBvnGHi3GVyQ
         NIxA==
X-Gm-Message-State: AJcUuke2HUfBT9tQ88PRuhmBu7nyaJBzLw9n7PEiuUn45GrBOqsWnx/X
        RpnGU+bUvnB6N7/fkJCOaaE=
X-Google-Smtp-Source: ALg8bN49Orxh4b3NuBvPqEJMjaF/3FXyr7216pMej7zyxWRM+H6kBFMEQL5DKorMjMjesJRUeiKNiA==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr1760925lji.145.1546975802468;
        Tue, 08 Jan 2019 11:30:02 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:30:02 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v3 11/12] drm/tinydrm: do not reply on drmP.h from drm_gem_cma_helper.h
Date:   Tue,  8 Jan 2019 20:29:38 +0100
Message-Id: <20190108192939.15255-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h was the only header file in the past and a lot
of files rely on that drmP.h defines everything.
The goal is to one day to delete drmP.h and
as a step towards this it will no longer be included in the
headers files in include/drm/

To prepare tinydrm/ for this add dependencies that
othwewise was pulled in by drmP.h from drm_gem_cma_helper.h

To avoid that tinydrm.h became "include everything",
push include files to the individual drivers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Acked-by: David Lechner <david@lechnology.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Eric Anholt <eric@anholt.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c | 3 +++
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c | 3 +++
 drivers/gpu/drm/tinydrm/hx8357d.c           | 1 +
 drivers/gpu/drm/tinydrm/ili9225.c           | 2 ++
 drivers/gpu/drm/tinydrm/ili9341.c           | 1 +
 drivers/gpu/drm/tinydrm/mi0283qt.c          | 1 +
 drivers/gpu/drm/tinydrm/mipi-dbi.c          | 3 +++
 drivers/gpu/drm/tinydrm/repaper.c           | 1 +
 drivers/gpu/drm/tinydrm/st7586.c            | 1 +
 drivers/gpu/drm/tinydrm/st7735r.c           | 1 +
 10 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
index 01a6f2d42440..aeb93eadb047 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
@@ -10,11 +10,14 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_print.h>
 #include <drm/tinydrm/tinydrm.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
+#include <linux/module.h>
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
index eacfc0ec8ff1..d4576d6e8ce4 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
@@ -9,8 +9,11 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
 #include <drm/tinydrm/tinydrm.h>
 
 struct tinydrm_connector {
diff --git a/drivers/gpu/drm/tinydrm/hx8357d.c b/drivers/gpu/drm/tinydrm/hx8357d.c
index 81a2bbeb25d4..3ae11aa4b73b 100644
--- a/drivers/gpu/drm/tinydrm/hx8357d.c
+++ b/drivers/gpu/drm/tinydrm/hx8357d.c
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
diff --git a/drivers/gpu/drm/tinydrm/ili9225.c b/drivers/gpu/drm/tinydrm/ili9225.c
index 78f7c2d1b449..b0ad58b97227 100644
--- a/drivers/gpu/drm/tinydrm/ili9225.c
+++ b/drivers/gpu/drm/tinydrm/ili9225.c
@@ -20,7 +20,9 @@
 #include <linux/spi/spi.h>
 #include <video/mipi_display.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/tinydrm/mipi-dbi.h>
diff --git a/drivers/gpu/drm/tinydrm/ili9341.c b/drivers/gpu/drm/tinydrm/ili9341.c
index 51395bdc6ca2..bcdf10906ade 100644
--- a/drivers/gpu/drm/tinydrm/ili9341.c
+++ b/drivers/gpu/drm/tinydrm/ili9341.c
@@ -15,6 +15,7 @@
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c b/drivers/gpu/drm/tinydrm/mi0283qt.c
index 3fa62e77c30b..97805ca37a04 100644
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ b/drivers/gpu/drm/tinydrm/mi0283qt.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index 3a05e56f9b0d..10294e1283dd 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -10,14 +10,17 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/tinydrm/mipi-dbi.h>
 #include <drm/tinydrm/tinydrm-helpers.h>
diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
index 54d6fe0f37ce..b2a8f894946a 100644
--- a/drivers/gpu/drm/tinydrm/repaper.c
+++ b/drivers/gpu/drm/tinydrm/repaper.c
@@ -26,6 +26,7 @@
 #include <linux/spi/spi.h>
 #include <linux/thermal.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/tinydrm/st7586.c b/drivers/gpu/drm/tinydrm/st7586.c
index a6a8a1081b73..bf518167760a 100644
--- a/drivers/gpu/drm/tinydrm/st7586.c
+++ b/drivers/gpu/drm/tinydrm/st7586.c
@@ -17,6 +17,7 @@
 #include <linux/spi/spi.h>
 #include <video/mipi_display.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/tinydrm/st7735r.c b/drivers/gpu/drm/tinydrm/st7735r.c
index b39779e0dcd8..9bc93d5a0401 100644
--- a/drivers/gpu/drm/tinydrm/st7735r.c
+++ b/drivers/gpu/drm/tinydrm/st7735r.c
@@ -14,6 +14,7 @@
 #include <linux/spi/spi.h>
 #include <video/mipi_display.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/tinydrm/mipi-dbi.h>
-- 
2.12.0

