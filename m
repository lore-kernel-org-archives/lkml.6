Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CEC46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxXp5O3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A6B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbeKFGKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:10:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFGKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:10:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so4764967pgv.3;
        Mon, 05 Nov 2018 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4p2prooMrBuBN4DjqsFBoeT3ZNXy+n4g0jtJQCtamEY=;
        b=KxXp5O3nlFzH394M8iOijRUV4ze0v0Sq12AIemSnlkXkhvGj9mQg+fwckBIbH1YV33
         j4AFPyY4Zl9d1RDgOwY+2f2Rlw6FKGauMeniuZjweP1qCeIVFFWikkxXhV7yTLxLDjAr
         jXemXkRGntoAbaRSsYwFfQUcI/v9dFaH5OPZfhjr0poZrd5IJ8eFhtuUGV2t8fQrSBYA
         lLyvh9+ALOkUBaiajSlNtaTTb5IaobkfhFQi9bzXJMosj9PeLAAviHcF0DUDEsV/mjK3
         rr3n9tCoA0HRY6BIaEcSCyhyBS7fnUuQYSvClTPEQZVh24LapL9o6Lo8oJVJdIaEvDpy
         XAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4p2prooMrBuBN4DjqsFBoeT3ZNXy+n4g0jtJQCtamEY=;
        b=FJn4d19Zgj0qdOYVIGrVmIt6OZMRxwY31qKHtFwxHTlto6aO2KOxCcr0jTqepyUl/g
         i9e3XNBeatxrTKpy4seso6aAVE9Py028UxWLSy97QeGlpEKwObuPl6mcLZNDLb6rbc2v
         8JG44E0pbratrhSh7jBYLQ2Gd34hL3BTYQBQrVgWhl00cI0t4zgrCRCAv4T7bHuLFljj
         zzDBvuRtVJrQu5j0I9anxx55a53NMQcPtNnIdiCTXgzVjWKUseY0S+8Q+ozjalo3VqpG
         HF8bIZa6JXEXUnVRHGVlKAeoRnI/Fr73ODO5Cu6PkXHfL9f6pfaeK6LBATC64HmZJibx
         yR2A==
X-Gm-Message-State: AGRZ1gKnNnh5FxGhuSx+nevDhoNJT8OkeezQ7Pag2Z12r6jZlbl4HfI0
        0iBs/cfV1LkaosktjepSNSI=
X-Google-Smtp-Source: AJdET5fjqjSB6oZS+Mn3Cmw1GPHduZZkGC+b+pTIHWI3/bulXXQuNaIPjnRe0N5gJwv+0Xn4HalrgA==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr1328600pga.157.1541450933245;
        Mon, 05 Nov 2018 12:48:53 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm25569257pgs.14.2018.11.05.12.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:48:52 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] hwmon: (ina3221) Add PM runtime support
Date:   Mon,  5 Nov 2018 12:48:43 -0800
Message-Id: <20181105204843.4081-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105204843.4081-1-nicoleotsuka@gmail.com>
References: <20181105204843.4081-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all three channels are disabled via in[123]_enable ABI,
the driver could suspend the chip for power saving purpose.

So this patch adds the PM runtime support in order to gain
more power control than system suspend and resume use case.

For PM runtime, there are a few related changes happening:
1) Added a new pm_dev device pointer for all the PM runtime
   callbacks. This is because hwmon core registers a child
   device for each hwmon driver and passes it back to each
   driver. So there might be a mismatch between two device
   pointers in the driver if mixing using them.
2) Added a check in ina3221_is_enabled() to make sure that
   the chip is resumed.
3) Bypassed the unchanged status in ina3221_write_enable()
   in order to keep the PM runtime refcount being matched.
4) Removed the reset routine in the probe() by calling the
   resume() via pm_runtime_get_sync() instead, as they're
   similar. It's also necessary to do so to match initial
   PM refcount with the number of enabled channels.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v4->v5:
 * Dropped the code of passing pm pointer via _info API
 ** Moved all changes back to the status of v3
 * Used i2c_client dev pointer for pm runtime callbacks
v3->v4:
 * Passed pm pointer via _with_info API instead the i2c driver
v2->v3:
 * Improved a dev_err message
 * Added comments at pm_runtime_put_noidle() callbacks
 * Added pm_runtime header file in an alphabetical order
