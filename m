Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475243-2-11142250698442946277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475243; b=VKEAuPNB9eU8atbNN8KKWYjj8fQZdPSudrEgzmti3U+AWht
    SHy2HEb8kKx2qCRCb34Ha4+GmWeLG1KIlFjIsqa9HTt8NZYYlpaOMC1q32Oec3Ei
    vTlo7SP7xHV1VeAMlKFjSt16v7uBR6W/4i+QX2SKQnWZrZTtYECJYpH46d3aEi2Y
    zg0pvKHmHvt/kS2hix1xsLZPURVrR7WmDiy3T7oZQUJ651uVxmf2yhlFBe7FoC3i
    NdpLawDr/NWmiBWCaPvRCkVVbNKItGrRMrhCkiGWNcuD2wNcPAgd4Bvp9Kh5HpnD
    QVp8+xunELq47FEX/qVgrB2fLmx4GtB2yHyceCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475243; bh=Jq1pFI
    8+GsJd6ZgMPVraD7F31rj4WxVosls7nuxat/I=; b=qmuEjFE2E9exh4SPECdqiC
    9zOomohaJPTlnSY+zli7377Ods4c6bi1Qc/QtCeoJC+e0LwOdmYmw4Xzu6WF/+G9
    jYapk6M5n/pgG/v26nDbTglZoRfq4YaYKSJJZacR6RtjwiOgq01gBCP8ME604Mfx
    CtZM310k2qYywScXPwZCaK7Lyaedx40ffDDCwj5DELUIwBytWTPVCeJJIA+uu3Pj
    EcXndSQDolPw6VZwqYrMFho/xWc0uWpMnCaX8V6ugi3e6hN680VCKsPISJJP4p6t
    Kp6HaNq4qiTm2q/2b2yY3LRKiLCou3YM4+VDKpNedggBqOT6nSb6rwMo1VyI5PWg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Znd1TZFJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekheenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Znd1TZFJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekheenucevlhhushhtvghrufhiiigvpeegud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934867AbeCSQAj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:39 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934858AbeCSQA3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 085/281] iio: hi8435: cleanup reset gpio
Thread-Topic: [PATCH AUTOSEL for 4.9 085/281] iio: hi8435: cleanup reset gpio
Thread-Index: AQHTv5tFkzFhrTlzgUCsTSBz8HywKw==
Date: Mon, 19 Mar 2018 15:59:32 +0000
Message-ID: <20180319155742.13731-85-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:9fcSRUsXQZGJLtsNG+ozdTNAU98spU2Mq2Sm6j3ABR/qhUTtBEM4TGW+iAEvvjPOLYR0VNWxAYAlWEOQW/5dCvzjcvO17D5lr4VCIKw53nAzRzFcFuW25rCUVc2/zAEZsS5FxCH2IJ+4wLGpCR2TbACr6PCzp7UC09+kzN0dTinjvfAPSBoFBEW4Kx95Yc7gbzX0GDY+qG96gdDDaqzaBB0sgd+hcd7ab1yGGzfYq53INYzPZvHO/uetnggZISKZ;20:hxsqAAhftfZvMS/YN9FC7ByzLK6IWo2sOh1bRdXLCKDwHQvUBVizcIJj7yTAwhi1DYJpHFzxDlDdZDLJGyz6l6bAM7ch3QZ5nKIaAUrF/0qFxrSh20W40U3wsyhHlFb0T2YTnviWwM1Z+6p0y7/i1qkNetMj5CGBH17RuDsMBpM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b889de3-3af1-42dc-abcd-08d58db27be6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869A20782DD823A143AF33FFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hf7dB21JiSo3ltOZWsDaRVCt24rFEVtDcAv6WY+2fJX9tBeNFIB7VKmtq6Okk3xw87oxVB5JSYVUOozknSHHBe9c8eakZITPwOsew03tQ29BaxqObA5L6m62wrgylOWTHdZ+8GqgNn2Yrz7CEdCeHTmcOin5zPVrQ17oUKfdd6HcM5WZA8s3BBR39+xAOXSLw2Bx62KIC3MQb6wGPNpG5isq4YoA9Y9tnyOOpaM/g7cGu25I1wEcnWaA9mdwOTO0xcMGIETyBDqw349TD7Hrhk5lrkmtNIzaD+YozFo9KRKIKR2UpFBRgNe46jDlr/Wqxq7cMWFsznhKW+tjLb63HA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b889de3-3af1-42dc-abcd-08d58db27be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:32.6377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

[ Upstream commit 61305664a542f874283f74bf0b27ddb31f5045d7 ]

Reset GPIO is active low.

Currently driver uses gpiod_set_value(1) to clean reset, which depends
on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.

This fixes driver to use _raw version of gpiod_set_value() to enforce
active-low semantics despite of what's written in device tree. Allowing
device tree to override that only opens possibility for errors and does
not add any value.

Additionally, use _cansleep version to make things work with i2c-gpio
and other sleeping gpio drivers.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/adc/hi8435.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 52b2dcf1d942..fec696ec3fd1 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -453,13 +453,15 @@ static int hi8435_probe(struct spi_device *spi)
 	priv->spi =3D spi;
=20
 	reset_gpio =3D devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio)) {
-		/* chip s/w reset if h/w reset failed */
+	if (!IS_ERR(reset_gpio)) {
+		/* need >=3D100ns low pulse to reset chip */
+		gpiod_set_raw_value_cansleep(reset_gpio, 0);
+		udelay(1);
+		gpiod_set_raw_value_cansleep(reset_gpio, 1);
+	} else {
+		/* s/w reset chip if h/w reset is not available */
 		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
-	} else {
-		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
 	}
=20
 	spi_set_drvdata(spi, idev);
--=20
2.14.1
