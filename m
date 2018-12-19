Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD7CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3272721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wXIEvwb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeLSKMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:15 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:36564
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1tlS7ho++5Rx4iawIVFndi/3E0Q2Fxut6iz8EC1nNk=;
 b=wXIEvwb336hHL7SVWWqZfjwdvWkL2WF0/ha9JlU9F+PBQj2UNBpu0o7uXu2qGw7ZeZRRA56lEE/myeP6DgalBsJzYjSXCWTTW18SjWLrmqqv2nctLlR0SLsXaHGBGs9Q7TMFNae+jo20TGUgut+Pmd93r4enXv8UQTgxWqlQzVU=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6141.eurprd04.prod.outlook.com (20.179.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:12:08 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:08 +0000
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
Subject: [PATCH v6 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v6 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUl4NM9R1591BDBEy3Eu6k3jnBMA==
Date:   Wed, 19 Dec 2018 10:12:08 +0000
Message-ID: <1545214186-16987-5-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6141;6:nxkDuO7Ae0oDYsz6QexlK4W+Vk38psKVP+a+G/j4SS/G+GdIq7uS5rY5l0yZnvV8PUmpMJVYHYHpA2uPdmBTHAGoFsq3lENrG3F23lqKBZt/qZSTZk+NnFy6qfluWcaEYOniC14d2nPvPjS+yvN36bPRC1sui6Jebm9vqQx+u3GxEuhYiWjPRLpvLk8t874zB7Tc/GB+q73MiVExJXrGTrZB1BuHG0JdZe0Ht8LHLT+MED2szurGIzchkDqA93gjIJTKItYxswKgsc1SpLUyJ8UuUjO1kZz9rPMuL3ElkjjAsZ8zMxlVPIVYsPcAxtDQiqHkRSTeWFQjMQDHUa62VvOtaWxRLia0Gwou7po83xdel+OZtniSquxSblsm5RYjOF2wBX5IyEtfqmmQOD0TUgXO7xlKRa+zH5vXTGnqkJ2YFXByPYeHKMdeupHLlrKhH0t3p+CZWneS73NgBFnhWw==;5:Lp30bTVEh1zf7PMDI2LEak7c0S1siN3kPkMVab5pd8nTxd3wsdo0ISO5bT62irohG55UCAg2Dz1UWaGc/TH2cylm5nhFTo6lIthxJQLVk8YgvZprmYMP47NmsdOlwSriPIosfSRC3PQ4xaciELmhxUsPWDQ2g10bZ4IOnOJI0GU=;7:capynnE/8jCeB5akaW4PaQ2bLZZz4rG6SeULA90UPC0kRUA2ONcLedBiUH2UVRhQOh2HwV9x/Fz2I0UK2CwrCpzWbqAtYkf9vbZINJ0d5LNqhoSzGDWm/0atpNtHfGjn5wdmNrJnYifH5mlTw7/urA==
x-ms-office365-filtering-correlation-id: 6856e873-f3e2-44b5-dcaf-08d6659a6ec6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6141;
x-ms-traffictypediagnostic: VI1PR04MB6141:
x-microsoft-antispam-prvs: <VI1PR04MB61419585AD7E9EC16B110AF599BE0@VI1PR04MB6141.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6141;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6141;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(39060400002)(78486014)(386003)(6512007)(6486002)(53936002)(3846002)(97736004)(2201001)(7736002)(6116002)(8676002)(55236004)(4326008)(2501003)(2906002)(66066001)(25786009)(14444005)(76176011)(52116002)(256004)(486006)(6436002)(102836004)(7416002)(105586002)(106356001)(36756003)(81156014)(476003)(8936002)(186003)(446003)(86362001)(478600001)(26005)(54906003)(2616005)(11346002)(71200400001)(71190400001)(110136005)(81166006)(68736007)(14454004)(5660300001)(305945005)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6141;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Bm6srcp+cDyyNhDBoI0QcYVTXFMWuPE/cK1CNQKf2Ip9El1JTAxWEkRP3cJM69XqIjk/8bnfaEWj46UwGRdawbQMkBNlAT93LFCStOmm+UvU0Przx8h+1UDSYTQ1Cd7b/VxJypOkDvPbPnTJ9P0FeGJZIp+gMmiZyX94nii6rdc4J1J0uRIwq8a3MCQyvmdLxn8YxggCX5HGtNnn++z5AOxrqNBfXJefVDaF+ulyJXHCrvUf3IChpcCxhVVin3Y5CaTl5AKtf5Iqmq6FXEGyG0ZdCCjkyi0lLTSqk0G5Qy05CinGmon3emuowwabSD7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6856e873-f3e2-44b5-dcaf-08d6659a6ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:08.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTAL_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
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
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 872d707..53a3bcc 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1877,7 +1877,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4

