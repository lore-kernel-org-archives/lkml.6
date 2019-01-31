Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B2C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AAC20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS4i+v9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfAaT1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfAaT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so3716157ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j28msssp0TjTJR4iCjFEAs8sSy31YRqlnPEu/Ja2OnA=;
        b=jS4i+v9TxcmuQNvMmNYShN+Rf/wPnHBXa5cp4vLAc4md8XMelj3vn08gIW6O4HrvfF
         SWyE2Mj2K3t2siORAGg2BUM5xyePhEkSBKZwcsShQ0P+pxt8emE1ivxvr6pGl4U4EkY2
         dWMXDvVOcwbqZkGsyuaMiZbY4S0j3wJkL4OLtHSYQ8mRc7yyCOl8UlPGV16bd9MSLDVM
         ItLPL7Caau/MCJV8siga7apGHyX4pZDkMcQSRc3vSxyFTRrXgucugjPm9SWH4lfzD7pl
         t/4NuvGrnK/DUroZt00vWYD6hiNU25Mxv9vjGKKQ29u2TSmB3DuJhH/P4WmrYstPPXkb
         Qa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=j28msssp0TjTJR4iCjFEAs8sSy31YRqlnPEu/Ja2OnA=;
        b=NMs6hIf8GlbQ4IkMHJ1q8yniYvAGSdyCwIia0eelLRbowyv2OL/4+ziDspwLmeGs/o
         6tPlfMrgIo5R/4Z7aH5GqQiCr/KXEt8kWBS7y8FDGO44U9WldoKQWFQ2Q+hG3mlb6PmG
         q+gHqQ7YbW7FEWx/hFbIp+JiCBHWoWnJOBggGYPxNbhMwJkwGpN1dREQAnEDLB/iwVv/
         yDZopvWiEcd6ANEc3kp4xZ00Vs+RPY86lgAs0TZuH/tcMxc2p3lR8JiQ4D73/zfsFeZX
         swmcI1UHqloCBHy2W8nlKW4ftisS0coT5hKiH09PVO5ueF9EyOV+osJkNSFyX0X2UOhk
         bzhw==
X-Gm-Message-State: AHQUAuZxEMdkHZi0tqFakudXoHIOFnnCI2Im2x/GjcOG6qqUI8Yp95zs
        jJy2O5YMfSyLQJtpnxgHOhM=
X-Google-Smtp-Source: AHgI3IbnzrrXMSeMxSf9888HZ+CoBQ7EM/389t9vyWcVijoYVjidmX0FF0DS1w8qbcDXnTbJz76Tow==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr10541450ljd.33.1548962806460;
        Thu, 31 Jan 2019 11:26:46 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:46 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 12/19] drm/panel: olimex: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:12 +0100
Message-Id: <20190131192619.9763-13-sam@ravnborg.org>
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index c8704be9caa3..efb223b35594 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -18,6 +18,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/videomode.h>
 #include <video/display_timing.h>
@@ -157,10 +158,11 @@ static int lcd_olinuxino_get_modes(struct drm_panel *panel)
 
 		mode = drm_mode_create(drm);
 		if (!mode) {
-			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
-				lcd_mode->hactive,
-				lcd_mode->vactive,
-				lcd_mode->refresh);
+			DRM_DEV_ERROR(drm->dev,
+				      "failed to add mode %ux%u@%u\n",
+				      lcd_mode->hactive,
+				      lcd_mode->vactive,
+				      lcd_mode->refresh);
 				continue;
 		}
 
@@ -242,7 +244,8 @@ static int lcd_olinuxino_probe(struct i2c_client *client,
 						    (u8 *)&lcd->eeprom + i);
 		mutex_unlock(&lcd->mutex);
 		if (ret < 0) {
-			dev_err(dev, "error reading from device at %02x\n", i);
+			DRM_DEV_ERROR(dev,
+				      "error reading from device at %02x\n", i);
 			return ret;
 		}
 	}
@@ -250,20 +253,21 @@ static int lcd_olinuxino_probe(struct i2c_client *client,
 	/* Check configuration checksum */
 	checksum = ~crc32(~0, (u8 *)&lcd->eeprom, 252);
 	if (checksum != lcd->eeprom.checksum) {
-		dev_err(dev, "configuration checksum does not match!\n");
+		DRM_DEV_ERROR(dev,
+			      "configuration checksum does not match!\n");
 		return -EINVAL;
 	}
 
 	/* Check magic header */
 	if (lcd->eeprom.header != LCD_OLINUXINO_HEADER_MAGIC) {
-		dev_err(dev, "magic header does not match\n");
+		DRM_DEV_ERROR(dev, "magic header does not match\n");
 		return -EINVAL;
 	}
 
-	dev_info(dev, "Detected %s, Rev. %s, Serial: %08x\n",
-		 lcd->eeprom.info.name,
-		 lcd->eeprom.revision,
-		 lcd->eeprom.serial);
+	DRM_DEV_INFO(dev, "Detected %s, Rev. %s, Serial: %08x\n",
+		     lcd->eeprom.info.name,
+		     lcd->eeprom.revision,
+		     lcd->eeprom.serial);
 
 	/*
 	 * The eeprom can hold up to 4 modes.
-- 
2.12.0

