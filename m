Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE293C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8E2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXBWZyNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeKUL7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:59:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38894 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:59:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so2937171plb.5;
        Tue, 20 Nov 2018 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ke/KchsjNiiMiNJoz6oIglowVLOLoOm+RU55Cm7ofAU=;
        b=TXBWZyNYtY5wlIKNZgLqoToKwRHOkD/zjT9+MfmWRVK4QFCLITA1WDxsSTJHbVVxvN
         rCxNEfJumUBOF9/nIGbJ5bq634+On/odp86JLl8ywCRvHJq96EqPQFgVNtvTnypo1tyB
         NMM53B2vdN7lkBhpweM2hJpFrJDTD06vcVms72XkhiUgPagCbHUcXd6e/e2YDwYr0lAo
         Z6vD/VqUxDQpjreI8S1zHfVJpxC9WuM8MyvA4mStmbdpqL7ABXfvG4GQ/O77V9OB4U+q
         kktpPSEbvaNNx9lM1iu6wfiUi0jzaynSE0kRv4agf8ZXJD77kXV4HZcCLIAoFaibWFEW
         0B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ke/KchsjNiiMiNJoz6oIglowVLOLoOm+RU55Cm7ofAU=;
        b=hhfjeJHw7zsHdohRPGeiOV3xNXGvC0Vizhpkqaadfw8A2fHaynRmJqy6hACHDYMlnG
         2w0yl4VEfJb6l5vaWmQDK0h9/YX6R2chEQDuazJfvcki/w53sW8TZ7NA7GMVN9AXhANC
         h1dU5FC6amIkIHJz5HfTPLQciJpxdHIA3Pdva8P72Ou2UepvYJ62Vzw88okkgUR93vrK
         xPD52Ehtx83zxmefTG95akna5E4GTb2BQgJww1vVOJ5/ghocL20OXPBKBJLhOu5Ahi6r
         42zFquA17CXoYF/nzcAKFl/y6eUqVHG6oexpOXOjlfxBLrhGDP7zpK3Q5pjnhVKdjCJ2
         DU4w==
X-Gm-Message-State: AGRZ1gJlYWVdSUvLs03YUB7/0bUvu8luSCKKDPZ6ttNWbLDqpVRBTukp
        IEm2/YjVAVF9xPLo2+MCmCkTMbxX
X-Google-Smtp-Source: AJdET5fDe4pOsiKFL2JjbJ/hrf9qcNyJOijQAsCODHEkDRtyf4i9Eek8fCY/EMOqv1ZEXm5VFtwACg==
X-Received: by 2002:a62:5716:: with SMTP id l22mr3928403pfb.16.1542763615386;
        Tue, 20 Nov 2018 17:26:55 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c4sm7388858pfm.151.2018.11.20.17.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 17:26:54 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, m.purski@samsung.com,
        stefan.bruens@rwth-aachen.de
Subject: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading precision
Date:   Tue, 20 Nov 2018 17:26:29 -0800
Message-Id: <20181121012629.5432-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=== Background ===
The ina2xx chip has a CALIBRATION register that's used to configure
calibration value to get the scale of current and power measurement
results from their registers. It basically follows two equations:
1) CAL = calibration factor / (current_lsb_A * rshunt_Ohm)
   [ calibration factor: 0.04096 for ina219; 0.00512 for ina226 ]
2) current_lsb_A = max_curr_A / 2^15

According to these two equations, calibration value, current scale,
max_curr_A, and shunt resistor value are related factors.

The driver has been using two methods for these two equations:
A) Used a fixed current_lsb at 1 mA scale
B) Using a fixed calibration value at 4096|2048 for ina219|226

=== Problem ===
Both methods simplify software routine by fixing one factor, which
sacrifices the precision of the hardware measurement results.

Using ina226 for example, with method A, the current scale was 1mA
and the power scale was 25mA.

