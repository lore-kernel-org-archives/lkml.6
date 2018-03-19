Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498511-2-4405117381748547654
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
    t=1521498509; b=H+gAd+VoWteHszdlPBAlEcLWD0gx6y7yn8KeAUNbkzzcwy/
    kLHhX1JS2Q64/04DazGDn8wZIhmVrje7r0K+RQwArEfABnDkTTU2GX/9SWprCFrM
    qWGLqStlp2V/2Tel0HK6DwDjbtu3EQoMdQv6zeNiYlnpHRhQ6/5rD20KLTtGvB6i
    R80JON4mx3cj49ncIdGaDcnNP1xVglQ+Lbg6Un7svUDNhV2Bq3SvmqHOPqn3Vmko
    QtJwqFU0JR2vbTccablWltMAN92ytut+p3rIcRVy14VwFMFOd1fIU19kZ6LhxpYE
    L7OoiuZ1tuGimv+tuWj5MLCQ/bAUzo/G39XX4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498509; bh=bG6H82
    ZUSe0kTt5cSICnzEnlRLMzksatSOQFNkgJGlU=; b=XDqlFCMzi9y1vXEGR5GIe6
    TqWVK0AehIaQtUx46SbV0MCulgmGpkzYG26r9FAU7qWyknY5RmI2mXYX6US9ahlJ
    YBdXGSK5Esnun9kOlJ1/au9q1IPN2oLh4rObQ63HCS1zSgkrVtEKEg+l3mjRDWZs
    GQFx63E3dW6DsD4FrRYR9rlp5KgdSdDG3oWRj1IQExQv3kmNlk/BhtgAY6sH8P3L
    erohKbEFMDxT4NgP2DnQjenL1OyHQIBZi40EQ8JGfCj7USteKrcoRK64OXxsvvUO
    FOZY30A5KDPtJF6S/az45A5VXDCOScs7DLKktmKvyQCNFjdG7UbHaLg7SdjDsmJg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Iheu8hA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeiheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Iheu8hA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeiheenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeCSW15 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:27:57 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:15712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933826AbeCSPsu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 059/124] backlight: tdo24m: Fix the SPI CS
 between transfers
Thread-Topic: [PATCH AUTOSEL for 4.15 059/124] backlight: tdo24m: Fix the SPI
 CS between transfers
Thread-Index: AQHTv5mq2fIwjklnbEKM6TTgp+JMfQ==
Date: Mon, 19 Mar 2018 15:48:03 +0000
Message-ID: <20180319154645.11350-59-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:kVmiMRpbzlT3IvzSvK3ZjXAboEeb3ehZ5ZLBAAkgE4u6fspFDPXR8NDiGBC2PpKU66Xi7Qu8KuieiDSImgI97ikiGb6SAq25MuZiEN2aU1nht9GpXj7U/4N/hFhqDlDWkiDpoBXP43dDwT2n71oDkfdBAzy5i0vTNoSzdWrLVTdX7Ec3jj7I6LiVHyRLiNa4vNz8LM/MqPVOFxFXjqhxbwWhScU0OqkGkoqw+ybuGAs5FJKYYVN+r+sMuKB7PPWa;20:25myHgv2PcnRmuURt0DjlGDq33IrpQL/PLyJ0AjrAN0fQJQHBWOO9vw8v5zOF9mztS/T8NrG1FNzfYZAC29aHzFFSJ1iPc7ictSgS9vynizOFtx69u3Q7YSf/onRMg694hKk++kOu+brYSx1ks3ltSeHzs2w6k8tUp7mV748IfE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51635b78-a54a-4f48-16f5-08d58db0d599
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031FB4EE88A6A29157272F7FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(22906009)(15866825006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xfEsllvDL8ENtTGdUv0SDgxEpvnGIfHlm1WN2CjbGaZCV5zvGHIGjelRpr4M9kulneEsEF0bY7dRAEKMcvqeD2IbaeJdeD39bPbFLcYuff5fKtZiplwKHofKM55SzE7WsSuCgRi5b7yrp2sOmA/juhFBCMibfb/37J3/NmCTKFiduwErmyVP/LWVLXRp23cOsha+uroIEBk5+bzp9P9mnPMIREJ1Q9LpCD45YhD82DxiJKsinAA5iAqXpB+KeuorjFvzwWlcr3SfivLYrSd1e5DsI0auVJVXlL0j6gURofM+9X8E9fEEfV5f/YjlzGpjuWZJEjQYTHNi7RGIYEwGxA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51635b78-a54a-4f48-16f5-08d58db0d599
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:03.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
