Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628179-2-3837630584803913995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628178; b=QRxBLKqLldu4egFzykIxZmMBYq+xy5mUS3pIwDWc45yRF+z
    R5mYPgw6PW0o6BEniOocKVfSD/RFXVkz4ajU4ayLATJ86pAe1Vi6/cDUEDEway0I
    5MB7cMGucGFEeIz8e7V3EP/NlIRP8i5sAWD//rzBhy/r6tQ+2MOk6qr7Qd1QWbm6
    wLaH8KAEHwuAjp+DOxXL5Ynm7LkL8/KtqK+549E4u9aaZ3xXeawFSV3f41/WRvVo
    wK0BX5+IwJb0DkUQezYQOIY60M+GWLM/i7XV8mTn7o8lTE1mEPXTFTi8TYR5aHiG
    +AmdPGoEc4wqEjF4jeNT9Lr5lfysW6N1ldPefuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628178; bh=n
    OSjOCjo+E2piPmBmPEobsiDxwA/oUgAqaLiZfRcpl0=; b=rfsqrmjq7iJkfRHYe
    Et3BRtJvIGBjUJrjDfVvjwSIk0L20nd8sVupZna1UBNA0Cg7C3bVfr0GMkg4sJ4E
    MuR78j/o6RAvSWJmPbxTwlIyv8WPVTPMFMe6CwrS8XlcfxwDov+3fyTbjNPK2G4q
    2tLImxpCZ0hrmZqz/9GNAgMm03WO2LTDcr5a7zi/IswCeVQjMffUhviLFtNsHhtV
    4kn9yM6LQ+J7K4ZL1E/+rxw1vdMfuG/hHwtN9KpjwulL1H312UtJjRmJnB7W9qkl
    jI/YWnQzcdRjxvNtpO1fgOcs5tjDrs9X4o4S+ISw+OX32KJSi5N1B9HJ1X8b8nIG
    68iFQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=V1r41NKw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=V1r41NKw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 07/11] staging: iio: tsl2x7x: split out als and prox
 persistence settings
Date: Wed, 21 Mar 2018 06:29:08 -0400
Message-Id: <20180321102912.5130-8-masneyb@onstation.org>
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

The struct tsl2x7x_settings contained a persistence member that
contained both the ALS and proximity persistence fields. This patch
splits this out into two separate fields so that the bitmasks in
several parts of the code are no longer necessary.

The default persistence settings are also changed by this patch from:

- Proximity: 0 (Every proximity cycle generates an interrupt)
- ALS: 255 (60 consecutive values out of range)

to something a little more reasonable based on my testing:

- Proximity: 1 (1 proximity value out of range)
- ALS: 1 (1 value outside of threshold range)

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 24 +++++++++++-------------
 drivers/staging/iio/light/tsl2x7x.h |  9 ++++++---
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 07ce3076a05d..c1e441857226 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -226,10 +226,11 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.prox_config = 0,
 	.als_gain_trim = 1000,
 	.als_cal_target = 150,
+	.als_persistence = 1,
 	.als_interrupt_en = false,
 	.als_thresh_low = 200,
 	.als_thresh_high = 256,
-	.persistence = 255,
+	.prox_persistence = 1,
 	.prox_interrupt_en = false,
 	.prox_thres_low  = 0,
 	.prox_thres_high = 512,
@@ -621,7 +622,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		(chip->settings.als_thresh_high) & 0xFF;
 	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHHI] =
 		(chip->settings.als_thresh_high >> 8) & 0xFF;
-	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] = chip->settings.persistence;
+	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] =
+		(chip->settings.prox_persistence & 0xFF) << 4 |
+		(chip->settings.als_persistence & 0xFF);
 
 	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
 			chip->settings.prox_pulse_count;
@@ -1043,15 +1046,10 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 
 		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
 
-		if (chan->type == IIO_INTENSITY) {
-			chip->settings.persistence &= 0xF0;
-			chip->settings.persistence |=
-				(filter_delay & 0x0F);
-		} else {
-			chip->settings.persistence &= 0x0F;
-			chip->settings.persistence |=
-				((filter_delay << 4) & 0xF0);
-		}
+		if (chan->type == IIO_INTENSITY)
+			chip->settings.als_persistence = filter_delay;
+		else
+			chip->settings.prox_persistence = filter_delay;
 		ret = 0;
 		break;
 	default:
@@ -1108,10 +1106,10 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_PERIOD:
 		if (chan->type == IIO_INTENSITY) {
 			time = chip->settings.als_time;
-			mult = chip->settings.persistence & 0x0F;
+			mult = chip->settings.als_persistence;
 		} else {
 			time = chip->settings.prx_time;
-			mult = (chip->settings.persistence & 0xF0) >> 4;
+			mult = chip->settings.prox_persistence;
 		}
 
 		/* Determine integration time */
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index b2aa642299b3..d382cdbb976e 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -50,11 +50,13 @@ struct tsl2x7x_lux {
  *  @prox_config:           Prox configuration filters.
  *  @als_cal_target:        Known external ALS reading for
  *                          calibration.
- *  @persistence:           H/W Filters, Number of 'out of limits'
- *                          ADC readings PRX/ALS.
+ *  @als_persistence:       H/W Filters, Number of 'out of limits'
+ *                          ALS readings.
  *  @als_interrupt_en:      Enable/Disable ALS interrupts
  *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
  *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
+ *  @prox_persistence:      H/W Filters, Number of 'out of limits'
+ *                          proximity readings.
  *  @prox_interrupt_en:     Enable/Disable proximity interrupts
  *  @prox_thres_low:        Low threshold proximity detection.
  *  @prox_thres_high:       High threshold proximity detection
@@ -70,10 +72,11 @@ struct tsl2x7x_settings {
 	int prox_gain;
 	int prox_config;
 	int als_cal_target;
-	u8  persistence;
+	u8 als_persistence;
 	bool als_interrupt_en;
 	int als_thresh_low;
 	int als_thresh_high;
+	u8 prox_persistence;
 	bool prox_interrupt_en;
 	int prox_thres_low;
 	int prox_thres_high;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
