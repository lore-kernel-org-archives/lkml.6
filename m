Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F7520663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJg4ZAdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBYNTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:19:05 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:60803
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbfBYNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlC00MMm+dFTWubTf4lzjiwZvJivqvoiolCjMH6pCkE=;
 b=HJg4ZAdRfPh/f4JL123iYiVkNrjDMLqHN3FG9oI6Kub8nUkDiqf3DM5rEDIc5ZShFeiknmULnREY0AnB+V86IGYDltH3Sgg+cdNl6CcZXnW66TA1FPmuEOS1zGIj1uJp+20na29lhg9yr1vkXnkhxwSg40JMDmOgZKVNIo2RX7g=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:47 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:47 +0000
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
Subject: [PATCH 2/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH 2/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHUzQx/7RiRqDuYxUWKv20qP3r9PQ==
Date:   Mon, 25 Feb 2019 13:17:47 +0000
Message-ID: <20190225131722.10253-2-daniel.baluta@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0202.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::32) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14f60b56-08cd-48a1-df8e-08d69b23a243
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2895;23:3NLEAXA0deOC9q6oJlGI5MJAX5SWFc3vkRLkO?=
 =?iso-8859-1?Q?hI6bBbP8LkpadlAm9Ayt0je5/TjLHqONqcpcEp5lTO5WvFXHuOwft4xtQ2?=
 =?iso-8859-1?Q?qjrsq9FqiazMNProMYCzL6UPZCAaw6hRdyCm3AQQezhJ6k2fCS91rmWubE?=
 =?iso-8859-1?Q?UfYcluRDyWip8/O8Fwwwtd3djOpe9dLp5m2gnp4hWy+KgBRZHia7oTGfkH?=
 =?iso-8859-1?Q?UaefDmTxXz24U7Akcm43Vod2VZYJSshh2t//xSrElbjaerqSBA9icBfeg7?=
 =?iso-8859-1?Q?SXAcixIrs7bW+/7A+OuAUn79FipSnfHd9a85X7fB4/TuKl3gGQAutr2oSk?=
 =?iso-8859-1?Q?W9z8Qt2QiWj9sYXlLnj0+GP6lFrqHoX7Ip/ETg7kgaV7GRwBh1sdq6sja3?=
 =?iso-8859-1?Q?saK2NZJyPS61uKrJLF3pZoEorPbsKyKv2xfr4pR3dpMffvT35IPPFMf/6l?=
 =?iso-8859-1?Q?gTZ0EAp6Qnic9GQOwCFaSu8at67qgM7XGMV818Yq668AWS5amr3076+Emj?=
 =?iso-8859-1?Q?+MEUqmMO77S2OFkJywXIrK2Dz/H6vHOU8oNXcTl9EDzRLkbzMAqkIKmlZ0?=
 =?iso-8859-1?Q?7RfCoKRUMMatjgaXoVZXRL7yGRmQLG+F2YrFOC7QF2p04uC1nL7FHd6Y89?=
 =?iso-8859-1?Q?bOHPTkGKU4yy3rO2eKdpLo2JPHjSN49scy+NYnJjxg1NHzUbU9FvVN8WUk?=
 =?iso-8859-1?Q?R6F8taJIkHf9OqEo8rx6y94XoiUTX43seA//d9JCeHaudBF8SwXT+5aSuC?=
 =?iso-8859-1?Q?yp3J9mkMDhVSZmfgihbd/LOp3/8SWtGyhrs4Ix3y/TmvfKMtslLmesJbFa?=
 =?iso-8859-1?Q?h1NKtcY7FYbKPO60Hb358vNi6MCADx/8rf65wJ7SBMNjqmRzCasFZC48jA?=
 =?iso-8859-1?Q?hGrxClTEkBkjfg05QLoBP+jjF9I2nZgu6AGSwb/imyRilLtOtS1Xr1rC4Z?=
 =?iso-8859-1?Q?3Dtq4NUVbLeAwIEF0zxeWBKU+AdD7UlVs+ynjgvx2rgaFD/LWXcHvNf91Q?=
 =?iso-8859-1?Q?sKRNq7XGqz1SYoLoP3rhAvPFDZAQl/KtwT9dnGDZdpwh7hr78gLfWSP/0U?=
 =?iso-8859-1?Q?tyFg769Pg99+TCwol9GKuCyWGkCyeWqT2o0gBfIPlWmADybM52BvOeuy++?=
 =?iso-8859-1?Q?rGJhnpn/pSTn9GTDsm6MugrCPP+wP0sBURNfWhe8n+oE6o9ejeK4x5soJF?=
 =?iso-8859-1?Q?dzeEWuxYIt3DRPf0zznv77hx0iKNbU/r8UzxyJe+lpqpkarvaKQ5aArobC?=
 =?iso-8859-1?Q?+BqNdO/IJFwC31D/nYwXmi8R9ukatu7unNkTnHIUVd5qKuaCRZUw2ciMdD?=
 =?iso-8859-1?Q?l1PwIRiATa+C4ksyjfsMejby4uFEqaxxcZPzlqZRXr4yJuN6Qe8QwrtS83?=
 =?iso-8859-1?Q?6xJv14y9jspIBoaEUGcmKPfqBn8cHeWz1qMSCZwo/K/Uv3GLbIx+cW2qO8?=
 =?iso-8859-1?Q?P1FDloCfcEX5YRYA=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2895D1B0C662A18500C60F1FF97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(446003)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(11346002)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(14444005)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(76176011)(52116002)(53936002)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Czi3aT3YGJI8GHqm0ZB8yrdN53wCv6LXa5zr8sKU9VAMXZH3jURU/7OlsdbHIia5Jl8wjQ5yJSM6PwQCvpYIPbgd40G5arlsB+3UblzMg8wB9CmeDDjnvzp25vQJJTSa3Bw2AvPrTlc7sfIIoTv79qpX5o1/4wjmL50CRxWRpvUJhyS7mCj8izJG6bxo4Vaz26ZNKnULRRZ+RhpZxFHqZa5eGGgvMmApQygRFVk4GP2E1ZGk1/vd4fLBOD9Na8MaCt2lLX59mk+nMGnXgO907A1iW5qfQpKQrDT1WuYNNJScrnSx79MS/Fe1fPTYd5dllfYVeQFjOLuzUWC3L/cUvt5JqWTErWTWblsmnR5uUMBDsgmk8MlPLBnE5EpAvKSgWZGDhjlYPrFooO4wec0Co+irKL1mEDap5WMaUkJznQs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f60b56-08cd-48a1-df8e-08d69b23a243
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:46.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
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
index 87839c5c8a7f..807497450f6a 100644
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

