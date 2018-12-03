Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439C6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CWiMZMjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E4120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLCIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:51 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:14962
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbeLCIju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48EaeEOjL/bixPEO734Ami99KOx/9DFIBEMyD3uEDck=;
 b=CWiMZMjfbihMqNaCeCCNbOlu167QrJHwxqbbLXggJWKW5kf1XrIrSTr/bNJ+/OrHziJmT3DCpzkkda1NL653Ixc+wZySOpYG8c3UPACd01D/a+Ipp5g1tCuFIrMLPLdkqxJvIZQsFQMosEPdMljnjZdqMFaWVkAJRXBrMKS5P5k=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5631.eurprd04.prod.outlook.com (20.178.125.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:43 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:43 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v5 7/7] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v5 7/7] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUiuO8mtyO3semSU+OB8iNhPsmgQ==
Date:   Mon, 3 Dec 2018 08:39:43 +0000
Message-ID: <1543826226-30898-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5631;6:GexwQnmwoRUobgKR1SM4ucWyFmNPl/rwPFAZAxD2aJ05SZanmspF983OvuERp0GAZTtvVc8Qo7TfTEx32qFvSWEF3lPOCDaPxPry+V5/XUjkcudprJRLgHZr+rUhaFphThUqlndj7kNnJoNEO4OpdQbaBhniyOq6KfEFFwjjNMtxFRQZcv7CqLZq+zbbJNeXnn3ya5ngTJv7ymLn9oW4BB0dBG53jMlX++kP5538xN7JYbSohWLGYkAC+TsoqaoXhCkCvU43/njftGwGyC57l7z5MteWIQTK48dWBViSbxGbnxbkCBBtMlpvuaIrMWPdo3l8sBf8XWYNwPvaJ06RnbcWNZytklxXiT2OyYCtP93mBmQVpZtCqqx8708UycLyDua/MtZ1X6tkqGRxHH+R5D1/7bJQ5dmFIex4CwlbR/PNxHU74LXu6MzB3GBZZdKHMTFgTBrWH73VBRCBu09YOg==;5:gAmbO9FON1BvL/q+ofiT6kH2x390wk7ykYs3WALHQ9Ldu6VQVgS9IyIhEYoJkl+ipxJaxjyZYb6CNgMJCbrCxbrw+0jcShVGGRC7YzEaoOzzLorMMBxnFFSBsSoOQtfPIzTXbfJCGGriHiqFP/w70FSyPY3Sp68q7qttu/scxZ4=;7:WynQDMpcbMG3ro3kOPetbYuq0oJNiN/GFS1V8cDVVIOAasnvtRuUQnMfkIr/kXjmjbAc3dcPeFyBynqYqt2QGj0nLWAEl20gy6siJIq4Va66qPXzqVKKCNn/0Tz7llbxt2HX1QbnfURfe612OUpDDA==
x-ms-office365-filtering-correlation-id: 0b0e485a-b07f-419a-4f6a-08d658fadf0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5631;
x-ms-traffictypediagnostic: VI1PR04MB5631:
x-microsoft-antispam-prvs: <VI1PR04MB56316AA58BB43CD8C66166A399AE0@VI1PR04MB5631.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5631;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5631;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(78486014)(256004)(110136005)(86362001)(6486002)(71200400001)(71190400001)(54906003)(6436002)(4326008)(39060400002)(14454004)(53936002)(5660300001)(2201001)(8936002)(99286004)(8676002)(81156014)(81166006)(6506007)(76176011)(386003)(55236004)(2501003)(52116002)(102836004)(7736002)(26005)(2616005)(66066001)(478600001)(7416002)(186003)(68736007)(305945005)(6512007)(25786009)(476003)(11346002)(486006)(36756003)(3846002)(97736004)(6116002)(105586002)(2906002)(106356001)(446003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5631;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b7onnGHOOrO47YTKGRqQ5S93T47AB9OYeiTUthvVM3P8RZhimwWJjCvmrGrbMUJnMYKlFLbQADPFmEExX9mWmct4+AUnxfisySR6GW9ppxFEy1Ef6xJNEsjbJj+qRV6zAocKUBHzDMbHyqWvj6H/zSzGOCqMCjMpGf3MDAIe0+TdgYRtRbkAPZET9w9MDlv0t0i9EnMiPjXZasQ9FQ64dlpYePckjFKGkDTuMoThZ8pGg11BYQv7cTAbbACmLz5re+cFJGAv9BZ+DmN6qGLNT41ToUKAbNV6YeVmVRZW0msaLr/AEn2KokmVZbngCP1Qg3bAdCbCWqZNVi31DKmG/ZlLb9wyBtCmfRBWKjmYqZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0e485a-b07f-419a-4f6a-08d658fadf0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:43.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 3b20c97..24cc41c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -45,6 +45,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <0>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
=20
 	mt35xu512aba1: flash@1 {
@@ -54,6 +56,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <1>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
 };
=20
--=20
2.7.4

