Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68628C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8FC20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXxyPmsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfBBPS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36836 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfBBPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so7259708lfg.3;
        Sat, 02 Feb 2019 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB/F5VbY7XSQ/g3rwzQi2XoWo9gRmJj9GxgZuRwAeKA=;
        b=MXxyPmsMq+4PBUdXSflnwP/8++u0kria9XU9iOjlHQ64ovtQLw/fa5tnIlQZO+6pr9
         2kAE2QiJtXz64PZox1KkKw/RrWqQA7M6vwUsH7TZfJ8dMqEuCdkc6hBJyHfAkGNzsiXh
         /ATLMSt86e1uR0lU6v2veLMdAz9O9bNy7OzAUaS34T6shRebMWIeVDHbZEtYhnTs/Bzo
         PUPKzQ3qfP0AJTZZWPAfKpQPnsbx3L8kPFfk/Bcs8XZxMBEUP7heUhhtqG835cnfy81z
         +EbtziwefTt/elpT7pjlUiyMc0jNAcTslvWCnU7a/zVaMwG2RX3LLWJ8znNXNMHyhiCg
         KxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB/F5VbY7XSQ/g3rwzQi2XoWo9gRmJj9GxgZuRwAeKA=;
        b=ZwRBGcCSexntBi6Epl2iwra4uwsm0K4ZjMvqqhtw1AWPFywZD9eZ4qL3U4aymb8jAq
         IQNTfFV6fsLahuhNnIzeuhmTcURrwMyGBbqXVMMXnR2M02+s9xL6VvFQkW+5qLX4Piui
         gf6oEfECXmUNLJZtkL1FoVGYKL7aKloLUjg8DusiTDmD0MtEZHZHhHYucIJmkGiPwPkE
         oqZlOcCXrZTfxp+q7aqQkQJxrg3d2Ifc4aEH6XhoJ+LlsFb0/55QXFfvSnDXkOnfEO7e
         8VSdJqz5VNsVkAiYAvlzojVu/CKvW0yxc696blPwW2lgXb+EPbkn2WEjEqyQx1emD8sB
         EbWQ==
X-Gm-Message-State: AHQUAub/5NFJdNhjbQRXQJPmSjbKZeZ7PtVPCnyj6zcZCzQJD3j5ahAr
        gb+dkAMuhkYeHCEawZJWWN8=
X-Google-Smtp-Source: AHgI3IYtbb4eWeF7YLEoamcbGRFdzC9yBGtuI/eXP0iKqv7rbgajLr7KLwbqcjg+rZEsD0fdhcmz6Q==
X-Received: by 2002:ac2:5085:: with SMTP id f5mr8418352lfm.30.1549120694579;
        Sat, 02 Feb 2019 07:18:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:13 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] input: misc: bma150: Add support for device tree
Date:   Sat,  2 Feb 2019 16:18:04 +0100
Message-Id: <20190202151806.9064-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add of_match table to enable bma150 to be probed via DT

Changes from v1:
 - Add properties for all of bma150_cfg

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 64 ++++++++++++++++++++++++++++++++++++-
 include/linux/bma150.h      | 20 ++++++------
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 79acaaf86b7e..e86df79490ad 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/bma150.h>
@@ -146,7 +147,7 @@ struct bma150_data {
  * are stated and verified by Bosch Sensortec where they are configured
  * to provide a generic sensitivity performance.
  */
-static const struct bma150_cfg default_cfg = {
+static struct bma150_cfg default_cfg = {
 	.any_motion_int = 1,
 	.hg_int = 1,
 	.lg_int = 1,
@@ -518,6 +519,51 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	return 0;
 }
 
+int bma150_cfg_from_of(struct device_node *np)
+{
+	int error;
+
+	default_cfg.any_motion_int =
+			of_property_read_bool(np, "any-motion-int");
+	default_cfg.hg_int =
+			of_property_read_bool(np, "hg-int");
+	default_cfg.lg_int =
+			of_property_read_bool(np, "lg-int");
+
+	error = of_property_read_u32_array(np, "any-motion-cfg",
+			&default_cfg.any_motion_dur, 2);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32_array(np, "hg-cfg",
+			&default_cfg.hg_hyst, 3);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32_array(np, "lg-cfg",
+			&default_cfg.lg_hyst, 3);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32(np, "range",
+			&default_cfg.range);
+	if (error < 0 && error != -EINVAL)
+		return error;
+	else if (default_cfg.range < BMA150_RANGE_2G ||
+			default_cfg.range > BMA150_RANGE_8G)
+		return -EINVAL;
+
+	error = of_property_read_u32(np, "bandwidth",
+			&default_cfg.bandwidth);
+	if (error < 0 && error != -EINVAL)
+		return error;
+	else if (default_cfg.bandwidth < BMA150_BW_25HZ ||
+			default_cfg.bandwidth > BMA150_BW_1500HZ)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
@@ -557,6 +603,13 @@ static int bma150_probe(struct i2c_client *client,
 			}
 		}
 		cfg = &pdata->cfg;
+	} else if (client->dev.of_node) {
+		error = bma150_cfg_from_of(client->dev.of_node);
+		if (error) {
+			dev_err(&client->dev, "Failed to parse of data\n");
+			return error;
+		}
+		cfg = &default_cfg;
 	} else {
 		cfg = &default_cfg;
 	}
@@ -620,6 +673,14 @@ static int bma150_resume(struct device *dev)
 
 static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id bma150_of_match[] = {
+	{ .compatible = "bosch,bma150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bma150_of_match);
+#endif
+
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
 	{ "smb380", 0 },
@@ -632,6 +693,7 @@ MODULE_DEVICE_TABLE(i2c, bma150_id);
 static struct i2c_driver bma150_driver = {
 	.driver = {
 		.name	= BMA150_DRIVER,
+		.of_match_table = of_match_ptr(bma150_of_match),
 		.pm	= &bma150_pm,
 	},
 	.class		= I2C_CLASS_HWMON,
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index b85266a9c35c..ad19dc7a30d7 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -29,16 +29,16 @@ struct bma150_cfg {
 	bool any_motion_int;		/* Set to enable any-motion interrupt */
 	bool hg_int;			/* Set to enable high-G interrupt */
 	bool lg_int;			/* Set to enable low-G interrupt */
-	unsigned char any_motion_dur;	/* Any-motion duration */
-	unsigned char any_motion_thres;	/* Any-motion threshold */
-	unsigned char hg_hyst;		/* High-G hysterisis */
-	unsigned char hg_dur;		/* High-G duration */
-	unsigned char hg_thres;		/* High-G threshold */
-	unsigned char lg_hyst;		/* Low-G hysterisis */
-	unsigned char lg_dur;		/* Low-G duration */
-	unsigned char lg_thres;		/* Low-G threshold */
-	unsigned char range;		/* one of BMA0150_RANGE_xxx */
-	unsigned char bandwidth;	/* one of BMA0150_BW_xxx */
+	u32 any_motion_dur;		/* Any-motion duration */
+	u32 any_motion_thres;		/* Any-motion threshold */
+	u32 hg_hyst;			/* High-G hysterisis */
+	u32 hg_dur;			/* High-G duration */
+	u32 hg_thres;			/* High-G threshold */
+	u32 lg_hyst;			/* Low-G hysterisis */
+	u32 lg_dur;			/* Low-G duration */
+	u32 lg_thres;			/* Low-G threshold */
+	u32 range;			/* one of BMA0150_RANGE_xxx */
+	u32 bandwidth;			/* one of BMA0150_BW_xxx */
 };
 
 struct bma150_platform_data {
-- 
2.17.1

