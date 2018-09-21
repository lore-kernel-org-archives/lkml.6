Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF5ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE721568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBB+huaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BE721568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbeIVCD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:03:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36730 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391409AbeIVCD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:03:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so6425249plk.3;
        Fri, 21 Sep 2018 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrsKKjLAmGORNhWKZyaMo7NC+vfAGvwqoqcKUAaL01k=;
        b=eBB+huaf6qyNWvthRbVFGot0wBRjpjcFYKHNgm2+AtRLqD/evid9mHWyJ3o1ngghWI
         1WMlUn5DAlxfG33FEQBYRJfh60kiDZI+xEW2BDx71yBKHxLA9ALzEU+R+7CO3it4b1qH
         cXiOyaZynKrKVRt/bF1VdcrkNUGwG+6KskGm7VDBZ7PWfeSilxKrU0Hs4EY47ReK69Xf
         jVxdbtslEicy6yB0WylXrFRrMNG8dGUT4hzqrKXL3g22vio/6CkkwfR6LvmJLDL5cXP6
         YTZ2IKd5ymkmlaHsAovgSTvyNBzVfsSsrowuTOwkvchucBa0XRl13OVJGhJyJd29smGQ
         CAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hrsKKjLAmGORNhWKZyaMo7NC+vfAGvwqoqcKUAaL01k=;
        b=nikKO214/4dTGfnXadHxMkl5OcgHzz8hOAhKUax27F+0rAm5qwJJoWcJr1kiO3WYCu
         aYOjT37W6VG+2+RkmdLwxu1kbQyVlzRC0sAboXsdFNmUQWM0OAzd9FWtdcSDPmrxh+vW
         J0IlMcxjYRW890L/9E90M+t/Ybg/J6/NF/pJgaXMSxYFhK5hLic3pHEXYA8EtbmIVFbu
         5Jfsrqk1RExOKnX1aU9PpyKD836PQDJ21ZiEeg1nlIvtlYIaJ/gFY4vkvOEVvcBIScMG
         jyP5qPnmlYaxUsQS1pvEk+MJY3e8M/eB9deHxAInlX/IeQTcwW4fQrcnf8VPgk2W/FHz
         29Ww==
X-Gm-Message-State: APzg51CeXIpC8vJcNo3Tmf/WsrTOjjumCYeTjNizGiBDMBRUYbVaoZdV
        7kq5tj/X21bz7Fj0H/hdiEE=
X-Google-Smtp-Source: ANB0Vdb8N7NxhAfF13w9pKbvWn6WunL434RMgva81AUxfJqXEEz9M+rGRUyA7LgvAcp4n1kAR3tF6w==
X-Received: by 2002:a17:902:26c:: with SMTP id 99-v6mr46009171plc.341.1537560780475;
        Fri, 21 Sep 2018 13:13:00 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 132-v6sm783231pgh.67.2018.09.21.13.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:12:59 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: ina3221: Read channel input source info from DT
Date:   Fri, 21 Sep 2018 13:12:52 -0700
Message-Id: <20180921201252.12875-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921201252.12875-1-nicoleotsuka@gmail.com>
References: <20180921201252.12875-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

An ina3221 chip has three input ports. Each port is used
to measure the voltage and current of its input source.

The DT binding now has defined bindings for their input
sources, so the driver should read these information and
handle accordingly.

This patch adds a new structure of input source specific
information including input source label, shunt resistor
value and its connection status. It exposes these labels
via sysfs and also disables those channels where there's
no input source being connected.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v1->v2:
 * Added a structure for input source corresponding to DT bindings
 * Moved shunt resistor value to the structure
 * Defined in[123]_label sysfs nodes instead of name[123]_input
 * Updated probe() function to get information from DT
 * Updated ina3221 hwmon documentation for the labels
 * Dropped dynamical group definition to keep all groups as they were
 * * Will send an incremental patch later apart from this DT binding series

 Documentation/hwmon/ina3221 |   1 +
 drivers/hwmon/ina3221.c     | 126 +++++++++++++++++++++++++++++++++---
 2 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 0ff74854cb2e..2726038be5bd 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -22,6 +22,7 @@ Sysfs entries
 -------------
 
 in[123]_input           Bus voltage(mV) channels
+in[123]_label           Voltage channel labels
 curr[123]_input         Current(mA) measurement channels
 shunt[123]_resistor     Shunt resistance(uOhm) channels
 curr[123]_crit          Critical alert current(mA) setting, activates the
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e6b49500c52a..ba470fc53e27 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -41,6 +41,7 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
 #define INA3221_CONFIG_MODE_BUS		BIT(2)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
+#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -86,16 +87,28 @@ static const unsigned int register_channel[] = {
 	[INA3221_WARN3] = INA3221_CHANNEL3,
 };
 
