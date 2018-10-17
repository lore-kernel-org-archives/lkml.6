Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938F6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53091214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOne4JNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53091214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38708 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so12337162pff.5;
        Tue, 16 Oct 2018 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14cljtA7/SkZpoUxuHPLkxQuZ59w2eqeIYUVwxGaV2A=;
        b=mOne4JNmLqR3Q1QpKwinW+vCvs060tKFMuE9NSWurLCJb0+vtbm+MEqQWvxYDfJp0d
         LYSC8k4bDpT/sY0GczK7sAH14RH38KVOLkaK11frhPTD4PnHRetcN3cLph2oP1xMVOgj
         CNl609ALEWT11BOhl3U3ZRKgb94dGAkhA3O1crrtwOu5frSTixu9G8dPNEyaK31xhiJf
         vrd6+7vJghja4NF0osYhVks1sNg09cFSb8IjXL+WCBhgi34fy8mxSIJQlyGrbz2hKg2d
         XHo44+iYAxpjKP6fYrfSsETneCgTIKCZnGwNVP01frkfPN6Cg/k5fvEyQ9BzQLok9/4w
         MIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14cljtA7/SkZpoUxuHPLkxQuZ59w2eqeIYUVwxGaV2A=;
        b=s4aAIYpJbx3OipgOEUwX96tm8qVosE0FCV+8yssnZtWZlU55lO2KVp7OzziLvlj5fE
         unjf97Vm889QlPojUSHnbMnuB2Fic/UJ8cE5gyoxmt5mwcXiaoIMH2pSw+CRmjNy1CtR
         B2r//Uh2zq+T/Iq9HcKKKaaaJny/WgXsJVwJa0JAcmtkEsj8Ey6X/gNkuJNFkDr0for5
         FceOAImqU3pPqS90BMvMv41Ef3+IUdoNTtGCLB7cCR+pYm+c/mEcy1E8dYq+LXfs9IUN
         N8FERIcjUbycE83vC1LiUO/H+zI3zytZiHCyfXc7YXErHQSvM71BLbPEwcYtV4O7zuCr
         5l0Q==
X-Gm-Message-State: ABuFfogy3DVRqRIq/GHwv7gtCLRIMmRmqhpYoiNacGLg1fWUaqjfP+VK
        GzyHTykXqbSwcwbUhmcJlqduC4yM
X-Google-Smtp-Source: ACcGV619FRzv6yV6EeebPmpEIJu4p5w+6pS8TlR3TawRs1PvPJKFw633twXFsSXrB1V0Gp0oGQOGfw==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr21926236pgv.233.1539739475311;
        Tue, 16 Oct 2018 18:24:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:34 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] hwmon: (ina3221) Serialize sysfs ABI accesses
Date:   Tue, 16 Oct 2018 18:24:24 -0700
Message-Id: <20181017012426.26958-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017012426.26958-1-nicoleotsuka@gmail.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a mutex to serialize accesses of sysfs attributes.

This is required when polling CVRF bit of the MASK/ENABLE register
because this bit is cleared on a read of this MASK/ENABLE register
or a write to CONFIG register, which means that this bit might be
accidentally cleared by reading other fields like alert flags.

So this patch adds a mutex lock to protect the write() and read()
callbacks. The read_string() callback won't need the lock since it
just returns the label without touching any hardware register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 3e98b59108ee..5fc375bf6635 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -18,6 +18,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 
@@ -94,12 +95,14 @@ struct ina3221_input {
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @inputs: Array of channel input source specific structures
+ * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
+	struct mutex lock;
 	u32 reg_config;
 };
 
@@ -261,29 +264,53 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&ina->lock);
+
 	switch (type) {
 	case hwmon_in:
 		/* 0-align channel ID */
-		return ina3221_read_in(dev, attr, channel - 1, val);
+		ret = ina3221_read_in(dev, attr, channel - 1, val);
+		break;
 	case hwmon_curr:
-		return ina3221_read_curr(dev, attr, channel, val);
+		ret = ina3221_read_curr(dev, attr, channel, val);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	mutex_unlock(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&ina->lock);
+
 	switch (type) {
 	case hwmon_in:
 		/* 0-align channel ID */
-		return ina3221_write_enable(dev, channel - 1, val);
+		ret = ina3221_write_enable(dev, channel - 1, val);
+		break;
 	case hwmon_curr:
-		return ina3221_write_curr(dev, attr, channel, val);
+		ret = ina3221_write_curr(dev, attr, channel, val);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	mutex_unlock(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
@@ -578,6 +605,7 @@ static int ina3221_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	mutex_init(&ina->lock);
 	dev_set_drvdata(dev, ina);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
@@ -585,12 +613,22 @@ static int ina3221_probe(struct i2c_client *client,
 							 ina3221_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
+		mutex_destroy(&ina->lock);
 		return PTR_ERR(hwmon_dev);
 	}
 
 	return 0;
 }
 
+static int ina3221_remove(struct i2c_client *client)
+{
+	struct ina3221_data *ina = dev_get_drvdata(&client->dev);
+
+	mutex_destroy(&ina->lock);
+
+	return 0;
+}
+
 static int __maybe_unused ina3221_suspend(struct device *dev)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -659,6 +697,7 @@ MODULE_DEVICE_TABLE(i2c, ina3221_ids);
 
 static struct i2c_driver ina3221_i2c_driver = {
 	.probe = ina3221_probe,
+	.remove = ina3221_remove,
 	.driver = {
 		.name = INA3221_DRIVER_NAME,
 		.of_match_table = ina3221_of_match_table,
-- 
2.17.1

