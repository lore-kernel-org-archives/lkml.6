Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-477182-1521921981-2-2442673134188725412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521921981; b=s5DU7gWkrnMSq/JyTyhhmUK9EHIaMNKTelr0z8FagAYK2vF
    8e9VzzrOk14ONsCIPWg4lQKJFO4cTVOIG95DCm720708LRPUSGSG8RFjxDaB6is3
    rY7/QU5ZOGprrG84i2FivBVzFKt3VPz4VIniRvGpxPkaGsdqYW3r6clgH+wGE8I/
    wWQVTgEjQbSbv6f5AeOQQ2ECvDHFyJPG2/1xEfN1oOB+jT7rBvVCEKPm1dGUCKmA
    92zDRm11eJXlL/qnMiMHiYogXiXC8Z+7DrHgPNRytRPoGSDg1bSM9aiAYgAeRkaJ
    O3RDDoW5syLOotzthUzv+whHkZagdyaukWVhhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521921981; bh=d
    HH8y/EBaWhxl3K9u6+h8OG8kezft1sPPn+nyBn3rbo=; b=MMF7cgbLYzx6TI8SK
    J8J/F5xwUKyERk6rBftTHHBywcVHtRiE2197QRahHHlS7zn37HNbgaWiXq3hgJ9G
    +C1TZsWfwT1lWPG2Z6pjNpD14uuiWcJTYVNU0yU58hAgrLSFupBkLXdFSq44O2oy
    GwoOg8uX2gNTzEnyfwOCDGEmFLe4HFHLgk3MpHL7u00n2Vwd+UEQuRP7zM7XUmqK
    MUBoQ1PmPB6dQmR7L31tnWUWCMOcuIM8EBer6wYbenDCftlm+i8CfCcCRpW5Kthh
    lcANBAoh/2LI9uVEfOfhTmp5brqtG0zvcknluTHHi6Ll0EY/MQjZOQPYUio5Vhpv
    uoWAg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=D9kvvlFc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=D9kvvlFc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/4] staging: iio: tsl2x7x: use either direction for
 IIO_EV_INFO_{ENABLE, PERIOD}
Date: Sat, 24 Mar 2018 16:05:54 -0400
Message-Id: <20180324200555.1403-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200555.1403-1-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
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

The events IIO_EV_INFO_VALUE and IIO_EV_INFO_ENABLE currently have a
falling and rising direction configured. There does not need to be a
separate distinction so this patch changes these to use the
either direction. Directory listing of event sysfs attributes for a
TSL2772 with this patch applied:

in_intensity0_thresh_either_en
in_intensity0_thresh_either_period
in_intensity0_thresh_falling_value
in_intensity0_thresh_rising_value
in_proximity0_thresh_either_en
in_proximity0_thresh_either_period
in_proximity0_thresh_falling_value
in_proximity0_thresh_rising_value

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index d5a237fb0a0b..940bea2378a9 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1469,17 +1469,16 @@ static const struct iio_event_spec tsl2x7x_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+			BIT(IIO_EV_INFO_ENABLE),
 	},
 };
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
