Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A287F21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECaMEUxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A287F21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeITWDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:03:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42927 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeITWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so8334277edw.9;
        Thu, 20 Sep 2018 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17p35fcEomFEHCE0Bwjf+jK4FTdDkqZHbOftL8d9eKs=;
        b=ECaMEUxN+bjmdq6vFeR1QhHNjswTYctVpgRSu6eg4UwzmX1/SpI3MbF3l6tXVf86Sa
         JpscXZqoUSnDpnN988xChgtNrDB7NU9AKkjBZIPl/JQMcL6wPTkrY82h+iDAxJNJCl8h
         CIBr1waHFyxDpCOpex2vI9TwHhLEB8FTMGBEMSbxkgyONqDm1/9TNh0h8OoK2Qht+Ih4
         +8n6/0AtjF2iNcepuCCBxx/Z7q+McSopFOSYA0tpR967PHisVHnlA+Wf4PI184+765Ci
         TY1jdX8hQGp8+U3lB5q5lSe5JVW4Ug1oIxa+Ek3czBb5MarGh5kGemKspJVtHvAezTtl
         i23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=17p35fcEomFEHCE0Bwjf+jK4FTdDkqZHbOftL8d9eKs=;
        b=fwYf0Q6RbAKfQmcFuTOn7LCJZVpYNh7hiAWCmtcMTdh7Uf9dKXXmIOdBfLFo0OycYj
         uTfC1Cbk25kWXyzf1Vpc1CcYTr3VEM5jKvIAi6PPJaQ7LZiTD5W4F2bOxD1MUKwe1IjU
         DVXv74hl4DF5GRvPXhR4lGqssKQ8HcB+enDlP1kp8X1Rc+svbcg692lTrLTWGHj9o2M2
         JLel9eNHm2GFEILeGstGYcMd07bdiuSjDOsL969MzNGCyjyvwMcxV8HZBM7s8ml7YEBg
         dIfMDXaUK5m6fs7exNKyenDrf70box2cmp5pYpXQTmyZoT+YMfOBheeqbg87ty7T4VTG
         am3w==
X-Gm-Message-State: APzg51Afky+J8NWVBb/cT7czlf7MvVUiHMmaAN2tF/rlWC7Cpa3jRzF8
        ShNNu4XNs7Luijt2VbTucnT2IrWu
X-Google-Smtp-Source: ANB0VdZxP8sZzqP2HRvTnrCPVlkHtfCYtsCYq3KMgBGJ1pqG3374qYJe5gQeappy4/bW0vxCZSGzBg==
X-Received: by 2002:a50:9817:: with SMTP id g23-v6mr5076773edb.277.1537460357900;
        Thu, 20 Sep 2018 09:19:17 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h40-v6sm958144edh.88.2018.09.20.09.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:16 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 2/4] [media] ad5820: Add support for enable pin
Date:   Thu, 20 Sep 2018 18:19:10 +0200
Message-Id: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a programmable enable pin. It can be used in
situations where the ANA-vcc is not configurable (dummy-regulator), or
just to have a more fine control of the power saving.

The use of the enable pin is optional

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/Kconfig  |  2 +-
 drivers/media/i2c/ad5820.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index 22759aaa2dba..20931217e3b1 100644
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
 
@@ -122,6 +125,9 @@ static int ad5820_power_off(struct ad5820_device *coil, bool standby)
 		ret = ad5820_update_hw(coil);
 	}
 
+	if (coil->enable_gpio)
+		gpiod_set_value_cansleep(coil->enable_gpio, 0);
+
 	ret2 = regulator_disable(coil->vana);
 	if (ret)
 		return ret;
@@ -136,6 +142,9 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	if (ret < 0)
 		return ret;
 
+	if (coil->enable_gpio)
+		gpiod_set_value_cansleep(coil->enable_gpio, 1);
+
 	if (restore) {
 		/* Restore the hardware settings. */
 		coil->standby = false;
@@ -146,6 +155,8 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	return 0;
 
 fail:
+	if (coil->enable_gpio)
+		gpiod_set_value_cansleep(coil->enable_gpio, 0);
 	coil->standby = true;
 	regulator_disable(coil->vana);
 
@@ -312,6 +323,15 @@ static int ad5820_probe(struct i2c_client *client,
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

