Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402446-2-10398701890640162295
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
    1525402445; b=nD2tuQhupS83bh7zu97ez9F6km6l4+V9qLHIXtXJ3N5QBr35p+
    j8/CILI1nhvBwJV3BPOZLSLB20buTBO7E34GR5a3z2pRmJEWsiFpWP5mgy44K5WL
    smQnNsEk7XKJCMrGt2QDgeTA3/5n1iZj+QkojH+9XXQY/kD6PPbf6N6uy1JHUThz
    sfo/fj+h6Fcla+vN2Kvjy+uuyaxNpSXEyjnlYRyjJO539p4AMalQ10sGx+F4b6j3
    xxCzAsiTSrkWl9P9cXlDROW6/FCB7aaSJxzqyBkWrTNblmOxTQK/BrYCwvQuEdEH
    LMTRjlD8S3pP5R1kcg6nCS+qLILzg5pIeTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402445; bh=/Y7Ww
    b8TmUQxM70tIqgTUFF5PxXU3011Z3wOsZzBQ4A=; b=BHVUohxSg8Bekw/kEOK1/
    wxEna1nKbmzQGgwlc3C2xO6KnSrMjfoeQpSlPLqJlwnIBdPNpNhnqpoEPidbVSm8
    NhCYIabuj2x//2zfNloQJX5h9RwY9gCJwed+ymCjgOXxquq+xxTnKeFWD3b7/CQ+
    s9uxTwp3GlrQlZ5QjQqOzO+2SzOudjgFWYVwTK8cPHDFzrtETm85Ayr3nXItKSkY
    Pf/GG5sBB6MD6TKAKoMD4CErjfyZF8+iI6c4ntKPBIIsykP0khIJo5S8LbpEQHXg
    mt+8dXP006S+GDj9I3ZqiWS0l91Pu+uKy9gHfrb2S4Xu4t82zyz35E4TmyOCR7p9
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=U0GvNU+O
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
      header.d=onstation.org header.i=@onstation.org header.b=U0GvNU+O
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
X-CM-Envelope: MS4wfOaynTitteZkqUEzhWSwRWjhyJe8b7HD2WE360WSeP8dewDUZ4ptDqk7Ec2L8q4q/bpJX28DteULjbJ428ZWFnx/bhq3DVbhW2EBfUETL9ydYT3Ckt3N
    Ax0nHyusxI5Aej57LrvhrEmQkxMTKPEKL4IJ7rj6JXl/fPMm/fKlnrMzs602TpH69hRbV5VzxpW7x4U8kLx2mYHPZeX4DNG9q24UB8rpVTZCnsvDBXx5j+rt
    U4/WNBR8ETljH7PBVI6SCw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=g2j3Jks1sq3F_6VN0vgA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 09/11] staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD
 values
Date: Thu,  3 May 2018 22:53:17 -0400
Message-Id: <20180504025319.28953-10-masneyb@onstation.org>
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
index 39de5e60fd33..f912f4bc61c4 100644
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
@@ -972,7 +970,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 				     int val, int val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL, y, z, filter_delay;
+	int ret = -EINVAL, count, persistence;
 	u8 time;
 
 	switch (info) {
@@ -1011,15 +1009,20 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 		else
 			time = chip->settings.prox_time;
 
-		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
-		z = y * TSL2X7X_MIN_ITIME;
+		count = 256 - time;
+		persistence = ((val * 1000000) + val2) /
+			(count * tsl2x7x_int_time[chip->id].increment_us);
 
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
@@ -1040,7 +1043,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL, filter_delay, mult;
+	int ret = -EINVAL, filter_delay, persistence;
 	u8 time;
 
 	switch (info) {
@@ -1076,18 +1079,21 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
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
+			tsl2x7x_int_time[chip->id].increment_us;
+
+		*val = filter_delay / 1000000;
+		*val2 = filter_delay % 1000000;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 1097ee890ce2..f74427f4ab6e 100644
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
