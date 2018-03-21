Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628180-2-2101619159881687322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES encada, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628179; b=NVAFFAIDZvIxHnciVEsxvD/XKm/qORYcLxQ+wPwfz0/Sg8+
    DTaIH/m3fFh0FyLEEckI0T4qcYzUcgCF9DqAJax2UR9HZRTD0HKlmHtEplkhtVaa
    62OW3C5LfJD/NiytW9l+NwBU9uMLXP1gSWvWTuQ0AgMxA6kVooMg+8ZKtwEw72Mv
    SVTHmlVFAZpjdOek7J9Uo63vVkVGCjs6GAzYxqTuUA12AaQrhCH9K2/9hSFP9hV0
    XHlm8QBeHDOqGBOknkQsO+sfJCTFxVGJcJNnrpHpGmVj0jgld+d0Db3paASZjEoD
    k2gOB1g/RP0ctD2/sPka4k7SYLFQEK+vlHwMCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628179; bh=w
    O3WT+e0p/Imq+tlBnQZSw7hz3NjU1a2SvUp+CDsVKE=; b=wpYlHKFnX6JLyH6qM
    yXQgP56cWGeytfpyIr4C99gwHVt0ytkKGP9OAbajBSb0s09EdwvGk0uG4c6zaPoX
    wQYGoPcnV3pA0Mxa4NCFc6IZLVOA/nXsqTVAaQgQze7FofOUfMlKDavK4pYu+rnb
    mxBY46yeFxpo9sXzrf4qbSTZVSQchFd0aA0OaKBVbWwzuXLaui6b/LkIY88w2DpW
    Ng8EXB1k5oPv8wFcXPLjEwy5Hr+CLpLIlyndDp3EPTYGB6BETrECqcQDh0VGTUjE
    fhb5Wshx3ZtvbxwJha9sM1utzb5fFsF/+JFHuZ3O3FbGgQLXMHgl1UIhZX3DV9uH
    87L2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=EuRJLxSf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=EuRJLxSf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 05/11] staging: iio: tsl2x7x: split out als and prox interrupt
 settings
Date: Wed, 21 Mar 2018 06:29:06 -0400
Message-Id: <20180321102912.5130-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
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
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The struct tsl2x7x_settings contained an interrupts_en member that was
a bitmask for which interrupts are enabled. This required having
bitmasks in several parts of the code. This patch splits this field
out into two booleans to remove most of the bitmasks in the code.

This patch also fixes a bug where if an interrupt pin was configured,
but proximity interrupts were disabled, then the proximity value could
not be polled.

This patch also removes an unnecessary second call to writing the
control register in tsl2x7x_chip_on().

Driver tested using a TSL2772 hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 64 ++++++++++++-------------------------
 drivers/staging/iio/light/tsl2x7x.h |  7 ++--
 2 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 99230d9313e1..f7e7fcc17059 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -226,10 +226,11 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.prox_config = 0,
 	.als_gain_trim = 1000,
 	.als_cal_target = 150,
+	.als_interrupt_en = false,
 	.als_thresh_low = 200,
 	.als_thresh_high = 256,
 	.persistence = 255,
-	.interrupts_en = 0,
+	.prox_interrupt_en = false,
 	.prox_thres_low  = 0,
 	.prox_thres_high = 512,
 	.prox_max_samples_cal = 30,
@@ -686,37 +687,22 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	/* Power-on settling time */
 	usleep_range(3000, 3500);
 
-	/*
-	 * NOW enable the ADC
-	 * initialize the desired mode of operation
-	 */
-	ret = tsl2x7x_write_control_reg(chip,
-					TSL2X7X_CNTL_PWR_ON |
-					TSL2X7X_CNTL_ADC_ENBL |
-					TSL2X7X_CNTL_PROX_DET_ENBL);
+	reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL |
+		  TSL2X7X_CNTL_PROX_DET_ENBL;
+	if (chip->settings.als_interrupt_en)
+		reg_val |= TSL2X7X_CNTL_ALS_INT_ENBL;
+	if (chip->settings.prox_interrupt_en)
+		reg_val |= TSL2X7X_CNTL_PROX_INT_ENBL;
+
+	ret = tsl2x7x_write_control_reg(chip, reg_val);
 	if (ret < 0)
 		return ret;
 
-	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
-
-	if (chip->settings.interrupts_en != 0) {
-		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
-
-		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
-		if (chip->settings.interrupts_en == 0x20 ||
-		    chip->settings.interrupts_en == 0x30)
-			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
-
-		reg_val |= chip->settings.interrupts_en;
-		ret = tsl2x7x_write_control_reg(chip, reg_val);
-		if (ret < 0)
-			return ret;
+	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
+	if (ret < 0)
+		return ret;
 
-		ret = tsl2x7x_clear_interrupts(chip,
-					       TSL2X7X_CMD_PROXALS_INT_CLR);
-		if (ret < 0)
-			return ret;
-	}
+	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
 
 	return ret;
 }
@@ -978,14 +964,11 @@ static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
 					 enum iio_event_direction dir)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type == IIO_INTENSITY)
-		ret = !!(chip->settings.interrupts_en & 0x10);
+		return chip->settings.als_interrupt_en;
 	else
-		ret = !!(chip->settings.interrupts_en & 0x20);
-
-	return ret;
+		return chip->settings.prox_interrupt_en;
 }
 
 static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
@@ -997,17 +980,10 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	if (chan->type == IIO_INTENSITY) {
-		if (val)
-			chip->settings.interrupts_en |= 0x10;
-		else
-			chip->settings.interrupts_en &= 0x20;
-	} else {
-		if (val)
-			chip->settings.interrupts_en |= 0x20;
-		else
-			chip->settings.interrupts_en &= 0x10;
-	}
+	if (chan->type == IIO_INTENSITY)
+		chip->settings.als_interrupt_en = val ? true : false;
+	else
+		chip->settings.prox_interrupt_en = val ? true : false;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 28b0e7fdc9b8..b2aa642299b3 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -50,12 +50,12 @@ struct tsl2x7x_lux {
  *  @prox_config:           Prox configuration filters.
  *  @als_cal_target:        Known external ALS reading for
  *                          calibration.
- *  @interrupts_en:         Enable/Disable - 0x00 = none, 0x10 = als,
- *                                           0x20 = prx,  0x30 = bth
  *  @persistence:           H/W Filters, Number of 'out of limits'
  *                          ADC readings PRX/ALS.
+ *  @als_interrupt_en:      Enable/Disable ALS interrupts
  *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
  *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
+ *  @prox_interrupt_en:     Enable/Disable proximity interrupts
  *  @prox_thres_low:        Low threshold proximity detection.
  *  @prox_thres_high:       High threshold proximity detection
  *  @prox_pulse_count:      Number if proximity emitter pulses
@@ -70,10 +70,11 @@ struct tsl2x7x_settings {
 	int prox_gain;
 	int prox_config;
 	int als_cal_target;
-	u8  interrupts_en;
 	u8  persistence;
+	bool als_interrupt_en;
 	int als_thresh_low;
 	int als_thresh_high;
+	bool prox_interrupt_en;
 	int prox_thres_low;
 	int prox_thres_high;
 	int prox_pulse_count;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