With method B, calibration value is fixed at 2048 so the precision
is decided by shunt resistor value. It sounds reasonable since the
hardware engineers can use a larger shunt resistor when they need
higher resolution. However, they often concern power burning across
the resistor as well, so the resistor usually won't be so large: a
typical value 1000 micro-ohms, which results in a current scale at
2.5 mA and a power sacle at 62.5 mW.

When measuring a 1.8v voltage running a small current (e.g. 33 mA),
the power value (that's supposed to be 59.4 mW) becomes inaccurate
due to the larger scale (25mA for method A; 62.5 mA for method B).

Also, worth mentioning: method B was added by commit 5d389b125186
("hwmon: (ina2xx) Make calibration register value fixed") stating
that 4096|2048 is the best value for ina219|in226. However, their
datasheets do not seem to mention this "best" keyword. Actually,
they are merely minimum calibration values. See below calculation:

Equation 1, mentioned at Background section:
   CAL = calibration factor / (current_lsb_A * rshunt_Ohm)
=> min CAL = calibration factor / (max current_lsb_A * rshunt_Ohm)
   [calibration factor is 0.00512 for ina226]

Equation 2, mentioned at Background section:
   current_lsb_A = max_curr_A / 2^15
=> max current_lsb_A = (upper bound of max_curr_A) / 2^15

Equation Aux:
   (upper bound of max_curr_A) = max Vshunt / rshunt_Ohm
   [max Vshunt is 81.92 mA mentioned in ina226 datasheet]

Combining three equations:
   min CAL = 0.00512 / (0.08192 / rshunt_Ohm / 2^15 * rshunt_Ohm)
	   = 0.00512 / (0.08192 / 2^15)
	   = 2048

=== Solution ===
Being implied in the previous two paragraphs, both methods result
in inaccurate measurements due to the large lsb values because of
the fixed factors for the calculations.

To address this problem, this patch introduces a sysfs attribute
"max_curr" (maximum expected current_lsb_mA) to allow user to set
the current_lsb_uA via this max_curr according to Equation 2, for
precision based on the use case, so they'll be able to indirectly
control the calibration_value through Equation 1.

(In order not to break existing platforms, this change continues
 using 4096|2048 as a default calibration value but renames them
 from "best" to "min")

Then the change introduces a pair of macros for Equation 1 and 2
and adds the calibration_factor back for Equation 1.

=== Testing ===
Fixed factors:
  shunt_resistor = 1000 uO
  in1_input = 1799 mV

Before:
  max_curr = 81920 mA
  calibration_value = 2048
  when curr1_input = 33 mA,
    power1_input = 125000 uW (expected 59367 uW)
  when curr1_input = 35 mA
    power1_input = 125000 uW (expected 62965 uW)

After:
  set "max_curr" to 5145 mA (smallest within the valid range)
  calibration_value = 32611
  when curr1_input = 32 mA
    power1_input = 58875 uW (expected 57568 uW)
  when curr1_input = 35 mA
    power1_input = 62800 uW (expected 62965 uW)

=== Summary ===
- "shunt_resistor" attribute sets rshunt and "max_curr" boundaries
- "max_curr" sysfs attribute decides current_lsb_uA and power_lsb_uW
- ina2xx_init() still uses 4096|2048 as default calibration setting
* All of them will calibrate as the factor of Equation 1 is changed

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Note:
This change is rebased upon the following Documentation change:
  Documentation: hwmon: Add descriptions for ina2xx sysfs entries
which was sent to the mail-list and is now under review already.

 Documentation/hwmon/ina2xx |   2 +
 drivers/hwmon/ina2xx.c     | 233 ++++++++++++++++++++++++++++++-------
 2 files changed, 192 insertions(+), 43 deletions(-)

diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index 0f36c021192d..ffe53f0f15e1 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -71,6 +71,8 @@ in1_input		Bus voltage(mV) channel
 curr1_input		Current(mA) measurement channel
 power1_input		Power(uW) measurement channel
 shunt_resistor		Shunt resistance(uOhm) channel
+max_curr		Maximum expected current used to improve precision
+			of readings of current and power measurements
 
 Sysfs entries for ina226, ina230 and ina231 only
 -------------
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 07ee19573b3f..2ec909a8ed34 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -86,6 +86,43 @@
  */
 #define INA226_TOTAL_CONV_TIME_DEFAULT	2200
 
+/* Largest calibration value for a 15-bit valid range */
+#define INA2XX_CALIBRATION_MAX		0x7FFF
+
+/*
+ * According to the Equation 1 in the datasheet,
+ *   CAL = (calibration_factor * 10^-6) / (current_lsb_A * rshunt_Ohm)
+ *       = (calibration_factor * 10^6) / (current_lsb_uA * rshunt_uOhm)
+ *
+ * Note: result of calculation is truncated according to datasheet
+ */
+#define INA2XX_EQUATION_1_CAL(factor, x, rshunt_uOhm) \
+	DIV_ROUND_DOWN_ULL((u64)factor * 1000000, x * rshunt_uOhm)
+/*
+ * By exchanging CAL and current_lsb_uA:
+ *   current_lsb_uA = (calibration_factor * 10^6) / (CAL * rshunt_uOhm)
+ *
+ * Since CAL was truncated (see above), using ROUND_UP here
+ */
+#define INA2XX_EQUATION_1_LSB(factor, x, rshunt_uOhm) \
+	DIV_ROUND_UP_ULL((u64)factor * 1000000, x * rshunt_uOhm)
+
+/*
+ * According to the Equation 2 in the datasheet,
+ *   current_lsb_A = max_curr_A / 2^15
+ *   => current_lsb_uA = max_curr_uA / 2^15
+ *                     = (max_curr_mA * 10^3) / 2^15
+ */
+#define INA2XX_EQUATION_2_LSB(max_curr_mA) \
+	DIV_ROUND_CLOSEST_ULL(max_curr_mA * 1000, 1 << 15)
+
+/*
+ * By exchanging current_lsb_uA and max_curr_mA:
+ *   max_curr_mA =  current_lsb_uA * 2^15 / 10^3
+ */
+#define INA2XX_EQUATION_2_MAX(current_lsb_uA) \
+	DIV_ROUND_CLOSEST_ULL(current_lsb_uA * (1 << 15), 1000)
+
 static struct regmap_config ina2xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -95,12 +132,14 @@ enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
 	u16 config_default;
-	int calibration_value;
+	int calibration_factor;
+	int calibration_value_min;
 	int registers;
 	int shunt_div;
 	int bus_voltage_shift;
 	int bus_voltage_lsb;	/* uV */
 	int power_lsb_factor;
+	int shunt_voltage_max;
 };
 
 struct ina2xx_data {
@@ -109,6 +148,8 @@ struct ina2xx_data {
 	long rshunt;
 	long current_lsb_uA;
 	long power_lsb_uW;
+	long max_curr_upper;
+	long max_curr_lower;
 	struct mutex config_lock;
 	struct regmap *regmap;
 
@@ -118,21 +159,25 @@ struct ina2xx_data {
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
-		.calibration_value = 4096,
+		.calibration_factor = 40960,
+		.calibration_value_min = 4096,
 		.registers = INA219_REGISTERS,
 		.shunt_div = 100,
 		.bus_voltage_shift = 3,
 		.bus_voltage_lsb = 4000,
 		.power_lsb_factor = 20,
+		.shunt_voltage_max = 32000,	/* uV */
 	},
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
-		.calibration_value = 2048,
+		.calibration_factor = 5120,
+		.calibration_value_min = 2048,
 		.registers = INA226_REGISTERS,
 		.shunt_div = 400,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
 		.power_lsb_factor = 25,
+		.shunt_voltage_max = 81920,	/* uV */
 	},
 };
 
