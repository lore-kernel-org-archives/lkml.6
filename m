Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402453-2-11206716121380326927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402453; b=iQIvvnGIk6GVQtKYf/Py2koThxGatovH61HCWYt5Mfl+4ton8p
    46oVbRfRk6sylxFd2qwnpHjw9zvvnMedDdD09SYe5UIufoCgeZfg9XbZ20wdqQNA
    /LJyRd3mypMuMeDboggTV6PItmS8QYr9xmKqgKeCsPSKSvCAt6kloIAmY6xyqdKz
    g7nnyhcGkSzBmL9FuSEJsdk/FS0mQkhawhb1aPJJzhrEGgL0JMeJlGpFhclW4QnH
    6sbOl/SpUJz5y8kbgsoxAVE1AsI2zeVMgXQZ9IQxxJfCUvdlUHQYp12XkMn6vTIF
    Z2xLPQiTGq+ak29weRcmdqUBHNPl83IE4A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402453; bh=YCPsX
    yypaLKRN8QBnBUSUJer2CxF7W5rRFbPJAybfjw=; b=HgrmWhEpdT7E74HARGMUE
    wWZEIY/gDD90nsfP8+Jy1w1WubtZ5IF2XokbIx/XyY6ak166nzZB8JYNyqqDwj4D
    hZkIM0InvRRH25bfJ1l9tTjAKzy8EvJgF4WbSVqCoFeex/Wlyko9CBjIpWb+QZgo
    6xN7A9go/i+KLK7/s/lXJKPk8NflWwEYIaA0TPqfBUWiQG1LrEOMcWkuRIUUa7Kl
    u3CI+dYGWNJC/+euNQLtDBjeV2gxqAQrabIRnagS3VK4kSEhJ6uDp9RpY07wf+FC
    uiTGkCTM+vrgk4vIgw+Ea/s2UFFZOAkyd+mQmYnAIyQcTJS2JqWKOsrQ+mKT+8Lg
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=Jot4GRBF
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=Jot4GRBF
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
X-CM-Envelope: MS4wfOHiz9yr2Ivj/+vdbtWlRtcn1cdjIW0M6Zw1nPqoI7sZAbyXje8Vi8iXbMEs6NjMxA6mBTaUbiHJjpx9pBOi8Fuo1CZQ2rS50TKLMI+EGN4kyy/zHhHX
    sX6rWEWKDXHXaXmmrTOBUFtHcjZ9Fcazj8WuGHeTbuua0qQNPzJMsJqG2N96ZXxvSPKgXxvk5dzZW6vE8ZMY2botYD4hrabd64S8cmhrGFJJHYmm2mHTqEx4
    vkI8RTVgJiu7HYMfTj2t/A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=flduS1S5oaO4pUN200IA:9 a=8-FAs5fVN6s5ZOOd:21 a=7prdIeRio0P2UQSQ:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 07/11] staging: iio: tsl2x7x: support 2.72 and 2.73 ALS
 increments
Date: Thu,  3 May 2018 22:53:15 -0400
Message-Id: <20180504025319.28953-8-masneyb@onstation.org>
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

The driver assumed that the ALS increment was 2.72 ms, and the upper
range was 696 ms. Some other supported devices use 2.73 ms - 699 ms.
This patch adds support for the multiple ranges.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
I debated whether or not this change should even be included. I feel
pretty confident that I can cleanly fold the tsl2583 driver into this
driver once the staging graduation is done. Those devices have an ALS
range of 2.7 ms - 688.5 ms.

 drivers/staging/iio/light/tsl2x7x.c | 50 +++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9b32054713fb..e3e37501829f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -209,9 +209,9 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
 };
 
 static const struct tsl2x7x_settings tsl2x7x_default_settings = {
-	.als_time = 255, /* 2.73 ms */
+	.als_time = 255, /* 2.72 / 2.73 ms */
 	.als_gain = 0,
-	.prox_time = 255, /* 2.73 ms */
+	.prox_time = 255, /* 2.72 / 2.73 ms */
 	.prox_gain = 0,
 	.wait_time = 255,
 	.als_prox_config = 0,
@@ -245,6 +245,24 @@ static const s16 tsl2x7x_prox_gain[] = {
 	8
 };
 
+struct tsl2x7x_int_time {
+	int increment_us;
+	char *display_range;
+};
+
+static const struct tsl2x7x_int_time tsl2x7x_int_time[] = {
+	[tsl2571] = { 2720, "0.00272 - 0.696" },
+	[tsl2671] = { 2720, "0.00272 - 0.696" },
+	[tmd2671] = { 2720, "0.00272 - 0.696" },
+	[tsl2771] = { 2720, "0.00272 - 0.696" },
+	[tmd2771] = { 2720, "0.00272 - 0.696" },
+	[tsl2572] = { 2730, "0.00273 - 0.699" },
+	[tsl2672] = { 2730, "0.00273 - 0.699" },
+	[tmd2672] = { 2730, "0.00273 - 0.699" },
+	[tsl2772] = { 2730, "0.00273 - 0.699" },
+	[tmd2772] = { 2730, "0.00273 - 0.699" },
+};
+
 /* Channel variations */
 enum {
 	ALS,
@@ -626,7 +644,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 
 	/* set chip time scaling and saturation */
 	als_count = 256 - chip->settings.als_time;
-	als_time_us = als_count * 2720;
+	als_time_us = als_count * tsl2x7x_int_time[chip->id].increment_us;
 	chip->als_saturation = als_count * 768; /* 75% of full scale */
 	chip->als_gain_time_scale = als_time_us *
 		tsl2x7x_als_gain[chip->settings.als_gain];
@@ -764,8 +782,16 @@ static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
 
 static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
-static IIO_CONST_ATTR(in_intensity0_integration_time_available,
-		".00272 - .696");
+static ssize_t
+in_intensity0_integration_time_available_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			tsl2x7x_int_time[chip->id].display_range);
+}
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
 						 struct device_attribute *attr,
@@ -1124,7 +1150,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
-		*val2 = (256 - chip->settings.als_time) * 2720;
+		*val2 = (256 - chip->settings.als_time) *
+			tsl2x7x_int_time[chip->id].increment_us;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
@@ -1184,7 +1211,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		chip->settings.als_gain_trim = val;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		chip->settings.als_time = 256 - (val2 / 2720);
+		chip->settings.als_time = 256 -
+			(val2 / tsl2x7x_int_time[chip->id].increment_us);
 		break;
 	default:
 		return -EINVAL;
@@ -1193,6 +1221,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
+static DEVICE_ATTR_RO(in_intensity0_integration_time_available);
+
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
 
 static DEVICE_ATTR_WO(in_illuminance0_calibrate);
@@ -1266,7 +1296,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1280,7 +1310,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1295,7 +1325,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
