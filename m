Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493593-2-764716080336677938
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
    t=1521493592; b=kPYKAph/+hFAf5RAw19z6QGMWaklpoea/JsE7uZr9a5mG3/
    OMSJu3OQB+3l7tN4svqm7yJT6FxAbtsiyUP8hxbnWjrRtPYg+l2m0DLWDQgLgznn
    210CT6kzcGmjK+gyqfjVLTLIxSx0pRYW9FLugSIYLaUJDq8XOph5TrSDzQZF3zGT
    +iZ7TGoru/du+v7lJLUo2Ip0larRGRDjdyS+m1eOZQeoL12stTmxy6ixL63wtXbL
    CkNoC/0wpO3168ny2VSVkikpCs8/WVZ+ahbWMcg7ZtjEPbj4NLMw5ki52jExlJqm
    n2c64Wf15PBeXDVfrxa++tXoWbi2SIs1rwLWTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493592; bh=bG6H82
    ZUSe0kTt5cSICnzEnlRLMzksatSOQFNkgJGlU=; b=QZHX+EXZlM4a14Cl4pySoD
    SBCObjrdoR55p7+ufmzmQ6n4loeLY77d1o5RD69IxytKcDylEQso0QAtWKlH+8yE
    Hp3L04rufIz2cTCymDe6T2WI21JMTMXw7sNn8aE35XD5ZMlD88U7CnhJe4QUW2Dl
    0B/18GN8iXlvXXQ6PHmfK3NKIvU6VPq4/wOhhOWSOTZi/l6vQZpscBGgazKl3S1X
    Hr5ALu8dWR2jDOGCFiQVX6UU2od32CifP2eD+HP/sC9RFry2yDZGKAN3yI4+/kqS
    NtzdOuVmlw18ssR37Sm8isnyQvt2XXgxLSEue7RXqt073s2tkZ15w9yrIlmA86CA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LnuhP7zo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludejheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LnuhP7zo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludejheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936002AbeCSVGL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:06:11 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:22550
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965388AbeCSQCH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 146/281] backlight: tdo24m: Fix the SPI CS
 between transfers
Thread-Topic: [PATCH AUTOSEL for 4.9 146/281] backlight: tdo24m: Fix the SPI
 CS between transfers
Thread-Index: AQHTv5txf+u1h7FFik+fk2dxP7BHLQ==
Date: Mon, 19 Mar 2018 16:00:46 +0000
Message-ID: <20180319155742.13731-146-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:V67IFqe9bW3YlFTRm7LbCWuVywPrLTJlT1DFwgg6qpduAfijX88vojxzBCYNrBcIb1v2dYMPWtx1ffXNFNqtGWuF605N7VxGJ579EIcFlvTwQa+JvvxO2+bLUrOJERQyQKHCq3sLHVuWYajkmTvhdYBZ6UwsuQpfgxJj5aKuLGgLY3Dk61u1dTYRvSq3lZmQVEhgYX+Qcrm07uyWZnEID2Vh+Fmdm9FHqWTwjiLnBCOiB2eg7RGDkCkNsvuWSe8i;20:Xg1RYv/ivIjHg6kh+rihNjA8+Lm1aeULi9RWAfH94MoqhO+X7XMZsw1rGBYWkRlnycgf0mf9rnVkWVFKWVgJRTRhp8F3Mihm3VTfu28eEpmUUJPNWBgDUHZnbP+rVfdivGkiTR6ve1uSvGUYbSTZETEoyX4tQ85TMsknpyK0cVE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c383cc5-adfe-480c-c4c3-08d58db2beeb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093305297E10C44DE01B5440FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(217873001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dCukSaBwPaibxOOWaxlExmPdhDY38YdFni6BrKOD7TGl+A8lzIoX1Q3LO6Q+8l9iD/iFoDw74SPYmb0Nt0BZo76gAmL65BWHmqnXImMG59y8sDFeg3hSe0zv+iig3no2ppN+jdMqPNYg64TiO5TIAkxSEmYaWt558QzkQILF7FX4M1vIpSJz2crTYud9HigKt2l3Rj0lJTFYB453gAuygFm/fAWtaDuI0Z7eMbzsEK9QlkBET6xX5T1va6d/KnD8LPFy6Jtj6EPMrHj3ZeXSyx4bhjBMstODW1+wjtU2vSLhCtlprnq2BE8uxA1q90F7h/9/1diHkur4NSLK2XwNiA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c383cc5-adfe-480c-c4c3-08d58db2beeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:46.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit 2023b0524a6310e9ea80daf085f51c71bff9289f ]

Currently the LCD display (TD035S) on the cm-x300 platform is broken and
remains blank.

The TD0245S specification requires that the chipselect is toggled
between commands sent to the panel. This was also the purpose of the
former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
select changes between transfers").

Unfortunately, the "cs_change" field of a SPI transfer is
misleading. Its true meaning is that for a SPI message holding multiple
transfers, the chip select is toggled between each transfer, but for the
last transfer it remains asserted.

In this driver, all the SPI messages contain exactly one transfer, which
means that each transfer is the last of its message, and as a
consequence the chip select is never toggled.

Actually, there was a second bug hidding the first one, hence the
problem was not seen until v4.6. This problem was fixed by commit
a52db659c79c ("spi: pxa2xx: Fix cs_change management") for PXA based
boards.

This fix makes the TD035S work again on a cm-x300 board. The same
applies to other PXA boards, ie. corgi and tosa.

Fixes: a52db659c79c ("spi: pxa2xx: Fix cs_change management")
Reported-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/backlight/corgi_lcd.c | 2 +-
 drivers/video/backlight/tdo24m.c    | 2 +-
 drivers/video/backlight/tosa_lcd.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/=
corgi_lcd.c
index d7c239ea3d09..f5574060f9c8 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -177,7 +177,7 @@ static int corgi_ssp_lcdtg_send(struct corgi_lcd *lcd, =
int adrs, uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer =3D {
 		.len		=3D 1,
-		.cs_change	=3D 1,
+		.cs_change	=3D 0,
 		.tx_buf		=3D lcd->buf,
 	};
=20
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo=
24m.c
index eab1f842f9c0..e4bd63e9db6b 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -369,7 +369,7 @@ static int tdo24m_probe(struct spi_device *spi)
=20
 	spi_message_init(m);
=20
-	x->cs_change =3D 1;
+	x->cs_change =3D 0;
 	x->tx_buf =3D &lcd->buf[0];
 	spi_message_add_tail(x, m);
=20
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/t=
osa_lcd.c
index 6a41ea92737a..4dc5ee8debeb 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -49,7 +49,7 @@ static int tosa_tg_send(struct spi_device *spi, int adrs,=
 uint8_t data)
 	struct spi_message msg;
 	struct spi_transfer xfer =3D {
 		.len		=3D 1,
-		.cs_change	=3D 1,
+		.cs_change	=3D 0,
 		.tx_buf		=3D buf,
 	};
=20
--=20
2.14.1
