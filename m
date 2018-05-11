Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2975690-1525997571-2-13095403340195484985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997570; b=EQm+0WVPhv+V6RHRhrGhGSEg5y7gJhimVF3UgSSTmTTZkX2C+h
    HP5HGmUNunz8gF6XGWuneRXegYD3pzHnMbAexbLnV0fu+9VucfqIqp3aUv79MKut
    hMFeN9TNsnb0xZaDQZA14R8pWdkdfZfM2PNquLAfgyfvnx0Lyk38IU6AN69xTMWq
    ycwasRn9rAbwZcpEqWhB+0r36yYexqRLxLD+J0EBFiR5QAbIKLykIhzXK747mB9I
    eMSfSnSVCgOIOkTCfs4g3tGq8SmW6ay1DMPfIl2qmj6AAUkVQ+wS+gOOCgP6D+Dl
    IDW6pwoNxNP6XvzmY65dTuFJuxfeIaQdQWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997570; bh=NkFpf
    PJ3wXDfM/8Iw/MM1qgHdTUVZaYF4ricnDjyxZo=; b=W+u+SLmBovxtQn/HOXw6W
    r5j9gPs0hsZozXCRi/daAyh7sLip1z97jy/HigePQilP41J9IxvTYuiYQmR2ki/A
    SEM6LH4o34hozYQtc9xWM5Amw3wFvgQBtfrBXRg9aNVlqOIcG08GR5BV2z8PWR4k
    3PyHo9BH9SitxPvGyRtJG1utuO6TFBCXDpAnIyFrMFgdjfjS2zemeI7e+Dd4Efoc
    lrX+d5sOzkp+qilQaSMjkERpE+w1qHtJB7gR7RGkYOFaPVRyp359hvAN8w3cgr9H
    UffeQiYSf4z2+lU1mKBdvFnI7wUK6zlfk36VLTtUO360AMn9fm8mG9GzrN5bxADS
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=eMHFcU+5
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=eMHFcU+5
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIWwq85k3RRPFks3s1+JzqqmhsJOxYfG24j1w3a5+/Xj4wLtBNv9TkAyI/FJ+WFJCXl03eUMQ16gJ1mE+ZkgFgP5ZFzOnV44cD0uNXBe+7MPW9LZfJLY
    3gnJ7XD4briw2zVmXQiQ+ND38ti/iUzVQA3Y/qZsFc3+DgYECKOKkZgoDb1rMxDU1Hxy6txyq2RAakW8ut/343+1hfn4TxxhoSlRAKrOhRAhInR4gR+SPnek
    wpka2lF7Us3OUR9VNmW7EQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=T8dStPftFcmDwBBS2QAA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 6/9] staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD
 values
Date: Thu, 10 May 2018 20:12:20 -0400
Message-Id: <20180511001223.12378-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180511001223.12378-1-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
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

The thresh periods assumed an integration time of 3ms. This patch adds
support for the correct integration time (2.72ms or 2.73ms). The code
had the ALS filter values as going up to 15, however the values actually
went up to 60 since the values scaled in increments of 5 once the
persistence value went above 3.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 44 +++++++++++++++++++++----------------
 drivers/staging/iio/light/tsl2x7x.h |  1 -
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 2d713d3c7c7b..0218eabcd6d7 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -103,8 +103,6 @@
 #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
 #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
 
-#define TSL2X7X_MIN_ITIME		3
-
 /* TAOS txx2x7x Device family members */
 enum {
 	tsl2571,
@@ -984,7 +982,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 				     int val, int val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL, y, z, filter_delay;
+	int ret = -EINVAL, count, persistence;
 	u8 time;
 
 	switch (info) {
@@ -1023,15 +1021,20 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 		else
 			time = chip->settings.prox_time;
 
-		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
-		z = y * TSL2X7X_MIN_ITIME;
+		count = 256 - time;
+		persistence = ((val * 1000000) + val2) /
+			(count * tsl2x7x_int_time_avail[chip->id][3]);
 
-		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
+		if (chan->type == IIO_INTENSITY) {
+			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
+			if (persistence > 3)
+				persistence = (persistence / 5) + 3;
+
+			chip->settings.als_persistence = persistence;
+		} else {
+			chip->settings.prox_persistence = persistence;
+		}
 
-		if (chan->type == IIO_INTENSITY)
-			chip->settings.als_persistence = filter_delay;
-		else
-			chip->settings.prox_persistence = filter_delay;
 		ret = 0;
 		break;
 	default:
@@ -1052,7 +1055,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int filter_delay, mult;
+	int filter_delay, persistence;
 	u8 time;
 
 	switch (info) {
@@ -1084,18 +1087,21 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_PERIOD:
 		if (chan->type == IIO_INTENSITY) {
 			time = chip->settings.als_time;
-			mult = chip->settings.als_persistence;
+			persistence = chip->settings.als_persistence;
+
+			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
+			if (persistence > 3)
+				persistence = (persistence - 3) * 5;
 		} else {
 			time = chip->settings.prox_time;
-			mult = chip->settings.prox_persistence;
+			persistence = chip->settings.prox_persistence;
 		}
 
-		/* Determine integration time */
-		*val = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
-		*val2 = *val * TSL2X7X_MIN_ITIME;
-		filter_delay = *val2 * mult;
-		*val = filter_delay / 1000;
-		*val2 = filter_delay % 1000;
+		filter_delay = persistence * (256 - time) *
+			tsl2x7x_int_time_avail[chip->id][3];
+
+		*val = filter_delay / 1000000;
+		*val2 = filter_delay % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index db344796fc1b..b86f6b260f9f 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -31,7 +31,6 @@ struct tsl2x7x_lux {
 #define TSL2X7X_50_mA                   0x01
 #define TSL2X7X_25_mA                   0x02
 #define TSL2X7X_13_mA                   0x03
-#define TSL2X7X_MAX_TIMER_CNT           0xFF
 
 /**
  * struct tsl2x7x_settings - Settings for the tsl2x7x driver
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
