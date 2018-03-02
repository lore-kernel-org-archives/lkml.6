Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1633200-1519997580-2-17368438071603422269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519997580; b=FnNUxmQeTHgds42iJY6DjiTU4mg48Hd3IVaI4SfU8du4+zy
    thFJq3I1ugKKm+K5ot+aZgOHwcr6UxcQyBZI5y434VuNTFzVBa2mjBWIVUd9Myim
    WdjFXrqTYTrQaBf5ktPVElMzXzhyZkfyGEZQnB8Vzn2wIgnlFw/B9spESmniuccc
    CZrs9nYLfVGPMy2lUJ5HK1PyqNecpoyDjxVgLJDAd5Xkxep5CEn1BnLICArCfQ3k
    KcjAt4c+0cbMWS+OoDoC5ge7gK/TQtrdT8u7Tp+LkE770JFyd0ywV7mhP1GI3CXh
    RlIvf58qTfh1y9wTSmlhCIpLvhFjnVyAwDvTbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519997580; bh=M
    CDjiHB+Sak40w3mrp5nRlro/NBP8zXigCjCNneoZvc=; b=BUC8fhRBW878JunSc
    EL/cAgeDbcu/rWR+AcFki7YwoiclubUwKHts4QKizp4NbmqWCNHYFo9A/P/Jpj14
    vORlWPMqnhIb2CUskfal6jzgwmSSNXZfJtwLAmXq9BGKmLeVQbAtXyqRAuJWZapr
    IfF4ZljD6w+UhCmJJeF+A1ftFGaAtPqhKl6bNnbAPJhXmJyoZsvWNGNr80m0U1TX
    u6TL3LowLPw5EiviTotOjMsvw/Qe0aeVOk/B/VvHT1dc6yOaSyFQDS9x7o8rKDVH
    ElA+bNbDFl8+u0LO7+qekfip9MgYKShJWbwCqqyZsm/veFwd/eUhIgJ5PzRBoH7e
    aYNoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B08kgiEq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XdJfY0n7;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B08kgiEq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XdJfY0n7;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELstQB/2dlszEf9RRwrgwrY/ML9WldwKgtdlhJzt7vst3JYpsw1wCWDTNX3ybjMa0uQSjM567g==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH 5/6] Staging: iio: adis16209: Add some informatic comments
Date: Fri,  2 Mar 2018 19:02:48 +0530
Message-Id: <11a9db0dda77749c865e864c81924c0ec578dd86.1519995673.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some of the register names does not make it's puporse
very clear and hence, add some comments for more
information.
Also there are certain unit based comments which are not
providing sufficient information, so expand those comments.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index d2d1254..7363fd0 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -27,13 +27,18 @@
 #define ADIS16209_SUPPLY_OUT_REG	0x02
 #define ADIS16209_XACCL_OUT_REG		0x04
 #define ADIS16209_YACCL_OUT_REG		0x06
+/* Output, auxiliary ADC */
 #define ADIS16209_AUX_ADC_REG		0x08
+/* Output, temperature */
 #define ADIS16209_TEMP_OUT_REG		0x0A
+/* Output, +/- 90 degrees X-axis inclination */
 #define ADIS16209_XINCL_OUT_REG		0x0C
 #define ADIS16209_YINCL_OUT_REG		0x0E
 #define ADIS16209_ROT_OUT_REG		0x10
 
-/* Calibration Register Definitions */
+/* Calibration Register Definitions.
+ * Acceleration, inclination or rotation offset null.
+ */
 #define ADIS16209_XACCL_NULL_REG	0x12
 #define ADIS16209_YACCL_NULL_REG	0x14
 #define ADIS16209_XINCL_NULL_REG	0x16
@@ -155,19 +160,29 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
+			/*
+			 * IIO base unit for sensitivity of accelerometer
+			 * is milligram.
+			 * 1 LSB represents 0.244 milligrams.
+			 */
 			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
+			*val2 = IIO_G_TO_M_S_2(244140);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 		case IIO_ROT:
+			/*
+			 * IIO base units for rotation are degrees.
+			 * 1 LSB represents 0.025 milli degrees.
+			 */
 			*val = 0;
-			*val2 = 25000; /* 0.025 degree */
+			*val2 = 25000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
+		/* TEMP_OUT_REG has a scale factor of -0.47 degrees celcius. */
 		*val = 25000 / -470 - 0x4FE;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
