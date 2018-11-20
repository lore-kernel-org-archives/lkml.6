Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HULvppI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9276C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeKTMCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:02:12 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:18887
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKTMCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IwZP8HyP3Af2fGIL1mxemXLDSajFfxQCowCaV1e2Wo=;
 b=HULvppI1fPV+rbyhPMO+tGQImN/RW2Bg2yE+oTMcdkmFNzbl3Q2NNiy/LN/oYZdgfpXNGyS0SdHEjhm9S9KIEordu/TtsqP5RRRRx/XqvCdAAY25zRaQbZbbXsLX2UY4EG+1xbIhXK67T5jymlHgm++sF9jR4lsKVQNmtzw5Ttk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 01:35:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 01:35:35 +0000
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
Subject: [PATCH V3] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH V3] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUgHFV71mTLuSnFEiJX1rGdBdziw==
Date:   Tue, 20 Nov 2018 01:35:34 +0000
Message-ID: <1542677411-27825-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:36::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3883;6:P8vmuVHzW4dETjnw3NUZLSDzCle+h4RK10k78DEgNN+uHPKaIfGaOvxo0j9gjGbbuF73nExE47SFf/GA3MhwFrzr1xYFV/3CKoI/3Pn+PbPjApTI+Ihz6Ohfsgi6n4Kl1O5gUD+4sOPxVPPtY+z9Ajeyv1Yq9+infcCKFglujhRgL6FA4g7DvB/tJ7Was9fGTcWXn/QLgQCUQFZ0l4cmjpQTjRwcNg1EhQyVfhQdhbXJN/yT6aKxmtu+hk9USsvhlk8KlgQjcd0bEB3i5sPPVoTZ861j538OieazUXVl6E1kmGCghNbEGUjfeJR1dgt4hVxbvQVhMWLXd4RfxMY2DEQKQbmN1H6ilX3WlXLuw0MjkhOjgtaMaEwY6dG1+xEa9NjVkAJDw5s6AgzJ1hZ+wEMxsuOcppRKgjJ4dR7yr6wm93cdY7Xtqa1BxOa0GO+bXjxVGl1VtK8JXIyc3Rm2wQ==;5:hipgjcSs8SESq8YvauygndjZ/eq9DvnEySX/+sejiRGgBHgfsTK+BZ58JUv3+RrX6sCYrTqH5ac0BnlMSvk35tpB7T1PVR6dAuJk3aNFN909GAxvwn3Rok0fDlXl2E7/i4+E0F3TUysIq745keDDEFqlRdTvwK5ftWyq+XAYyro=;7:+itnt9z/Jxj6OEfATdx2FCEZTlzilTyAs0IWmwVwlNvJ/0CTw6jg0WYqMiv0f41xHf51klB19BBztca46NuX8epl2d704Vgu8iV5hN9pob6exd1aWJ0WpBmvIu+sNrSdkLPjXGe+D5+S9gIy3U8nqA==
x-ms-office365-filtering-correlation-id: 2b6910fe-f4c6-4808-bfc9-08d64e887745
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB388390E3F18CEF55D31E66CCF5D90@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3883;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3883;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(71190400001)(316002)(71200400001)(110136005)(68736007)(14444005)(256004)(8936002)(81156014)(81166006)(50226002)(8676002)(2906002)(2900100001)(3846002)(6116002)(2501003)(66066001)(97736004)(2201001)(86362001)(575784001)(476003)(2616005)(486006)(36756003)(105586002)(5660300001)(305945005)(106356001)(478600001)(4326008)(25786009)(6486002)(26005)(99286004)(6506007)(186003)(386003)(53936002)(14454004)(52116002)(102836004)(7736002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pOEv97R/Z+XBQco4MJIED/l0o6JnRC7l6osqpV8StgfVby+LDviwNMxCYDQQniI8p2ea+uWRPed14GeqrMZ+moZLPHoMbRRJotRsD57L9WuFtg3/CwyBmzrPWVMKORogu61XaIVi/6hX/59scAkLRxHTRFAmh8Zp07MTcBsWJFriQLHe9A1K4mfvcGdfUIt2Z/ujGD9+ZJe8HNas7nePR36GBPB8HFF1RGrKhLy8XEAGzSUSfGx/k7vwKE4Zu9b/dL5CBOHxM+gBeAp0CQpaisGIYps2UM+0mLvigPZDPusLh3m99oEoLu2L2QZt+pqhu67lUTd88NC8iAACoyLr47Hp4lgiMS6e/aC8WlSu9rE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6910fe-f4c6-4808-bfc9-08d64e887745
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:35:34.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
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
changes since V2:
	use USB OTG2 VBUS fix regulator to reference GPIO pinctrl entry instead of=
 hog group.
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx7d-sdb-reva.dts | 40 ++++++++++++++++++++++++++++++++=
++++
 arch/arm/boot/dts/imx7d-sdb.dts      | 28 +++++++++++++++++++++++--
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
index 0000000..7ce9d8c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-sdb-reva.dts
@@ -0,0 +1,40 @@
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
+		pinctrl-0 =3D <&pinctrl_usb_otg2_vbus_reg_reva>;
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
+				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
+			>;
+		};
+
+		pinctrl_usb_otg2_vbus_reg_reva: usbotg2vbusregrevagrp {
+			fsl,pins =3D <
+				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.=
dts
index b1b613b..202922e 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -72,9 +72,11 @@
 	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "usb_otg2_vbus";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_usb_otg2_vbus_reg>;
 		regulator-min-microvolt =3D <5000000>;
 		regulator-max-microvolt =3D <5000000>;
-		gpio =3D <&gpio4 7 GPIO_ACTIVE_HIGH>;
+		gpio =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
=20
@@ -115,6 +117,16 @@
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
@@ -211,6 +223,7 @@
 	assigned-clock-rates =3D <0>, <100000000>;
 	phy-mode =3D "rgmii";
 	phy-handle =3D <&ethphy1>;
+	phy-supply =3D <&reg_fec2_3v3>;
 	fsl,magic-packet;
 	status =3D "okay";
 };
@@ -492,6 +505,12 @@
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
@@ -514,7 +533,6 @@
=20
 		pinctrl_hog: hoggrp {
 			fsl,pins =3D <
-				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
 				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
 			>;
 		};
@@ -736,4 +754,10 @@
 			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x30
 		>;
 	};
+
+	pinctrl_usb_otg2_vbus_reg: usbotg2vbusreggrp {
+		fsl,pins =3D <
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14
+		>;
+	};
 };
--=20
2.7.4

