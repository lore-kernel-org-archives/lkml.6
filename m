Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2975690-1525997566-2-6926892018585054682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997565; b=fOou8E4HWJihCTAwpNlpHEoGKgu9oOOey5qfKq/1irufI/ANeC
    lbvUY0sx7Xr6UOGsH7Fi0h3ibrqW+yOCfh2nzQ5S4LVuvu2Qsa/I7pLLhWragpY8
    etyHAvZNLSpQuDZTBV4YeRcNmQC/di5AICcc4qw4ge16UsATfw/4rOT+4TLg/w/p
    ImhO0nIlEOy/5ZsMpYrNZZlsH7SyzSgBlNb6M5lZwvODKwYgaPIDmIoYb2t4jiJh
    mDJLgsk9XAmzf65sxpXZfiigKXAXG7ai0BdO69vGe2E1nZUpAPEXq0JDA/HNR62j
    RaPJOPAWLjXWVPzYRHAzitBX3HN5moekCDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997565; bh=v8z2k
    w0YDG3NcaGyu89/Wts3OnyQXB3is4jjYrdgY2o=; b=AACWn+Fxhedp5OHBDQLZB
    LffJKITZhOBdFz44qDnc0XZZKZqMROv4w7I+jr1NkKlkWSNiRMXaamtZLsg1uIjI
    lgwydBo4r2kclSnX5MzPbY0smPvjvjwwic4y47eeOakohkJ4fnzU7Lk0k2mfNrk/
    zZ/oMR57wCnC9+xYsKAUb2VDRJjYe++eMYGC6woZsrJUfsjxFkfc1HgZXmp8tfff
    MSv4SG8CUHPsn5Ce8PFCafygHw8+hTBGRZnxSKdW8llL/yIAcWXGo4DV0O32b+WI
    qS0zyAMW6zYJisvVgcQbVT1NchgeS2z/aJtzTfoIIKxhEnit0TBm0JJEDdlaPY9D
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=gFLv000q
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=gFLv000q
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
X-CM-Envelope: MS4wfOMYr0Cw+Nmb/4+PDtBQ510kQGyDhcMQmSyRO5lFqoXz0L0Xw5uRa9cY9TDiTOA/6obCx43WevPQFzTPcoK//h47vBu9OqFrxMkvBwxmdYxng5QMou6U
    81MJqYiMeIe1TJRyzrKwGk7ZYwdzPAFZG3pSzr4mi9FYzP8eqvWcanDPDNWCWP0gB0RwQSu/Xb/mIjCCkZS7gxPmhslmDEEPl+mTCpSk3tMEXVC6APmAc9mc
    w96rAkiK8n/c2q84xZ/q6Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=qPrlOk11FTAA51DO2BgA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 3/9] staging: iio: tsl2x7x: turn chip off if IIO device
 registration fails
Date: Thu, 10 May 2018 20:12:17 -0400
Message-Id: <20180511001223.12378-4-masneyb@onstation.org>
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

This patch turns the chip off if IIO device registration fails so that
the error handling mirrors the device remove to make review easier in
preparation for moving this driver out of staging.

This patch also adds a missing error check in the call to
tsl2x7x_chip_on() in tsl2x7x_probe().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index c1e726fc87b7..f5ca5ada0358 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1657,10 +1657,13 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	}
 
 	tsl2x7x_defaults(chip);
-	tsl2x7x_chip_on(indio_dev);
+	ret = tsl2x7x_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
+		tsl2x7x_chip_off(indio_dev);
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
 		return ret;
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
