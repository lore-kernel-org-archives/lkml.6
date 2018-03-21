Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628180-5-18316870497987030488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628179; b=TZBRKGlCIOjK99SMjUoIWeMFZkKklmzIjcEMABSKAFsst8i
    Jla/+7TtDAx5oKglkvE2lcrsJttl94V0S2w6wzZftzzT6r3/QZKgeto+n13J+SnG
    sln8pBHtiFmQ0odcRPVPSsmakz15bD1IWjZEHZ28/ORUq5BuRhXHX2cCJH8kiSFX
    nlVHLZpxhqQSbHao7g0NEtKyZw8M8HdTu8TjTNhMCQ0Z5/Cxv72p06YNFJd6J+78
    GuhpvJhCH7Qij+0mh49/ThflIOMhqCyn7p90XSFD2f53ihdw8M6DS4bVgrd7CEcU
    80a7uuGtNuAZ84qhkJQB+MyW9PHiGZZ7dUtYVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628179; bh=L
    Va6NzjcJB5Rm294BnS3luZbW8ttWBNVdErvfCQkyIM=; b=ISlYnHZN1C+aCIGGt
    WJS2/pBNjhI9z9uJexFw+Y+6zeUV+743QB0d4VtF/RHFEU4YkNSbpfjnkBChbyfF
    ksQRyNnjzMYcYateWwS1cbj3z/8FZ+2guL5y6YTR3xSC5SMMeVQOZ3XqxsZgSgu7
    BBTe9lEsAHtFiRsvIicEHeYUqahOcqBxiZ7qHEdYar8CYeW8AKgvnRl4ojNEiQyz
    XptpZFeo+wH81KUxvWz1i/KoA7tM4Qtkj4HDg5DeA65r1zqestGBJMqdZS34cfSS
    SiJwjyaOnBn0EyuDnMivSJmbsFRJFJGnJDSg/twtwEXNJZ69gaYYoHCLXLZKJMyC
    xnRjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=AEK2Dq62 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=AEK2Dq62 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 04/11] staging: iio: tsl2x7x: simplify tsl2x7x_prox_cal()
Date: Wed, 21 Mar 2018 06:29:05 -0400
Message-Id: <20180321102912.5130-5-masneyb@onstation.org>
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

tsl2x7x_prox_cal() would set the interrupt flag, and reset the device to
start doing the calibration routine. However, this did not actually
affect the readings since they are polled. This patch drops the interrupt
code.

This patch also drops the function tsl2x7x_prox_calculate() and removes
support for the standard deviation and min sample since those values
were not used.

Driver was tested using a TSL2772 hooked up to a Raspberry Pi 2. I
performed the following testing at various distances:

- Put hand in front of sensor and keep the sensor and hand stationary.
- Perform calibration routine.
- Run iio_event_monitor.
- Verify that a proximity event is triggered when my hand comes
  anywhere between the sensor and where I performed the calibration
  routine.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 107 +++++-------------------------------
 1 file changed, 15 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9c929e273135..99230d9313e1 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -149,13 +149,6 @@ struct tsl2x7x_als_info {
 	u16 lux;
 };
 
-struct tsl2x7x_prox_stat {
-	int min;
-	int max;
-	int mean;
-	unsigned long stddev;
-};
-
 struct tsl2x7x_chip_info {
 	int chan_table_elements;
 	struct iio_chan_spec		channel[4];
@@ -771,106 +764,36 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static void tsl2x7x_prox_calculate(int *data, int length,
-				   struct tsl2x7x_prox_stat *stat)
-{
-	int i;
-	int sample_sum;
-	int tmp;
-
-	if (!length)
-		length = 1;
-
-	sample_sum = 0;
-	stat->min = INT_MAX;
-	stat->max = INT_MIN;
-	for (i = 0; i < length; i++) {
-		sample_sum += data[i];
-		stat->min = min(stat->min, data[i]);
-		stat->max = max(stat->max, data[i]);
-	}
-
-	stat->mean = sample_sum / length;
-	sample_sum = 0;
-	for (i = 0; i < length; i++) {
-		tmp = data[i] - stat->mean;
-		sample_sum += tmp * tmp;
-	}
-	stat->stddev = int_sqrt((long)sample_sum / length);
-}
-
-/**
- * tsl2x7x_prox_cal() - Calculates std. and sets thresholds.
- * @indio_dev:	pointer to IIO device
- *
- * Calculates a standard deviation based on the samples,
- * and sets the threshold accordingly.
- */
 static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 {
-	int prox_history[MAX_SAMPLES_CAL + 1];
-	int i, ret;
-	struct tsl2x7x_prox_stat prox_stat_data[2];
-	struct tsl2x7x_prox_stat *cal;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	u8 tmp_irq_settings;
-	u8 current_state = chip->tsl2x7x_chip_status;
-
-	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
-		dev_err(&chip->client->dev,
-			"max prox samples cal is too big: %d\n",
-			chip->settings.prox_max_samples_cal);
-		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
-	}
-
-	/* have to stop to change settings */
-	ret = tsl2x7x_chip_off(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	/* Enable proximity detection save just in case prox not wanted yet*/
-	tmp_irq_settings = chip->settings.interrupts_en;
-	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
+	int prox_history[MAX_SAMPLES_CAL + 1];
+	int i, ret, mean, max, sample_sum;
 
-	/*turn on device if not already on*/
-	ret = tsl2x7x_chip_on(indio_dev);
-	if (ret < 0)
-		return ret;
+	if (chip->settings.prox_max_samples_cal < 1 ||
+	    chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL)
+		return -EINVAL;
 
-	/*gather the samples*/
 	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
 		usleep_range(15000, 17500);
 		ret = tsl2x7x_get_prox(indio_dev);
 		if (ret < 0)
 			return ret;
+
 		prox_history[i] = chip->prox_data;
-		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
-			 i, chip->prox_data);
 	}
 
-	ret = tsl2x7x_chip_off(indio_dev);
-	if (ret < 0)
-		return ret;
-	cal = &prox_stat_data[PROX_STAT_CAL];
-	tsl2x7x_prox_calculate(prox_history,
-			       chip->settings.prox_max_samples_cal, cal);
-	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
-
-	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
-		 cal->min, cal->mean, cal->max);
-	dev_info(&chip->client->dev,
-		 "%s proximity threshold set to %d\n",
-		 chip->client->name, chip->settings.prox_thres_high);
-
-	/* back to the way they were */
-	chip->settings.interrupts_en = tmp_irq_settings;
-	if (current_state == TSL2X7X_CHIP_WORKING) {
-		ret = tsl2x7x_chip_on(indio_dev);
-		if (ret < 0)
-			return ret;
+	sample_sum = 0;
+	max = INT_MIN;
+	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
+		sample_sum += prox_history[i];
+		max = max(max, prox_history[i]);
 	}
+	mean = sample_sum / chip->settings.prox_max_samples_cal;
 
-	return 0;
+	chip->settings.prox_thres_high = (max << 1) - mean;
+
+	return tsl2x7x_invoke_change(indio_dev);
 }
 
 static ssize_t
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
