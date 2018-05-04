Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402442-2-6987491864883225385
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402440; b=XPwsw6kCi/ktpt7YtHjYqNEPyIEzR9cP5ClWKLw85KX72BDSi2
    T4Yyqrnu3Znpfq3iF0/YAAF1v/qPcBLhGlJ/+w7FHFy+3jY5EoGKAv43mLuWQuk4
    XFboDtfxGTfwpI47PJuNBoLCrEKLUkQF7s6/qAIFV0rRm4ofUi861x803SPp10cc
    MlNZqCm+nYnEAF/NMvcmq3XOiLTkqh3p+sxaSpCmEEinnJ2OhAWKf5+99oNolPXr
    xhqoEIQYbksmpWhlnpd0Jd+XBj2cRQGcZ0iaShK4YuPqkMdNSQoDtDxKeg5QhYNu
    AaoKEzE5LP47EFFz8YqpR9wYW2AJga84krWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402440; bh=kbZY6
    G1t5XqJrLeeF2iCtBaVG9xnNTNhoF8nlHDJW6A=; b=GryygUXfj8F0Um7G9TlTn
    ZV2XekYYWEkbJXVYN/MxzZyTdBZQMvs3mFgZeYGOwjBA9fHNgw8bVPEEBNB0GSjE
    9JyThzuT3lNf34WY/pMOWvZmmNNuV1gtguNr2fO3eClNLY5qJ8sdyT+jsqGk+cp5
    r7tO3/Gfsiim4GPyXDV8L5lpa4m+tvJXvjw8rf3H8aEqYdCNPROmXE8A5JVbEfyg
    8NpzU6vLp0LIuloZZNoCgvbOEm9y8p54ZuJWH4DIewwIRNxhvMXNmmU5lqcsPgPJ
    V7QvMbtAPccYeglu/JF66L6jqodfzXBECO6QDcYsegTPQl6EVnix49QJ58FOGxjT
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=JbeFVFAM
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=JbeFVFAM
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL0EaEI/UVS1zR8Yp6MW2nKEr2FUjg3zW7Jm2D1Sh6N+cthPOQRSoT9/yuzIkrwIcEINQG/+juF8s4N3i5kL7Xe4noqto6e3QSPC/bPVlxcqFsfhwfg+
    JUXs7chZAoVwhCqSAwnnqYr6Kzt6PE0rKxPEXNIHE94lFiHfyUq7paBWgn9g6CnZ9PXV16KrHygGgphP25ICnLnqNYys9P8DqbME25PCT3K7JxMsTk0K7ufp
    W0BJ3VcX3Sh7//GO8LP6RA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=8pif782wAAAA:8 a=tvE6cUz2AAAA:8
    a=DDOyTI_5AAAA:8 a=It-ul741W7PyzNwt_bAA:9 a=5OylR7l9CXzSC-0t:21
    a=pmGkbC2nWKk9MKBG:21 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 06/11] staging: iio: tsl2x7x: correct integration time and
 lux equation
Date: Thu,  3 May 2018 22:53:14 -0400
Message-Id: <20180504025319.28953-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 drew.paterson@ams.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The integration_time sysfs attribute did not report the correct
time. Changing the integration time would cause the reported lux to
change wildly. Once the integration time was corrected, all of the
equations, and lux tables needed to be corrected to match what the
data sheets expected. This patch corrects all of this, and adds some
more comments about how some of the constants were derived. Here are
the results from testing a TSL2772 hooked up to a Raspberry Pi 2:

# cat in_intensity0_integration_time
0.002730
# watch -n .1 cat in_illuminance0_input
; Lux hovers around 55
# echo 0.65 > in_intensity0_integration_time
# cat in_intensity0_integration_time
0.649740
# watch -n .1 cat in_illuminance0_input
; Lux hovers around 55 with noticeable lag to lux changes in watch
; process.

; Now test the ALS calibration routine.
# cat in_intensity0_calibbias
1000
# cat in_illuminance0_target_input
150
# echo 1 > in_illuminance0_calibrate
# cat in_intensity0_calibbias
2777
# watch -n .1 cat in_illuminance0_input
; Lux now hovers around 150-155

