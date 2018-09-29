Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CBCC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A042087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqw5sTDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A042087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeI3EOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:14:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42775 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeI3EOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:14:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so6239604pgq.9;
        Sat, 29 Sep 2018 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jIcczCRJA7bP+5h9Te1N43SjRq2VNPPLL50OG3IxI4c=;
        b=Gqw5sTDDrdpJkHshjfWTkFb7NL4mC7M1jMFEMpfQjjj0bdbPLQWd5P+NEQi5vI/xy7
         mhhHMQcd3sD3PaaEp93WlSGU4Ibr8RILc2lrswI9BJJ/8lpAMzkhlKNZuYO7cenlKoyF
         oUNcD6T1b1mSQvxJgzvZo29Z9nhDYJ8m8To1oKcEu9oOQoDSvQeibcxB3jFmxiZqhHux
         N7N/Io1A9crQWb81LarhHB2aMHOLm1C0QkCQfZq4a2vQAsxdYQ+Oz3V++oNqACW6Onof
         zm69Px1TdgR3PbMog7ogxI4m2393bTrLEHqNMLDtTijNBi8GLMZCs9MP5U/sRUZ4N0Qm
         3IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jIcczCRJA7bP+5h9Te1N43SjRq2VNPPLL50OG3IxI4c=;
        b=daHEfHbPpMAMz2v5UORZR6hni7jw/65xwrlF4ygqMvLOJftWu2sJf1Ck4MfkXx4DTY
         oKPEt+kqgcDLsi7B8B3qFhpWTKbBxGwIGiZJxP8LiSD93csu8FWcH88DhVJvoaOLG2Xq
         XFmtt+fmT0p7QrBmM3/knpLgSt8YbuQsu56wmi5D95Wp/cjpuL/NuqhzxzpOJYjeJdFZ
         N+/qxDPLR7Z/ZUNRy6wBydFih5uXN/ac+OYafd+5MgAdc0ngmZUF5qVa8nf8FxeTXhA1
         Yuq/LdnFdach40bGNIdaUY8+Ct3rqfynlrmEIr5BoWj7eVxSbn2Iz/M2Xqd/FyQ+U9NR
         PkaQ==
X-Gm-Message-State: ABuFfogLQ2SFJTJ1ivvMKZeSvOZrYIENaPV+n+h6qP5LL4NFIk4M0E3y
        YtD3Ondh4PG85b3rnbaQNik=
X-Google-Smtp-Source: ACcGV62z028jGyXJObtfc0st/T3SjcoKZ0Fd8ZuZcQ6eWyfyfkeqwtyS+f702kjx4kDSjUEHCj4NhQ==
X-Received: by 2002:a17:902:103:: with SMTP id 3-v6mr2918531plb.58.1538257457170;
        Sat, 29 Sep 2018 14:44:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o20-v6sm17780313pfj.35.2018.09.29.14.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 14:44:16 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: ina3221: Add suspend and resume functions
Date:   Sat, 29 Sep 2018 14:44:07 -0700
Message-Id: <20180929214407.27208-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929214407.27208-1-nicoleotsuka@gmail.com>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the hardware design, an INA3221 chip might lose
its power during system suspend/resume. So this patch adds
a set of suspend and resume functions to cache the register
values including config register value and limit settings.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Added power-down setting during suspend for power saving

 drivers/hwmon/ina3221.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e0c4f4d83f4e..877952efaa88 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -38,6 +38,8 @@
 #define INA3221_WARN3			0x0c
 #define INA3221_MASK_ENABLE		0x0f
 
+#define INA3221_CONFIG_MODE_MASK	GENMASK(2, 0)
+#define INA3221_CONFIG_MODE_POWERDOWN	0
 #define INA3221_CONFIG_MODE_SHUNT	BIT(0)
 #define INA3221_CONFIG_MODE_BUS		BIT(1)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
@@ -91,11 +93,13 @@ static const unsigned int register_channel[] = {
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @shunt_resistors: Array of resistor values per channel
+ * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	int shunt_resistors[INA3221_NUM_CHANNELS];
+	u32 reg_config;
 };
 
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
@@ -415,9 +419,67 @@ static int ina3221_probe(struct i2c_client *client,
 		return PTR_ERR(hwmon_dev);
 	}
 
+	dev_set_drvdata(dev, ina);
+
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ina3221_suspend(struct device *dev)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	/* Save config register value and enable cache-only */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		return ret;
+
+	/* Set to power-down mode for power saving */
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+				 INA3221_CONFIG_MODE_MASK,
+				 INA3221_CONFIG_MODE_POWERDOWN);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(ina->regmap, true);
+	regcache_mark_dirty(ina->regmap);
+
+	return 0;
+}
+
+static int ina3221_resume(struct device *dev)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(ina->regmap, false);
+
+	/* Software reset the chip */
+	ret = regmap_field_write(ina->fields[F_RST], true);
+	if (ret) {
+		dev_err(dev, "Unable to reset device\n");
+		return ret;
+	}
+
+	/* Restore cached register values to hardware */
+	ret = regcache_sync(ina->regmap);
+	if (ret)
+		return ret;
+
+	/* Restore config register value to hardware */
+	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops ina3221_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
+};
+
 static const struct of_device_id ina3221_of_match_table[] = {
 	{ .compatible = "ti,ina3221", },
 	{ /* sentinel */ }
@@ -435,6 +497,7 @@ static struct i2c_driver ina3221_i2c_driver = {
 	.driver = {
 		.name = INA3221_DRIVER_NAME,
 		.of_match_table = ina3221_of_match_table,
+		.pm = &ina3221_pm,
 	},
 	.id_table = ina3221_ids,
 };
-- 
2.17.1

