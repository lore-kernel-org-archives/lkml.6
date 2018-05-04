Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402422-2-2642779075016902517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402421; b=ZM+SnjTqn3RI8xjJmCF9UCmy6m2SbDuQrH0CwuKPCiNxGhCWTo
    gz1Je8l2wUgNWdMQGevkN36DAxY1RDrrbbb11lVEnVogfeF09fTTbiDfG04Gdh3I
    rumS34pJQj0rlhx1mz8GOHaIMkP0/iyqBsdlWFjvtK3UsuIWx2R34v8YqAsDvvS2
    3RJ8KmxHzR8nBeyVeP8qicJIwhxDqL9FUIXIRAOIT+q0NDlcYXwiriYVGSjd2f3i
    /w27vysAZLpgd8yEkPvAQglzDp1Nx23RyhMV2Sbg6rURc1G9jDNFKbm9uf2PwltO
    J+q75SkW2bkp+9nBdz0q2mlij3zcmmPxe8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402421; bh=GYXJH
    /Dc5L9iAhQcjNJO76a3a69yylytkiDc7HN7pxA=; b=XC0NVmvKOX4VG2/3yMKDm
    XQLr29awxJLg3HqDwQXCDF8G2S9meuljNtCkVuuFqf+HRAWi065p8WZLR/9caC3X
    Pr+u8A0VRRbPp/zo3fgfJChhNytFVd/U00rJkFbFiwXyKiVj2+o1kXzDBbiAAtgA
    UfAveyeHX60wBOioMPvfpXLh4h8RBmCnGlhgG+zSn40Bp+UP40tDJ3AAT0oUYUhT
    ZTzvkLJdBx6G8k3R71jjxqQb3uwTvUGWLlJGbkcP3RAuJ79hsfYxSzpshCN8T1CI
    PUM3RDcGx+8LRVzeWzWAEl3nh6ZbjogXj6HucHLJhZnKCco8oJYULbg5X2nXFMtx
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=Buwm8pvE
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=Buwm8pvE
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
X-CM-Envelope: MS4wfOEDv6e8n5daf+9t/iX/Ny0F3pRgZ1ASCkNEZRU96wI04qb9IICtq4wBhIlukz6tLOYBscYgrPSVx2k6NXrhcbhSORruJQjImpEGWB/k4id9K9Qquqwp
    HUrDCUBFhWA8qZRoluzs2CPNs8heYEPhgladlMeDXbJ3bDKNRAbmnG54wUUlVUs0kmuDnxjKkVw1ymrZDdAj/kokwwiPsgckFOxIfC9j3LWZr31VUb3H1mE8
    Cz9sDOlf3HX5L8SZDSM1dg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=R5poM6WO9fr8cxHymNoA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 02/11] staging: iio: tsl2x7x: add range checking to three
 sysfs attributes
Date: Thu,  3 May 2018 22:53:10 -0400
Message-Id: <20180504025319.28953-3-masneyb@onstation.org>
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

The sysfs attributes in_illuminance0_target_input,
in_illuminance0_calibrate, and in_proximity0_calibrate did not have
proper range checking in place so this patch adds the correct range
checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 01bff4593640..b4d77f65ca12 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -814,15 +814,13 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	u16 value;
 	int ret;
 
-	if (kstrtoul(buf, 0, &value))
+	if (kstrtou16(buf, 0, &value))
 		return -EINVAL;
 
-	if (value)
-		chip->settings.als_cal_target = value;
-
+	chip->settings.als_cal_target = value;
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -838,14 +836,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_als_calibrate(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_als_calibrate(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
@@ -932,14 +928,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_prox_cal(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_prox_cal(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
