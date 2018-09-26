Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E139C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A067208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZGJROmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A067208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeIZMyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:54:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40026 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:54:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so5174341pfj.7;
        Tue, 25 Sep 2018 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42ZH26G1GulK3kR63BbBk0+Kh0/u+HjdaTLKuRf+Mnc=;
        b=AZGJROmt00K4siKgZFnEiEsI/F5jsOTDsUduXGODDe6LVWOIDUWC6ZPRP041lujzQS
         zzg3ids9XF3vU6z+lyQFvid9McEgvtb4/zqBcoLvtnRYUl3pn+Kqyp50c9OkdEi1RWo4
         XHsrHxivP1GG4JxhHhpe2g7qZXK1szNGjEKVzN1KvXbqJNchOjVQrZ1gbK1XE5oDEgxY
         +dOtCTWATHb3sOrPvw4+Kjui+NzBPJJlHkOiY0phrbsp49OTLqwqGkbLyfh0RjZwY6xV
         BYR8o5TWLnPwZPkrAGAhBFLMZbk35K+XRWAgL0bowFXOaOzet0THrUR6tauSnGcbi6bc
         juUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42ZH26G1GulK3kR63BbBk0+Kh0/u+HjdaTLKuRf+Mnc=;
        b=pkFXwuaEGsNtGWcPO0sAFvWkdFQ1yfmscTRlGPsIcV2etZVTAqmqmlxXvlvS57q3Xn
         fYIojoBQV3lH4cy/nEwsh05WnmGiXNeDX8gdTEaF64p2OJ57eCMbQiVYj2Xau7cMD8B2
         TGW3dKfUX4y6c+s5Fj2FjJPXR/w9I8J5BAwovC3POl2mu8OXSHZFF3XWA80gnIA2CjNX
         0VqM6Wj+dYXrnBJjDtlkhenbIxPieabm56byqAWXtO3Wvuuwb0NMqjNuChAUg04pL7ij
         NLSmChOZZubaNUgOZO10QwAhpK0eQyWt9JGV2b5iGJOPUlFrCIJH9QuxOu79485rbhKo
         IIwQ==
X-Gm-Message-State: ABuFfogcyTEeZ/1voDuMkrmc0JEpwxTe3VKEFOqawnxfUsMf02FNYwtN
        RaAECzr42xByQq0QrSGg9rk=
X-Google-Smtp-Source: ACcGV60CerIXF2b+kpAxzK/JgVhny9LbrJsp8nL+CM69L24nCkUcpcI406Gi+gfSTsnn1Yq/CdOmOw==
X-Received: by 2002:a62:cc0e:: with SMTP id a14-v6mr4621354pfg.131.1537944182457;
        Tue, 25 Sep 2018 23:43:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5574861pfx.182.2018.09.25.23.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 23:43:02 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Date:   Tue, 25 Sep 2018 23:42:45 -0700
Message-Id: <20180926064245.4091-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926064245.4091-1-nicoleotsuka@gmail.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inX_enable interface allows user space to enable or disable
the corresponding channel. Meanwhile, according to hwmon ABI, a
disabled channel/sensor should return -ENODATA as a read result.

However, there're configurable nodes sharing the same __show()
functions. So this change also adds to check if the attribute is
read-only to make sure it's not reading a configuration but the
sensor data.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/ina3221 |  1 +
 drivers/hwmon/ina3221.c     | 85 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 6be64b553cd0..1aa32366d8aa 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -23,6 +23,7 @@ Sysfs entries
 
 in[123]_input           Bus voltage(mV) channels
 in[123]_label           Voltage channel labels
+in[123]_enable          Voltage channel enable controls
 curr[123]_input         Current(mA) measurement channels
 shunt[123]_resistor     Shunt resistance(uOhm) channels
 curr[123]_crit          Critical alert current(mA) setting, activates the
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 5890a2da3bfe..1be2d062a19e 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -78,6 +78,9 @@ enum ina3221_channels {
 };
 
 static const unsigned int register_channel[] = {
+	[INA3221_BUS1] = INA3221_CHANNEL1,
+	[INA3221_BUS2] = INA3221_CHANNEL2,
+	[INA3221_BUS3] = INA3221_CHANNEL3,
 	[INA3221_SHUNT1] = INA3221_CHANNEL1,
 	[INA3221_SHUNT2] = INA3221_CHANNEL2,
 	[INA3221_SHUNT3] = INA3221_CHANNEL3,
@@ -113,6 +116,19 @@ struct ina3221_data {
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 };
 
+static inline bool ina3221_is_enable(struct ina3221_data *ina, int channel)
+{
+	unsigned int config;
+	int ret;
+
+	/* Return false to reject further read */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &config);
+	if (ret)
+		return false;
+
+	return (config & INA3221_CONFIG_CHx_EN(channel)) > 0;
+}
+
 static ssize_t ina3221_show_label(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -124,6 +140,45 @@ static ssize_t ina3221_show_label(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
 }
 
+static ssize_t ina3221_show_enable(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ina3221_is_enable(ina, channel));
+}
+
+static ssize_t ina3221_set_enable(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+	unsigned int mask = INA3221_CONFIG_CHx_EN(channel);
+	unsigned int config;
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	/* inX_enable only accepts 1 for enabling or 0 for disabling */
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	config = val ? mask : 0;
+
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
@@ -146,8 +201,13 @@ static ssize_t ina3221_show_bus_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_mv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -164,8 +224,13 @@ static ssize_t ina3221_show_shunt_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_uv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -201,8 +266,13 @@ static ssize_t ina3221_show_current(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int current_ma, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = __ina3221_show_current(ina, reg, &current_ma);
 	if (ret)
 		return ret;
@@ -318,6 +388,10 @@ static ssize_t ina3221_show_power(struct device *dev,
 	int val, current_ma, voltage_mv, ret;
 	s64 power_uw;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	/* Read bus voltage */
 	ret = ina3221_read_value(ina, reg_bus, &val);
 	if (ret)
@@ -377,6 +451,14 @@ static SENSOR_DEVICE_ATTR(in2_label, 0444,
 static SENSOR_DEVICE_ATTR(in3_label, 0444,
 		ina3221_show_label, NULL, INA3221_CHANNEL3);
 
+/* voltage channel enable */
+static SENSOR_DEVICE_ATTR(in1_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(in2_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(in3_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL3);
+
 /* bus voltage */
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
 		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
@@ -460,6 +542,7 @@ static SENSOR_DEVICE_ATTR(power3_crit, 0644,
 static struct attribute *ina3221_attrs[] = {
 	/* channel 1 -- make sure label at first */
 	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in1_enable.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
@@ -473,6 +556,7 @@ static struct attribute *ina3221_attrs[] = {
 
 	/* channel 2 -- make sure label at first */
 	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in2_enable.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
@@ -486,6 +570,7 @@ static struct attribute *ina3221_attrs[] = {
 
 	/* channel 3 -- make sure label at first */
 	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in3_enable.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
-- 
2.17.1

