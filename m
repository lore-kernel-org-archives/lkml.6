Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497306-2-9677900723784998915
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES rocaen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497305; b=bt0HLb+G+LbKvO9VjZHaX1IEEIUwxWYCd1w+f+ggiSMUmGk
    M5WYWT1i85iTBjmwJvZ8teW2H0di2+Vwvx3YNUir6HD15jNseZhj10zmlzpFi/3u
    bbZbB4YrbLvHWWJgGDmllYQyU/ItJUCB5s16QZ06uzesom9cP7KDPskdYDg0x7oA
    x2xfQwnKAmtVMFQsc2KwplIm40RGzwl7I3Arqed69ZbUK3t+eCyO5IWCQnqGd9nM
    ls+ge/T3hT1ytyUPOpYBBypNDmToMXTeSyWr5PLRLjH33Ro62XufmmSwW3308m3a
    UME8ZJPMtt4J1/9uI042AnzMg+nIK6FYZsaCXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497305; bh=bB8//0
    79pp0fm/qfZ2M+WVLiH4nHNAgM52nbCMY8sig=; b=YGOESArLbox4/1WoItfJqN
    rulsFQw+UMW7Bv1jH6V4koMz+Xp7TWzgZbTNBl2HVT/c3P5090+6Wor82GWppfN9
    55+eMCHZgaKqlSAu9MrDB/F/IIwAU0rfnflbITtnGgplzkgx2Glywkd/mHJAMfHS
    PzRqqcqtrF3iTHaDv0m6Eg7lGp1cP3t69moDBxy1o17WDuog0V6pUjtNJJQ5kllj
    ik0M4X1kF9K4fYwOw+x+zBVDzegsP9JVHuN6Be2fwfLAIgFnQNkAzsDopW+8+yEl
    AlKbZ9HZ+ahoaAooTW2kqQEm2dhnA255ojyTwqtNEQ1Kyz+VZsemeQwtoh3X+/vw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L3vDc76/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleeinecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L3vDc76/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehleeinecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934319AbeCSWHm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:07:42 -0400
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:16544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934280AbeCSPzA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maciej Purski <m.purski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 25/97] hwmon: (ina2xx) Make calibration
 register value fixed
Thread-Topic: [PATCH AUTOSEL for 4.14 25/97] hwmon: (ina2xx) Make calibration
 register value fixed
Thread-Index: AQHTv5qhCmPYEmB77E2wdUkyrSeUrQ==
Date: Mon, 19 Mar 2018 15:54:57 +0000
Message-ID: <20180319155411.12348-25-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:XH+2opNjBQRUE3Kh0mD82OKhN24aSWQ7QxnndTwFWxKLQhaVARXAlgg52WtmOUewDE3b3oxvkRIeW8KRt53kvZXqO8CbwMK6VDmpBRR6bBwl7B4XVwzeRsj0X55VpyauDHQe7VV5T/5YG9GA4K7vJxqQucT7adG15gcG+oD3TkJGZgqH8pBuTXKPoLBCL91n4+zwIV4y1dI2s92y6cCjrH2ONa2kaj2IHxtLPznTHoO7lckjiT5jaiJJQR8GLKw/;20:SkM6uBjuoVEx7KFsy+FQg1qwTxGx4kwjHgR9zZOJKraoFhtve3SpSsPLHRDCUUiISzQ6Ee+tTEVXkFaDBBALCKApxj+4GXzjbv9xSeyTUIgZFVdoXUU8NrgJLfTG7F30oq8YTQZXQO/tFJHuSh7zDsGY5qC2dFRu09lJcWZnlFQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4140b8c8-e025-4bda-b6e2-08d58db1c3eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090388276E0B4FE40B08CDE7FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lXJCIcFeW+Y/oH5jJi/s7v1icTR8KNPXbv7aUnJ21wPD3+GKwKPnV/siWsEg63YfWecqN91r39DNuy6AnhwO4e7yS9TY39PjT7KXkPdzrdUwTUTdHYeQr3Y/w/XPwsvxn91nkRKbrlHNH6Zw8vVWT99qM2ceg9wYQn9y7bhYja1pOUswxyZOjwpH++R08jllWyVtiCkd4L5IlbZVhtpX7qmL/nX8VL9v4RyT9UAdKKywlvvTJ8mr9yzx4TaSuKUuwLmsz+K+Vl9mNfZlbS8mZAI0zVH0Pkm+eZqDFX+sKkFNWc7k6GD4RMNmlJo31c9r1Dwk8HtC7Krj80/eraS5rA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4140b8c8-e025-4bda-b6e2-08d58db1c3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:57.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maciej Purski <m.purski@samsung.com>

[ Upstream commit 5d389b125186cf254ad5b8015763ac07c151aea4 ]

Calibration register is used for calculating current register in
hardware according to datasheet:
current =3D shunt_volt * calib_register / 2048 (ina 226)
current =3D shunt_volt * calib_register / 4096 (ina 219)

Fix calib_register value to 2048 for ina226 and 4096 for ina 219 in
order to avoid truncation error and provide best precision allowed
by shunt_voltage measurement. Make current scale value follow changes
of shunt_resistor from sysfs as calib_register value is now fixed.