+/**
+ * struct ina3221_input - channel input source specific information
+ * @label: label of channel input source
+ * @shunt_resistor: shunt resistor value of channel input source
+ * @disconnected: connection status of channel input source
+ */
+struct ina3221_input {
+	const char *label;
+	int shunt_resistor;
+	bool disconnected;
+};
+
 /**
  * struct ina3221_data - device specific information
  * @regmap: Register map of the device
  * @fields: Register fields of the device
- * @shunt_resistors: Array of resistor values per channel
+ * @inputs: Array of channel input source specific structures
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
-	int shunt_resistors[INA3221_NUM_CHANNELS];
+	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 };
 
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
@@ -131,6 +144,17 @@ static ssize_t ina3221_show_bus_voltage(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_mv);
 }
 
+static ssize_t ina3221_show_label(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+	struct ina3221_input *input = &ina->inputs[channel];
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
+}
+
 static ssize_t ina3221_show_shunt_voltage(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -155,7 +179,8 @@ static ssize_t ina3221_show_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_nv, ret;
 
 	ret = ina3221_read_value(ina, reg, &val);
@@ -176,7 +201,8 @@ static ssize_t ina3221_set_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_uv, ret;
 
 	ret = kstrtoint(buf, 0, &current_ma);
@@ -209,11 +235,9 @@ static ssize_t ina3221_show_shunt(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
-	unsigned int resistance_uo;
+	struct ina3221_input *input = &ina->inputs[channel];
 
-	resistance_uo = ina->shunt_resistors[channel];
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", resistance_uo);
+	return snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
 }
 
 static ssize_t ina3221_set_shunt(struct device *dev,
@@ -223,6 +247,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
+	struct ina3221_input *input = &ina->inputs[channel];
 	int val;
 	int ret;
 
@@ -232,7 +257,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 
 	val = clamp_val(val, 1, INT_MAX);
 
-	ina->shunt_resistors[channel] = val;
+	input->shunt_resistor = val;
 
 	return count;
 }
@@ -261,6 +286,14 @@ static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO,
 static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO,
 		ina3221_show_bus_voltage, NULL, INA3221_BUS3);
 
+/* voltage channel label */
+static SENSOR_DEVICE_ATTR(in1_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(in2_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(in3_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL3);
+
 /* calculated current */
 static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO,
 		ina3221_show_current, NULL, INA3221_SHUNT1);
@@ -320,6 +353,7 @@ static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 static struct attribute *ina3221_attrs[] = {
 	/* channel 1 */
 	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_label.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
 	&sensor_dev_attr_curr1_crit.dev_attr.attr,
@@ -330,6 +364,7 @@ static struct attribute *ina3221_attrs[] = {
 
 	/* channel 2 */
 	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
 	&sensor_dev_attr_curr2_crit.dev_attr.attr,
@@ -340,6 +375,7 @@ static struct attribute *ina3221_attrs[] = {
 
 	/* channel 3 */
 	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
 	&sensor_dev_attr_curr3_crit.dev_attr.attr,
@@ -370,6 +406,60 @@ static const struct regmap_config ina3221_regmap_config = {
 	.volatile_table = &ina3221_volatile_table,
 };
 
+static int ina3221_probe_child_from_dt(struct device *dev,
+				       struct device_node *child,
+				       struct ina3221_data *ina)
+{
+	struct ina3221_input *input;
+	u32 val;
+	int ret;
+
+	ret = of_property_read_u32(child, "input-id", &val);
+	if (ret) {
+		dev_err(dev, "missing input-id property of %s\n", child->name);
+		return ret;
+	} else if (val < 1 || val > INA3221_NUM_CHANNELS) {
+		dev_err(dev, "invalid input-id %d of %s\n", val, child->name);
+		return ret;
+	}
+
+	input = &ina->inputs[val - 1];
+
+	/* Log the disconnected channel input */
+	if (!of_device_is_available(child)) {
+		input->disconnected = true;
+		return 0;
+	}
+
+	/* Log the connected channel input */
+	input->label = child->name;
+
+	/* Overwrite default shunt resistor value optionally */
+	if (!of_property_read_u32(child, "shunt-resistor", &val))
+		input->shunt_resistor = val;
+
+	return 0;
+}
+
+static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
+{
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int ret;
+
+	/* Compatible with non-DT platforms */
+	if (!np)
+		return 0;
+
+	for_each_child_of_node(np, child) {
+		ret = ina3221_probe_child_from_dt(dev, child, ina);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ina3221_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -377,6 +467,7 @@ static int ina3221_probe(struct i2c_client *client,
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
 	int i, ret;
+	u16 mask;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
@@ -399,7 +490,13 @@ static int ina3221_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
-		ina->shunt_resistors[i] = INA3221_RSHUNT_DEFAULT;
+		ina->inputs[i].shunt_resistor = INA3221_RSHUNT_DEFAULT;
+
+	ret = ina3221_probe_from_dt(dev, ina);
+	if (ret) {
+		dev_err(dev, "Unable to probe from device treee\n");
+		return ret;
+	}
 
 	ret = regmap_field_write(ina->fields[F_RST], true);
 	if (ret) {
@@ -407,6 +504,15 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* Disable channels if their inputs are disconnected */
+	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (ina->inputs[i].disconnected)
+			mask |= INA3221_CONFIG_CHx_EN(i);
+	}
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, 0);
+	if (ret)
+		return ret;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
 							   client->name,
 							   ina, ina3221_groups);
-- 
2.17.1