v1->v2:
 * Bypassed i2c_client->dev in suspend/resume()
 * Added a missing '\n' in one dev_err()

 drivers/hwmon/ina3221.c | 93 ++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 07dd6ef58d3e..17a57dbc0424 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #define INA3221_DRIVER_NAME		"ina3221"
@@ -53,6 +54,7 @@
 #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
+#define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
 
 enum ina3221_fields {
@@ -103,6 +105,7 @@ struct ina3221_input {
 
 /**
  * struct ina3221_data - device specific information
+ * @pm_dev: Device pointer for pm runtime
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @inputs: Array of channel input source specific structures
@@ -110,6 +113,7 @@ struct ina3221_input {
  * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
+	struct device *pm_dev;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
@@ -119,7 +123,8 @@ struct ina3221_data {
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 {
-	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
+	return pm_runtime_active(ina->pm_dev) &&
+	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
 }
 
 /* Lookup table for Bus and Shunt conversion times in usec */
@@ -290,21 +295,48 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
+	u16 config_old = ina->reg_config & mask;
 	int ret;
 
 	config = enable ? mask : 0;
 
+	/* Bypass if enable status is not being changed */
+	if (config_old == config)
+		return 0;
+
+	/* For enabling routine, increase refcount and resume() at first */
+	if (enable) {
+		ret = pm_runtime_get_sync(ina->pm_dev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to get PM runtime\n");
+			return ret;
+		}
+	}
+
 	/* Enable or disable the channel */
 	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/* Cache the latest config register value */
 	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
 	if (ret)
-		return ret;
+		goto fail;
+
+	/* For disabling routine, decrease refcount or suspend() at last */
+	if (!enable)
+		pm_runtime_put_sync(ina->pm_dev);
 
 	return 0;
+
+fail:
+	if (enable) {
+		dev_err(dev, "Failed to enable channel %d: error %d\n",
+			channel, ret);
+		pm_runtime_put_sync(ina->pm_dev);
+	}
+
+	return ret;
 }
 
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
@@ -631,44 +663,65 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = regmap_field_write(ina->fields[F_RST], true);
-	if (ret) {
-		dev_err(dev, "Unable to reset device\n");
-		return ret;
-	}
-
-	/* Sync config register after reset */
-	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
-	if (ret)
-		return ret;
+	/* The driver will be reset, so use reset value */
+	ina->reg_config = INA3221_CONFIG_DEFAULT;
 
 	/* Disable channels if their inputs are disconnected */
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
 		if (ina->inputs[i].disconnected)
 			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
 	}
-	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
-	if (ret)
-		return ret;
 
+	ina->pm_dev = dev;
 	mutex_init(&ina->lock);
 	dev_set_drvdata(dev, ina);
 
+	/* Enable PM runtime -- status is suspended by default */
+	pm_runtime_enable(ina->pm_dev);
+
+	/* Initialize (resume) the device */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (ina->inputs[i].disconnected)
+			continue;
+		/* Match the refcount with number of enabled channels */
+		ret = pm_runtime_get_sync(ina->pm_dev);
+		if (ret < 0)
+			goto fail;
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
 							 &ina3221_chip_info,
 							 ina3221_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
-		mutex_destroy(&ina->lock);
-		return PTR_ERR(hwmon_dev);
+		ret = PTR_ERR(hwmon_dev);
+		goto fail;
 	}
 
 	return 0;
+
+fail:
+	pm_runtime_disable(ina->pm_dev);
+	pm_runtime_set_suspended(ina->pm_dev);
+	/* pm_runtime_put_noidle() will decrease the PM refcount until 0 */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
+		pm_runtime_put_noidle(ina->pm_dev);
+	mutex_destroy(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_remove(struct i2c_client *client)
 {
 	struct ina3221_data *ina = dev_get_drvdata(&client->dev);
+	int i;
+
+	pm_runtime_disable(ina->pm_dev);
+	pm_runtime_set_suspended(ina->pm_dev);
+
+	/* pm_runtime_put_noidle() will decrease the PM refcount until 0 */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
+		pm_runtime_put_noidle(ina->pm_dev);
 
 	mutex_destroy(&ina->lock);
 
@@ -726,7 +779,9 @@ static int __maybe_unused ina3221_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops ina3221_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(ina3221_suspend, ina3221_resume, NULL)
 };
 
 static const struct of_device_id ina3221_of_match_table[] = {
-- 
2.17.1

