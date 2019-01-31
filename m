Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42671C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263D218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7/dseJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfAaT05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41532 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfAaT0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so3204499lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AoVvPA9lfsZiUyyNj6RbSzWbtTxiVyPl+jCEkMhvWw=;
        b=c7/dseJeBuagIpJ1AoRqyvAmD+AS2xsfB9Wmmu5Ox3doNJa4sfei5RCNef6zuoS7SS
         uDKKgGVTlDifoHzWzCmH2AdHWqptX5WDgOZWVN2xULIjnkjUBV2khaQO/NhS5LaSJRKJ
         1kJ6f8B4DDiq6/EC2de8OSFRG+tMaXPCsShkevhNtYZFw76ftRttgZi0pKTRTBXGdhqO
         H1AbxwXxxbyjYYxQcVaU0jgKNS9Fo0eaGQMY4gTiDLGbWHAV5/XwOS7aVDp2IrJTAKIy
         RpJ5CGnpZ3cHE3ud+Mc/xgtOZGy114yB+zjyjQKFEgbDZtYI3oNnkyzBVhucnG9WVstq
         4uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0AoVvPA9lfsZiUyyNj6RbSzWbtTxiVyPl+jCEkMhvWw=;
        b=Op0wAFiGrGNZGRGDuj5OOG9nrUPaZ3RBH6lAqRqgM2cgtnkIBD4xsb4k9GNxQ2mjoD
         bYREnT1YuHkHUCh+mYdCvFJZy3qopO8Ifns6sgEDOfgXMpIT5/TnODni3Uwmt0Hu1LKd
         dS2n779R0+u4UXUpim30375iOOv6eteWSyzerYLKEZ92DKvi3+VDPKhLLwDdU3/3sbbM
         HrQvDISENFqbL8Tgy1EMx3T4T2wXDx0MNrN/zWyQ0JOYCvHPjdx0nJd9FW7RipE/bvGv
         Pbjl4uLHiEp2AoTHA7GdptAGszxpuiDUZAPoFuqPUlzU1TmgrJt5EoPtFoW6p4zQP97P
         xcZw==
X-Gm-Message-State: AJcUuke9QOEF6IbCs6JhIoeK77X491Igw+5Ria5rupeTSIjlYr8BJpwV
        Nz3/y0vKU7nb0e8uH2MT3yU=
X-Google-Smtp-Source: ALg8bN7c9y85MK3kUAjko6no4MMGSiaM2pZBbOfEx3hC9hVdYP2oqIdnUzxk5/D3QHDI6DtERUmI+Q==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr29442062lfa.65.1548962812045;
        Thu, 31 Jan 2019 11:26:52 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:51 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 18/19] drm/panel: sharp: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:18 +0100
Message-Id: <20190131192619.9763-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 63 ++++++++++++++++---------
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 24 ++++++----
 2 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 2ed11d86c10e..98788750084c 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -17,6 +17,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -58,14 +59,16 @@ static int sharp_panel_write(struct sharp_panel *sharp, u16 offset, u8 value)
 
 	err = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
 	if (err < 0) {
-		dev_err(&dsi->dev, "failed to write %02x to %04x: %zd\n",
-			value, offset, err);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to write %02x to %04x: %zd\n",
+			      value, offset, err);
 		return err;
 	}
 
 	err = mipi_dsi_dcs_nop(dsi);
 	if (err < 0) {
-		dev_err(&dsi->dev, "failed to send DCS nop: %zd\n", err);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to send DCS nop: %zd\n", err);
 		return err;
 	}
 
@@ -84,8 +87,9 @@ static __maybe_unused int sharp_panel_read(struct sharp_panel *sharp,
 	err = mipi_dsi_generic_read(sharp->link1, &offset, sizeof(offset),
 				    value, sizeof(*value));
 	if (err < 0)
-		dev_err(&sharp->link1->dev, "failed to read from %04x: %zd\n",
-			offset, err);
+		DRM_DEV_ERROR(&sharp->link1->dev,
+			      "failed to read from %04x: %zd\n",
+			      offset, err);
 
 	return err;
 }