Power_lsb value should also follow shunt_resistor changes as stated in
datasheet:
power_lsb =3D 25 * current_lsb (ina 226)
power_lsb =3D 20 * current_lsb (ina 219)

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/ina2xx.c | 87 +++++++++++++++++++++++++++++-----------------=
----
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 62e38fa8cda2..e362a932fe8c 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -95,18 +95,20 @@ enum ina2xx_ids { ina219, ina226 };
=20
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
=20
 struct ina2xx_data {
 	const struct ina2xx_config *config;
=20
 	long rshunt;
+	long current_lsb_uA;
+	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
=20
@@ -116,21 +118,21 @@ struct ina2xx_data {
 static const struct ina2xx_config ina2xx_config[] =3D {
 	[ina219] =3D {
 		.config_default =3D INA219_CONFIG_DEFAULT,
-		.calibration_factor =3D 40960000,
+		.calibration_value =3D 4096,
 		.registers =3D INA219_REGISTERS,
 		.shunt_div =3D 100,
 		.bus_voltage_shift =3D 3,
 		.bus_voltage_lsb =3D 4000,
-		.power_lsb =3D 20000,
+		.power_lsb_factor =3D 20,
 	},
 	[ina226] =3D {
 		.config_default =3D INA226_CONFIG_DEFAULT,
-		.calibration_factor =3D 5120000,
+		.calibration_value =3D 2048,
 		.registers =3D INA226_REGISTERS,
 		.shunt_div =3D 400,
 		.bus_voltage_shift =3D 0,
 		.bus_voltage_lsb =3D 1250,
-		.power_lsb =3D 25000,
+		.power_lsb_factor =3D 25,
 	},
 };
=20
@@ -169,12 +171,16 @@ static u16 ina226_interval_to_reg(int interval)
 	return INA226_SHIFT_AVG(avg_bits);
 }
=20
+/*
+ * Calibration register is set to the best value, which eliminates
+ * truncation errors on calculating current register in hardware.
+ * According to datasheet (eq. 3) the best values are 2048 for
+ * ina226 and 4096 for ina219. They are hardcoded as calibration_value.
+ */
 static int ina2xx_calibrate(struct ina2xx_data *data)
 {
-	u16 val =3D DIV_ROUND_CLOSEST(data->config->calibration_factor,
-				    data->rshunt);
-
-	return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
+	return regmap_write(data->regmap, INA2XX_CALIBRATION,
+			    data->config->calibration_value);
 }
=20
 /*
@@ -187,10 +193,6 @@ static int ina2xx_init(struct ina2xx_data *data)
 	if (ret < 0)
 		return ret;
=20
-	/*
-	 * Set current LSB to 1mA, shunt is in uOhms
-	 * (equation 13 in datasheet).
-	 */
 	return ina2xx_calibrate(data);
 }
=20
@@ -268,15 +270,15 @@ static int ina2xx_get_value(struct ina2xx_data *data,=
 u8 reg,
 		val =3D DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_POWER:
-		val =3D regval * data->config->power_lsb;
+		val =3D regval * data->power_lsb_uW;
 		break;
 	case INA2XX_CURRENT:
-		/* signed register, LSB=3D1mA (selected), in mA */
-		val =3D (s16)regval;
+		/* signed register, result in mA */
+		val =3D regval * data->current_lsb_uA;
+		val =3D DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-		val =3D DIV_ROUND_CLOSEST(data->config->calibration_factor,
-					regval);
+		val =3D regval;
 		break;
 	default:
 		/* programmer goofed */
@@ -304,9 +306,32 @@ static ssize_t ina2xx_show_value(struct device *dev,
 			ina2xx_get_value(data, attr->index, regval));
 }
=20
-static ssize_t ina2xx_set_shunt(struct device *dev,
-				struct device_attribute *da,
-				const char *buf, size_t count)
+/*
+ * In order to keep calibration register value fixed, the product
+ * of current_lsb and shunt_resistor should also be fixed and equal
+ * to shunt_voltage_lsb =3D 1 / shunt_div multiplied by 10^9 in order
+ * to keep the scale.
+ */
+static int ina2xx_set_shunt(struct ina2xx_data *data, long val)
+{
+	unsigned int dividend =3D DIV_ROUND_CLOSEST(1000000000,
+						  data->config->shunt_div);
+	if (val <=3D 0 || val > dividend)
+		return -EINVAL;
+
+	mutex_lock(&data->config_lock);
+	data->rshunt =3D val;
+	data->current_lsb_uA =3D DIV_ROUND_CLOSEST(dividend, val);
+	data->power_lsb_uW =3D data->config->power_lsb_factor *
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
@@ -316,18 +341,9 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
 	if (status < 0)
 		return status;
=20
-	if (val =3D=3D 0 ||
-	    /* Values greater than the calibration factor make no sense. */
-	    val > data->config->calibration_factor)
-		return -EINVAL;
-
-	mutex_lock(&data->config_lock);
-	data->rshunt =3D val;
-	status =3D ina2xx_calibrate(data);
-	mutex_unlock(&data->config_lock);
+	status =3D ina2xx_set_shunt(data, val);
 	if (status < 0)
 		return status;
-
 	return count;
 }
=20
@@ -387,7 +403,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx=
_show_value, NULL,
=20
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_set_shunt,
+			  ina2xx_show_value, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
=20
 /* update interval (ina226 only) */
@@ -448,10 +464,7 @@ static int ina2xx_probe(struct i2c_client *client,
 			val =3D INA2XX_RSHUNT_DEFAULT;
 	}
=20
-	if (val <=3D 0 || val > data->config->calibration_factor)
-		return -ENODEV;
-
-	data->rshunt =3D val;
+	ina2xx_set_shunt(data, val);
=20
 	ina2xx_regmap_config.max_register =3D data->config->registers;
=20
--=20
2.14.1
