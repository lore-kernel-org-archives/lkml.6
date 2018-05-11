Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2982922-1525997568-2-14240216014365417428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997567; b=DPtg9oZkaLzYIC7YzM+k1/Q9AXAzwqbHYe5QzPBe5k8pApiyHV
    XEUk2gVjHnuW6pt36N1j1c07vcO7V2nGaZ+OXXKhT6zX/Em24qOH7PdneCNhr93u
    n4tlv/Og1GGCkyHX4DXFhWYdv5Hu2a07NuYhmXl7N6NnzmW34DtMq36C83+ebRbv
    0uTKw5i7cNyZYD7p1LGm054qJh+zWOpGVUEAZKruXOwNmorbNa8rD+Segh0y6+Ku
    YFSENA1Wdqnkt5j8h58ixHQwfC+kHcEjTP/ddRUv3+PEXS/4/wr+T40BzO55CuuO
    2/c9Bp0fxSi8/3TMNi1U4JUUpVRq98+cJv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997567; bh=fanXb
    lgp4NQ2esPmsD3FPIJXA9ZLKdb9CqAU9CrpHuY=; b=NJ36IKz73TjUsLkhPXo/k
    yqkJRMHBQOiqsV/jM27oeAWs9Ckn4An7DC9JGp4L4Izhnr9O080l8BzBCPR2p4CJ
    +m6Jk8D+NMFTXieyOuON7M8K7rpzJ0yv8wnz5GRhlBbwv7L+EnuJGvpn29rFwFW+
    rlg2YqwUZtcq55DMqNF5k3/3PoeKPbjuYma5mz1UxqyIq1cgZfdvL/YyW1ou9bai
    SyQckZjWdF6ja9sjhCjHWj5iU7mrEfniq6A+pTZoBVfnJ4iwTe+XCDvKiTH+9gxQ
    qgyOQEn0EvbhJ+lR0RqnkUm8VEfnSZJCL4egaCF+uj0J0IGFxM6zDG5z+J331y4t
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=mjn/BCIp
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
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
      header.d=onstation.org header.i=@onstation.org header.b=mjn/BCIp
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHRZqD02INLh5yA7rBHnIUJUdCiWtL9Ej5RRjji3IizNRAAdwQm+pLUNNmP9CbqYFqN3tghI1eePcy7FzUkRUluCy1Ovk1ikFXSK43xHEQ8AI8V5BGB
    dpwKcBXd4jrJUobspqCgHr1B4bklNt3mqNGNqWbYcr1vNuOXbA5OzQwEC4zJR9iICjZMb4aHrk73PoIqQJq0uBJYAPB+wQr6yT1nP3TaUwIxtdVE4nAQnImi
    8ZyBRusqGkKE1C1954vEsg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=KOCLOxNrzR6iszZ1x7QA:9 a=DRZYITYJfVXOZQe9:21 a=hCZb4eiBzzIyacgv:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/9] staging: iio: tsl2x7x: use direct returns
Date: Thu, 10 May 2018 20:12:16 -0400
Message-Id: <20180511001223.12378-3-masneyb@onstation.org>
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

This patch changes the functions tsl2x7x_read_event_value() and
tsl2x7x_read_raw() to use direct returns to simplify the code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 49 ++++++++++++-------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 3ae2fd19ae9c..c1e726fc87b7 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1014,7 +1014,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL, filter_delay, mult;
+	int filter_delay, mult;
 	u8 time;
 
 	switch (info) {
@@ -1023,27 +1023,23 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
 				*val = chip->settings.als_thresh_high;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			case IIO_EV_DIR_FALLING:
 				*val = chip->settings.als_thresh_low;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			default:
-				break;
+				return -EINVAL;
 			}
 		} else {
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
 				*val = chip->settings.prox_thres_high;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			case IIO_EV_DIR_FALLING:
 				*val = chip->settings.prox_thres_low;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			default:
-				break;
+				return -EINVAL;
 			}
 		}
 		break;
@@ -1062,13 +1058,10 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
 		filter_delay = *val2 * mult;
 		*val = filter_delay / 1000;
 		*val2 = filter_delay % 1000;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		break;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
@@ -1078,7 +1071,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1086,12 +1078,10 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			tsl2x7x_get_lux(indio_dev);
 			*val = chip->als_cur_info.lux;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_INTENSITY:
@@ -1100,13 +1090,11 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 				*val = chip->als_cur_info.als_ch0;
 			else
 				*val = chip->als_cur_info.als_ch1;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_PROXIMITY:
 			tsl2x7x_get_prox(indio_dev);
 			*val = chip->prox_data;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -1116,22 +1104,17 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 			*val = tsl2x7x_als_gain[chip->settings.als_gain];
 		else
 			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		*val = chip->settings.als_gain_trim;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
 		*val2 = (256 - chip->settings.als_time) * 2720;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
