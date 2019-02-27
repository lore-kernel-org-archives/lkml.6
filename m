Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8907218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4MssBjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfB0Gi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:38:28 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:57376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbfB0Gi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A/brPF/ottDOXK8GAQCAkZm4NioZewlhXYa/4I+Aqw=;
 b=P4MssBjHCeiG7eep0bdpYbcLI4+sbHI+lKDFm7aUZO33S3EXGGMhpkSq7uNcLBFBrvxCOQgyGztOKnXti+CoWax0tHwzlj2D7hv+b1Wo2hHotOMVcHRxdl2N67AnKCwXGVav52UcPF4zmJWctSt/EuKBzBA9TGmnWlOM5xUqJoA=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:12 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:12 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 3/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH v4 3/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHUzmcCyITNaa6iNE2H6oXyTOkuOA==
Date:   Wed, 27 Feb 2019 06:38:12 +0000
Message-ID: <20190227063737.24445-4-daniel.baluta@nxp.com>
References: <20190227063737.24445-1-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85ac9955-f2fa-43bc-2ff0-08d69c7e2502
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3615;
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3615;23:z3FSuiO0NDMZjHVpWS5pd/uSY5mQrUUOBxiPT?=
 =?iso-8859-1?Q?esAk8KP6iM/sK4mW0CBCGdg026Tzbb46xYaBaLsxWaODjZW+1LOUuiHrgh?=
 =?iso-8859-1?Q?DEcRZpiEAIxjNDRXMDi+GVm2e/k4Kle3IjgDQD+rrfAbllTQTrBZ+o+0jZ?=
 =?iso-8859-1?Q?vWCsfRxXicLxSyLYqoYUhwXefJZVhbOmimuCDxNEVZzwNb12Q/gL9HuJ7y?=
 =?iso-8859-1?Q?7SGoWoIkLRqY1VI+086cHU7g5RqldGFkfoyOuIVCSOCy+8aJYflE5MIeLt?=
 =?iso-8859-1?Q?i7Dm16Wlo+Q1Xfsi0fBZIw+GMpHz92zoR6H3axR+tUmG1bTB0ai4zZ7JuB?=
 =?iso-8859-1?Q?sm0fbRsjo5u/ljZ0gut1HdFK1BlgxoPAsUjxmCesISOVnfx6lTbFcrkEHm?=
 =?iso-8859-1?Q?3nutzjADetc+9PGJOjo51Id8Pi6fAvYyd/g/h3hA1iE60TpbpT3elOGrxt?=
 =?iso-8859-1?Q?lh/N+rVcxOPS7DDumpMRWieyV7ufkSV/2uDF+G2vHDmhO/4X7ngCxt64W3?=
 =?iso-8859-1?Q?8J6i32PRXP1bC3GXyeP4A4YwJ3Zx866PqlfyYCl2uwUHMHT5FGql5yogIn?=
 =?iso-8859-1?Q?y7timeXXhGJBCuo0Ox0/am8K8Gu8Ya570Anf0sBwnF+dfepUL7DXTRwpm4?=
 =?iso-8859-1?Q?4CJQpZNtgwP986WAxayNyJZIGhf0wNobz6IfKHTD1TP3iIPsOSuFjAn7LB?=
 =?iso-8859-1?Q?BSAWnyuzh78tsZaPgzwwJjMxSqBuMJbTOgrRoYWg5BC7nq6YAR80NLo9qW?=
 =?iso-8859-1?Q?k1A1atUm8RG2nSkfzaiJGY4LTzBDZ1ruBmpm31+1WerPGvhWDXl8Bz5q7X?=
 =?iso-8859-1?Q?arzpwvzjCqwIt3Ur1g8t9ml4A9c0z7b7dx79qqvMOkB75EeotqYr3RNfzH?=
 =?iso-8859-1?Q?/sg5Nlbx6v4DpYAjkBXqhL0p2tsY5tOqdU5ojMFaNZotRaavPdi2iwoVrf?=
 =?iso-8859-1?Q?bmQmdGwpMkYwHyX5aO0rxRi0D/YOjZEV+Qm4VR115NDHpci0nvo2LO0Ege?=
 =?iso-8859-1?Q?2drIXnGJxO+NYjLi/rX85g5p9v6kCrlZfBp63QrGGoTFuL0SNpxaka8BHK?=
 =?iso-8859-1?Q?rM+TZBsF4lg8FmwwNTXfg8yhYqCbUM6c3ibCiVgn7SOqEFqEFhmAJ5colL?=
 =?iso-8859-1?Q?WqKOM89fUqywslMBzdfPyf1zY6fe+OhMljItF/8RvbZIcCjaG66B+bBG8z?=
 =?iso-8859-1?Q?YqqichBRWGDTznyFadsH3SDmWfoygIcZtMZTrvEoWGgivkvq5tR7ulIZGa?=
 =?iso-8859-1?Q?eptXKVZY1x/tLGz8lcwkbTf/ep7JsAvhGgsVgTlaWx571F2lyh0dZ6wnW3?=
 =?iso-8859-1?Q?OnQx7Z8l2cybhPrq9noLClIUsKR36geXn5xKn51Y2hy9KWWFCf/vIzKj3O?=
 =?iso-8859-1?Q?qvlzU4kPDSeGtrz0vlmETu7NGhP5iMjNrWsvh+UC5iTBi3P1W1l+oGMEkL?=
 =?iso-8859-1?Q?ugHhluOdgVmBpNFWTIJRZXkjf2OP3FBlLYnzG?=
x-microsoft-antispam-prvs: <VI1PR0402MB36151C2CA017E82734D85D1FF9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(446003)(71190400001)(7736002)(11346002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(4744005)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(76176011)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(14444005)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3615;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1pnbCJ+6oWCtck1f2Ytwg/LvUiiHv9KTlk3mm4MRwsB2VJBaREznuIkLNBYikWWz77rGXPAPkB2rHXh1nt3x3MR+J7uExeGg60fpPfA0UfK63X9RGWgZyX7XmblOljsZFF6LrjrLSIwx68VSFNCKN2jEFQOuK6G8dY9E4t5S6vueXBMe/jY1gbHStUlh2ek2pDq5Ff4JqA+wpb6DGmFUyx4rI3KAfJT5kTIY26sakQq807EoYVo5N5Udfju0U15HBSzrvCgcs7RrviiHaVHiFFPvtg8rokrSTU8HeGXZX9xHlZO5ydSmmfhpc9erkJ5HJRyMkhbQPd5UpKf0oDr+Nvf9U0BIXsES3Rd+tP+o1BPoMfNyEsiB/s1b1G0/en3M8QErer78DZqXaxuw/I1Luog86axEcF8oV5cNeO4HCaY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ac9955-f2fa-43bc-2ff0-08d69c7e2502
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:11.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI2 is part of AIPS-3 memory region.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9d48450453fb..565f4175e73b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -489,6 +489,22 @@
 				status =3D "disabled";
 			};
=20
+			sai2: sai@308b0000 {
+				#sound-dai-cells =3D <0>;
+				compatible =3D "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg =3D <0x308b0000 0x10000>;
+				interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SAI2_IPG>,
+					 <&clk IMX8MQ_CLK_DUMMY>,
+					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible =3D "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg =3D <0x30a20000 0x10000>;
--=20
2.17.1

