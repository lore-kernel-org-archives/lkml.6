Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCFCECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976A321536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHU0I/yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976A321536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbeIUFyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:54:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35006 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeIUFyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:54:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so5121388pfh.2;
        Thu, 20 Sep 2018 17:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQpG/Nl0x9DvMs9MlFGsNHInv2vOjzi+DpmvyozQgTM=;
        b=sHU0I/yrGQlFPtmJTv2l2kfBArXCLYKAs+aBItHMVf7Evrpeig1fpwSRv1Zp6dY2yQ
         9I/hTuGAhEZXFBC3/ZScx0h2s5geXKb+pAeaXI5S4MBifZT47QpSRX25DBlPREX0KeXG
         Ol/qXDNhCqXuhGZHpAt3gQipvtiYvrDbu2FN9AEia0HQlPj9kJcCAmqLu30JUplty3zL
         sbRzisgEszGNtkQS6u5s8kls3N8Uze+NJxIZcKKfd0mkyjfmvKBsYOJkj2tfH8TJ/mIC
         8i4tYYHMwfA1v+TM48xIrQrzz0yJN4+TTvUtQcMryWKJ3eXY2vvjsSVygWwRLxaq+ou0
         VQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQpG/Nl0x9DvMs9MlFGsNHInv2vOjzi+DpmvyozQgTM=;
        b=Lr973p/34KlXDbuNR01gmHlkpJpv+z90stzDJ8oi4ECStyJ9fCvlZNqhgR6ihFhW9X
         8qOjciBFUn2LHZYi2Dd9EtK24qy0YjjFgLhunK9WjCtegtzp+tlWHgDZ5UqW5nLGTKxV
         6FwWUEPZYlfE+fskLRKfJdnJxgFIPmX7S+fAmAGJxXS3VPPOie2Q58u8oHP0jwjMIrPI
         hhTekgrPYYeDYa26f5hJAEL5w9unD+Xzflvj8o1VD+VGpIT1JNEjDO0g1DmYFUlAMOSc
         K6A6f3Wg0h1uMNmuKIwwlcCZlH241b2ZlSDL66JsZzKnp8RTLDWe+Pa/siaQY6GT83kv
         WJaw==
X-Gm-Message-State: APzg51Dc5sRuohoar2XADGgRyTm9ZxleNqO+aEEji6mvBdKd2A2yZKuY
        xUPKI3oARM8ljJDlpTNM6GuB6nNE
X-Google-Smtp-Source: ANB0VdYHJnyRlCD44j1x92IUY0Q3vxLJ6jS932oidZT9bbTpyjLRPedMO/y2Q9iMytZWCHotPubDAw==
X-Received: by 2002:a62:808c:: with SMTP id j134-v6mr43549271pfd.120.1537488495896;
        Thu, 20 Sep 2018 17:08:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q26-v6sm43355083pfj.127.2018.09.20.17.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:08:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
Date:   Thu, 20 Sep 2018 17:07:53 -0700
Message-Id: <20180921000753.21846-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921000753.21846-1-nicoleotsuka@gmail.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The connection of channels are usually descirbed in the
schematics, which then should be indicated in DT binding
as well, and further should get exposed to sysfs so as
to help driver users understand what channels are really
monitoring respectively.

Meanwhile, channels could be left unconnected based on
the hardware design. So the channel name should support
NC so the driver could disable the channel accordingly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 88 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e6b49500c52a..5d487e205260 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -41,9 +41,12 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
 #define INA3221_CONFIG_MODE_BUS		BIT(2)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
+#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
+#define INA3221_NOT_CONNECTED		"NC"
+
 enum ina3221_fields {
 	/* Configuration */
 	F_RST,
@@ -91,11 +94,20 @@ static const unsigned int register_channel[] = {
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @shunt_resistors: Array of resistor values per channel
+ * @attr_group: attribute groups for sysfs node
+ *              (leave one space at the end for NULL termination)
+ * @channel_name: channel names
+ * @enable: enable or disable channels
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	int shunt_resistors[INA3221_NUM_CHANNELS];
+
+	const struct attribute_group *attr_group[INA3221_NUM_CHANNELS + 1];
+	const char *channel_name[INA3221_NUM_CHANNELS];
+
+	bool enable[INA3221_NUM_CHANNELS];
 };
 
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
@@ -253,6 +265,24 @@ static ssize_t ina3221_show_alert(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
 }
 
+static ssize_t ina3221_show_name(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", ina->channel_name[channel]);
+}
+
+/* channel name */
+static SENSOR_DEVICE_ATTR(name1_input, 0444,
+		ina3221_show_name, NULL, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(name2_input, 0444,
+		ina3221_show_name, NULL, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(name3_input, 0444,
+		ina3221_show_name, NULL, INA3221_CHANNEL3);
+
 /* bus voltage */
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
 		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
@@ -317,8 +347,8 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
 
-static struct attribute *ina3221_attrs[] = {
-	/* channel 1 */
+static struct attribute *ina3221_channel1_attrs[] = {
+	&sensor_dev_attr_name1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
@@ -328,7 +358,11 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 
-	/* channel 2 */
+	NULL,
+};
+
+static struct attribute *ina3221_channel2_attrs[] = {
+	&sensor_dev_attr_name2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
@@ -338,7 +372,11 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 
-	/* channel 3 */
+	NULL,
+};
+
+static struct attribute *ina3221_channel3_attrs[] = {
+	&sensor_dev_attr_name3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
@@ -350,7 +388,12 @@ static struct attribute *ina3221_attrs[] = {
 
 	NULL,
 };
-ATTRIBUTE_GROUPS(ina3221);
+
+static const struct attribute_group ina3221_group[INA3221_NUM_CHANNELS] = {
+	{ .attrs = ina3221_channel1_attrs, },
+	{ .attrs = ina3221_channel2_attrs, },
+	{ .attrs = ina3221_channel3_attrs, },
+};
 
 static const struct regmap_range ina3221_yes_ranges[] = {
 	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
@@ -373,10 +416,14 @@ static const struct regmap_config ina3221_regmap_config = {
 static int ina3221_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	const struct device_node *np = client->dev.of_node;
 	struct device *dev = &client->dev;
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
-	int i, ret;
+	u16 mask = 0, val = 0;
+	const char *str;
+	char prop[32];
+	int i, g, ret;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
@@ -407,9 +454,34 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* Fetch hardware information from Device Tree */
+	for (i = 0, g = 0; i < INA3221_NUM_CHANNELS; i++) {
+		/* Fetch the channel name */
+		sprintf(prop, "ti,channel%d-name", i + 1);
+		/* Set a default name on failure */
+		if (of_property_read_string(np, prop, &str))
+			str = "unknown";
+		/* Ignore unconnected channels */
+		if (!strcmp(str, INA3221_NOT_CONNECTED))
+			continue;
+		/* Log connected channels */
+		ina->attr_group[g++] = &ina3221_group[i];
+		ina->channel_name[i] = str;
+		ina->enable[i] = true;
+	}
+
+	/* Disable unconnected channels */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		mask |= INA3221_CONFIG_CHx_EN(i);
+		val |= ina->enable[i] ? INA3221_CONFIG_CHx_EN(i) : 0;
+	}
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, val);
+	if (ret)
+		return ret;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
-							   client->name,
-							   ina, ina3221_groups);
+							   client->name, ina,
+							   ina->attr_group);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
 		return PTR_ERR(hwmon_dev);
-- 
2.17.1

