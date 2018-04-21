Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2940329-1524271339-2-12783228150800783286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271338; b=D3SmGY/4EV3VRiHq5P7doXnouILf0OhbxUZVORfLvC/zuYziiH
    dGSA8YYx9m9WZM2ERAlwlYL1rFrBDhdJac0T33Wm200ucwC7NqN2ji+VWIeF9PkP
    qBS/OP2tCSd2w14p+y/Wy9vcgxg4Sw0Z5RB+3HlYbco16aOKpe4aumWmvv79aI1e
    hs7Nh5gBObpVCVTCJYTmYrRpkI5O62roGWOuGC/v/4R1QrxG2PmzFiVC5xcIhrKk
    tNOJm378v1v6VTJvIcXEjGZhziANPDqxIPiVI+dknG8taSClzQ5HTmpj7OOWFWBN
    kS5aMRW/iX7DoxR1zI27bcNUuzwBJv8krygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271338; bh=uVHAW
    NhQb+eXIeTyDwpUbucZi7sEh9aVfOMg4SiR5vE=; b=p3qG5GUZ5I9Frw9Wv1GLC
    A+0uJk60KlKT3P1Z8RIyDMdKt3T1EQrbSGLH/S8Ke3ersAGvT2rYR2EJegbGY/fM
    jUEs4efE23SMM+NoKq8FA0Civ+e/1XXQQ9bO+dnYOmvZNOP2CLCM5LK3cgoF0oUP
    adhE81RJVMZIyhxEfQSaBIE6CRY1a2Q1MtKxZsfIGwFr80wnNRK59VRYeNHW6hh/
    Mb6bffHusxmMPXwHMS/dT92RqMmhfGZdlxEZ/gqdQQZudZVJRV18B6lpbeSvkg5o
    9d4kmVUj3OUV0KONeZ6N5pJEOJyjVwFwTVXUWuYauNYd9xPDOa52t/ieLjTTuZ7Z
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=mJ7x93lR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=mJ7x93lR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKuZKYwn7DmvMkKWrWFyna9XNWMPjYLx8WQcMC23E3yTtU+ccKAeVxty67Zx5DRH/9H6DRhGzDNwsBhTtevKp0B+Ue3aCiM8jdpdGJpSVpmCl4l/yfkF
    R+L8Y8iB3YyDufPDmmBB2fp4AEDn2lciu9RwZ24u+bglB5jwcETyA/R1bN/cORUiOFbvBi3wo8BwKzrDcsYSj69CguBsw15KxoTJtyDQeC2RpJ59kpWB7naA
    4czHsWQmPWE3TP9OJXrQEg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=QLmRry_OY8VsopkBm2sA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 01/13] staging: iio: tsl2x7x: move integration_time*
 attributes to IIO_INTENSITY channel
Date: Fri, 20 Apr 2018 20:41:41 -0400
Message-Id: <20180421004153.19073-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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

The integration_time* attributes are currently associated with the
IIO_LIGHT channel but should be associated with the IIO_INTENSITY
channel. Directory listing of the sysfs attributes for a TSL2772
with this patch applied:

dev
events
in_illuminance0_calibrate
in_illuminance0_calibscale_available
in_illuminance0_input
in_illuminance0_lux_table
in_illuminance0_target_input
in_intensity0_calibbias
in_intensity0_calibscale
in_intensity0_integration_time
in_intensity0_integration_time_available
in_intensity0_raw
in_intensity1_raw
in_proximity0_calibrate
in_proximity0_calibscale
in_proximity0_calibscale_available
in_proximity0_raw
name
of_node
power
subsystem
uevent

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9991b0483956..eeccfbb0eb1f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -827,7 +827,7 @@ in_illuminance0_calibscale_available_show(struct device *dev,
 
 static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
-static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
+static IIO_CONST_ATTR(in_intensity0_integration_time_available,
 		".00272 - .696");
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
@@ -1358,7 +1358,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1373,7 +1373,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1389,7 +1389,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1489,13 +1489,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
@@ -1529,13 +1529,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
@@ -1578,13 +1578,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
