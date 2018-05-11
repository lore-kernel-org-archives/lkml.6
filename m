Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2989163-1525997574-2-12528318936497536179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997573; b=Fc9wZmUBxTA2qbEMt99gGGh1Uf3iCqQ7QRkHWHfmS8MyULjykn
    QiZWNwsnQ6FBKy6FgGU7GDCXOrQyhDvR/9Yv8rYRoVIu6oXyR5KB4LXc2DsUUcBL
    hdC/Yi3slnBau8HGEI6/fAu7HtjGDpwRSmXYBB8/QxpbEAicqea6R5DhtP0yMrMK
    1rkVgKU8ixZJB16NWYVeb6oUmKdJc7EOy4xmHNJ81CTypNRo8bkX+nN4v5SB58eu
    01aglk7O+wTI0iaxdwtUeQXEjT4ezGngq2l9PIQOH293/3hK/9Nm+mbIeOAYjTI2
    po7uWsB1OiYctnURrtBA00trXlV7sNdBoY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997573; bh=t6TBH
    LmyvKp33VPZBeHSQanqIDXC7jr5XU+AxGjjJhQ=; b=BexSJC0ai1ORili8ylmq+
    DDf8Qw0BKpxcCxmNy68ElbxaEdVPM5w/HpKCm9EjAhjKkQ4mMtLjsf4giLGLR/Vu
    OSjY6OMg7tKaPU/4tmbAKMtoA+J5GmBdDfzkjkRyCkWvPMZCzmsH3fjrOTdZH8yf
    39ZNsTEaCEnIZ56HnrfNjNgwZ/RdMyaGeMFW5PrKDWnIhCOwXwlzlYQAE9hQxB4r
    Ol2VbQBMH3p3t7Ffl1CygSvFUSI02/yXfBIRdbW3PzcIWIhlKW7iaIj5z77LlgHm
    StfpMlnrd6ste9F2CL/OrftyR/jCCBd2Kv/u2ZTMs4DVDcS+87dXL8dgO1EnBR2L
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=E9wdu7Mc
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
      header.d=onstation.org header.i=@onstation.org header.b=E9wdu7Mc
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
X-CM-Envelope: MS4wfDsFZCMdnUabLubkUj0krA/slSifS5ZR+oLsTFVdy1qjYM1MHWIOllIJondOmmXHLIS4kujsFsyd6fkDRAO7CnDQbmKf1Hvu3jEC/7VGTA9YjXFue8wo
    keutOnacE3LD4hb7nNUvMe1TlUsWJ9AdJHEBCMFR5DNnIffDm/KhpN44UM18JXlscAJD0m0Hnk6SXLP4gEKDtvnFri7VTVzocTcCj661LTyjk+7jTZQklKVo
    62w341+xJ6BQ5NZXyLEL+A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=qiDtuMH4x1dZe14e2DsA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 4/9] staging: iio: tsl2x7x: use macro to populate
 tsl2X7X_device_info
Date: Thu, 10 May 2018 20:12:18 -0400
Message-Id: <20180511001223.12378-5-masneyb@onstation.org>
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

This patch creates a macro that populates the tsl2X7X_device_info
structure to reduce duplicated code in the driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 61 ++++++++++---------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f5ca5ada0358..51c1a90cb592 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1305,52 +1305,23 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
 	},
 };
 
+#define TSL2X7X_DEVICE_INFO(type)[type] = \
+	{ \
+		.attrs = &tsl2X7X_device_attr_group_tbl[type], \
+		.read_raw = &tsl2x7x_read_raw, \
+		.write_raw = &tsl2x7x_write_raw, \
+		.read_event_value = &tsl2x7x_read_event_value, \
+		.write_event_value = &tsl2x7x_write_event_value, \
+		.read_event_config = &tsl2x7x_read_interrupt_config, \
+		.write_event_config = &tsl2x7x_write_interrupt_config, \
+	}
+
 static const struct iio_info tsl2X7X_device_info[] = {
-	[ALS] = {
-		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
-		.read_raw = &tsl2x7x_read_raw,
-		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_event_value,
-		.write_event_value = &tsl2x7x_write_event_value,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
-	},
-	[PRX] = {
-		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
-		.read_raw = &tsl2x7x_read_raw,
-		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_event_value,
-		.write_event_value = &tsl2x7x_write_event_value,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
-	},
-	[ALSPRX] = {
-		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
-		.read_raw = &tsl2x7x_read_raw,
-		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_event_value,
-		.write_event_value = &tsl2x7x_write_event_value,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
-	},
-	[PRX2] = {
-		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
-		.read_raw = &tsl2x7x_read_raw,
-		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_event_value,
-		.write_event_value = &tsl2x7x_write_event_value,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
-	},
-	[ALSPRX2] = {
-		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
-		.read_raw = &tsl2x7x_read_raw,
-		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_event_value,
-		.write_event_value = &tsl2x7x_write_event_value,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
-	},
+	TSL2X7X_DEVICE_INFO(ALS),
+	TSL2X7X_DEVICE_INFO(PRX),
+	TSL2X7X_DEVICE_INFO(ALSPRX),
+	TSL2X7X_DEVICE_INFO(PRX2),
+	TSL2X7X_DEVICE_INFO(ALSPRX2),
 };
 
 static const struct iio_event_spec tsl2x7x_events[] = {
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
