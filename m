Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BE020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGyg2jjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAaT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35450 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfAaT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so3714813ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ge1hrHkar9sk1UI7FF3x9mKF9IHtV/Tb/hl7NzBj2q0=;
        b=tGyg2jjK+AGMY5E6r/lhzztIgi4cgheyA8T0woQAgQ7s4xkkuqJxCfacbkXNFiOglw
         mLsBmHRz3T6UklGUbUfD7eYE9Pt/hN3U5iEB+rMGTZ42ic6dlbi5iAK+1N5HJZVvb1Jv
         MVkWKqVMzZjMjQop0eRmhOkRNqWTGV8+gCEHwmWeuy5FHatQGPOd84EDPhdf4FNqtXjT
         hv75gxae3V9i3n/UyX2h30CyF5W+84jZcIoGJH7GEVvUq1ZWTrGx5oI0y2/fxr6IRmiQ
         zouh7gq/HUbzXDmsywN8oQlDtMdAobcNzP1YhMk532GdFt4hgmAOxrEbVTOzGcK7FYFz
         589g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ge1hrHkar9sk1UI7FF3x9mKF9IHtV/Tb/hl7NzBj2q0=;
        b=bLaXdrhrdu8/h0U5I1cT+eg3cO9zb1pQxvhnfFVXtfFIZn25GmDl2FrG/Cb0TUnYeY
         h6jnVYqj5YQ7TLwCU3moVnauWvunriafCYm/TnuVIfo5jA8RhZXMIQ6XanxTiZSQF+Np
         JhgvJ6KiO01VcB/npbfrmI4X0E20j6gl6bqxNTNUkfgNHG9toEExqoaOYo4VGQ/p2v4t
         acJ+LvAHvRMfyh1d0ivnBu/um0eQPYv9/59gcC83YfuPbGeMDOytiWui+Tf1YPwP/caS
         hABsb5gdHZTMATUf/Npb/GaE61OaRs4yXd3tJRlAB8gEwr3Gw/H63V36vEIK9gJpySzO
         oPHw==
X-Gm-Message-State: AJcUukf/eiAwMU8QnpHvnTg4aYOwUoWQZ5oyvZswGqZW6U6FpXeLj7Kk
        +ayfd8RfiP6a+Rdu85EaDLk=
X-Google-Smtp-Source: ALg8bN5XrRyGCJpVJt28Xm0RSMd77BycmVj5d/w/EJpOenOBU6GG38ZqAW0F3saXf5CvcOu8IvxxAw==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr29045541ljj.1.1548962809311;
        Thu, 31 Jan 2019 11:26:49 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:48 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 15/19] drm/panel: raspberrypi: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:15 +0100
Message-Id: <20190131192619.9763-16-sam@ravnborg.org>
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
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 28c0620dfe0f..c9013faff9ed 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -57,6 +57,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #define RPI_DSI_DRIVER_NAME "rpi-ts-dsi"
 
@@ -232,7 +233,7 @@ static void rpi_touchscreen_i2c_write(struct rpi_touchscreen *ts,
 
 	ret = i2c_smbus_write_byte_data(ts->i2c, reg, val);
 	if (ret)
-		dev_err(&ts->dsi->dev, "I2C write failed: %d\n", ret);
+		DRM_DEV_ERROR(&ts->dsi->dev, "I2C write failed: %d\n", ret);
 }
 
 static int rpi_touchscreen_write(struct rpi_touchscreen *ts, u16 reg, u32 val)
@@ -324,8 +325,9 @@ static int rpi_touchscreen_get_modes(struct drm_panel *panel)
 
 		mode = drm_mode_duplicate(drm, m);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
-				m->hdisplay, m->vdisplay, m->vrefresh);
+			DRM_DEV_ERROR(drm->dev,
+				      "failed to add mode %ux%u@%u\n",
+				      m->hdisplay, m->vdisplay, m->vrefresh);
 			continue;
 		}
 
@@ -381,7 +383,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 
 	ver = rpi_touchscreen_i2c_read(ts, REG_ID);
 	if (ver < 0) {
-		dev_err(dev, "Atmel I2C read failed: %d\n", ver);
+		DRM_DEV_ERROR(dev, "Atmel I2C read failed: %d\n", ver);
 		return -ENODEV;
 	}
 
@@ -390,7 +392,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 	case 0xc3: /* ver 2 */
 		break;
 	default:
-		dev_err(dev, "Unknown Atmel firmware revision: 0x%02x\n", ver);
+		DRM_DEV_ERROR(dev,
+			      "Unknown Atmel firmware revision: 0x%02x\n",
+			       ver);
 		return -ENODEV;
 	}
 
@@ -412,8 +416,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 
 	ts->dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(ts->dsi)) {
-		dev_err(dev, "DSI device registration failed: %ld\n",
-			PTR_ERR(ts->dsi));
+		DRM_DEV_ERROR(dev,
+			      "DSI device registration failed: %ld\n",
+			      PTR_ERR(ts->dsi));
 		return PTR_ERR(ts->dsi);
 	}
 
@@ -457,7 +462,8 @@ static int rpi_touchscreen_dsi_probe(struct mipi_dsi_device *dsi)
 	ret = mipi_dsi_attach(dsi);
 
 	if (ret)
-		dev_err(&dsi->dev, "failed to attach dsi to host: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to attach dsi to host: %d\n", ret);
 
 	return ret;
 }
-- 
2.12.0

