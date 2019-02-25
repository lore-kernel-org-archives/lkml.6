Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD31C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C420663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qxz2gqdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfBYN0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:26:55 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:32132
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfBYN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWftcf8SrJsOU5X4AznxrONSgEEntkz25eTzgABEEhY=;
 b=Qxz2gqdjQ8p1jL5S0x2xmUkRA2Vpmxx6Df2HuhycQKbjU11vtZ32521TqBa51XITgGAbodcGbF56V33ZB6Wq0U8oCgXOpscud+JEtWLWxfsBBi5hAM3xycJVuZODMtPA/fCFe7oue03nkFTggaB8YVzlUEmm3P/nIIo+rvXqwAI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:26:37 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:37 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/5 v2] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH 2/5 v2] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHUzQ27PdTDp/7b7EyAA+4Bj+dPfQ==
Date:   Mon, 25 Feb 2019 13:26:37 +0000
Message-ID: <20190225132617.10987-3-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1a1c1b-be6e-4ed2-dfbe-08d69b24de4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3485;
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3485;23:fOPq/8CFFpANXlPYabPjqXGEHFg/BUMCYhBwq?=
 =?iso-8859-1?Q?riLlz7/dTYqO82T7EgQAFDKd8bf9enW9JqRDKcMqf06PVY9YcnZAoQaZ9/?=
 =?iso-8859-1?Q?I+FKlNaFVA06Wu6PkFT4ptEbC2jimOK6ybD0Z0q9WbBgNTuPLoGUT3M8R4?=
 =?iso-8859-1?Q?2dWibcR+ejfon4IK/PNIo4XHGA1Aw0uhoUbGrtdwBDKCt0GUaStmuGsC1g?=
 =?iso-8859-1?Q?yQb6QObva8nWHaEFGXpm7a2wYnFJ7asuMC0HDUQ63T9IPpgtPpI3idYe3L?=
 =?iso-8859-1?Q?Bsq4jVp454J0u0YJfv5IaSv7K4xjxDGCVKBRjRl6I6JTeBDIFbffQWSxAi?=
 =?iso-8859-1?Q?ezOOEQ6GUiMuI8LLMNiqrWEjaSh0DVOqiBKpbZkBQ1Shw9ozdBhXOKPsza?=
 =?iso-8859-1?Q?j9UDFzeDKF2SCBebEXy1e9fi1IKay/KtSSeU7a3uNi31LrgLsZAgIABpdK?=
 =?iso-8859-1?Q?72xQhAGYVpesPgHPvZtra1Tb9mnCA/ejNVMeq7oXz2Zl09tF5rooVlmqBp?=
 =?iso-8859-1?Q?t45ieTqsJUvS4N9d3c6KZMvzoqdA0HTc5O0hSEH5SCvKKj08RTz/M5IZu5?=
 =?iso-8859-1?Q?kL6gV8y1xmLbYkvKAqjSVEDg+FYdbHNjrfvF+ICBAz9UDfygmVtx2vmFc4?=
 =?iso-8859-1?Q?CeqLfbLKRanIYO2aFkVwYhCvhph9Bge30sfJXVT84C30QLv+1DmueELdsl?=
 =?iso-8859-1?Q?2aXHBPrFCaxIMPFOQ0PvCnB70sGzx+gU6ym7TaQuEMIn7nO0CRegnOQDG3?=
 =?iso-8859-1?Q?tiGdJAWZypnPDbWbb5tn+ZOrDze1BNBT9xWaP4q8o0kDLnro+iCN6+OBYd?=
 =?iso-8859-1?Q?x0NyKf8HqjQDFXonN8preDTFiJYUSnVWVPPNzSjWpw8vdQgWd8P0NZ1jDN?=
 =?iso-8859-1?Q?v/IZFwUlHLMvUaanfWlb0RL6pJHcczhbqUHnwZ6l0UwqKxldR9Y8iwXvI5?=
 =?iso-8859-1?Q?LQlo4CaG68dm17DjBLAgFpmrm0Yw/9hw0d69Dp4tNrCAp5+/7e7u/fWxj9?=
 =?iso-8859-1?Q?NbpyGmoHgje4gxcjTq40HoXmxljUXu4/48PNsfdIfYu2CQ87pwDtyUMmSi?=
 =?iso-8859-1?Q?HTyaPaD19VZYH14dtItzE4EAyhDkcoKBYAIXG4JdC9uIT5r2xznGgZbIgF?=
 =?iso-8859-1?Q?FbJuEhoPqbguSsbP6ZO2Rfp+88+iJRm0d5Jka1oVNkaHUR66Jdvul8qaUM?=
 =?iso-8859-1?Q?OqG+rcblQwSysqFsystgH2BGiSrOOGt4uPuGhqGnt/uHgweXJ688Z0/nPM?=
 =?iso-8859-1?Q?f/WsaA2ZfocifKwiXs9GjoALS+R037/q3LKzNon5UnCosz4pZyKplaRwvr?=
 =?iso-8859-1?Q?pgxkN8ilkFhDIkw1HdkeoMlpZsSqDUs9dCrY0BTwXCdp9p1Ux7NeFfllDC?=
 =?iso-8859-1?Q?d2ObYLnWASOWQ2Z7aXFCC95ucz2mnjFf1dkuAlx+EacE1ZeY5KFmkq794f?=
 =?iso-8859-1?Q?F3Z99u+rUaF2vk78=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB34858EDFD566AE80013AFA5FF97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6512007)(36756003)(256004)(26005)(476003)(54906003)(4326008)(486006)(2501003)(50226002)(446003)(68736007)(11346002)(44832011)(99286004)(52116002)(76176011)(2616005)(1076003)(8936002)(53936002)(102836004)(386003)(6506007)(186003)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3485;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqTxSechP18UD6N5eB4mY3kTA8uc5fQsQyEKkMMRPA7nkHRp1s/ZmMwEKSG+kFrX9iB3J3l0iMD/4JU3cPqQJX1wOynlwIpi81MZuzXUYebPdbpsFC7uumhbJZ3RAvFxa9NcA+n/cM7bswvxE2NcPP7K0BpQdguPL/sjgDdjZSupZOmUSfojlCJL9AK9rHv+f3EYmEyADf1nM96sQ55xY4xBkCx15YJzBpfEclOhtDOAHptmOEqexDdzCKSJAvJssO6Ehos/7cnPiVHNsx08i7UtIwbphAK/LUR7P7SDiVfplha8+npME9xOvOfllV5/ehp5J3cnK1Ej8zEyav+0F7GIdQO2UE5ri/1CgowN6QybpGI8zNdfo/RJSL6n9AdCHu4Sux1yM73U/HeVDr6jsOi0tac0+AiHwIkKOp3Phx0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1a1c1b-be6e-4ed2-dfbe-08d69b24de4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:36.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI2 is part of AIPS-3 memory region and it's the DAI through
which the wm8524 codec gets its data.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 8cafec17726b..6fe5798afd2d 100644
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

