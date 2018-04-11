Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479466-2-2959542272102774586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rocaen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479465; b=WetzCMzigIhNC31ruudRY4gUKNlQbZfPuJ/n6/FG6teDuw1m1T
    on4mAxFFNMk5wDhVc8lYbRyCIGtTlIwQmsfw1pfi3FSK5YduQDHamlgiUjOE120Z
    EO5KWjdkGVb2qA9dX5AjY3F38ESy7sfD7eYefMaCz5Dl6ThsDRmidJkdw57LbFyV
    I1A8m590+EZLWqhiKT6k13RcXANJSWBVj2kb0O/OyehVoJuYnbZLlames6tUd+Gb
    1KFXQxnqDHaJnlwqAJwBoAPUW3BFNk3ee44pr66VpOUw7Oh1FsLaJ8hNsoWw6JTD
    Jw+7oAtWLnr804uFTJ4IIC2XscBNAnUAo2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479465; bh=WtMCJGwCH1gxcMVd4DXxmHaRjh+Eot
    vL5hPNYGnUm9U=; b=eEbOgylboAc6Q4D4AF+lH3Irtm18rm3kn40ZZLCbubOZU8
    uHRDY0PsgQTukDZpjAamUhPX65v96moTtkkIR1OnwJMrCgD+nlZ5cn2huMwx237/
    Tn2JwpMds1TC/r9Vjykzpd6C0DmP8AH/mIH3wlkRLZqI9qp4hVBeFlhb70ski6pM
    hSmTnE3vX8A17Ye6fTJPCB+K3KFiIUfRGQanutBFd/RdY/5r77+48hLbpy/wqI1g
    8fZ44PSD/y8OAOeec3Tiy4NnJerNoSc+P5m2e9IkDHDQjjgEvG2RZPGL1DBg1pTu
    jiufsBn3TUpWRH5Mm8noOlJ2KGRP5xmlvuUMHGlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLmQD024Nish6W87iXXy2ZpVyXX2QPjcGEAAFwTil1dAhvr04BhT38Qg0d/ZW1Zz8TFjmpvYGTn3ZfUSDSsio+JokXqEimUXho8U9r00DkfD7KNivEA
    q63HYRe+6RxU+wyCKC09EcMmoTZspU448tSkQXMZzzb68WJi1MK8Rl1O6wyuZiFthlFEvWCmFkKD5mNFQ6PHG5SJ9ldzSyoZuAyniZhNulShiki9pFxlpinL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=9MQAw0Xb0rqwkDRvbBMA:9 a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbeDKSrT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeDKSrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maciej Purski <m.purski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 086/190] hwmon: (ina2xx) Make calibration register value fixed
Date: Wed, 11 Apr 2018 20:35:32 +0200
Message-Id: <20180411183555.643374763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Purski <m.purski@samsung.com>


[ Upstream commit 5d389b125186cf254ad5b8015763ac07c151aea4 ]

Calibration register is used for calculating current register in
hardware according to datasheet:
current = shunt_volt * calib_register / 2048 (ina 226)
current = shunt_volt * calib_register / 4096 (ina 219)

Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
order to avoid truncation error and provide best precision allowed
by shunt_voltage measurement. Make current scale value follow changes
of shunt_resistor from sysfs as calib_register value is now fixed.

Power_lsb value should also follow shunt_resistor changes as stated in
datasheet:
power_lsb = 25 * current_lsb (ina 226)
power_lsb = 20 * current_lsb (ina 219)

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/ina2xx.c |   87 ++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -94,18 +94,20 @@ enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
 	u16 config_default;
-	int calibration_factor;
+	int calibration_value;
 	int registers;
 	int shunt_div;
 	int bus_voltage_shift;
 	int bus_voltage_lsb;	/* uV */
-	int power_lsb;		/* uW */
+	int power_lsb_factor;
 };
 
 struct ina2xx_data {
 	const struct ina2xx_config *config;
 
 	long rshunt;
+	long current_lsb_uA;
+	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
 
@@ -115,21 +117,21 @@ struct ina2xx_data {
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
 		.config_default = INA219_CONFIG_DEFAULT,
-		.calibration_factor = 40960000,
+		.calibration_value = 4096,
 		.registers = INA219_REGISTERS,
 		.shunt_div = 100,
 		.bus_voltage_shift = 3,
 		.bus_voltage_lsb = 4000,
-		.power_lsb = 20000,
+		.power_lsb_factor = 20,
 	},
 	[ina226] = {
 		.config_default = INA226_CONFIG_DEFAULT,
-		.calibration_factor = 5120000,
+		.calibration_value = 2048,
 		.registers = INA226_REGISTERS,
 		.shunt_div = 400,
 		.bus_voltage_shift = 0,
 		.bus_voltage_lsb = 1250,
-		.power_lsb = 25000,
+		.power_lsb_factor = 25,
 	},
 };
 
