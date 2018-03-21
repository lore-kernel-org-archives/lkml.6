Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521628181-5-6424969116009815884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628181; b=Nu5ZiGznNEZZSJvJIKI2I3tjWYtY1g8Pop03W8QWdVHrFvb
    7HLFSYTeQdKhukeBvGrF2B+vmFVZmE+or7iPxczEvML2WmNw+sIXzGTMl6bNdpvb
    gDeehOtoqXSuwDof7QXt7sQ42uT0SAkjNOW3l4oju5XrXj9qfCxoMSemzQQZ2B2G
    rTewrOq/LJ/fjk6RLCPKsv/4Nv2n+oKnSDypyibn+fDvg0GExo8mDqPGuopVYp9H
    uQNWKGxtdvVIR6ezY94Pe97WVbmU7Wq3UlTxBvydC+f1DKf0OtoI1nirjoV98YVP
    TsS+NyEG7mGCFGwmOFhE/QvB0I75rW8+YBX6LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628181; bh=6
    nrpOH0kxdYTCnJxDvMHwhJAg32zAF3ZpC4LNwHtemY=; b=qeSuknfyq/yuXS5JZ
    zptBEPmGdH9w55guWly9CocPj8O1bl5zko9aT/hHot4cDtIdS+sB620TojnYpury
    v0kBT0fTnpvDf257nZYBJ+1fJdgqxp3wMxecQkWAwVRDo2MkPnFL8ImMzJzTR4d2
    Y46M4aNuFMoK9rkV1qhR5HmVg3gBRUsL/5F/dXGBvbOA5qGUpks+gdsE64Lzmcno
    +Hsjhzmo9awdSMUZx+tEjkISGe6dheZAPUVVwNSk2qPcbTg/9+hsXgAN8WFcALws
    SCo5YsEWfXyIY5wOsEbv19G6ZNkWLgRgsbCw+E7D/9u42glNAhp8ykWMcvQffVg+
    B0J8Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=NreJGdK5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=NreJGdK5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
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
Subject: [PATCH 09/11] staging: iio: tsl2x7x: remove ch0 and ch1 variables
 from tsl2x7x_get_lux()
Date: Wed, 21 Mar 2018 06:29:10 -0400
Message-Id: <20180321102912.5130-10-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
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

Remove the ch0 and ch1 variables from tsl2x7x_get_lux() and
write those values directly into the chip->als_cur_info.als_ch0
and chip->als_cur_info.als_ch01 variables.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1e38e8449f9e..65b7fbca8c5d 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -336,7 +336,6 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
  */
 static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 {
-	u16 ch0, ch1; /* separated ch0/ch1 data from device */
 	u32 lux; /* raw lux calculated from device data */
 	u64 lux64;
 	u32 ratio;
@@ -382,24 +381,24 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	}
 
 	/* extract ALS/lux data */
-	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
-	ch1 = le16_to_cpup((const __le16 *)&buf[2]);
+	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
+	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
 
-	chip->als_cur_info.als_ch0 = ch0;
-	chip->als_cur_info.als_ch1 = ch1;
-
-	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
+	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
+	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
 		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
 		goto return_max;
 	}
 
-	if (!ch0) {
+	if (!chip->als_cur_info.als_ch0) {
 		/* have no data, so return LAST VALUE */
 		ret = chip->als_cur_info.lux;
 		goto out_unlock;
 	}
+
 	/* calculate ratio */
-	ratio = (ch1 << 15) / ch0;
+	ratio = (chip->als_cur_info.als_ch1 << 15) / chip->als_cur_info.als_ch0;
+
 	/* convert to unscaled lux using the pointer to the table */
 	p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux;
 	while (p->ratio != 0 && p->ratio < ratio)
@@ -408,9 +407,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	if (p->ratio == 0) {
 		lux = 0;
 	} else {
-		lux = DIV_ROUND_UP(ch0 * p->ch0,
+		lux = DIV_ROUND_UP(chip->als_cur_info.als_ch0 * p->ch0,
 				   tsl2x7x_als_gain[chip->settings.als_gain]) -
-		      DIV_ROUND_UP(ch1 * p->ch1,
+		      DIV_ROUND_UP(chip->als_cur_info.als_ch1 * p->ch1,
 				   tsl2x7x_als_gain[chip->settings.als_gain]);
 	}
 
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
