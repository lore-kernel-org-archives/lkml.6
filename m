Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2989163-1525997570-2-5542557218739635891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997569; b=e8AzAIBSX2R3wDBWz5Jf2vbabKC6zKZBuKDwdBNVtmpun2/ra6
    TFUc/TBPUpSTQ2cQ96NVCREyx4tBRnxKVlIRy0r2jy/r6K2dotp3Jd8BVMnw9gJX
    GOknYlEtSBoCfavvEYr8g05JGyOf2pV09TKv3BhJod+PuEkEC4hMrH49M/qNKDMd
    d1c/MMjC1bUsglR6tMLjMtdjSZmd719Pci0BJwBo45cLTymzvYy3k7QfNFPSeQgD
    wJGNSC1VqC7cYvKPV+EsDjSTvi9HXQ6xQV/q3Oyq9/guTnJGeS4cE0Oq+H6DPag4
    9pWiSK0WeBxav7TUbCGB0BlWPasvYvsHirKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997569; bh=VDmmJ
    eXoIATo/thzqfxaEVHrqIhWkQYroykUV4+oLf8=; b=lDYlE+JlwnkJ+B0vRmB9p
    MMcjmItLwaCDBTDx6MBAry8nY7paOh0PfpNyjtLQFFyyU8uhe+9NeWe8mPhY11bt
    kJR9SV6V8waol53TGCgGf1ozwru5YCWFKdF7NVnZVQgU3mddd0e5eR670F4bNUg7
    dFreQSKB4RGW3UD2KhpGL6IURGBgNL0Cqajux8afcuhZ+zQHwbI68GXfmGUG8yww
    6srApuIm0EXv/b9JrwxDJDoaZtLFN6HjaQqXJ42CdwkpQSyzcyJQ+fbPVKi6BMBg
    0TlnD96mN+l0i39lViaNnPx2kFCOzoT8STN3mILtyse7nZgmiD2URTwzNGMR0qFn
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=JUbNCNEK
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=JUbNCNEK
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
X-CM-Envelope: MS4wfLsR3SoH1ZV2P+vrciSGem7xeUussckDPBhgp5eNVoNwVoFjguVaXDk+DqRKJBZ/vvtEMvJtLUZsRTO88oLsPvBBIjfhR/+4r2dDMohP0BptVECx7V0b
    QImEIyRhhVt370ETrllgY/Qtauuk4zPE4WShKEFxwgayHSZFsyl93fUkA6Pgl2BKGc53aEPB5IwwOt94WoUtKH3zCAeeIdM1/9NBhDCmapgLxSfwAH80YEau
    +hwCTDL+VfmTflkgXs2K3w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=bzlasn1I6SXQn1qRHlYA:9 a=Q4oa_FTWs_Cg_p_3:21 a=vgM0KxnB1k6I1cUL:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 7/9] staging: iio: tsl2x7x: add range checking to
 tsl2x7x_write_raw
Date: Thu, 10 May 2018 20:12:21 -0400
Message-Id: <20180511001223.12378-8-masneyb@onstation.org>
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

The CALIBBIAS and INT_TIME masks in tsl2x7x_write_raw did not have any
range checking in place so this patch adds the appropriate range
checking. The defines TSL2X7X_ALS_GAIN_TRIM_{MIN,MAX} are also
introduced by this patch.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 0218eabcd6d7..f9500afab30c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -103,6 +103,9 @@
 #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
 #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
 
+#define TSL2X7X_ALS_GAIN_TRIM_MIN	250
+#define TSL2X7X_ALS_GAIN_TRIM_MAX	4000
+
 /* TAOS txx2x7x Device family members */
 enum {
 	tsl2571,
@@ -581,7 +584,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 
 	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
 			lux_val;
-	if (ret < 250 || ret > 4000)
+	if (ret < TSL2X7X_ALS_GAIN_TRIM_MIN || ret > TSL2X7X_ALS_GAIN_TRIM_MAX)
 		return -ERANGE;
 
 	chip->settings.als_gain_trim = ret;
@@ -1209,9 +1212,17 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < TSL2X7X_ALS_GAIN_TRIM_MIN ||
+		    val > TSL2X7X_ALS_GAIN_TRIM_MAX)
+			return -EINVAL;
+
 		chip->settings.als_gain_trim = val;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0 || val2 < tsl2x7x_int_time_avail[chip->id][1] ||
+		    val2 > tsl2x7x_int_time_avail[chip->id][5])
+			return -EINVAL;
+
 		chip->settings.als_time = 256 -
 			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
 		break;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
