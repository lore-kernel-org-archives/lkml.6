Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571AAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057BE20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilXooM4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057BE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeLIO0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:37 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeLIO0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG1Ekk60JOOhx8hSneyd+/HmkEhbatfmhEmm5FpxrEQ=;
 b=ilXooM4IZ31HSnic2t7CCE0pxfrMGgb7lhtTRmO1kDcaCnGPh3Yma2NUjE7E0y52XsAm1F30iJByyaPlfb7tDr7GDV1Gcj9fa6PF+9aH0aEpQGOtKZxsOCcRxWGEaMAKU2o7Tt3EbZWV35t5MNb0Y5pxcpBhLRmga1Kc0MJ96pU=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:08 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 3/6] arm64: add support for i.MX8M EVK board
Thread-Topic: [PATCH v5 3/6] arm64: add support for i.MX8M EVK board
Thread-Index: AQHUj8sgvZXsC01KmE+Xnr5Yk7ohlQ==
Date:   Sun, 9 Dec 2018 14:26:08 +0000
Message-ID: <1544365552-30270-4-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:3dGLUX7CsP1/jJ63Fx8PvKHoY+3m2OCiglCHPt2p+mMaaokrpYs8zuYm75+lVV9c4H7G7odeDUnyXfBLTJCqads5Mu3aZFuEqTG9EMRgcnxSQE6coFHIv++IBLsvcFzQqbnKYSugeSeuJYi3npkUzrnUGUg6XeEDDyyKcydffw6A68cXFHE1N7dd/TRrMJOSI1X3ycCrOQThbKivVb4zDRnPzAQF0+Gen7V7KtOJ8yZffvFCw7A8L/dMn/8zGLcTH7KC3YTwwtn/W3N++jKvTaSCXJw6bpuK6ftzBUUj2UkE5cYcXLHrrnVA2p1D6Txk/7lMbKJ6VI4V3eVw5+tHS5HO/TfMHAoluHvHcqws67uGi8GsddPjJadHyngDBbpO+aU0Ijx7o94Cb15nCiQoa0Fk7QDN19+8mTXRupP/uwC0xDi8Ld2L4fAJ5iaVGOD9d8E4pVl4EZS9a0mNH5vBuQ==;5:QWvlO4SAPzr8Bj8y0rMR04YxYh03I7Ommw0comyt1U6VoT6WUuxqyYcBXu9G9G+X1JNhT8Eq32adoS1ztpPrAUWdzFJHQdYTDs2M+XbFwY9UIQD+Nwwd/psex9ScrAeb5phAeVFDbmhjC7ZW9/DgybW2TptIQ0JgfEKtSqGXIVA=;7:p5m4Fk6KGrYCNfxPC0qFv/GYSkLabi1E1RFtF1Nbb67+ZvoMLHJrbG2XshwD6MM2zqI3ROlQZfkO7HquokRW/z/yk0t6r0NplAcrCqPn1d6TbXfxK74CiC60gAXHTG5pwvnxfnAdt5we2tyBZci3ZA==
x-ms-office365-filtering-correlation-id: 4eeeb051-c0a9-4886-9c67-08d65de2427e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB3910600609AF4F6084CE511EF6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(575784001)(8936002)(52116002)(316002)(414714003)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KtL56ahlfjIqaJ31nnK5VjA7ro3Vhinxrp2JeIFGDmO5h/aMiqMvnVccODqRAiRsWzTV1sjloDzPBp0d/KuI3pKorZAw95qHrLxt4jelxFxVraXDXAZM2S4a0Ay/5olqSLHpZTvvIj+FHi/VJcdt7UDByPxsGS2Rk2c0tmlvioW/UGsGhhYnzMvS2gOjBddMHWCHIq6luzia8i7zwz5T5ZVK/rDfnFSoruLgC9+QvbQJRqfy1q+PWYcBrreXv18R6pcEJQVrfu2D9vOqv2rcj1xj1poveeu298wddlVstbQ88aEu2J4x01MPSC7XNvsFsYZyoA3ZgVySj7kvJ0X+iUpdqfRws8YvUitbmtliesU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeeb051-c0a9-4886-9c67-08d65de2427e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:08.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is the evaluation kit board for the i.MX8M. The current level of
support yields a working console and is able to boot userspace from
SD card or Network.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
Reviewed-by: Rob Herring <robh@kernel.org> (v3)
Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 290 ++++++++++++++++++++++=
++++
 3 files changed, 296 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/=
devicetree/bindings/arm/fsl.txt
index 9f4aba2..71b78ff 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -105,6 +105,10 @@ i.MX7ULP Evaluation Kit
 Required root node properties:
     - compatible =3D "fsl,imx7ulp-evk", "fsl,imx7ulp";
=20
+i.MX8MQ Evaluation Kit
+Required root node properties:
+    - compatible =3D "fsl,imx8mq-evk", "fsl,imx8mq";
+
 Generic i.MX boards
 -------------------
=20
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index 7748e6d..0001361 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -18,3 +18,5 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
+
+dtb-$(CONFIG_SOC_IMX8MQ) +=3D imx8mq-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
new file mode 100644
index 0000000..04ce13f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2017 NXP
+ * Copyright (C) 2017-2018 Pengutronix, Lucas Stach <kernel@pengutronix.de=
>
+ */
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+
+/ {
+	model =3D "NXP i.MX8MQ EVK";
+	compatible =3D "fsl,imx8mq-evk", "fsl,imx8mq";
+
+	chosen {
+		stdout-path =3D &uart1;
+	};
+
+	memory@40000000 {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x40000000 0 0xc0000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-vsd-3v3 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_reg_usdhc2>;
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "VSD_3V3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&fec1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_fec1>;
+	phy-mode =3D "rgmii-id";
+	status =3D "okay";
+};
+
+&i2c1 {
+	clock-frequency =3D <100000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c1>;
+	status =3D "okay";
+
+	pmic@8 {
+		compatible =3D "fsl,pfuze100";
+		reg =3D <0x8>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt =3D <825000>;
+				regulator-max-microvolt =3D <1100000>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt =3D <825000>;
+				regulator-max-microvolt =3D <1100000>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt =3D <1100000>;
+				regulator-max-microvolt =3D <1100000>;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3ab {
+				regulator-min-microvolt =3D <825000>;
+				regulator-max-microvolt =3D <1100000>;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt =3D <5000000>;
+				regulator-max-microvolt =3D <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <3000000>;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt =3D <800000>;
+				regulator-max-microvolt =3D <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt =3D <850000>;
+				regulator-max-microvolt =3D <975000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt =3D <1675000>;
+				regulator-max-microvolt =3D <1975000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt =3D <1625000>;
+				regulator-max-microvolt =3D <1875000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt =3D <3075000>;
+				regulator-max-microvolt =3D <3625000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+			};
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1>;
+	status =3D "okay";
+};
+
+&usdhc1 {
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc1>;
+	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
+	vqmmc-supply =3D <&sw4_reg>;
+	bus-width =3D <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status =3D "okay";
+};
+
+&usdhc2 {
+	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 =3D <&pinctrl_usdhc2>;
+	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;
+	cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply =3D <&reg_usdhc2_vmmc>;
+	status =3D "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_reg_usdhc2: regusdhc2grpgpio {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+};
--=20
2.7.4

