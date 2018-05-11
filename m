Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2982922-1525997565-2-13807190671858775733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997563; b=nlKfBgNe5Ct2vIv6n2T6Uisb3tFXB5Eew9DycRS9yRLSJYEsgp
    UbUKfLVFiXYLp9nZDFmI9fWCOOlmQGe2q8d1QbGmhOjs3wSCka8VsXqsPo5Kr078
    +Q7wcUfX2CRc8br7Qjwc5zwXi/UHjkGznKu0XJruE6YEmP/ehI+ydqM2Uy5i4eCz
    TQs7sJqMRPNS8lEWHaAOLtM93vs5O3GePTRplKxDylXSNC+CMMQdJcg3JyAj6s94
    cu5RC8h0sfjB828w+HZ/UPn8j9KHG9cS4W1LCepTOrRk9AdXrquUhehdsQj30saR
    SRxMDS9iHzcxtHnoLw4U3vFJaGZaA7OT9lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997563; bh=veZAq
    5z1tZzWlxtmx6KYl1GAUuyiLHCnNxdd4FmN91o=; b=jqrDOJTZM7y6xiAngLwcR
    AgR3tqN76Ii8OmCyA0jtl5aIy4LkiycmKVkHyjceThaMyNTPNKMSIUBCqJevylkS
    BLgsn28Rwidqz/r3ggEk6kqsN3R9EGiOmYNFBC+pBnxLLYHdcY7/hoCVrtP1wCTQ
    ZWNJVtpJu3z0DnZJZOrHoPB/XacUSiZkwOOTTSv7mdd/ga/cX8tGj7WiAIZt0lwX
    WOPFKPfkGiCq/wRUEmXl7q6OjCaUAqBH90ZRhyLvrtBFezUjttNvSQUYDyAQXpNC
    YP0Z5i8C0XnFZx+vYPjFpnhKAL9YBOSW/BTt4he//2g0eWVjT0uu+7vD8ASze6qr
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=NEFgXO3S
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=NEFgXO3S
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
X-CM-Envelope: MS4wfELK5iMIsM7k4Go1v7kFWDn2FoA8CQcLS7k071/f8KFr5GY4C/PCtYhCvLTF4cwaJU84djF3vWA4HMYobPUVVQ/W47IPjcZwh5RrOPJKa9k08NjFWJh1
    HSYzhcCTebqxhjLaWmyZYVfY3UGm2yc0NzOwsIgcxwFwQkZIxl7a82l/2f4KtT702FdDe/uItYPocfu+y8qgOwC+lVywvDhc/Y8h7mlk7+oZM2DZPRh0dDSi
    sQVpXy6LPmri+j4Hcw7IRA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=DnpFlQPngvoMj9eoVJsA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/9] staging: iio: tsl2x7x: remove unnecessary whitespace
Date: Thu, 10 May 2018 20:12:15 -0400
Message-Id: <20180511001223.12378-2-masneyb@onstation.org>
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

This patch removes unnecessary whitespace in preparation for moving this
driver out of staging.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 22 +++++++++++-----------
 drivers/staging/iio/light/tsl2x7x.h |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cc863e8927f5..3ae2fd19ae9c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -196,16 +196,16 @@ static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
 };
 
 static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
-	[tsl2571] =	tsl2x71_lux_table,
-	[tsl2671] =	tsl2x71_lux_table,
-	[tmd2671] =	tmd2x71_lux_table,
-	[tsl2771] =	tsl2x71_lux_table,
-	[tmd2771] =	tmd2x71_lux_table,
-	[tsl2572] =	tsl2x72_lux_table,
-	[tsl2672] =	tsl2x72_lux_table,
-	[tmd2672] =	tmd2x72_lux_table,
-	[tsl2772] =	tsl2x72_lux_table,
-	[tmd2772] =	tmd2x72_lux_table,
+	[tsl2571] = tsl2x71_lux_table,
+	[tsl2671] = tsl2x71_lux_table,
+	[tmd2671] = tmd2x71_lux_table,
+	[tsl2771] = tsl2x71_lux_table,
+	[tmd2771] = tmd2x71_lux_table,
+	[tsl2572] = tsl2x72_lux_table,
+	[tsl2672] = tsl2x72_lux_table,
+	[tmd2672] = tmd2x72_lux_table,
+	[tsl2772] = tsl2x72_lux_table,
+	[tmd2772] = tmd2x72_lux_table,
 };
 
 static const struct tsl2x7x_settings tsl2x7x_default_settings = {
@@ -1241,7 +1241,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_EITHER),
-						    timestamp);
+			       timestamp);
 	}
 
 	if (ret & TSL2X7X_STA_ALS_INTR) {
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 1097ee890ce2..db344796fc1b 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -92,7 +92,6 @@ struct tsl2x7x_settings {
  * struct tsl2X7X_platform_data - Platform callback, glass and defaults
  * @platform_lux_table:        Device specific glass coefficents
  * @platform_default_settings: Device specific power on defaults
- *
  */
 struct tsl2X7X_platform_data {
 	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
