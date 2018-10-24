Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB23C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB14020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dBuQbpvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB14020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJXTm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:28 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:51712
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeJXTm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrGjWWQV3eRH0X4pthW9+U29QX4cZ5RmLQX3zlM5ums=;
 b=dBuQbpvO5PDPt1gotXpNCpXMhU1woN3qdAbY+VVN4tO/vNyClv8XaD7pkupou7zcI0xNtzhkRpGGKdGhdiQXlVs5eOmXJMuInsQgshjV5xakYGnfk1Mn29+Y98RtrvzaGgd/YXL0Cc65yp4PzDtgIh6Q+Gq+R9WfMnHJXVjyZFM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4138.eurprd04.prod.outlook.com (52.135.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Wed, 24 Oct 2018 11:14:42 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 11:14:42 +0000
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
Subject: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Topic: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Index: AQHUa4rCncfeoBYpBkmKYYSezC6GHw==
Date:   Wed, 24 Oct 2018 11:14:42 +0000
Message-ID: <20181024111213.2724-4-qiangqing.zhang@nxp.com>
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0098.apcprd06.prod.outlook.com
 (2603:1096:3:14::24) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4138;6:Y3rXkxBaB5AWa8bWiDRx0skNBlA5IVgRtPM5Pmjy1qemZXelJ8/AI3MjJbFDOqmA5br9DfhIWAzdYimm/oM+IObXELWhD5ZJCxpLNtsQXMtHoSOju54nSLVa7jFQLtZSIlJLQFE59iJuijg9WOqKARTnSWvGRL6G1U2zX0aReYEGFBDmY9dseXaZ6uQ66yb6X1pCPB4YN+V5lvoMOjyJ9/2YgIAJfLxeoPPTt3hMG569drsVkl0DeAG5DGIBN/lKtNz0bmYCxmH67Lm+EBYzq1+kZr8o4R8ibTaDaaf88y3Gi9oyKhC7FsUmqi/tn9O8UVONOSzj7mx6FV5b/rvkgVS32Q1gJaIl1wxp9YiVbTnbE++k8fCizT77vHcmpBFt+azl14SSke8vYi+E7AfGoI5VM1Vsmxb8irlOOFvfQvSk8jyVx5iZ7x37aLRcrK1NC1J8UaY6l5pL1OhNkyCCDw==;5:kDf41XkG4sk0qiA1VakX5utCzo1dgqC5NruS6eWIWt7Q87up4naiaMpILsFcUZj4trLJz5B1LGNXGghKcnY9KjmGyw+4aGe3uVn5cBnJihq8YZ0SzS+s76FkAKzGHbFS3w/kis/1H5DOuxRl2YG+6B6tmqm/ZdjdnP5Hd7cv2RQ=;7:2gxMUutPkAwmj2qdKlf7OmlefV/gpB8NNzZu+exvuKgc+39QbypFA5028crvef8EfoNiADvV+oMwXRjPXvaPs40znUJWACrEPWitanvJtiO3Fv6zZ05sS8zn/KvyJCN2Z2TF6kVc0x0k549+y6s1kw==
x-ms-office365-filtering-correlation-id: cffc47ba-fe9d-4bd9-2edb-08d639a1e53b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4138;
x-ms-traffictypediagnostic: DB7PR04MB4138:
x-microsoft-antispam-prvs: <DB7PR04MB41380D216ABE5636E064AA26E6F60@DB7PR04MB4138.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4138;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4138;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(81166006)(26005)(54906003)(66066001)(105586002)(14454004)(86362001)(8936002)(575784001)(2906002)(186003)(11346002)(478600001)(71200400001)(71190400001)(25786009)(106356001)(5660300001)(76176011)(305945005)(50226002)(386003)(486006)(102836004)(7736002)(81156014)(14444005)(316002)(110136005)(4326008)(256004)(8676002)(68736007)(2616005)(476003)(52116002)(6506007)(6486002)(53936002)(97736004)(2900100001)(6436002)(99286004)(446003)(36756003)(6512007)(5250100002)(2501003)(1076002)(3846002)(6116002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4138;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r18Ymqv3N3I5yxZKhP0QgMZNTs+0vh7eWYRkqoChN+/yP4W+MMDl2fvERP7dvF+CjutxvFgNq2znq4PiFkqSH/lNKTbKHCv42v7V9WMgWnvdoeiLERCT1RMxFIbh0nI1NzIaqRZgilmprZu8MJ0JRPsRT3tn9FvBlTpbYolFEn3eub0QqJuS+7Gs8wguS50AlvjE3DivzhXZDSkDfn5xLjM3i6XDf/t2d2Vpt6SAijjn8a7DxEF27yqMCjHcsu7YbqdxHsH53git24KAbdgTbaoiPzipcsuM4U1EWOrelIzi1IFyVy1MPJlRq8jxmGMFmnw7FUfblWNeG0wyYAN90tKD7td8lMPSBF8S7afq0HU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc47ba-fe9d-4bd9-2edb-08d639a1e53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 11:14:42.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4138
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
 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 19 ++++++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 19 ++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 48 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts b/arch/arm/boo=
t/dts/imx6dl-sabreauto-flexcan1.dts
new file mode 100644
index 000000000000..963e0b559d60
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
index 000000000000..2648437a983f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
index a10f0ad0bfb1..205f063ee5a4 100644
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
@@ -279,6 +298,21 @@
 	status =3D "okay";
 };
=20
+&can1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	pinctrl-assert-gpios =3D <&max7310_b 3 GPIO_ACTIVE_HIGH>; /* TX */
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
@@ -494,6 +528,20 @@
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

