Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3509029-1525402420-2-1089726682328477547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES rofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402419; b=WO2pErqGO4wOcgDUJM4GR0YTM35WWiRO/MZcN32dw8tnVrXYpW
    oNKh1t28rucZiszF6zY6OXUgH3a8LmygLxFL6K2aSmUZU22m/jtFlDhbXZ0oc5Lu
    TsohoD6otLVVAyhNJDvP/2Mvw+eV0KbZfImz0gujb/subSqoAjb2LEcK5DpVQMcH
    C307lmok/OP1g3KvPTVb3fApThckHXSqB9vO2INbSQSNHYT2JgGL9XPZE61qz85X
    cCvPlU3tfqb5ysw+MyxIn/J2YDmid0AssWMEKbCa26p8X2EiCchpSf96MYGvbpYa
    JFUix2ucZQi9IbZ/+VOct0/JLIkBer+AbOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402419; bh=oCDRi
    ZFzoUxRNtoVu8wbdVbD8XeYmd121mhQjZtv/hs=; b=mbGkCf5k/aBXQNqEOkJDf
    oOfGkQI3k+CEnQGbJTXsEbyUd8vqyAnSjYNZ0tWXC3WIMY4e22ih47td+PV+4FKz
    /reZ3BidLEboUO6WJjgQ6Icby2uT7aqI7/XbhV6U8pZ7X0/wBNLGb4AlbvM+Du8H
    c8Va4XXAmgz7BjoKOwiXoHImMIYpopDW3jUP/OaclN5ciJcOIcrWmUtCyMdsZy/u
    PmW/oN7ViWonWj8KacsLyTrlketXoMbND4sHAlMjGDaAH1RyfYKXyQZjqqnrDAKL
    NAL7YGpiGH7YPLACWCnWUTvoZAaeheexWaRNxWcC177vi1JAG4ESjsmeSWr8FhHH
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=YdcgMOsz
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=YdcgMOsz
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMN9hZsBahA7AAKmy1IIdl8rvFYPm3U4uYkp+lc7W3jYT34spBcbD4Vz7gkRv3adUIlQaPCWy4qTUkhGz/CD7+RT37iR63lBOqNQk/Ob8kc2Iuy2cRVl
    3H/qxCJSmgqavw74ShR1wqd2bXB6u8xTU1x23JZ4g4QeHM7Qf+Ce60M7dKCe9wCvMCqSRqkE5osZAavo1lz7UcDBTXnJ4sUkrgSjIfh5CBYOWbqzMuj9BjK2
    AmcMm5eDIs9aQvle95x2dQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=xdDr8l6oF4kBUZpbEJIA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 04/11] staging: iio: tsl2x7x: move calibscale_available
 attribute to IIO_INTENSITY channel
Date: Thu,  3 May 2018 22:53:12 -0400
Message-Id: <20180504025319.28953-5-masneyb@onstation.org>
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

The calibscale_available attribute is currently associated with the
IIO_LIGHT channel but should be associated with the IIO_INTENSITY
channel. This patch corrects that association and it also corrects
lines that were unnecessarily split for the
in_intensity0_integration_time sysfs attribute.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 7e8db5178a2c..9aee04fb4168 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -777,9 +777,9 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 }
 
 static ssize_t
-in_illuminance0_calibscale_available_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+in_intensity0_calibscale_available_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
@@ -1247,7 +1247,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
-static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
+static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
 
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
 
@@ -1321,9 +1321,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 }
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_intensity0_integration_time_available
-		.dev_attr.attr,
+	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1336,9 +1335,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 };
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_intensity0_integration_time_available
-		.dev_attr.attr,
+	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1352,9 +1350,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 };
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
-	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_intensity0_integration_time_available
-		.dev_attr.attr,
+	&dev_attr_in_intensity0_calibscale_available.attr,
+	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