The returned lux values were tested on a TSL2772 in various lighting
conditions and the results are within the lux ranges described at
https://en.wikipedia.org/wiki/Lux.

The driver was primarily tested using a TSL2772, however some quick tests
were also ran against the devices TSL2771, TSL2572, and TMD2772.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 174 ++++++++++++++++--------------------
 drivers/staging/iio/light/tsl2x7x.h |   3 +-
 2 files changed, 79 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cf582a2e3633..9b32054713fb 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -148,7 +148,7 @@ struct tsl2X7X_chip {
 	struct tsl2x7x_als_info als_cur_info;
 	struct tsl2x7x_settings settings;
 	struct tsl2X7X_platform_data *pdata;
-	int als_time_scale;
+	int als_gain_time_scale;
 	int als_saturation;
 	int tsl2x7x_chip_status;
 	u8 tsl2x7x_config[TSL2X7X_MAX_CONFIG_REG];
@@ -163,29 +163,36 @@ struct tsl2X7X_chip {
 	struct tsl2x7x_lux tsl2x7x_device_lux[TSL2X7X_MAX_LUX_TABLE_SIZE];
 };
 
-/* Different devices require different coefficents */
+/*
+ * Different devices require different coefficents, and these numbers were
+ * derived from the 'Lux Equation' section of the various device datasheets.
+ * All of these coefficients assume a Glass Attenuation (GA) factor of 1.
+ * The coefficients are multiplied by 1000 to avoid floating point operations.
+ * The two rows in each table correspond to the Lux1 and Lux2 equations from
+ * the datasheets.
+ */
 static const struct tsl2x7x_lux tsl2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
-	{ 14461,   611,   1211 },
-	{ 18540,   352,    623 },
-	{     0,     0,      0 },
+	{ 53000, 106000 },
+	{ 31800,  53000 },
+	{ 0,          0 },
 };
 
 static const struct tsl2x7x_lux tmd2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
-	{ 11635,   115,    256 },
-	{ 15536,    87,    179 },
-	{     0,     0,      0 },
+	{ 24000,  48000 },
+	{ 14400,  24000 },
+	{ 0,          0 },
 };
 
 static const struct tsl2x7x_lux tsl2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
-	{ 14013,   466,   917 },
-	{ 18222,   310,   552 },
-	{     0,     0,     0 },
+	{ 60000, 112200 },
+	{ 37800,  60000 },
+	{     0,      0 },
 };
 
 static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
-	{ 13218,   130,   262 },
-	{ 17592,   92,    169 },
-	{     0,     0,     0 },
+	{ 20000,  35000 },
+	{ 12600,  20000 },
+	{     0,      0 },
 };
 
 static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
@@ -343,22 +350,18 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
  * @indio_dev:	pointer to IIO device
  *
  * The raw ch0 and ch1 values of the ambient light sensed in the last
- * integration cycle are read from the device. Time scale factor array values
- * are adjusted based on the integration time. The raw values are multiplied
- * by a scale factor, and device gain is obtained using gain index. Limit
- * checks are done next, then the ratio of a multiple of ch1 value, to the
- * ch0 value, is calculated. Array tsl2x7x_device_lux[] is then scanned to
- * find the first ratio value that is just above the ratio we just calculated.
- * The ch0 and ch1 multiplier constants in the array are then used along with
- * the time scale factor array values, to calculate the lux.
+ * integration cycle are read from the device. The raw values are multiplied
+ * by a device-specific scale factor, and divided by the integration time and
+ * device gain. The code supports multiple lux equations through the lux table
+ * coefficients. A lux gain trim is applied to each lux equation, and then the
+ * maximum lux within the interval 0..65535 is selected.
  */
 static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	struct tsl2x7x_lux *p;
-	u32 lux, ratio;
-	u64 lux64;
-	int ret;
+	int max_lux, ret;
+	bool overflow;
 
 	mutex_lock(&chip->als_mutex);
 
