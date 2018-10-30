Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E84C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85F620823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nS1UcH4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85F620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ3RfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:35:24 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:53096
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbeJ3RfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gymtkmyv6rFOO6B298WaESK7cXf2Cl8P9YW6zl4FmwA=;
 b=nS1UcH4qmWnoEfiwxrZQRcbYJ4zponyjPn4U6KARPG4BKmjECocJllfX+O4Kr4buVXICy8Nu6oG9F6SvkhHLT9Q2RugKnH9rpMeALj96OS/Gx7mNJzox2FmgXh/PH1BylsO2AL6QthAXf4TekoZnghqJwrSmnrHyGbuk2dl3+sw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4427.eurprd04.prod.outlook.com (52.135.137.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 08:42:47 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 08:42:47 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Topic: [PATCH V2 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Index: AQHUcCyIGORNf3a2+UCEyOg35tyqnQ==
Date:   Tue, 30 Oct 2018 08:42:47 +0000
Message-ID: <20181030083954.26440-4-qiangqing.zhang@nxp.com>
References: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:3:2::32) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4427;6:j4Z15dHP3vniFwFAi6DDfp9lKw8kol3MtNA2AelRhDZkg/FAaPBGzl5ZrJWSqrAq/HkNtrubl6K6K2XzwO3iXezAZgxuAqfxZ8/FsLB7MQFcaMHW+FmRZtnEvlyfrpzpz9BPfct+5ULS9tfAqOANIUjLFL6whO33xmtmTZPTD7RUSUn5one/IzbUeweKUXhDfJGhVdXRt9X0X/qeQbE90apkHgeZ0FxXUtLTepXJYQHo/WnI0OueVqTrfxhz/5z6gKQz4PefKHysDYf9yummjZ460pVCJfGZ37C/yBLijlURi9z0Dx11clmdR+JloU97/Ck31OyAdzHjnxWvgBb/Sh0aLf4HjqZeUlJN89P7ffkUi7TNcdWpvfhFZZKvSYcWOXmkRTG0BrjbfzKEERIyVHjb+llczTY8zxRPBT53cZuoc+lVjXYqHZaxhVGxD9Qe/9+IuJRzqKVHP449kJmPFw==;5:QMyAxH7sh8+dLgDnDGou34zbJHx/1aU+QPt0F2zNGLdF2x6wa8ur1fIg//8+laRL4N5Lun+wjYrgRtxRan7zdLQr0OSOO6NQC1mhbRoejy4zlrSQV4sprIFW95b/5iHLEmcBdZgQdMctBfFTPvYIpYKP1yveasLPbxlTRfQP3pY=;7:AxTsYKuPXGcWKOY9BQlOJrMAgbiDVhLhX1bxSdPk8bEQj95aVKTG//1m8tCs3BIawWDExPH/sG5GYKwsaIZvuEO0uGvu6zpOhE5gyyqmz5TeDycZ8+BXjAiKpMYwgCBGejIrmLlg2R6lGN6Ig6I2Cw==
x-ms-office365-filtering-correlation-id: e0cee2d0-5703-48ac-a4c2-08d63e43aaa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4427;
x-ms-traffictypediagnostic: DB7PR04MB4427:
x-microsoft-antispam-prvs: <DB7PR04MB44278535265E64FC42683F24E6CC0@DB7PR04MB4427.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4427;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4427;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(6506007)(71200400001)(54906003)(7736002)(71190400001)(110136005)(316002)(99286004)(53936002)(6512007)(5250100002)(6436002)(66066001)(305945005)(97736004)(14444005)(256004)(2501003)(8676002)(102836004)(575784001)(105586002)(81166006)(14454004)(52116002)(4326008)(25786009)(81156014)(1076002)(106356001)(3846002)(6116002)(5660300001)(86362001)(186003)(386003)(2906002)(8936002)(68736007)(478600001)(36756003)(50226002)(486006)(6486002)(76176011)(26005)(446003)(2900100001)(476003)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4427;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CCUnqIktZfLOnGiTlqlCKjO0XWH6t7MKQ8Ef/yJVgsuU8cxsZpnR+Y2Q7BNXix0FKNqVc3I73LgYrkAvm0ty9gr8gbRX6wpYKD4VVa3JLunxFpBj8S+puTpyELwZ1YdCS5A1/pBNez8e8YXi7yEB/6LfQ/NhNZTZ0mf1gohiy13SXzi5+GgTqSEi9B4PZ+HXQByWIKlEnG7md/HjqlgxdPrRd3XBp5aygnLt45zpvpcTsA9+r1xolCYa4O3V55aa//7+oKlb/QG53QT4O0YZ5bSF7abofEijbPX5xKHN40Jqj4CoLtStZDN7nxp9rI/PdRyTeCTDVU3iH6Ap7oRuf9lCPp5MskMBWtGIOpttVf4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cee2d0-5703-48ac-a4c2-08d63e43aaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 08:42:47.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The flexcan1 is pin conflict with fec. So we add a new dts file with
flexcan1 enabled with fec disabled for user to use.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 14 ++++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 14 ++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 47 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts b/arch/arm/boo=
t/dts/imx6dl-sabreauto-flexcan1.dts
new file mode 100644
index 000000000000..4ebcc283f549
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
+
+#include "imx6dl-sabreauto.dts"
+
+&can1{
+	status =3D "okay";
+};
+
+&fec {
+	/* pin conflict with flexcan1 */
+	status =3D "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts b/arch/arm/boot=
/dts/imx6q-sabreauto-flexcan1.dts
new file mode 100644
index 000000000000..e7e684656f09
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
+
+#include "imx6q-sabreauto.dts"
+
+&can1{
+	status =3D "okay";
+};
+
+&fec {
+	/* pin conflict with flexcan1 */
+	status =3D "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/i=
mx6qdl-sabreauto.dtsi
index a10f0ad0bfb1..c1111b972b46 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -101,6 +101,25 @@
 		enable-active-high;
 	};
=20
+	reg_can_en: regulator-can-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-en";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&max7310_b 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-stby";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&max7310_b 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply =3D <&reg_can_en>;
+	};
+
 	sound-cs42888 {
 		compatible =3D "fsl,imx6-sabreauto-cs42888",
 			"fsl,imx-audio-cs42888";
@@ -279,6 +298,20 @@
 	status =3D "okay";
 };
=20
+&can1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "disabled"; /* pin conflict with fec */
+};
+
+&can2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "okay";
+};
+
 &gpmi {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_gpmi_nand>;
@@ -494,6 +527,20 @@
 			>;
 		};
=20
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins =3D <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX        0x17059
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x17059
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins =3D <
+				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x17059
+				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x17059
+			>;
+		};
+
 		pinctrl_gpio_keys: gpiokeysgrp {
 			fsl,pins =3D <
 				MX6QDL_PAD_SD2_CMD__GPIO1_IO11		0x1b0b0
--=20
2.17.1