@@ -172,28 +217,92 @@ static u16 ina226_interval_to_reg(int interval)
 }
 
 /*
- * Calibration register is set to the best value, which eliminates
- * truncation errors on calculating current register in hardware.
- * According to datasheet (eq. 3) the best values are 2048 for
- * ina226 and 4096 for ina219. They are hardcoded as calibration_value.
+ * Update shunt resistor value and boundaries of maximum current
+ *
+ * The range of maximum current should be within two boundaries:
+ * -- upper <= maximum shunt voltage / shunt resistor value
+ * -- lower <= minimum current_lsb_uA and Equation 2
+ *             |_ minimum current_lsb_uA <= max calibration and Equation 1
  */
-static int ina2xx_calibrate(struct ina2xx_data *data)
+static int ina2xx_set_shunt(struct ina2xx_data *data, long rshunt)
 {
-	return regmap_write(data->regmap, INA2XX_CALIBRATION,
-			    data->config->calibration_value);
+	const struct ina2xx_config *config = data->config;
+	int shunt_voltage_max = config->shunt_voltage_max;
+	long current_lsb_uA_min;
+
+	if (rshunt <= 0)
+		return -EINVAL;
+
+	data->rshunt = rshunt;
+
+	/* Calculate upper limit of max current based on rshunt */
+	data->max_curr_upper = DIV_ROUND_CLOSEST_ULL(shunt_voltage_max * 1000,
+						     rshunt);
+
+	/* Calculate lower limit of max current from INA2XX_CALIBRATION_MAX */
+	current_lsb_uA_min = INA2XX_EQUATION_1_LSB(config->calibration_factor,
+					       INA2XX_CALIBRATION_MAX, rshunt);
+	data->max_curr_lower = INA2XX_EQUATION_2_MAX(current_lsb_uA_min);
+
+	return 0;
 }
 
 /*
- * Initialize the configuration and calibration registers.
+ * Calculate calibration value and configure it
+ *
+ * This function will truncate the calibration value with two boundaries
+ * so callers should not rely on it to do value validation but should do
+ * value check before calling this function.
  */
