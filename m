Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B51EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7321850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qu3fOdnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeLSKM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:27 -0500
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:54784
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729046AbeLSKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQMdJRuZhrf3FPGVR1Fda+dT8eND4c5hppQNjlgocd0=;
 b=qu3fOdnH0GBih5tSOfUY0Zk4uUVpDStVoChJ2fgQsIyS0ugONCKzc6qAmHkNtv79f9sNjAPr2hEaEvd+csD/IOr7JhgOkw1f9i6euOh84PRC8z52zK4r8EWMp8sYPvl5u1SvE4mF7/NCxHwWS6NXHJ81dfOlanlvUYCq84zuFrI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6141.eurprd04.prod.outlook.com (20.179.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:12:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:20 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v6 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Topic: [PATCH v6 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Index: AQHUl4NTdJxg/UgGtEeSFbAm/QNYvA==
Date:   Wed, 19 Dec 2018 10:12:20 +0000
Message-ID: <1545214186-16987-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6141;6:0T2OyCirj3fH09WaRIXscM85i9cQEUY4YsmJNRSDf0J9bjDsazRV/Ei9MJKAW79UFdsS132ThEmivCl8jDSijlJfpGeVOPf3sVP7A03uA9QJA2QnhZ2NfUOC3ivLfYylrZVRhjaAII8T8pMeV8PRYyoZ3X5nSgN+9GRoMOUYSJ45SJ32y9Ft7cTkC/r0k+beUF2Z/1Z5m0swwj2NGQkH1WbwwRxOU9xCYcOeUp+qTTyBYRj40VZkC+V/6j98g1u0teZkZVqr2VzGRX+hwM0msKP6cVUWTMHkNF5oAYeWwH5fFWPuscCDK65EuEs0UxwGktGECVqqS9phWMNPNUcSaM63lTr5CQnPzyq6EXa8LKAFMvt8J69RiaKin+vTeRqeKPbVli2r0TZHfrXAYEbnP8MbE54v9L2ZJYodIqsKoUroJt7OhaQHSPVnkp26GfEPEhayMhfDWY4KKizugkzEcw==;5:5HuuEd3LPHmHpgYT1ptaWlO4htQMhvfP73EG9FJf+XjpfdR3uk6cjXJW/ZUovDInEhwCz4zwU/5eEHl6wWcuIHga4HQXZuvTUWZEHjiO8zH3TqSPcS7anyUsbiSgUnlt+Fmv4d4ZTBDbiAG0tV3dMUT4XhHUg2OmQvHgZHuMM4U=;7:3HH8df3QrqFOJTceRnlURTb1SkfS2kiaRMUnROjhcCxV3f3p31Z5AN2tC+z5/FX4x4ZX9V/AFTjfvEyG1lj6ZWWkRub5cE5kJGVcPX+fZ8JfuVBmi/Qw6fkD6J9EeKSAZvLHUJWVwjNrv9FbOla9wA==
x-ms-office365-filtering-correlation-id: c2c11697-fdeb-49b0-b642-08d6659a7611
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6141;
x-ms-traffictypediagnostic: VI1PR04MB6141:
x-microsoft-antispam-prvs: <VI1PR04MB61411ECACF4E593CE78DB2B599BE0@VI1PR04MB6141.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6141;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6141;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(39060400002)(78486014)(386003)(6512007)(6486002)(53936002)(3846002)(97736004)(2201001)(7736002)(6116002)(8676002)(55236004)(4326008)(2501003)(2906002)(66066001)(25786009)(76176011)(52116002)(256004)(486006)(6436002)(102836004)(7416002)(105586002)(106356001)(36756003)(81156014)(476003)(8936002)(186003)(446003)(86362001)(478600001)(26005)(54906003)(2616005)(11346002)(71200400001)(71190400001)(110136005)(81166006)(68736007)(14454004)(5660300001)(305945005)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6141;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pAE3BqfUd9Ppo2AhqDb5A36s3pVLK58H1QJtZ1ATH2Jr0QeNP0SHTfeMcBtrrU2kE1fpeqLT+hRurag58uq4VuZeB2URFMPmccB5fgktyVz1/IoTK//8YPJCLnzzp097XNyGuQXmaH1HTxjVBsQGauOFscm6wdICLcR+i94VtPgtejZXTl2I7SVqg3zLyNB8nOwhvoKkFv3Jig8O+RBT5MFIBBHOcTPI7yEFyA5qmXJU8GipJbWSdPy03xP38ajsoB/eouAwbpsbSUNLyGB0jIyPjVAEEgKtxL3bDdyj3ANKN0OGZUKI6dy1hT9825Bx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c11697-fdeb-49b0-b642-08d6659a7611
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:20.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6d497f4..cfd3126 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -995,8 +995,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.7.4

