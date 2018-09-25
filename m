Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86881ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E722089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDVO7KR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E722089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIZFJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:09:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38705 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeIZFJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:09:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so7510525pgr.5;
        Tue, 25 Sep 2018 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nvYOg4sYKsU0jHqgpHmvzOLT5FCsfhCxBJx1jWVsWE=;
        b=QDVO7KR2DqcKbALvViMWnnPF7dBQPMDYJBuHYWFdjnhGGOlZ1l7aAgG8xQcQCGEQUQ
         tzVG3W7yojoF2bNr71lXE7ZSfWXsQsBWZ5VltTZ7i8cErI3qhgVgWYO8p6uiopEAPbMX
         3WMHDZyowSH/sljT7SkfEC0i5AhoE2JLX6INkrmGGYuXcmm9UPnROQ1iF2itr/X6yvS6
         iWYdxqtqQj6mi4d+JGVUxIazpqml6hjUmnWQEDOwP20qaNth2R7/CUpcovp7GBoX6dRD
         +CnPW+WjIsQd8zeWeFJ2bNZjHDGt47ywEm2Q27BDhCYP1LB6vKKfEw5HBneYKbm8JpnF
         YC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5nvYOg4sYKsU0jHqgpHmvzOLT5FCsfhCxBJx1jWVsWE=;
        b=OnsL8eMXgn232U3QSJ8mIKPv/mXOwBOh6ikFP2sYCpu8mo6YXPdsDTHRdO+ItQPKDr
         96ib8S+k4HgEtnvvHmAOZPHMDSFd4+gdnwBjoq8nOqAL0Qry8n6fXfL5XT4Z9/BBQ6C9
         vK/ZmpHg4mGwzQyE7zen3S8EilGXuWA5E3zXu8D2G7eUdJALqrDeszmYTrTtqu9DhqSm
         6+Rn6Y9aRwWKemPwdfUnmWbw2Il4EAHap3a5CiNsxLSvPbLfRaajUtj0RuQEa4U9wW3Z
         dPU8WmSqh+TyszCvOUWaYawnMpIasWIlGLl6AA0xVFsjznvXIMCrKk2cTnzSJgptj9OI
         +PVQ==
X-Gm-Message-State: ABuFfoi56iWN9LIZ0wDTIcoUnP0zPZc0AMV0vZy/R3juS/CPZz3/IJGb
        R/FPNmvVSRvmMogjr6kKMTg=
X-Google-Smtp-Source: ACcGV62kdiSFrybej+Iu7bfersgffK+pstbcxmb/7puh5fnD+DW059bX6i68PB9ocDeahYA26aBwcQ==
X-Received: by 2002:a63:fc46:: with SMTP id r6-v6mr2956073pgk.345.1537916393031;
        Tue, 25 Sep 2018 15:59:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n22-v6sm4652579pfi.185.2018.09.25.15.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:59:52 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 2/2] hwmon: ina3221: Read channel input source info from DT
Date:   Tue, 25 Sep 2018 15:59:30 -0700
Message-Id: <20180925225930.31886-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925225930.31886-1-nicoleotsuka@gmail.com>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
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
v4->v5:
 * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
 * Replaced "input-label" with "label"
 * Replaced "input-id" with "reg"
 * Simplified is_visible() by using index of the attr
 * Moved inX_label to index-0 and added comments for safety
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
 drivers/hwmon/ina3221.c     | 161 ++++++++++++++++++++++++++++++++----
 2 files changed, 148 insertions(+), 14 deletions(-)

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
index e6b49500c52a..25fa8c05a3bf 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -41,6 +41,7 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
 #define INA3221_CONFIG_MODE_BUS		BIT(2)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
+#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -86,18 +87,41 @@ static const unsigned int register_channel[] = {
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
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
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
-
-	resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
 
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
@@ -253,6 +278,14 @@ static ssize_t ina3221_show_alert(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
 }
 
+/* input channel label */
+static SENSOR_DEVICE_ATTR(in1_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(in2_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(in3_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL3);
+
 /* bus voltage */
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
 		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
@@ -318,7 +351,8 @@ static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
 
 static struct attribute *ina3221_attrs[] = {
-	/* channel 1 */
+	/* channel 1 -- make sure label at first */
+	&sensor_dev_attr_in1_label.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
@@ -328,7 +362,8 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 
-	/* channel 2 */
+	/* channel 2 -- make sure label at first */
+	&sensor_dev_attr_in2_label.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
@@ -338,7 +373,8 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 
-	/* channel 3 */
+	/* channel 3 -- make sure label at first */
+	&sensor_dev_attr_in3_label.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
@@ -350,7 +386,34 @@ static struct attribute *ina3221_attrs[] = {
 
 	NULL,
 };
-ATTRIBUTE_GROUPS(ina3221);
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
+	int index = n % num_attrs;
+
+	/* Hide if channel input source is disconnected */
+	if (input->disconnected)
+		return 0;
+
+	/* Hide label node if label is not provided */
+	if (index == 0 && !input->label)
+		return 0;
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
@@ -370,6 +433,60 @@ static const struct regmap_config ina3221_regmap_config = {
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
+	ret = of_property_read_u32(child, "reg", &val);
+	if (ret) {
+		dev_err(dev, "missing reg property of %s\n", child->name);
+		return ret;
+	} else if (val > INA3221_CHANNEL3) {
+		dev_err(dev, "invalid reg %d of %s\n", val, child->name);
+		return ret;
+	}
+
+	input = &ina->inputs[val];
+
+	/* Log the disconnected channel input */
+	if (!of_device_is_available(child)) {
+		input->disconnected = true;
+		return 0;
+	}
+
+	/* Save the connected input label if available */
+	of_property_read_string(child, "label", &input->label);
+
+	/* Overwrite default shunt resistor value optionally */
+	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
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
@@ -377,6 +494,7 @@ static int ina3221_probe(struct i2c_client *client,
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
 	int i, ret;
+	u16 mask;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
@@ -399,7 +517,13 @@ static int ina3221_probe(struct i2c_client *client,
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
@@ -407,6 +531,15 @@ static int ina3221_probe(struct i2c_client *client,
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