@@ -168,12 +170,16 @@ static u16 ina226_interval_to_reg(int in
 	return INA226_SHIFT_AVG(avg_bits);
 }
 
+/*
+ * Calibration register is set to the best value, which eliminates
+ * truncation errors on calculating current register in hardware.
+ * According to datasheet (eq. 3) the best values are 2048 for
+ * ina226 and 4096 for ina219. They are hardcoded as calibration_value.
+ */
 static int ina2xx_calibrate(struct ina2xx_data *data)
 {
-	u16 val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
-				    data->rshunt);
-
-	return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
+	return regmap_write(data->regmap, INA2XX_CALIBRATION,
+			    data->config->calibration_value);
 }
 
 /*
@@ -186,10 +192,6 @@ static int ina2xx_init(struct ina2xx_dat
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Set current LSB to 1mA, shunt is in uOhms
-	 * (equation 13 in datasheet).
-	 */
 	return ina2xx_calibrate(data);
 }
 
@@ -267,15 +269,15 @@ static int ina2xx_get_value(struct ina2x
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_POWER:
-		val = regval * data->config->power_lsb;
+		val = regval * data->power_lsb_uW;
 		break;
 	case INA2XX_CURRENT:
-		/* signed register, LSB=1mA (selected), in mA */
-		val = (s16)regval;
+		/* signed register, result in mA */
+		val = regval * data->current_lsb_uA;
+		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-		val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
-					regval);
+		val = regval;
 		break;
 	default:
 		/* programmer goofed */
@@ -303,9 +305,32 @@ static ssize_t ina2xx_show_value(struct
 			ina2xx_get_value(data, attr->index, regval));
 }
 
-static ssize_t ina2xx_set_shunt(struct device *dev,
-				struct device_attribute *da,
-				const char *buf, size_t count)
+/*
+ * In order to keep calibration register value fixed, the product
+ * of current_lsb and shunt_resistor should also be fixed and equal
+ * to shunt_voltage_lsb = 1 / shunt_div multiplied by 10^9 in order
+ * to keep the scale.
+ */
+static int ina2xx_set_shunt(struct ina2xx_data *data, long val)
+{
+	unsigned int dividend = DIV_ROUND_CLOSEST(1000000000,
+						  data->config->shunt_div);
+	if (val <= 0 || val > dividend)
+		return -EINVAL;
+
+	mutex_lock(&data->config_lock);
+	data->rshunt = val;
+	data->current_lsb_uA = DIV_ROUND_CLOSEST(dividend, val);
+	data->power_lsb_uW = data->config->power_lsb_factor *
+			     data->current_lsb_uA;
+	mutex_unlock(&data->config_lock);
+
+	return 0;
+}
+
+static ssize_t ina2xx_store_shunt(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
 {
 	unsigned long val;
 	int status;
@@ -315,18 +340,9 @@ static ssize_t ina2xx_set_shunt(struct d
 	if (status < 0)
 		return status;
 
-	if (val == 0 ||
-	    /* Values greater than the calibration factor make no sense. */
-	    val > data->config->calibration_factor)
-		return -EINVAL;
-
-	mutex_lock(&data->config_lock);
-	data->rshunt = val;
-	status = ina2xx_calibrate(data);
-	mutex_unlock(&data->config_lock);
+	status = ina2xx_set_shunt(data, val);
 	if (status < 0)
 		return status;
-
 	return count;
 }
 
@@ -386,7 +402,7 @@ static SENSOR_DEVICE_ATTR(power1_input,
 
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_set_shunt,
+			  ina2xx_show_value, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
 
 /* update interval (ina226 only) */
@@ -441,10 +457,7 @@ static int ina2xx_probe(struct i2c_clien
 			val = INA2XX_RSHUNT_DEFAULT;
 	}
 
-	if (val <= 0 || val > data->config->calibration_factor)
-		return -ENODEV;
-
-	data->rshunt = val;
+	ina2xx_set_shunt(data, val);
 
 	ina2xx_regmap_config.max_register = data->config->registers;
 
