Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3509029-1525402436-2-14815971678702921322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402435; b=QPf7LIvlAOmfS7ArskWj9L3YGmQZO16gNZku+r885GWJTBmrx4
    51id6eeMOCJTIPkuxCKcGveU6elN0XjJXEgzVaRxxbaC6I9/00szbCvC0Z/SkA/G
    HfDVFJXTH5eT+OoEMCsHPybijN6i/+YIsrsMH7itC69UVf5EQMU+Lo5EGPgNAkDy
    QGy5vQ3LOxB83pNU1s7k7BmlTR8oDSBMyh+ZBvmnVFcnambEJlNMK0RZvcKN7EqN
    mUK1DMsm0sk6rBEIl7XExoRvZGEsQKtQiOemqfWMOwLuVJc8Yl/w0EayES0Eex6R
    D75bNXAXqk2jwlThFW5WuPiSkTj1sU5EGmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402435; bh=Djcz4
    B1+jPBFZsbQ2AQr+N2UpF3LYj9KvALwXXifacY=; b=HwO3lZeHFO6S+QoEzyhZI
    ozsIZgfLg9m5Qu1J3zXZANTj3cluaHyM0smUTFAarweDVJ2OL0uRw1worHQ1p8QQ
    rCA5C1zw2wZTVackZ0SWUt3NMio6piHMlHDUEDAGgQookVOqTdW1pU67vYLRThhI
    KxmJrdtXgBIMxlP6HN0qGxgmqgvSpR5QKziZktJybe+7nCGTucC712yxTzefJarR
    Z8IqNWZGxHTUe8NikoyDXmesH39F4Neg9aMn6dnXbXJ7ThGwYnC/00Zixp96tguB
    yKif1RRmCdtKgVcPbghdYchlVKfKGooNqFYDAMS324Tt0ukIbGercG1YdEWj8p+H
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=DM3LJdJ1
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
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
      header.d=onstation.org header.i=@onstation.org header.b=DM3LJdJ1
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgK3+gkYCpzMEJ9lEpUR+h5VTZQv0pcEFEjsY5F/sa7eRY4U/r3VMr7DgsY4xPxC2QXLpPAlZUto/q7X3PU2npBeZj9gynYHl5nngZMhhjEDqw2f0Pg
    C7DNjXRjwxZS0PoqeI6z9uaQ1tEkomwRFnb+B78/OBkgILB9/AegZpyEAV0wQjG6HOlEXnuIjdIzFqKx70LKnz1JISk/BZk0slsXNY5WZx+XJXrsKZd4qk05
    Vl+0rDdNCMSoTOIcHsSA0Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=n09FV-eumC6tvtyW-E4A:9 a=kqrsazqBj6R_92md:21 a=WsK3TsM6KmXCW6JX:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 05/11] staging: iio: tsl2x7x: use IIO_CONST_ATTR for
 calibscale_available
Date: Thu,  3 May 2018 22:53:13 -0400
Message-Id: <20180504025319.28953-6-masneyb@onstation.org>
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

The in_intensity0_calibscale_available sysfs attribute has code that
checks the device type to determine which calibration scales are
available. This check is not necessary since all of the supported
ALS device types use the scales 1 8 16 120. This patch converts the
sysfs attribute to use IIO_CONST_ATTR. The following device datasheets
were checked: tsl2571, tsl2771, tmd2771, tsl2572, tsl2772, tmd2772.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 46 ++++---------------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9aee04fb4168..cf582a2e3633 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -776,24 +776,7 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
-static ssize_t
-in_intensity0_calibscale_available_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
-
-	switch (chip->id) {
-	case tsl2571:
-	case tsl2671:
-	case tmd2671:
-	case tsl2771:
-	case tmd2771:
-		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
-	}
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
-}
+static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
 
 static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
@@ -1190,25 +1173,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 				chip->settings.als_gain = 2;
 				break;
 			case 120:
-				switch (chip->id) {
-				case tsl2572:
-				case tsl2672:
-				case tmd2672:
-				case tsl2772:
-				case tmd2772:
-					return -EINVAL;
-				}
-				chip->settings.als_gain = 3;
-				break;
-			case 128:
-				switch (chip->id) {
-				case tsl2571:
-				case tsl2671:
-				case tmd2671:
-				case tsl2771:
-				case tmd2771:
-					return -EINVAL;
-				}
 				chip->settings.als_gain = 3;
 				break;
 			default:
@@ -1247,8 +1211,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
-static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
-
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
 
 static DEVICE_ATTR_WO(in_illuminance0_calibrate);
@@ -1321,7 +1283,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 }
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
-	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
 	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1335,7 +1297,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 };
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
-	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
 	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1350,7 +1312,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 };
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
-	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
 	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