+static int ina2xx_calibrate(struct ina2xx_data *data)
+{
+	unsigned long cal;
+
+	cal = INA2XX_EQUATION_1_CAL(data->config->calibration_factor,
+				    data->current_lsb_uA, data->rshunt);
+	/*
+	 * Do not bounce an out-of-range value here as this function might
+	 * be called by ina2xx_store_shunt which reflects hardware design
+	 * over a software configuration. Besides, the out-of-range value
+	 * might be resulted from the rounding errors during calculations.
+	 *
+	 * So truncate calibration_value with the lower and upper bounds
+	 */
+	if (cal < data->config->calibration_value_min)
+		cal = data->config->calibration_value_min;
+	if (cal > INA2XX_CALIBRATION_MAX)
+		cal = INA2XX_CALIBRATION_MAX;
+
+	return regmap_write(data->regmap, INA2XX_CALIBRATION, cal);
+}
+
 static int ina2xx_init(struct ina2xx_data *data)
 {
-	int ret = regmap_write(data->regmap, INA2XX_CONFIG,
-			       data->config->config_default);
-	if (ret < 0)
-		return ret;
+	int calibration_factor = data->config->calibration_factor;
+	int cal_min = data->config->calibration_value_min;
+	int ret;
 
-	return ina2xx_calibrate(data);
+	mutex_lock(&data->config_lock);
+
+	/* Initialize current_lsb_uA and power_lsb_uW with cal_min */
+	if (data->current_lsb_uA == 0) {
+		data->current_lsb_uA = INA2XX_EQUATION_1_LSB(calibration_factor,
+							cal_min, data->rshunt);
+		data->power_lsb_uW = data->config->power_lsb_factor *
+				     data->current_lsb_uA;
+	}
+
+	/* Pass data->rshunt for validation and max_curr boundary calculation */
+	ret = ina2xx_set_shunt(data, data->rshunt);
+	if (ret)
+		goto out;
+
+	ret = ina2xx_calibrate(data);
+
+out:
+	mutex_unlock(&data->config_lock);
+
+	return ret;
 }
 
 static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
@@ -306,29 +415,6 @@ static ssize_t ina2xx_show_value(struct device *dev,
 			ina2xx_get_value(data, attr->index, regval));
 }
 