@@ -392,10 +395,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		goto out_unlock;
 	chip->als_cur_info.als_ch1 = ret;
 
-	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
-	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
-		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
-		goto return_max;
+	if (chip->als_cur_info.als_ch0 >= chip->als_saturation) {
+		max_lux = TSL2X7X_LUX_CALC_OVER_FLOW;
+		goto update_struct_with_max_lux;
 	}
 
 	if (!chip->als_cur_info.als_ch0) {
@@ -404,51 +406,38 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	/* calculate ratio */
-	ratio = (chip->als_cur_info.als_ch1 << 15) / chip->als_cur_info.als_ch0;
-
-	/* convert to unscaled lux using the pointer to the table */
-	p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux;
-	while (p->ratio != 0 && p->ratio < ratio)
-		p++;
+	max_lux = 0;
+	overflow = false;
+	for (p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux; p->ch0 != 0;
+	     p++) {
+		int lux;
+
+		lux = ((chip->als_cur_info.als_ch0 * p->ch0) -
+		       (chip->als_cur_info.als_ch1 * p->ch1)) /
+			chip->als_gain_time_scale;
+
+		/*
+		 * The als_gain_trim can have a value within the range 250..4000
+		 * and is a multiplier for the lux. A trim of 1000 makes no
+		 * changes to the lux, less than 1000 scales it down, and
+		 * greater than 1000 scales it up.
+		 */
+		lux = (lux * chip->settings.als_gain_trim) / 1000;
+
+		if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) {
+			overflow = true;
+			continue;
+		}
 
-	if (p->ratio == 0) {
-		lux = 0;
-	} else {
-		lux = DIV_ROUND_UP(chip->als_cur_info.als_ch0 * p->ch0,
-				   tsl2x7x_als_gain[chip->settings.als_gain]) -
-		      DIV_ROUND_UP(chip->als_cur_info.als_ch1 * p->ch1,
-				   tsl2x7x_als_gain[chip->settings.als_gain]);
+		max_lux = max(max_lux, lux);
 	}
 
-	/* adjust for active time scale */
-	if (chip->als_time_scale == 0)
-		lux = 0;
-	else
-		lux = (lux + (chip->als_time_scale >> 1)) /
-			chip->als_time_scale;
-
-	/*
-	 * adjust for active gain scale. The tsl2x7x_device_lux tables have a
-	 * factor of 256 built-in. User-specified gain provides a multiplier.
-	 * Apply user-specified gain before shifting right to retain precision.
-	 * Use 64 bits to avoid overflow on multiplication. Then go back to
-	 * 32 bits before division to avoid using div_u64().
-	 */
-
-	lux64 = lux;
-	lux64 = lux64 * chip->settings.als_gain_trim;
-	lux64 >>= 8;
-	lux = lux64;
-	lux = (lux + 500) / 1000;
+	if (overflow && max_lux == 0)
+		max_lux = TSL2X7X_LUX_CALC_OVER_FLOW;
 
-	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) /* check for overflow */
-		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
-
-	/* Update the structure with the latest lux. */
-return_max:
-	chip->als_cur_info.lux = lux;
-	ret = lux;
+update_struct_with_max_lux:
+	chip->als_cur_info.lux = max_lux;
+	ret = max_lux;
 
 out_unlock:
 	mutex_unlock(&chip->als_mutex);
@@ -525,7 +514,7 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
 		       sizeof(tsl2x7x_default_settings));
 
 	/* Load up the proper lux table. */
-	if (chip->pdata && chip->pdata->platform_lux_table[0].ratio != 0)
+	if (chip->pdata && chip->pdata->platform_lux_table[0].ch0 != 0)
 		memcpy(chip->tsl2x7x_device_lux,
 		       chip->pdata->platform_lux_table,
 		       sizeof(chip->pdata->platform_lux_table));
@@ -588,10 +577,11 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret, i, als_count, als_time;
+	int ret, i, als_count, als_time_us;
 	u8 *dev_reg, reg_val;
 
 	/* Non calculated parameters */
