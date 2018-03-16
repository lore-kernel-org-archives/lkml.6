Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230841-2-3550108692188268913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230841; b=dWPY/Ndml2B7D1OYoRUmsQ1mmfb4M8b2BMu4HVNAZYmBTQ+
    IhKR0f7ET+j46aXTpJxoHTfihjCEcf/FoM/bwjp+BrgXqhafjDumm4atwZuab7g8
    2ssnY1/Cu7eGHez4epfmtpTsoUUC2azCJKrDuM3CUi74bPZ9aJzFOXSoklgpdCxY
    D8+KWX5AWHqXeE8BTXxB8Lg1RV/85Y8gqyhM5l3LoeZNyhKKbOVuH185tbOI5wu+
    S7IrPo/l/uVEETdTKlQPZdkiBE+HHj93r2+LE0GeVo7OyH7RGlGYujxgXA5m/WS1
    zXQZjI4TZJTS8JxyrnrO9eS2vmWZvc+70azDqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230841; bh=m
    nmrIRA+uY6lBjpZiOIOQc8/QYGih8uviNrvoo2ANmc=; b=vBKZoyb+N0tTL17qf
    AdVAnoF8/ppEWs6tZYnX55xKr0pSXAjohhHvNxeKIodxdRt9BMsHJ+Idxs+z/XYo
    Ikga8HvIeNnvxmtL1RiaGOJt0FJ3MsQHMkktcq4P0X10RJmY/hiIFpQWku7n5xHN
    h9ckhWiToKMAye70oKtsWNMrAIqhq2QlwPH11iI2kzb1YaQuOWuIqqHcesfm7LF9
    FNDw+8EhUQMw9ovgI8dMkKJHYNROoiQF3DJBw/h8iQiND+06GMlsD42qW4IeyUFM
    ZdIG/hQQsHPPs0CNb2GazdKswxrzADX10exsNcd6GzNYWOdRHMLuMCLkdmKe5Vps
    yqCiQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gIzb8Tg/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HzwRmXA9;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gIzb8Tg/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HzwRmXA9;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsKPHEdPuraDo88FY6OfesgTfTBcqg1X1c6Bc/cHhmBkzpi+pyePkx3vtAEfLBIe6O/+lD95g==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 5/9] Staging: iio: accel: adis16201: Add comments about
 units in read_raw()
Date: Sat, 17 Mar 2018 01:36:22 +0530
Message-Id: <1521230786-18155-6-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, 21cnbao@gmail.com, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clarify the conversion and formation of resultant data in the
adis16201_read_raw() with sufficient comments and remove the unnecessary
comments.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -clarify voltage base conversions.

 drivers/staging/iio/accel/adis16201.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 8de3f27..97150ea 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -120,31 +120,43 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			if (chan->channel == 0) {
+			/* Voltage base units are mV hence 1.22 mV */
 				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
+				*val2 = 220000;
 			} else {
+			/* Voltage base units are mV hence 0.61 mV */
 				*val = 0;
-				*val2 = 610000; /* 0.610 mV */
+				*val2 = 610000;
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = -470; /* 0.47 C */
+			*val = -470;
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
+			/*
+			 * IIO base unit for sensitivity of accelerometer
+			 * is milli g.
+			 * 1 LSB represents 0.244 mg.
+			 */
 			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
+			*val2 = IIO_G_TO_M_S_2(462400);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000; /* 0.1 degree */
+			*val2 = 100000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
+		/*
+		 * The raw ADC value is 1278 when the temperature
+		 * is 25 degrees and the scale factor per milli
+		 * degree celcius is -470.
+		 */
+		*val = 25000 / -470 - 1278;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -252,13 +264,11 @@ static int adis16201_probe(struct spi_device *spi)
 	struct adis *st;
 	struct iio_dev *indio_dev;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
@@ -277,7 +287,6 @@ static int adis16201_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(st);
 	if (ret)
 		goto error_cleanup_buffer_trigger;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
