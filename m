Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785CCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46268218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuMeMhd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfAaT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45970 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfAaT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so3189017lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8BqVEWdHISfwf6T723kLfpxgwVQ99K3wsJZXvoBWpA=;
        b=cuMeMhd0sLjjjYZU+P6tOQZtbrSQtXtDYlUKTKebckOz4eCJQjK6kuoA1ozzMJNicE
         gmNMr3CNdNDfzdke/YMiyMXXp2TTkSsX893ygciHksNVRyGLiLmK8ShYjm3GuzvlWDaq
         yDv4mOA8OuyWHy8SWhGMgvR6IB380nt1yt7ajFXhd/1iWV/iZIwWppp6Yl2Lq7LpbO6o
         KEQ5ryBpDaCrLBmMGpuLMQmZ14H9w7jpaRCfnX6GHrYrn5xwKEu3x76oASON0eUEkFWm
         SbDKO6Cf3LXwV1tblBT8CzJfBaKqqaru4mOprU9RwhJgxLnJo88Av/gr172gTXC4EyvV
         ZnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=o8BqVEWdHISfwf6T723kLfpxgwVQ99K3wsJZXvoBWpA=;
        b=ZwsXpOWZlW3qXjSKJWo0s6yJAt6bxNTDe/c0IjWva6+2R1QfCxf2F4coRx9yULjUov
         UjmWLNwbV3Q2rucRAzNL7GX309p4rkMyOITHXLNxtV/KXzHvnsW5ixn97WU3EdcjRcGP
         /WtwK27Wt53itP1CLYYWMNXQnKw2ftvv2spOLrvrorHWL8wgIpldkd1kO8FFergPsJJp
         qd6TO/uMDnIRVUl6+C/8Xlej7hu2hvCSkXUJlqO8PnvPY8JDO4xNA1kLljW5W+ISJVCZ
         0gR30+ZZlIpEB26n37abD14vR5OdAYOK+3TthmJ8hYm1wcQxta8aYSVA/HWTXhlYufDL
         /XSQ==
X-Gm-Message-State: AHQUAuYPtgDkg1i8xYIi86uzgs/mnrtzcxAGHYj+D580e6Fii7Sjr+Se
        NMxHqX3dX3tIvb8NyRG7960=
X-Google-Smtp-Source: AHgI3IZD1Mu7plaZOv3dxgqNS1aBUgwUNGsBrMCO9MyaDs+keQx9BmX3coxy/9W2fEZB+dCda3onAw==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr4768468lfh.159.1548962808401;
        Thu, 31 Jan 2019 11:26:48 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:47 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 14/19] drm/panel: panasonic: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:14 +0100
Message-Id: <20190131192619.9763-15-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index c7037942c7f3..738270439285 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -28,6 +28,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -132,7 +133,7 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 
 	ret = wuxga_nt_panel_on(wuxga_nt);
 	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel on: %d\n", ret);
+		DRM_DEV_ERROR(panel->dev, "failed to set panel on: %d\n", ret);
 		goto poweroff;
 	}
 
@@ -183,9 +184,10 @@ static int wuxga_nt_panel_get_modes(struct drm_panel *panel)
 
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
 
@@ -294,11 +296,13 @@ static int wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
 
 	ret = wuxga_nt_panel_disable(&wuxga_nt->base);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to disable panel: %d\n", ret);
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to detach from DSI host: %d\n", ret);
 
 	wuxga_nt_panel_del(wuxga_nt);
 
-- 
2.12.0