@@ -116,11 +120,13 @@ static int sharp_panel_unprepare(struct drm_panel *panel)
 
 	err = mipi_dsi_dcs_set_display_off(sharp->link1);
 	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set display off: %d\n", err);
 
 	err = mipi_dsi_dcs_enter_sleep_mode(sharp->link1);
 	if (err < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to enter sleep mode: %d\n", err);
 
 	msleep(120);
 
@@ -139,26 +145,30 @@ static int sharp_setup_symmetrical_split(struct mipi_dsi_device *left,
 
 	err = mipi_dsi_dcs_set_column_address(left, 0, mode->hdisplay / 2 - 1);
 	if (err < 0) {
-		dev_err(&left->dev, "failed to set column address: %d\n", err);
+		DRM_DEV_ERROR(&left->dev,
+			      "failed to set column address: %d\n", err);
 		return err;
 	}
 
 	err = mipi_dsi_dcs_set_page_address(left, 0, mode->vdisplay - 1);
 	if (err < 0) {
-		dev_err(&left->dev, "failed to set page address: %d\n", err);
+		DRM_DEV_ERROR(&left->dev,
+			      "failed to set page address: %d\n", err);
 		return err;
 	}
 
 	err = mipi_dsi_dcs_set_column_address(right, mode->hdisplay / 2,
 					      mode->hdisplay - 1);
 	if (err < 0) {
-		dev_err(&right->dev, "failed to set column address: %d\n", err);
+		DRM_DEV_ERROR(&right->dev,
+			      "failed to set column address: %d\n", err);
 		return err;
 	}
 
 	err = mipi_dsi_dcs_set_page_address(right, 0, mode->vdisplay - 1);
 	if (err < 0) {
-		dev_err(&right->dev, "failed to set page address: %d\n", err);
+		DRM_DEV_ERROR(&right->dev,
+			      "failed to set page address: %d\n", err);
 		return err;
 	}
 
@@ -188,7 +198,8 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 
 	err = mipi_dsi_dcs_exit_sleep_mode(sharp->link1);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to exit sleep mode: %d\n", err);
 		goto poweroff;
 	}
 
@@ -204,20 +215,23 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	/* set left-right mode */
 	err = sharp_panel_write(sharp, 0x1000, 0x2a);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to set left-right mode: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set left-right mode: %d\n", err);
 		goto poweroff;
 	}
 
 	/* enable command mode */
 	err = sharp_panel_write(sharp, 0x1001, 0x01);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to enable command mode: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to enable command mode: %d\n", err);
 		goto poweroff;
 	}
 
 	err = mipi_dsi_dcs_set_pixel_format(sharp->link1, format);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set pixel format: %d\n", err);
 		goto poweroff;
 	}
 
@@ -231,14 +245,16 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	err = sharp_setup_symmetrical_split(sharp->link1, sharp->link2,
 					    sharp->mode);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to set up symmetrical split: %d\n",
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set up symmetrical split: %d\n",
 			err);
 		goto poweroff;
 	}
 
 	err = mipi_dsi_dcs_set_display_on(sharp->link1);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set display on: %d\n", err);
 		goto poweroff;
 	}
 
@@ -287,9 +303,10 @@ static int sharp_panel_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			default_mode.vrefresh);
+		DRM_DEV_ERROR(panel->drm->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -413,11 +430,13 @@ static int sharp_panel_remove(struct mipi_dsi_device *dsi)
 
 	err = sharp_panel_disable(&sharp->base);
 	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to disable panel: %d\n", err);
 
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to detach from DSI host: %d\n", err);
 
 	sharp_panel_del(sharp);
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index e8e2277e934d..c34bb2a16f0e 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -29,6 +29,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -135,7 +136,8 @@ static int sharp_nt_panel_unprepare(struct drm_panel *panel)
 
 	ret = sharp_nt_panel_off(sharp_nt);
 	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to set panel off: %d\n", ret);
 		return ret;
 	}
 
@@ -173,13 +175,13 @@ static int sharp_nt_panel_prepare(struct drm_panel *panel)
 
 	ret = sharp_nt_panel_init(sharp_nt);
 	if (ret < 0) {
-		dev_err(panel->dev, "failed to init panel: %d\n", ret);
+		DRM_DEV_ERROR(panel->dev, "failed to init panel: %d\n", ret);
 		goto poweroff;
 	}
 
 	ret = sharp_nt_panel_on(sharp_nt);
 	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel on: %d\n", ret);
+		DRM_DEV_ERROR(panel->dev, "failed to set panel on: %d\n", ret);
 		goto poweroff;
 	}
 
@@ -227,9 +229,10 @@ static int sharp_nt_panel_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
-				default_mode.hdisplay, default_mode.vdisplay,
-				default_mode.vrefresh);
+		DRM_DEV_ERROR(panel->drm->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -263,8 +266,8 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 
 	sharp_nt->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(sharp_nt->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
-			PTR_ERR(sharp_nt->reset_gpio));
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
+			      PTR_ERR(sharp_nt->reset_gpio));
 		sharp_nt->reset_gpio = NULL;
 	} else {
 		gpiod_set_value(sharp_nt->reset_gpio, 0);
@@ -322,11 +325,12 @@ static int sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 
 	ret = sharp_nt_panel_disable(&sharp_nt->base);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev, "failed to disable panel: %d\n", ret);
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to detach from DSI host: %d\n", ret);
 
 	sharp_nt_panel_del(sharp_nt);
 
-- 
2.12.0

