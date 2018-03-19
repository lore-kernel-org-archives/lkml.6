Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494044-2-16112881548186672276
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
    t=1521494043; b=HRA8fDd/oQ3GSjX+D++514Wi/nDXppnUwpCyvM6WWA5K5NF
    W/TbfdG06WXlCSFGlMSJviAOcfN4AnxKEArtXBes/zhfAqK4hbap56QuzrL/DLWD
    V1vdSTzEPy9EEVoIK+Qw9lM6mpbWMQIeES+L4lMnrI0eU5rFGtn6iJ42gjr756BB
    RjM7GsqOTpX7v3Ita3HRJoihy0sRxSvJ3wHpLWEs9WNwpJTltNwY4DC6XbtqLP15
    6KTswpjGMeQ5B7sITQ8Zb6aLG1zDZEHzpEDdQRcGkAatMa3cmJTP4knlvFUJtl0z
    yUePcc1WkdUPmtf9gWnm9R0863Ag99MIqkyBovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494043; bh=LjQdGe
    HufexL/2fxsCOVXEzoOQwTt+SKkv9dvHCfsp8=; b=L9EA5iDEu4jjVKCLHB+sBV
    k1pY5uCmPMkygNBI9+WVXHRYNkwJADRmSUW7N6G4fpXsCF1Xah2x61aiU8ZdmDcN
    F3KqbjmTwjBrvET2VlF8MKUAgio2MlwWQkrHLUmhwEiteEtVyg5o56+O6eJUewqW
    4aL2SyPF4PaytOgPtNkTYP/mRqPFxlWdMJdoZDvm2kkSDsUBOcCvtiCKEX1m7gll
    d9TzQ8fxC064Jfl4Nya4yRsZqK1ByeZnAM4E28NJ75QKRGzlAw5PuN7sp0d4xbwV
    4rQgo1WJ03UFkbH9xZsy92FkVHsUxttZPAPdB2HmDvHzeMpdgWvOoY8g34SHc/sw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H8f6wwyw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehiedvnecuvehluhhsthgvrhfuihiivgepgedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H8f6wwyw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdehiedvnecuvehluhhsthgvrhfuihiivgepgedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965478AbeCSVL4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:11:56 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933644AbeCSQBv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maciej Purski <m.purski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 132/281] hwmon: (ina2xx) Make calibration
 register value fixed
Thread-Topic: [PATCH AUTOSEL for 4.9 132/281] hwmon: (ina2xx) Make calibration
 register value fixed
Thread-Index: AQHTv5tnY1QlTp2wi0G9R6CkuvKQBg==
Date: Mon, 19 Mar 2018 16:00:29 +0000
Message-ID: <20180319155742.13731-132-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:x4GgqYAFpAxRPLPfyc6nT1ltGXIQCh4ROW5kQ9cb/cHoxswO00RhTPXyx4Xhl9Y5gT19WhCDu3rc2xZ5cT3rLR8AnA5xO3NqWpQfRIYmmR8HqZFPXBS0hw28TlK5DX/S8JOkeIlNJmPQgQYF9lX3echGPfOD/CbxGrfP1nKJbPlTOEO6Yp/9XqzRIPwXtFQO9rlvu2hLmVLptQP+NajVMTgXYGGSovgT4yK7VCiZZyq+KJRlxtXAoYFYTyA6bCba;20:kgM+eASy0Nf08Ey6I3Q0qc9WXqh59hlbuuz/DdTvt7hbiUTwCf/Mvhr1gkxLW/sFNm6bM4wVxZeiSAwCHxvw8/vn8/brtgzhZiUsToJ9/TpKTRKdyKXdYqFZP7rf1h632Yp+PetlJqBBUwMqPClpc4q+v7y80+0zDR49CKZ7HhM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f37d0b5-975f-4cb9-5536-08d58db2b7d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919423917EEB3365F495031FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: a0eqg4GTpDLrffc0c7sXLKeoqILCG/jDBof47mWjaBFVaVUAP78NzXRwMLVuULv6PCzVeYtSP5+On1/am7Kv+CeaeVXSkUFh4rz4ZMPhINyinhrrEFKkoC6+pmXE18w5uncEnqlbtQbpQrRH5LeUcu6+kgOAcFWFXS/HaiJ2fJS2NRRfJjv9r4YjgaFpwPn352zb94OrIiukdBNTVPEpqKAZhoABIQI9dKyPpa9LzDTp+a7Q5SYjlzVUPNoJj/tPtVyiTkYU+2FzRZSp4uTFApyhoJdseL6Y4whQU7JBOJVGg0Be1FjJNDjdvTyi0XvF9YH1JgAErKAq+Hvz36bbOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f37d0b5-975f-4cb9-5536-08d58db2b7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:29.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index b24f1d3045f0..a629f7c130f0 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -94,18 +94,20 @@ enum ina2xx_ids { ina219, ina226 };
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
@@ -115,21 +117,21 @@ struct ina2xx_data {
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
@@ -168,12 +170,16 @@ static u16 ina226_interval_to_reg(int interval)
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
@@ -186,10 +192,6 @@ static int ina2xx_init(struct ina2xx_data *data)
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
@@ -267,15 +269,15 @@ static int ina2xx_get_value(struct ina2xx_data *data,=
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
@@ -303,9 +305,32 @@ static ssize_t ina2xx_show_value(struct device *dev,
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
@@ -315,18 +340,9 @@ static ssize_t ina2xx_set_shunt(struct device *dev,
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
@@ -386,7 +402,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx=
_show_value, NULL,
=20
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_set_shunt,
+			  ina2xx_show_value, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
=20
 /* update interval (ina226 only) */
@@ -441,10 +457,7 @@ static int ina2xx_probe(struct i2c_client *client,
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