-/*
- * In order to keep calibration register value fixed, the product
- * of current_lsb and shunt_resistor should also be fixed and equal
- * to shunt_voltage_lsb = 1 / shunt_div multiplied by 10^9 in order
- * to keep the scale.
- */
-static int ina2xx_set_shunt(struct ina2xx_data *data, long val)
-{
-	unsigned int dividend = DIV_ROUND_CLOSEST(1000000000,
-						  data->config->shunt_div);
-	if (val <= 0 || val > dividend)
-		return -EINVAL;
-
-	mutex_lock(&data->config_lock);
-	data->rshunt = val;
-	data->current_lsb_uA = DIV_ROUND_CLOSEST(dividend, val);
-	data->power_lsb_uW = data->config->power_lsb_factor *
-			     data->current_lsb_uA;
-	mutex_unlock(&data->config_lock);
-
-	return 0;
-}
-
 static ssize_t ina2xx_show_shunt(struct device *dev,
 			      struct device_attribute *da,
 			      char *buf)
@@ -350,10 +436,67 @@ static ssize_t ina2xx_store_shunt(struct device *dev,
 	if (status < 0)
 		return status;
 
+	mutex_lock(&data->config_lock);
+
 	status = ina2xx_set_shunt(data, val);
 	if (status < 0)
-		return status;
-	return count;
+		goto out;
+
+	status = ina2xx_calibrate(data);
+
+out:
+	mutex_unlock(&data->config_lock);
+
+	return status ? status : count;
+}
+
+static ssize_t ina2xx_show_max_curr(struct device *dev,
+				    struct device_attribute *da, char *buf)
+{
+	struct ina2xx_data *data = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			INA2XX_EQUATION_2_MAX(data->current_lsb_uA));
+}
+
+static ssize_t ina2xx_store_max_curr(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
+{
+	struct ina2xx_data *data = dev_get_drvdata(dev);
+	const struct ina2xx_config *config = data->config;
+	unsigned long max_curr_mA;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &max_curr_mA);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Validate the max expected current value with two boundaries coming
+	 * from the shunt resistor value and valid range of calibration_value
+	 */
+	if (max_curr_mA < data->max_curr_lower ||
+	    max_curr_mA > data->max_curr_upper) {
+		dev_warn(dev, "max_curr out of range [%ld, %ld]\n",
+			 data->max_curr_lower, data->max_curr_upper);
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->config_lock);
+
+	/* max_curr_mA decides the current_lsb_uA directly */
+	data->current_lsb_uA = INA2XX_EQUATION_2_LSB(max_curr_mA);
+	data->power_lsb_uW = config->power_lsb_factor * data->current_lsb_uA;
+
+	ret = ina2xx_calibrate(data);
+
+	mutex_unlock(&data->config_lock);
+
+	dev_dbg(dev, "setting current_lsb_uA %ld, power_lsb_uW = %ld\n",
+		data->current_lsb_uA, data->power_lsb_uW);
+
+	return ret ? ret : count;
 }
 
 static ssize_t ina226_set_interval(struct device *dev,
@@ -415,6 +558,10 @@ static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
 			  ina2xx_show_shunt, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
 
+/* max expected current */
+static SENSOR_DEVICE_ATTR(max_curr, 0644,
+			  ina2xx_show_max_curr, ina2xx_store_max_curr, 0);
+
 /* update interval (ina226 only) */
 static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
 			  ina226_show_interval, ina226_set_interval, 0);
@@ -426,6 +573,7 @@ static struct attribute *ina2xx_attrs[] = {
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_power1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt_resistor.dev_attr.attr,
+	&sensor_dev_attr_max_curr.dev_attr.attr,
 	NULL,
 };
 
@@ -473,8 +621,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		else
 			val = INA2XX_RSHUNT_DEFAULT;
 	}
-
-	ina2xx_set_shunt(data, val);
+	data->rshunt = val;
 
 	ina2xx_regmap_config.max_register = data->config->registers;
 
-- 
2.17.1

