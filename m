Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF08C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2997D224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThVBAJ7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2997D224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeKMOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:20:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42605 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:20:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1622984pga.9;
        Mon, 12 Nov 2018 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RXXUPWHjbF+um19Xd3QGgmRmxsUbhZ8J8z5FmBELzkE=;
        b=ThVBAJ7NKx9A0LLDMwLLtXKuZwVBQk34wr1EX+gIoHUu41mz0L+cEoqgHWysQ2r3PA
         6LXKr+oHPhqT1wG9fGWBqym546QHjLtVT8z8SkRO8gFF/RU4Le6WrzSuSqLTXdR8MOig
         T+AxqfntSTV+bnig/spKr81aap+lakj3p4Lb4mmAYeIvdS/eHu+Em8NqssEts7h6g4j9
         /2jidPJTRnVyFHt9PB2BQVvM63Oo2aHYr1X2XM4a2xnBKfUOqlhnCjKIqc0R6hW8Zf9N
         Tt4iBkxgWNgUyPnILOVPn4EVgQtlmZsyAr0XSBcNyZvz0WTduZfu1Fs3t3Hgd2DnukAO
         RSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RXXUPWHjbF+um19Xd3QGgmRmxsUbhZ8J8z5FmBELzkE=;
        b=jjP9mArG/qXtYU7v2mEaPuDvNVRhkX/KLppfrN7Z6ep3/TU67D6BkWvYHYwdZbTENJ
         fXmbBjxa1q9AZ48+CDH8nm6k3I79slD5W1EuVnfSRwOaejdemHoi59jo+pMU/d8gaRMT
         YvsZa9BLLjsxV3HgViwOj2XkxZziEsoiKiPjIkx4osEvEiVh13pxMyMFPS73WPwS+dJI
         /pnTMKklpdTP6uJyWn74G2+rHSUIEkbTlIm2q3+i4TvoDhqH835iSa0Oh25yG31FWxVo
         F5cOFhk5Mz7ixL7rmPBth04qlHCkw1s+gXGZ9uA5rjXYHJ7VmGk617r/T0nN6vJWA9kw
         JMbw==
X-Gm-Message-State: AGRZ1gL4vB0uKL5JWHv/B6yRWcyq94lQG3JEXaguVdPwamlgPi/uNIi2
        RV9Q3oNl+Sv+JTLkgITzgAGmK7LG
X-Google-Smtp-Source: AJdET5cZPIX70poh3uw9T0lA21SWl+aI7yVCEMNf4VmgMNugYsq7kh36FjcSytCy3dNrm76sYMjXuA==
X-Received: by 2002:a63:d747:: with SMTP id w7mr3290184pgi.360.1542083065199;
        Mon, 12 Nov 2018 20:24:25 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t82-v6sm38571856pfi.45.2018.11.12.20.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:24:24 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] hwmon (ina3221) Add single-shot mode support
Date:   Mon, 12 Nov 2018 20:23:53 -0800
Message-Id: <20181113042353.1507-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INA3221 supports both continuous and single-shot modes. When
running in the continuous mode, it keeps measuring the inputs
and converting them to the data register even if there are no
users reading the data out. In this use case, this could be a
power waste.

So this patch adds a single-shot mode support so that ina3221
could do measurement and conversion only if users trigger it,
depending on the use case where it only needs to poll data in
a lower frequency.

The change also exposes "mode" and "available_modes" nodes to
allow users to switch between two operating modes.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/ina3221 |   3 +
 drivers/hwmon/ina3221.c     | 109 ++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 4b82cbfb551c..b03f4ad901ee 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -35,3 +35,6 @@ curr[123]_max           Warning alert current(mA) setting, activates the
                           average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+available_modes         Available operating modes of the chip:
+                          continuous mode; single-shot mode
+mode                    Current operating mode of the chip
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 17a57dbc0424..8f7da3f75d53 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -91,6 +91,17 @@ enum ina3221_channels {
 	INA3221_NUM_CHANNELS
 };
 
+enum ina3221_modes {
+	INA3221_MODE_SINGLE_SHOT,
+	INA3221_MODE_CONTINUOUS,
+	INA3221_NUM_MODES,
+};
+
+static const char * const ina3221_mode_names[] = {
+	[INA3221_MODE_SINGLE_SHOT] = "single-shot",
+	[INA3221_MODE_CONTINUOUS] = "continuous",
+};
+
 /**
  * struct ina3221_input - channel input source specific information
  * @label: label of channel input source
@@ -127,6 +138,11 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
 }
 
+static inline bool ina3221_is_singleshot_mode(struct ina3221_data *ina)
+{
+	return !(ina->reg_config & INA3221_CONFIG_MODE_CONTINUOUS);
+}
+
 /* Lookup table for Bus and Shunt conversion times in usec */
 static const u16 ina3221_conv_time[] = {
 	140, 204, 332, 588, 1100, 2116, 4156, 8244,
@@ -188,6 +204,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina3221_is_singleshot_mode(ina))
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -232,6 +253,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina3221_is_singleshot_mode(ina))
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -532,6 +558,82 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 	return count;
 }
 
+static ssize_t available_modes_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ina3221_mode_names); i++)
+		snprintf(buf, PAGE_SIZE, "%s%s ", buf, ina3221_mode_names[i]);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", buf);
+}
+
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int mode;
+
+	if (ina->reg_config & INA3221_CONFIG_MODE_CONTINUOUS)
+		mode = INA3221_MODE_CONTINUOUS;
+	else
+		mode = INA3221_MODE_SINGLE_SHOT;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", ina3221_mode_names[mode]);
+}
+
+static ssize_t mode_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	u16 mask = INA3221_CONFIG_MODE_CONTINUOUS;
+	u16 continuous;
+	int mode, ret;
+	char name[32];
+
+	mutex_lock(&ina->lock);
+
+	snprintf(name, sizeof(name), "%s", buf);
+	strim(name);
+
+	for (mode = 0; mode < INA3221_NUM_MODES; mode++) {
+		if (!strcmp(name, ina3221_mode_names[mode]))
+			break;
+	}
+
+	switch (mode) {
+	case INA3221_MODE_SINGLE_SHOT:
+		continuous = 0;
+		break;
+	case INA3221_MODE_CONTINUOUS:
+		continuous = INA3221_CONFIG_MODE_CONTINUOUS;
+		break;
+	default:
+		mutex_unlock(&ina->lock);
+		return -EINVAL;
+	}
+
+	/* Set register to configure single-shot or continuous mode */
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, continuous);
+	if (ret) {
+		mutex_unlock(&ina->lock);
+		return ret;
+	}
+
+	/* Cache the latest config register value */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret) {
+		mutex_unlock(&ina->lock);
+		return ret;
+	}
+
+	mutex_unlock(&ina->lock);
+
+	return count;
+}
+
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt1_resistor, S_IRUGO | S_IWUSR,
 		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL1);
@@ -540,10 +642,17 @@ static SENSOR_DEVICE_ATTR(shunt2_resistor, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(shunt3_resistor, S_IRUGO | S_IWUSR,
 		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL3);
 
+/* operating mode */
+static DEVICE_ATTR_RW(mode);
+static DEVICE_ATTR_RO(available_modes);
+
 static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
+	/* common attributes */
+	&dev_attr_mode.attr,
+	&dev_attr_available_modes.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(ina3221);
-- 
2.17.1

