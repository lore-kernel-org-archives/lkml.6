Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A68C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510021533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT3uVCnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0510021533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbeIUAat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:30:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34231 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeIUAat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:30:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id e25so256304edv.1;
        Thu, 20 Sep 2018 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCaEKlZfrKOaIAaRGQkC9jdTapEZ9vbpVpv1ISxlmZg=;
        b=WT3uVCnbm5sko7hqODtSLYNnLDnGzboi8S7tr8oneQ+0LcVa7N0OoxC3i5/9bYCrvU
         SVAW97bMgEV71U/frjM4a46jfPC6JIIogCgu7noexGkiM5QbiWKMGN/tKeMn/DSdcOuQ
         xM7u7FVCRNFIHJnLfYFABmMZIb7s2z82a1QvdRxu/HVPfqbNxLN1FP0jimO1G1AhZAg7
         T56kxdcX0bWD1iknWpCaI+unn6+VQx7B59+46ifPy75oCJ8hcx4Ifz53hH9IA9xnbHL9
         qGs3aSiBeJLfbZ5uokqIMiSQdXnJaF2yoolZoRLUuHOPtyjZCVYVVLNUFhmVtneCf6xH
         pXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCaEKlZfrKOaIAaRGQkC9jdTapEZ9vbpVpv1ISxlmZg=;
        b=WLnvZJoy/zfP+Rhtp/+2Br1srjlvsAzDmUppwXsiJfmGMJOcgpUeO1DexpY1jnfA2p
         ZzXqD0GtueWROCcqqo9NrQg9ujUrGtuhlqpoAcXwZq0AH9EhMY9SC32rU3/g1RdynU/w
         4/4swZF+11qCe7wM6oKc9bnbOQKxLj3vzOPkamZAIn3+GlY8SuSOFPLRs+4iA2bI0Fyk
         cmSC9kVEyGY07oT12d5ngBHM6/dPkHk6PyerPFPf5xcoMFJOnv2wpW6HQOVKfkxzeTOp
         bMwIyez0u1SE5j7+j5MpYlHclGrOUssSgPqE/Rgx9WbpraZ56RgQggtH8+RXGsn6k6fb
         JopA==
X-Gm-Message-State: APzg51AFOFZGThmhfbSpBdh7mx/nnMrz/c+41ttt5KVOKJ/CyUKEz7nl
        FdD79NzapYE/9lzJ/8TvRmV0DEeY
X-Google-Smtp-Source: ANB0VdZ4FfKb5/3zlF4IcOVe2mQpy3ysAMe/UTV9PwtpN1qSlgn405onXQImK0+sfqe75nOZD6l37w==
X-Received: by 2002:aa7:cb56:: with SMTP id w22-v6mr6195752edt.202.1537469156598;
        Thu, 20 Sep 2018 11:45:56 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y27-v6sm1136957edb.20.2018.09.20.11.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:45:55 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
Date:   Thu, 20 Sep 2018 20:45:52 +0200
Message-Id: <20180920184552.4919-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a programmable enable pin. It can be used in
situations where the ANA-vcc is not configurable (dummy-regulator), or
just to have a more fine control of the power saving.

The use of the enable pin is optional.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/Kconfig  |  2 +-
 drivers/media/i2c/ad5820.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index bfdb494686bf..1ba6eaaf58fb 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -321,7 +321,7 @@ config VIDEO_ML86V7667
 
 config VIDEO_AD5820
 	tristate "AD5820 lens voice coil support"
-	depends on I2C && VIDEO_V4L2 && MEDIA_CONTROLLER
+	depends on GPIOLIB && I2C && VIDEO_V4L2 && MEDIA_CONTROLLER
 	---help---
 	  This is a driver for the AD5820 camera lens voice coil.
 	  It is used for example in Nokia N900 (RX-51).
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 22759aaa2dba..625867472929 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -55,6 +56,8 @@ struct ad5820_device {
 	u32 focus_ramp_time;
 	u32 focus_ramp_mode;
 
+	struct gpio_desc *enable_gpio;
+
 	struct mutex power_lock;
 	int power_count;
 
@@ -122,6 +125,8 @@ static int ad5820_power_off(struct ad5820_device *coil, bool standby)
 		ret = ad5820_update_hw(coil);
 	}
 
+	gpiod_set_value_cansleep(coil->enable_gpio, 0);
+
 	ret2 = regulator_disable(coil->vana);
 	if (ret)
 		return ret;
@@ -136,6 +141,8 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	if (ret < 0)
 		return ret;
 
+	gpiod_set_value_cansleep(coil->enable_gpio, 1);
+
 	if (restore) {
 		/* Restore the hardware settings. */
 		coil->standby = false;
@@ -146,6 +153,7 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	return 0;
 
 fail:
+	gpiod_set_value_cansleep(coil->enable_gpio, 0);
 	coil->standby = true;
 	regulator_disable(coil->vana);
 
@@ -312,6 +320,15 @@ static int ad5820_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	coil->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(coil->enable_gpio)) {
+		ret = PTR_ERR(coil->enable_gpio);
+		if (ret == -EPROBE_DEFER)
+			dev_err(&client->dev, "could not get enable gpio\n");
+		return ret;
+	}
+
 	mutex_init(&coil->power_lock);
 
 	v4l2_i2c_subdev_init(&coil->subdev, client, &ad5820_ops);
-- 
2.18.0

