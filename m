Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2940329-1524271350-2-1168885525395132888
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
    1524271349; b=ALi9tNPWMNgFIuSVwUkvDTxJkJYDdcBHCo9ehqcxg7kX4pPxVE
    oUA5XRxoaBlFW2CG+CJJmpSTOkqwdTcM33vcr/FhCLAPPLttVPXIJQ0/422VpWlH
    7cf+3JHTv3ana2SEghEvp+rGE6uzM5J+sD4LMeLFgZQbvETiAOj6ay78YoZQBBBj
    w7idxWDf7vb5dc4kzcUNGKAIusx29KHMJme7FCp6CkhdcfcdDKxY4vWQo84w1REd
    pirnhZMz7frxyvzl25BMSSsyZzkHb1seD4iNq0sbxSObPKlDm00Zwkma0xa0wesT
    IouYF2XoIO2cskJO4zb2rXVTnZ8+kBeNHqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271349; bh=pkOth
    t9esPiYa0S4Rfa/O1hNgTtighSZ36MgFSKLwcU=; b=W3WcFqyPTjstdaetTvQGY
    P5+iYbkQkD0x5VwIWIxQWofkv5Q49BLsYlfOa3SAeiLvKlglxc+q9w1wmzcPXays
    Yq2oR87RLiGt/0NFUN0ZYN/5V8iBT5mPvrV2WgOj8SVDwV+buaaC5BWIYKSP7bJN
    fJFt2leeS9QRYtR3l+rCzJHPS21VBvaXwRHpPgLXwww1iUiHf5s62iSKjV4z6s2x
    wryEu9k2DRE/OsBvVNLqYkEh+09TqqDDETSQb+O9I7aByEIxSiL/qq45TdALxFfc
    RvacgtktXdi/hz1JfTZ80ZvL3OC6Mw8syj4WHNzeLI+onGSfkeN4JWtM5ck/muEo
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=srkm+5Vc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=srkm+5Vc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/dlTWe+WlqLL/JuC4e3QMUd828IvljmsrRZfmx8dUjmfXnE+msaK35ULqPnbHuUIEv4dYngqql57nQ2fexuCj9Sz+glxgCziGr+fRGo5Dy+uWLxYnN
    /QAa0gZazQvBUWlAweY1dbWqsvo3WvxG6vKym5PBLk90Xds4OcDifpap1r4dmJ4uIvppZE65lTpsqorT07AbLVbUGFhKdAY8PT68B8AkdJfg6DoBd4UJfaJ2
    8Is5/YFwkQXsBjOGZRHbRA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=DlxmyD7xvutBj01CuwQA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 07/13] staging: iio: tsl2x7x: simplify device id verification
Date: Fri, 20 Apr 2018 20:41:47 -0400
Message-Id: <20180421004153.19073-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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

This patch renames tsl2x7x_device_id() to tsl2x7x_device_id_verif(),
removes the unnecessary pointer on the id parameter, and only calls
the verification function once.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index d202bc7e1f4f..56730baea927 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1277,22 +1277,22 @@ static DEVICE_ATTR_WO(in_proximity0_calibrate);
 static DEVICE_ATTR_RW(in_illuminance0_lux_table);
 
 /* Use the default register values to identify the Taos device */
-static int tsl2x7x_device_id(int *id, int target)
+static int tsl2x7x_device_id_verif(int id, int target)
 {
 	switch (target) {
 	case tsl2571:
 	case tsl2671:
 	case tsl2771:
-		return (*id & 0xf0) == TRITON_ID;
+		return (id & 0xf0) == TRITON_ID;
 	case tmd2671:
 	case tmd2771:
-		return (*id & 0xf0) == HALIBUT_ID;
+		return (id & 0xf0) == HALIBUT_ID;
 	case tsl2572:
 	case tsl2672:
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
-		return (*id & 0xf0) == SWORDFISH_ID;
+		return (id & 0xf0) == SWORDFISH_ID;
 	}
 
 	return -EINVAL;
@@ -1612,8 +1612,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
-	if ((!tsl2x7x_device_id(&ret, id->driver_data)) ||
-	    (tsl2x7x_device_id(&ret, id->driver_data) == -EINVAL)) {
+	if (tsl2x7x_device_id_verif(ret, id->driver_data) <= 0) {
 		dev_info(&chip->client->dev,
 			 "%s: i2c device found does not match expected id\n",
 				__func__);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
