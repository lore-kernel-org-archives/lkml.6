Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E91C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87320838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cx2FBD7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C87320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLGCur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:47 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:26304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeLGCup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Ls6U31j9MrmEmO+vs5Ark3fniNjdMD4jOXjxspTNQ=;
 b=Cx2FBD7c+8P3o43qCUMWK8cX4TKWtq0/ronIAV96tpoPd6Ffr2m7rH9cSmvZoMoExomH9yLwGtSydK80ItbmrAfjaRizJFPrKFsytqslFO1VR7uRuBd7foEzOMlfDxZGN16CDeXOMMJ8K7EOEQrTJ9nxA+TXu3BEikPx3M6rRFU=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4072.eurprd04.prod.outlook.com (52.135.167.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 02:50:41 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 02:50:41 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 4/4] doc: lpspi: Document DT bindings for LPSPI slave mode
Thread-Topic: [PATCH V3 4/4] doc: lpspi: Document DT bindings for LPSPI slave
 mode
Thread-Index: AQHUjdekfLWah/JENEWCqX2dQrhepw==
Date:   Fri, 7 Dec 2018 02:50:41 +0000
Message-ID: <20181207024924.6315-5-xiaoning.wang@nxp.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181207024924.6315-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To AM6PR04MB5016.eurprd04.prod.outlook.com (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4072;6:7PS1/IEmLCtRxu+xeoC1Q7N6+lauO2PGclyQqHPVcOcmWPMVOl9Gkd3UhzaBXCmsDajMZVrCvqSxkGFePyUEbLpcKm1vekstgYGlMb7xUw+yjsiDRDJWKSBRXTwmPnn3hxvBP7wgkcsm5hwgmvVVbUxo8aO86cJ+bBVN7CYYZ3f2Tde4Ut5661fxeTo7pWsOZiXcgkxbhOi045WRSfZY3qWfAYrxMInQyf0OGYJa1GIl1zjRr/K6zFkJh1l+rXEmaVEdU4EskRGN9rIrh/obQPy/NGfMqRc41BJRNDbjuGHwwjwYQL0uGl9FZP/pCCHVtgt4AMyJRqSVJC4omFAqULfGd2w1ztXl8h/WzdnArevwrhtbTGr376nWfVGx0UkU3GHZgv6onJubf038Wwvg95b+uoZIVtSnKqtnKlz6/LuhDXxmUnxukHjtCY2vIdgtP6f7vw1mNSv26dHRtic/BA==;5:6rgTLsxQ0jaXAnRkHaNM2MNnnB3mcxqDrGrYzY0OnWRo2TB/hjna7YT2D/jWQVY/yAVTbtwj3eNHU1oFc5pv3cnRqbLPV90h1yRPOkApIP8eoS+tyP1EmUlqDwWXQsBUUJNV07YkFKJv32PXt5mLgqqdbXwcjQcBowosqolvMEY=;7:r7pBtJ8I2wYBgsmJn5KkN7pVeJhz8Z6hyLxL+DT/O3DxHQn5HHCx8gECetMq79aAO+6oYYP3RZfOHV8fj7Y4TxLIVICsy1Qpgm8iERylg3CHbFZJiHRNLXQJxmCWSSkwQZaPgGK7I49D2BmIDXURrA==
x-ms-office365-filtering-correlation-id: 26440486-49c9-48cf-97d0-08d65beec65e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4072;
x-ms-traffictypediagnostic: AM6PR04MB4072:
x-microsoft-antispam-prvs: <AM6PR04MB407247F8BA64446741A20EEFF3AA0@AM6PR04MB4072.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4072;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4072;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(54534003)(199004)(6486002)(1076002)(8676002)(316002)(76176011)(1730700003)(81156014)(81166006)(97736004)(54906003)(52116002)(2906002)(5640700003)(99286004)(68736007)(5660300001)(25786009)(66066001)(478600001)(106356001)(2351001)(3846002)(6916009)(105586002)(6116002)(6436002)(7736002)(11346002)(2616005)(476003)(446003)(305945005)(8936002)(486006)(26005)(4326008)(36756003)(53936002)(71190400001)(71200400001)(86362001)(256004)(6512007)(14454004)(186003)(102836004)(2501003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4072;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j555rqOk3eZC3Orv4wVr9wcSH8cEtb7G3tn01d4x0wn4zS1Tah60clev6K1h0SAoJy6dH2uVEeLU81RttPa01Eka8JC7Hvz/gJiqNVyas50FGEKDuCTDybbU4F/CXX963ZgkLgOtj/SAD6Jkcls8xy7OyIO50RICXcHphuq2aYViU68ArXqa6sm3GaMgKsiLT6q74HgaVoA0SV10O5sgIrUaUaA86xvN62+yvW/gDh/GNigXrQ9b9GOAgp/6KYxI1FX8tUeUgAWftO3QoLNexF94KHxRriJI4U89b9i7uv1tvxumoncl8sy1bMqMhrISazL/lAyYvnEQ0wzbGqNr7ezL5YPKn731j3BO+b0Eh+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26440486-49c9-48cf-97d0-08d65beec65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 02:50:41.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:
 - No change.
V3:
 - Keep the description of "fsl,imx8qxp-spi" in spi-fsl-lpspi.txt.
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..6cc3c6fe25a3 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -5,8 +5,11 @@ Required properties:
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX=
7ULP soc
   - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX=
8QXP soc
 - reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- spi-slave : spi slave mode support. In slave mode, add this attribute wi=
thout
+	      value. In master mode, remove it.
=20
 Examples:
=20
@@ -16,4 +19,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
--=20
2.17.1

