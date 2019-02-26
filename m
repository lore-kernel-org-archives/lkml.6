Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735BC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AE217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BfEeGPC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBZHIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:08:21 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:21797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfBZHIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEzK5phlpib4oVDmbwHn7ERuei4f3lDtTX1M7w5TjBY=;
 b=BfEeGPC7uj7kSjnsdgfVG/8Ejn91dyTAnGr1iJeQBgC2X0BY5pjmmoUTKGGLpdtCNxo25gTDJqpPKY085janMeKMMJmniHFM5ziLfLadXHWgZ+oKAme6tZoF3gmwJHELlmjN8d6xVPwllo6GJwZZHRXzlC6blBEcu0uSh6z00Uo=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3741.eurprd04.prod.outlook.com (52.134.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 07:08:12 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:12 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH v3 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH v3 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzaIJaz1vuE2TVUKFPBLSrvtSQQ==
Date:   Tue, 26 Feb 2019 07:08:12 +0000
Message-ID: <20190226070742.30551-2-daniel.baluta@nxp.com>
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4922cb2-9cfe-495f-eb51-08d69bb92b77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3741;
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3741;23:09K45m40IOVsRKHbkYhaySTaG9D4kTO5eor3b?=
 =?iso-8859-1?Q?3EhULqAwUUUeq2Wd87t8Z685IyPk3oAz7sZluYtkvsGorTwSVaVSJ+lzSL?=
 =?iso-8859-1?Q?8Qbk9dcL3qhR5rnjCwnAidz/ggE61AvZ391jXdJ8hG5s1CjlH+Fl2Jcbp6?=
 =?iso-8859-1?Q?GLHyTrA3W8tJHOhdsyV+WOO4950YrEZRw7oeOaH3kh8U0JtlbV8j+0YHop?=
 =?iso-8859-1?Q?fJvUluAiQFsEiKwiuIHpkm/Z41E1508/KQcBlQLrJtpyroCiDfuMVk9qNu?=
 =?iso-8859-1?Q?8rn26BNIapF2HZ0MueQsIb8xk/SqncVvzsXk+9rzEdLmbLKMBpg5+LAUiI?=
 =?iso-8859-1?Q?bg+U7YBF/gf1HMM3E/1Imw6NZIhT6j+msaNgQ3tS09z72vMTwAsJ9bBNPF?=
 =?iso-8859-1?Q?+Uc/s5mRarckjDQDAdyVobjluDfQ/omf751XYDXgLNBI5RfCyY+zx6ntNE?=
 =?iso-8859-1?Q?Popy2n9/YjXtFtgnX03hi0JpjFOZU/DC8ImFkLZtHiwNOGUiUyRu5KD8L9?=
 =?iso-8859-1?Q?LkPTMPHWzr6jCgdG7iDIQDubxAHcu8KX+yj6ozj2of7oIjo3ryvygThcaG?=
 =?iso-8859-1?Q?IpXD2azQB35l5CXxsV7+4CzMR0pm7AoMq7D6SIxIJh0sIRPHM9IoyyHLQn?=
 =?iso-8859-1?Q?7zw8OwYHkzLPzU8oeu2fWDCVvHReQv8egbdcELw0wgVuxTHrirJPzqilF2?=
 =?iso-8859-1?Q?2T0f0ydPNM8RiKUv9EG1rZxEAPD3+gOpkDXpzKbhebPsjcK4N4P8gQOnEO?=
 =?iso-8859-1?Q?bif4tpWdeNgfvpmDmBat+2fHgzfFYWCUmHhUxCbghItGs9g+4fWExpemrd?=
 =?iso-8859-1?Q?TvNIH+VAebKuSHeRHk+RSgLGHmnwr6GemHq0zYjZ0su/M/iixqIsWdpuyi?=
 =?iso-8859-1?Q?YBl1aak3HSinsoi30NQdir5is5j7ACVtssVyMQGJ7+VcUlhCnVmRoO9ueG?=
 =?iso-8859-1?Q?6PKuv1RoidhE2SHqQtyU+LDfylVdnQ4wLHbJLWRavzzs84MfDlpFLqanay?=
 =?iso-8859-1?Q?yAjPURtHiPeUvXiz+j3h6TGXVCITe9UxK+sTmEDLMy2CokbsPeDXtA5ZM/?=
 =?iso-8859-1?Q?D2Hl0E0eyZtcZWVpOXICYteC/wdtylM1lbYuFVdzWSLUkUGJ3amVCy0CkZ?=
 =?iso-8859-1?Q?7UQCQcpX8Scqb3pqzozGZ7NUtBj51CbhvOp/5nOIYP5UlVBOEW77ZmHzUL?=
 =?iso-8859-1?Q?Wr95Zgh4uisQMoz2TX5ricBMfYwSrF3qeW3fFiiSyuzVcy70FMVXFk+nF0?=
 =?iso-8859-1?Q?i1CytF/oAmnk9iJSrC44m+CpSghCEUuaAEIN3L4Fqu9AKXn12RnECi9S3+?=
 =?iso-8859-1?Q?Xn2FItwhzgBGev9Oy2g/lMs2/N6d9c/su6dIU9br4fl3sdS2AxqcmDJ+5e?=
 =?iso-8859-1?Q?kiLXb66QEjU2NxoWwpMykwYi3TUNyIbqphwkqQ181QYF5OzOPWV/kfhmWp?=
 =?iso-8859-1?Q?9I3yy1TJHSkuSHLQ=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3741E68F8837CA0204A405A2F97B0@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(3846002)(6116002)(305945005)(7736002)(6486002)(6436002)(1076003)(2906002)(71200400001)(71190400001)(54906003)(8676002)(1730700003)(50226002)(316002)(8936002)(81156014)(81166006)(6512007)(53936002)(5640700003)(66066001)(478600001)(76176011)(486006)(7416002)(14444005)(68736007)(6916009)(6506007)(5660300002)(2616005)(386003)(11346002)(476003)(2501003)(2351001)(97736004)(36756003)(86362001)(99286004)(4326008)(186003)(106356001)(44832011)(105586002)(26005)(256004)(14454004)(25786009)(52116002)(102836004)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3741;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NjznmxRg1L4K5LJXA6TYUmLMg+NDoic47QIobe+h7esJb7uV9EWurZ3+wpWcgdl5Ov6ijXFwrwIPlywnP2xjNEjfjv7EyadOz5jz89g2ppEbz887cT+cdBYkLKGZ3t9Zns8qF/FAE0Bi9y5WSom5i9AqCNQzS1TEPGcJ1nv/MCsGDpBikHo5TW6VU8jaeYzNUGU2FLlgMRxlla8R/QyTGSOXCGhLeHnm4jDSWmrXh1NMwN+zwO80eJh9C+7HYzHGLTa7cUvUNp4ygBXhlJ8fASWaOfCDBQa4ZOKlxi4ctWwA6/hQvUarjDGjaH34kL3m3umP5boCtGJDOhbaXqP4FuOA0aCSUVLL4mVZE0UlJiMDq7SP5JnQxDhEUB2KUeteYp7ncBHzgsVeboziK55QRYUPpooQHu84Ex038OV+cNE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4922cb2-9cfe-495f-eb51-08d69bb92b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:11.1852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4784eb..8cafec17726b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma2: sdma@302c0000 {
+				compatible =3D "fsl,imx7d-sdma";
+				reg =3D <0x302c0000 0x10000>;
+				interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible =3D "fsl,imx8mq-iomuxc";
 				reg =3D <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma1: sdma@30bd0000 {
+				compatible =3D "fsl,imx7d-sdma";
+				reg =3D <0x30bd0000 0x10000>;
+				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible =3D "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg =3D <0x30be0000 0x10000>;
--=20
2.17.1

