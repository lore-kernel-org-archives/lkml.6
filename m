Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5336C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752DF218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xWcHJo9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfB0Gib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:38:31 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:57376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbfB0Gi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+uwQeTr9h2VLcjVOPkI1UtiTv6ufEtAo1X/rnYFXs8=;
 b=xWcHJo9gtpUX7oLUoExBu6MglTXUCClmt0CxedciFQig6lHucqFp7Hu0LV/pRlYMaYfPPAthILvdI7LVCHL3z+dxAo0xf+PRejFn8dODWlVczE2hvT02RzaI7pYlrwkckEac7Rt+bhArXPbNmJGVBL5Hf3PhWr4pl2w2lzF41Qw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:13 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:13 +0000
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
Subject: [PATCH v4 4/5] arm64: dts: imx8mq-evk: Enable SAI2 node
Thread-Topic: [PATCH v4 4/5] arm64: dts: imx8mq-evk: Enable SAI2 node
Thread-Index: AQHUzmcDFo9K1QK8lEy8PvNxCBdjKQ==
Date:   Wed, 27 Feb 2019 06:38:13 +0000
Message-ID: <20190227063737.24445-5-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2b9e96fc-460f-4ac8-5440-08d69c7e25b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3615;
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3615;23:Dh47kPlGUGLufrZv/oAm4FlFLPRMc65YZpS+5?=
 =?iso-8859-1?Q?+SQ68eEUCN8XxQuirY2OKTb4ELvyHKOx0gqygYVwvCLr90EXhNipXCQe0A?=
 =?iso-8859-1?Q?UIGDWKy7XNGHiCFVqoEqes9c9mpREKj3+OZoS1eTEoZ08QkQDGClp38qC2?=
 =?iso-8859-1?Q?6zJ+4jfJUswfuoGnTOiV/WPGznOYH0b+Isyugt+iif9vsOLKUNGZ9dq3yV?=
 =?iso-8859-1?Q?pjzsjxFmQeyS/6wVfxE/19IgIxi8u4yY/ypmUjkUXblIGYB+5qqbc42Vqr?=
 =?iso-8859-1?Q?DrYAkGGhD2jxLkkIl/ahLdAZ10zJHXwnKjg/spsDWbTOM2cYVLdfWQLtXa?=
 =?iso-8859-1?Q?I9BS7K36JSe/lb/9YFO0JOxybHZbAOiNsQAS52rYp4zc7s3B+nxkmWTjvI?=
 =?iso-8859-1?Q?r+V3XEeWa06vMsAOYZWmUmnX3VQ75oI4ywg6qqp9wYTaRKEiZ62w1qW21T?=
 =?iso-8859-1?Q?qG0SNs4wVrD/s1mNP0YUzc5az9nRFmGdiuFuXZdkP8ZLzOFKeraxRYm53k?=
 =?iso-8859-1?Q?Ti3TE6m81oFYpFKb6Uk6/hzZo96eXutmomAsdHlWg37bekXHcjpFmlrgSt?=
 =?iso-8859-1?Q?LFE6mPWnqr1wvWRe11FM012bjPam1QjOgf1g87sA2zkb5GFSXWFmQFT15A?=
 =?iso-8859-1?Q?PLOVVo77u1bs+0UB11+RcBUJ3hrXsifHK9bOvpjy1FeoIZuB66WEHkqbTs?=
 =?iso-8859-1?Q?pPJ8c0p6Fu/ymwrwRDB/l65qSvgNPLP6JFqTukVg6QjcgEN+iWAQXbzQlk?=
 =?iso-8859-1?Q?W8j39aRijVSrJSTlZksqAbnWldM8CkVIbNlwtfwDLsyxglYHCmG4JeI2Jw?=
 =?iso-8859-1?Q?QEgkSNS8dY7DuTTeHqqF3vzgUebiVz2paXEms/V4Nvt9ogXGW+qYjKkDk0?=
 =?iso-8859-1?Q?wznc5o5Ipg6D0DwzJuT1/Zo4azcKdHRgxErz47n5xhppzfS8PL7TGNClgu?=
 =?iso-8859-1?Q?EoVNDqnLB95/XfYdk1YzYtCutG41t+7wgbV4EKNYE5cX9cKFZ5WNFww+o/?=
 =?iso-8859-1?Q?uxiEsWKW6yeVjp/wWzshxNHlSNUmPndYRSI2RHjxLSGu1dUlFsBpHExLXa?=
 =?iso-8859-1?Q?SLwX8BofGPPk2H8WEKcAwv2Wye/VlOTp1UMlV43kd1mSbJ4j0+iWx5aFfg?=
 =?iso-8859-1?Q?zEEARHjBOVt3HyC67JsG6pPkh39p19Y6a3lPIby8DarAvxHUAdc2oweD5k?=
 =?iso-8859-1?Q?X82BNMsyXpTtJEI/O7BEbxWgaDYDJWpil1SfESZy75zpEWK1LAzHE6roqN?=
 =?iso-8859-1?Q?lVnjk/NE77TpsBr3gMfPZwwkOrSRJevaAnjusBtS9490egii0dYJnDivYW?=
 =?iso-8859-1?Q?7E/Niq8hzDtt9wDwdjve4llXLo17N/3AWj5go/zv8S8R2NBsYM7Zd7jC9E?=
 =?iso-8859-1?Q?93XSOlr3XUsDIrXn1V52GwvStBY5dTIFOBtdkbpQzjc9vMbQ7fvbA=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB36154607DFA445496B7C0279F9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(446003)(71190400001)(7736002)(11346002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(76176011)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3615;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GAnQWpioOHsNmft/DfU3e3vQGEkYcDEIrFK4WqV22eTLB+6Qwm/S3GPxJma/iF1tipAFYf9cPqOkULx8iBohaf5aKZG/8YiYi/eo/39Q01yMspyjkCKK8Lg+GbDBlNt89helYUjhegGp3gYqa58KNRnXVIOpFOclRlY6Ldp4AT49tguQaUg1OolMgEukJZyHJWoUrYgxbfa1XkeSV0KwBo4EVv2+H82I6L9U0Iw1MOcNo9njD1E2BKdm1y5I26oKngGU+0cZy3iVflRqES0yzkJyV4W7pPxv6qx8G2ZlIqVTuy5VooRadKbBXXDP+UuwU0jJCIgVH+veWShBqskj7kpgrC/mMIpex0hqClcz23Rffhcwb1tuoXnZ2KM8DI0iATZvgTV3xY+dj+51ibGP6hJLgpJtGaEtSW5JvllsO+s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9e96fc-460f-4ac8-5440-08d69c7e25b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:12.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets up clock hierarchy and pin configuration.

Use PLL1 to derive a proper rate for playing files
with a rate multiple of 8000.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..58de4a3d6029 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -52,6 +52,15 @@
 	};
 };
=20
+&sai2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sai2>;
+	assigned-clocks =3D <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates =3D <24576000>;
+	status =3D "okay";
+};
+
 &i2c1 {
 	clock-frequency =3D <100000>;
 	pinctrl-names =3D "default";
@@ -223,6 +232,16 @@
 		>;
 	};
=20
+	pinctrl_sai2: sai2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
--=20
2.17.1

