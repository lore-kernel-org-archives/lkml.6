Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F60ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9436214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4OdtANP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9436214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeIWKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 06:07:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41954 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIWKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 06:07:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so7646466pfk.8;
        Sat, 22 Sep 2018 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFTEwK60eNnvOOpg3S5O3XFcFRsXeD1iqStYG0pOJ8o=;
        b=o4OdtANPTeNzV3TVRCHV5zBiSaxZbwt76maPMa14HEW1of0NY3grChCgOA7W3bKGJ1
         yLHwuTJFxsfJqGzK3CArQF8P3zzViMh8TKge8Zqqd6jU5/vHjnaqB78JgXroyONH/Nus
         LwjuOf1t8wQ6qday3Bm0R2q5NpRI1I743LowpY3M0GcTOR7Dzks0TdeyCcCquCl+i4Pc
         AACPODZMQcYSs8x5wFZ9oWniovcJwbKD75dzKZoagWV3J5/KCdb8Tzv7Xk3+SWWyReyZ
         ra7NgL1DIGznXjksshRwVkI9NYPFe+31rIpuYx/9pApfoRmlGX/RimDvCYUzABgjR8nN
         j6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFTEwK60eNnvOOpg3S5O3XFcFRsXeD1iqStYG0pOJ8o=;
        b=kUCgqiMru6rJNEbexmHYd/JBxO2IsK8VU3JWdj+cJ6STbSRWj2BtJYbalXwqJD7uUe
         zGIBQvgmZJS+wdTf49ie7Lut088sU7C8iJ0GgYiHavQBIHaMOWOp5Ct2XULewfo2nHlU
         Ja5TtCKqCCQ2uyzwQuzOgh5uPxXP3KCL09q2mk05VpprxcvUMVamvKI6ZoQZxpznELJ2
         0xEn9p4APARWv3zA2IzJJWwaPT1xXlXll8bzuUox9Y4NBLh3/MBEaqo5J0IvcNvbcftQ
         b4VbIpbpLV1Si8yJQjb635wbLIXOKcp/POrQv+4Yzm5NUbPL5x2yhBHRdf1QfN2Qha0F
         RuEA==
X-Gm-Message-State: ABuFfoiGiH8S6V3vLXrOJ3JbhpLRsM7Tx9Indu7Zevh06XNq05i3LVKX
        B4SAHMawlhu5bs9YOwEUSxQ=
X-Google-Smtp-Source: ACcGV600ln+N7Yj0Uvp+g3SJ8S3/UM2iDMkVgmFi6XRfy929nLfD0019M0K6uhNYDPt0BcEnrgMw0g==
X-Received: by 2002:a63:d03:: with SMTP id c3-v6mr2896845pgl.314.1537675890982;
        Sat, 22 Sep 2018 21:11:30 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l10-v6sm68942799pfj.179.2018.09.22.21.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 21:11:30 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/2] hwmon: ina3221: Read channel input source info from DT
Date:   Sat, 22 Sep 2018 21:11:18 -0700
Message-Id: <20180923041118.8743-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923041118.8743-1-nicoleotsuka@gmail.com>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ina3221 chip has three input ports. Each port is used
to measure the voltage and current of its input source.

The DT binding now has defined bindings for their input
sources, so the driver should read these information and
handle accordingly.

This patch adds a new structure of input source specific
information including input source label, shunt resistor
value and its connection status. It exposes these labels
via sysfs if available and also disables those channels
where there's no input source being connected.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v3->v4:
 * Added is_visible callback function to hide sysfs nodes
v2->v3:
 * N/A
v1->v2:
 * Added a structure for input source corresponding to DT bindings
 * Moved shunt resistor value to the structure
 * Defined in[123]_label sysfs nodes instead of name[123]_input
 * Updated probe() function to get information from DT
 * Updated ina3221 hwmon documentation for the labels
 * Dropped dynamical group definition to keep all groups as they were
 * * Will send an incremental patch later apart from this DT binding series

 Documentation/hwmon/ina3221 |   1 +
 drivers/hwmon/ina3221.c     | 164 +++++++++++++++++++++++++++++++++---
 2 files changed, 154 insertions(+), 11 deletions(-)

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
index e6b49500c52a..101473e5e6b6 100644
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
@@ -350,7 +386,43 @@ static struct attribute *ina3221_attrs[] = {
 
 	NULL,
 };
-ATTRIBUTE_GROUPS(ina3221);
+
+static const struct attribute *ina3221_label_attrs[] = {
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+};
+
+static umode_t ina3221_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	const int max_attrs = ARRAY_SIZE(ina3221_attrs) - 1;
+	const int num_attrs = max_attrs / INA3221_NUM_CHANNELS;
+	struct device *dev = kobj_to_dev(kobj);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	enum ina3221_channels channel = n / num_attrs;
+	struct ina3221_input *input = &ina->inputs[channel];
+	int i;
+
+	/* Hide if channel input source is disconnected */
+	if (input->disconnected)
+		return 0;
+
+	/* Hide label node if label is not provided */
+	for (i = 0; i < ARRAY_SIZE(ina3221_label_attrs); i++) {
+		input = &ina->inputs[i];
+		if (ina3221_label_attrs[i] == attr && !input->label)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group ina3221_group = {
+	.is_visible = ina3221_attr_is_visible,
+	.attrs = ina3221_attrs,
+};
+__ATTRIBUTE_GROUPS(ina3221);
 
 static const struct regmap_range ina3221_yes_ranges[] = {
 	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
@@ -370,6 +442,60 @@ static const struct regmap_config ina3221_regmap_config = {
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
+	/* Save the connected input label if available */
+	of_property_read_string(child, "input-label", &input->label);
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
@@ -377,6 +503,7 @@ static int ina3221_probe(struct i2c_client *client,
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
 	int i, ret;
+	u16 mask;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
@@ -399,7 +526,13 @@ static int ina3221_probe(struct i2c_client *client,
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
@@ -407,6 +540,15 @@ static int ina3221_probe(struct i2c_client *client,
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

