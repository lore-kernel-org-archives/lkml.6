Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236247-2-4697956059905008294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236247; b=v+nDgQ1zN98DnY6Ky0N0RtORJgMHAy7I7Ty5BJG0QhhEj/F
    7xBSWU5z6wQ8BgI18SrE9rdV4bcUJwW5JPw9VsFOfFn8JmVIKQTROdRoqUIz5RVL
    3RMsFM1cuaEB7Ry9IaQtQQCJ9/RkIf8KzhwPmzxNGMU8UQyP01fuckXu/9I/t1Io
    cWhm0JT0MN89Q+XSyXOjYMbqu7RssWRQS4LWuv0olUGf0U+tQneMdSl4Bf8heKXb
    YmHy8ko0Pjvf3IjKsM6rRJkpGDRDeDDe4ZcixcSLynQs2j/joPwMngs1vfjEZ6Of
    9Z8SmUQMExgdxxnYOxzZVEzMK+ldxpy8sxSbXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236247; bh=Z
    NiD1c+v3d/aSnIEJMc2Ig+FjKUpZkdj9yctj0N24MU=; b=WPlEYRVzeeTCars+P
    ChBcGbopJxBCxaxDv9qMW756l4DyB/Ua24Uu2RMa3QA/GX5YAEekjxOtb2KObDKj
    3lUM4sa4dOR0Van7osDQEcJHHByBcbni0HYcKO6jdOyXalROBFDitjkfYd8bq0jo
    M8nFGLe0Esm0CxLDvTXaqtRT9Eqp5U6D8FDQHIZX84b+EReKJxJKVU7YO5NpBMC9
    c1tOujYVVVopnR69jguudMAx6h5nb9f3KofBqq+hSAretgE7JmMXVWSYI1p2Jt0d
    yHxX5mls4Q1MObgQw7YzjUAPwZhQ8YbzhakFtf4NUMc9s25zy5PSZDTqcmLZKxxw
    CXx/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=om+5mHN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wfhxjig9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=om+5mHN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wfhxjig9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtBwnLmhbf077KZKA28AuIaWE/c+DjrARyPerS3esSkDfH/EQ93W+SAFLe/TkZ3RdN6j/ZyTA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 10/11] Staging: iio: accel: Add comments about units in data
 read function
Date: Mon,  5 Mar 2018 13:19:29 +0530
Message-Id: <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clarify the conversion and formation of resultant data in the
adis16201_read_raw() with sufficient comments.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 8d795e2..946c7b1 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -130,6 +130,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
+		       /*
+			* IIO base unit for sensitivity of accelerometer
+			* is milli g.
+			* 1 LSB represents 0.244 mg.
+			*/
 			*val = 0;
 			*val2 = IIO_G_TO_M_S_2(462400);
 			return IIO_VAL_INT_PLUS_NANO;
@@ -142,6 +147,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
+	       /*
+		* The raw ADC value is 0x4FE when the temperature
+		* is 25 degrees and the scale factor per milli
+		* degree celcius is -470.
+		*/
 		*val = 25000 / -470 - 1278;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