+	chip->tsl2x7x_config[TSL2X7X_ALS_TIME] = chip->settings.als_time;
 	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
 	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
 	chip->tsl2x7x_config[TSL2X7X_ALS_PRX_CONFIG] =
@@ -627,15 +617,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	/* determine als integration register */
-	als_count = (chip->settings.als_time * 100 + 135) / 270;
-	if (!als_count)
-		als_count = 1; /* ensure at least one cycle */
-
-	/* convert back to time (encompasses overrides) */
-	als_time = (als_count * 27 + 5) / 10;
-	chip->tsl2x7x_config[TSL2X7X_ALS_TIME] = 256 - als_count;
-
 	/* Set the gain based on tsl2x7x_settings struct */
 	chip->tsl2x7x_config[TSL2X7X_GAIN] =
 		(chip->settings.als_gain & 0xFF) |
@@ -643,9 +624,12 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		(chip->settings.prox_diode << 4) |
 		(chip->settings.prox_power << 6);
 
-	/* set chip struct re scaling and saturation */
-	chip->als_saturation = als_count * 922; /* 90% of full scale */
-	chip->als_time_scale = (als_time + 25) / 50;
+	/* set chip time scaling and saturation */
+	als_count = 256 - chip->settings.als_time;
+	als_time_us = als_count * 2720;
+	chip->als_saturation = als_count * 768; /* 75% of full scale */
+	chip->als_gain_time_scale = als_time_us *
+		tsl2x7x_als_gain[chip->settings.als_gain];
 
 	/*
 	 * TSL2X7X Specific power-on / adc enable sequence
@@ -843,11 +827,10 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
-			chip->tsl2x7x_device_lux[i].ratio,
+		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
 			chip->tsl2x7x_device_lux[i].ch0,
 			chip->tsl2x7x_device_lux[i].ch1);
-		if (chip->tsl2x7x_device_lux[i].ratio == 0) {
+		if (chip->tsl2x7x_device_lux[i].ch0 == 0) {
 			/*
 			 * We just printed the first "0" entry.
 			 * Now get rid of the extra "," and break.
@@ -868,7 +851,7 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int value[ARRAY_SIZE(chip->tsl2x7x_device_lux) * 3 + 1];
+	int value[ARRAY_SIZE(chip->tsl2x7x_device_lux) * 2 + 1];
 	int n, ret;
 
 	get_options(buf, ARRAY_SIZE(value), value);
@@ -876,15 +859,15 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 	/*
 	 * We now have an array of ints starting at value[1], and
 	 * enumerated by value[0].
-	 * We expect each group of three ints is one table entry,
+	 * We expect each group of two ints to be one table entry,
 	 * and the last table entry is all 0.
 	 */
 	n = value[0];
-	if ((n % 3) || n < 6 ||
-	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3))
+	if ((n % 2) || n < 4 ||
+	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 2))
 		return -EINVAL;
 
-	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0)
+	if ((value[(n - 1)] | value[n]) != 0)
 		return -EINVAL;
 
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
@@ -1140,8 +1123,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		*val = (TSL2X7X_MAX_TIMER_CNT - chip->settings.als_time) + 1;
-		*val2 = ((*val * TSL2X7X_MIN_ITIME) % 1000) / 1000;
+		*val = 0;
+		*val2 = (256 - chip->settings.als_time) * 2720;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
@@ -1201,8 +1184,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		chip->settings.als_gain_trim = val;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		chip->settings.als_time =
-			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
+		chip->settings.als_time = 256 - (val2 / 2720);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 8eb7f4749ea7..1097ee890ce2 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -10,13 +10,12 @@
 #define __TSL2X7X_H
 
 struct tsl2x7x_lux {
-	unsigned int ratio;
 	unsigned int ch0;
 	unsigned int ch1;
 };
 
 /* Max number of segments allowable in LUX table */
-#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
+#define TSL2X7X_MAX_LUX_TABLE_SIZE		6
 /* The default LUX tables all have 3 elements.  */
 #define TSL2X7X_DEF_LUX_TABLE_SZ		3
 #define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
