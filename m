Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381F221904
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwQTxcFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAaT1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33406 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfAaT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so3258575lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MyVK94RakuFZ4I1yQL5qAdKZU6bbiJw2520k+jpnxW0=;
        b=QwQTxcFMXi8tU638LzKYv0yxOQ3TyqvPsiZRu1r34703XZv66jDOHqrM+6WNfWUnWr
         pmp/sOucJeMSAv62Vh3ruRbEI6Dap4KMkx2oQ8Vslfp731Q2QEtlxfrAP0wzbzJ9t2vQ
         Wog6B0I1flDkBvUGqmUlbPUDzYsqpIFJLAzhQceQJpQij2bjxpLe6OHBlC6s2PLXfLf7
         S+Q2sFY/MIUWAE7njOApnDvCW3q0TsdlCfDbgHW4FZ+nrZsJOZuxzg+kr1kHHREsv+tz
         j/XrHYAkvzBH2Gw5UGtZA/ndzTaZQXmoaogEmN7mzUVt//MmA3Y8MaAaFXGLH8Hnesxb
         3FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MyVK94RakuFZ4I1yQL5qAdKZU6bbiJw2520k+jpnxW0=;
        b=LWUY3/7ExSzlZtMfAjGcTyaowi7VRV8uocw50OkJ9kQpaiiGfygMwAZuu0WNTWlwHw
         0sldPaAeG2YajoBR8+CrxN0jUVw07GNNRqodKe7KkND8AuGFYpSfoqmc0N7hhAVmVnYT
         1I2Y13Ja41EBibBViyjxkbTUuqO5RD7JcYeDNyoIDbVjRpXHhKDLE+SDb0A0Qc5OarNH
         vDvQ1clttKiexjUk4e2pVzCkfYkwl/Dc6Bds73t7YxP3evfMW4UWeyYErFnSYPOP3SH1
         8XDBt9/9VkeKSlBVeuvIim+wMDB4m88Fxw416mqbBpQcLjJ9aCTj5/nIwDtK1qgDH6JR
         /fSQ==
X-Gm-Message-State: AHQUAua3kXY7BXMvHTljrE9ncW+kGrPAZSA1N8H7pfK23p6qEk/Pyrg1
        5z6Dkt2nkI5GZgQgmWfzakDx3G9K
X-Google-Smtp-Source: AHgI3IYmp5pdV1dgPrJCLlBLw62IXdPgIumH1kmgbPh8ZRyWMI3i2RnEcPC18FfC6GNHHYRND1eRnQ==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr1684401lfm.81.1548962812950;
        Thu, 31 Jan 2019 11:26:52 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:52 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 19/19] drm/panel: simple: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:19 +0100
Message-Id: <20190131192619.9763-20-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-simple.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 406b1d7aef31..a5d98a19f138 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -33,6 +33,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/display_timing.h>
 #include <video/videomode.h>
@@ -103,6 +104,7 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 {
 	struct drm_connector *connector = panel->base.connector;
 	struct drm_device *drm = panel->base.drm;
+	struct device *dev = drm->dev;
 	struct drm_display_mode *mode;
 	unsigned int i, num = 0;
 
@@ -116,8 +118,8 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 		videomode_from_timing(dt, &vm);
 		mode = drm_mode_create(drm);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u\n",
-				dt->hactive.typ, dt->vactive.typ);
+			DRM_DEV_ERROR(dev, "failed to add mode %ux%u\n",
+				      dt->hactive.typ, dt->vactive.typ);
 			continue;
 		}
 
@@ -137,8 +139,8 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 
 		mode = drm_mode_duplicate(drm, m);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
-				m->hdisplay, m->vdisplay, m->vrefresh);
+			DRM_DEV_ERROR(dev, "failed to add mode %ux%u@%u\n",
+				      m->hdisplay, m->vdisplay, m->vrefresh);
 			continue;
 		}
 
@@ -215,7 +217,8 @@ static int panel_simple_prepare(struct drm_panel *panel)
 
 	err = regulator_enable(p->supply);
 	if (err < 0) {
-		dev_err(panel->dev, "failed to enable supply: %d\n", err);
+		DRM_DEV_ERROR(panel->dev, "failed to enable supply: %d\n",
+			      err);
 		return err;
 	}
 
@@ -325,7 +328,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	if (IS_ERR(panel->enable_gpio)) {
 		err = PTR_ERR(panel->enable_gpio);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "failed to request GPIO: %d\n", err);
+			DRM_DEV_ERROR(dev, "failed to request GPIO: %d\n",
+				      err);
 		return err;
 	}
 
@@ -3048,7 +3052,8 @@ static int panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
 
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to detach from DSI host: %d\n", err);
 
 	return panel_simple_remove(&dsi->dev);
 }
-- 
2.12.0

