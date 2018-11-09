Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE183C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC162086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7yThmFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC162086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKILFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:05:33 -0500
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:58448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726929AbeKILFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvxxgSsKEXEUSx8vKEomhUI5TjFd7gQsXNEIMSpgHhY=;
 b=C7yThmFVNSKDJQJNS+3qfYlvZBiQ2HGNDQtf2czzR4l3ET2lnPh2xDlFiWPEXPrwFtx8B1KsTaqdbJUHIaXHlizaX1wFdBjsWHHzWww+bjHdTbTuWpYbkj3NdmXNndTAhuAcwgsLMiDKC2eXkyUTYpI272TZiH8CTlyku4o4LS4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 01:27:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 01:27:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH V2] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUd8tW10PZEKvl502/f9j+OWw2Kw==
Date:   Fri, 9 Nov 2018 01:27:10 +0000
Message-ID: <1541726525-19544-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:jG+wUSGqhx4/SxVULzcOosblEJ7UiR3VDRsB8Q6PZGYKnBAWdfpArP7yorYYLoCrUMFlazW4dEu++3DfDd4PJzhdWbMcXgwPWAW6TxziHC79/CtGWrqaoDsPqWZLSjl5l60QoIidu/DgIk5QRRFa+dSBgBco6aGsfokE1qk2xJMa4ZzSEtf/vBvz3Cl/i4NZFiiO7Z496Opu5IyjVwikKz5rXouybU3QFijWoR7Os/hWJrOpemgfQmFZM9BjejlAYX1nor87e1pigoiALrJjxYnBhwpJArvRpM3K2y8iM5qn+PTG8/7/XnLvcrJi8FcKdqLL+WFWNdQYckP1huC39LiruwWFpG0RmG7LK8W+fetryjoJ3MADaJAY3jjRQZaBfmNX7bnBjEfoy+Ag3+7zHWAL9DSaD9rv1HuDZCcgWkfdlh70gOLBLBPyHh89Yz2EFJJSYkgFlOYQwaBvrBz0cg==;5:EfQyzqa6jOwTBIq3cYkWNuePG7OtzUt8224PnYFVYCoQzds0sgcE66N//AOqsBR8YhukIg0vVnUWfuasDafrWsmbSvCMedw+cbhZlkjvN9JrjRKtAcrug0eRw6R82cByBmSP/t5JWi9LCy7fm87PuK1qzRh8E2G7uAqOY6LVdgA=;7:5V3/DaHBD4Hi4F03H7I8/YnK5fmAye/RrwOQ3I1xO5LmRgdP7QytMZk0ygeGrJTaIf+D3Cw/N0IzY4cfHC18NGMUeos83iFa7SELhVEeXiZ0oFH9IQW8Y1lus7WxKex9CH2lv3WyrjkXh1EypUvU/w==
x-ms-office365-filtering-correlation-id: 28cb3d13-7547-4ab8-284e-08d645e27875
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB3659C976E175E3112C7A2C82F5C60@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(2501003)(8676002)(2900100001)(2616005)(186003)(6506007)(36756003)(66066001)(6486002)(6116002)(6512007)(71190400001)(386003)(71200400001)(53936002)(81156014)(2906002)(305945005)(106356001)(6436002)(7736002)(99286004)(26005)(105586002)(478600001)(14454004)(575784001)(2201001)(50226002)(25786009)(14444005)(102836004)(4326008)(256004)(86362001)(97736004)(8936002)(110136005)(486006)(68736007)(5660300001)(316002)(52116002)(3846002)(476003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V2l1j4/9uw2mda5avT9bkhcTRdjahUvbTRlxbWE5/fkA2Yw7CXUEMkPlgjnWycsi1g+xbAc0GuQmQ36UXIhONh4UhyihFFwv771ZMUlpiAUyYeW7Op32iJDPs9FMdTsme3nnlYi3ETA2Peeyk5nnki7TxyLcz87qsyn9YjIQ7SpK9yTbBxLufYXcKpPULaeZk+7C2H8Z98Wlxtz6HoxlAzvHxsQSjd2dUIBG4lsYPKl+DDXEv/Jd7+2Mm1LpiCvAzPpNfUrqQ9yhbPMhX+nmc3kAzdmzAtkuonv1WSssKCSqxuxLDMlfckN7yRmhT7P8MnQfszldWKbzd7dP5DQi+/4rlUy4fWJhiuAFo9lSNWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cb3d13-7547-4ab8-284e-08d645e27875
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 01:27:10.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current imx7d-sdb.dts has some incorrect settings about
Rev-A and Rev-B boards, some of the settings are based on
Rev-A board but some are based on Rev-B board, clean up it
by adding i.MX7D SDB Rev-A board support, make default
imx7d-sdb.dts for Rev-B board as usual, and introduce
imx7d-sdb-reva.dts for Rev-A board. Below are the affected
differences of Rev-A and Rev-B board:

                Rev-A           Rev-B
USB_OTG2_PWR:   UART3_CTS_B     GPIO1_IO07
ENET_EN_B:      None            GPIO1_IO04
TP_INT_B:       EPDC_DATA13     EPDC_BDR1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
change since V1:
	remove "pinctrl-assert-gpios" which is unused in upstream, and use phy-sup=
ply
to control fec2's enable pin, model the enable pin as GPIO regulator.
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx7d-sdb-reva.dts | 39 ++++++++++++++++++++++++++++++++=
++++
 arch/arm/boot/dts/imx7d-sdb.dts      | 29 +++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-reva.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ef9ffa4..6d133b9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -572,6 +572,7 @@ dtb-$(CONFIG_SOC_IMX7D) +=3D \
 	imx7d-pico-pi.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
+	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
diff --git a/arch/arm/boot/dts/imx7d-sdb-reva.dts b/arch/arm/boot/dts/imx7d=
-sdb-reva.dts
new file mode 100644
index 0000000..7741eaa
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-sdb-reva.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Copyright (C) 2015 Freescale Semiconductor, Inc.
+
+/dts-v1/;
+
+#include "imx7d-sdb.dts"
+
+/ {
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		gpio =3D <&gpio4 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&fec2 {
+	/delete-property/phy-supply;
+};
+
+&iomuxc {
+	imx7d-sdb {
+		pinctrl_tsc2046_pendown: tsc2046_pendown {
+			fsl,pins =3D <
+				MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x59
+			>;
+		};
+
+		pinctrl_hog: hoggrp {
+			fsl,pins =3D <
+				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
+				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
+			>;
+		};
+	};
+};
+
+&iomuxc_lpsr {
+	/delete-property/pinctrl-names;
+	/delete-property/pinctrl-0;
+};
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.=
dts
index f1bafda..8385b9b 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -73,7 +73,7 @@
 		regulator-name =3D "usb_otg2_vbus";
 		regulator-min-microvolt =3D <5000000>;
 		regulator-max-microvolt =3D <5000000>;
-		gpio =3D <&gpio4 7 GPIO_ACTIVE_HIGH>;
+		gpio =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
=20
@@ -114,6 +114,16 @@
 		gpio =3D <&gpio2 14 GPIO_ACTIVE_LOW>;
 	};
=20
+	reg_fec2_3v3: regulator-fec2-3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "fec2-3v3";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_enet2_reg>;
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
+	};
+
 	backlight: backlight {
 		compatible =3D "pwm-backlight";
 		pwms =3D <&pwm1 0 5000000 0>;
@@ -210,6 +220,7 @@
 	assigned-clock-rates =3D <0>, <100000000>;
 	phy-mode =3D "rgmii";
 	phy-handle =3D <&ethphy1>;
+	phy-supply =3D <&reg_fec2_3v3>;
 	fsl,magic-packet;
 	status =3D "okay";
 };
@@ -491,6 +502,12 @@
 			>;
 		};
=20
+		pinctrl_enet2_reg: enet2reggrp {
+			fsl,pins =3D <
+				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x14
+			>;
+		};
+
 		pinctrl_flexcan2: flexcan2grp {
 			fsl,pins =3D <
 				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
@@ -513,7 +530,6 @@
=20
 		pinctrl_hog: hoggrp {
 			fsl,pins =3D <
-				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
 				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
 			>;
 		};
@@ -724,6 +740,9 @@
 };
=20
 &iomuxc_lpsr {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_hog_2>;
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins =3D <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
@@ -735,4 +754,10 @@
 			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x30
 		>;
 	};
+
+	pinctrl_hog_2: hoggrp-2 {
+		fsl,pins =3D <
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14
+		>;
+	};
 };
--=20
2.7.4

