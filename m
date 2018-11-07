Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0202C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KueasWWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0202C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeKGOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:47:39 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:7386
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbeKGOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmRVmGxJo+3SW7n9hPCAYg/vg1KP/5royhS5VFMAgZE=;
 b=KueasWWMsz3JX0HjrMqkhXcuyaMZP8Ssd/tUy+VE4xcur1zNBTIJry0Y9LCPO9Fcsx456y1SUJCvlYYEyggMWGzEPL/gwN63jjS9WRrPzmBIPzstB1Go1ozPOLYeOcpaUAk6qE2OJVLhDMQTIsOPRoFbUF1I6gkivsm1IoQRqUc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:18:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 05:18:47 +0000
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
Subject: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUdllc2yTfT4Rj4kWlQDRFrtQfPg==
Date:   Wed, 7 Nov 2018 05:18:47 +0000
Message-ID: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3641;6:ztf7m3xsE1ObFqsRYeQ9dPOKYGu1+8Pq0b2VRqw0btfkCNcVLHUIo3ng2NkY+DoYzjf8WzmD6FHRA99ngMTEzg3q/A/sBbzeWMR6nSBppsYptN/k0paVSAic+Jc736YFEv7pIzrLGflCxqogZnrV/WQbcX8qz/6Jd1wMolqlUnqxbf5+UV2e4zDoxMKd2MpPMANrvGN+8mVUMX6uPBE/6H3QYR9Pine3d6S+61UdobeDTSiLQ9Xe3kEReQKGE/E2/tOSo9kxr+P628ig8Xap3Tbz4V3pFIuWwQQQ4IrGHzjLY/MfviYHAGGCN/yI5PAzjuToVqZh9q6GGpbBddmj4cBJ8c/xTaiaiMadeQQXDqrsWY02i4zQodz2UNd5KJMJqHq1wbakJAEQrorJ45Ywo7DA69buW0ea5Nyylr7GERviueGvOjHTtjgndRcWq1rnX+sQUGmxgub/xXn/3x2SEg==;5:QZzyZJH+OAAoVTk+woTdGB+cq+0ijj/Mnro9moUw2QAIz3ijGP37Zc1gAseAVldOeTSEpfM3usaJAB5RZibp6K9FfiQ4D1eg2mc7dN5cioZQ3lzlGo9NdsgInAbvfmTJhUOko31hx0LUwM9dcRtB1r5ezh8oF7K0YwBP6soIY0E=;7:wyNnTbVVMGQbrFqj/ef3B64KpmDsEykpXmxrPMFAns+g57yZ3eSft1d+encQDYmeHkqvFg0IW0IXDCBn+GJkGh9MzzUq6kJpIHU9V1bYBqHyQcGRc1i8ZcRC6rcuXX1j98BZDN3+36JraiFyziEqlw==
x-ms-office365-filtering-correlation-id: 3d636515-d785-4615-5ab8-08d644707e9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-microsoft-antispam-prvs: <DB3PR0402MB36418D3875CB096A3CB43A6BF5C40@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3641;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3641;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(36756003)(2616005)(476003)(486006)(66066001)(6436002)(99286004)(105586002)(52116002)(6512007)(53936002)(68736007)(1857600001)(2900100001)(2906002)(4326008)(26005)(386003)(14454004)(186003)(102836004)(6506007)(7736002)(305945005)(106356001)(478600001)(71200400001)(71190400001)(3846002)(6116002)(97736004)(14444005)(256004)(5660300001)(316002)(110136005)(2201001)(50226002)(25786009)(8936002)(86362001)(575784001)(81156014)(8676002)(81166006)(2501003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iHx1NsKnRT/LbCKJfdts3AFTlHFjsyzSJa2RZruyoDhBgM+dWHHvJQq6oyMY73bqq0WJgiWsefXgmj19qcpKfqcF/CodI7ehFwr1fmKPQX9TbR1gjd8NJN/e95in6FJqrRRRGfds2KQJY3ZlPPJ387EQEsebQh393BCYBVhnUdiTZ9y2+ptEVQ5ElwsXr9/Qd6h0DIqK4MOCs1Utx/rBNxWK4ivFffNhUZSYpkC6qyFBYgkvua7tPbOZqlbuFciDn6PSaQhLAeZb0Fql+OGYlA7t//ksh4Tzqc3cWV0KFL613mLTJUiuds244b5jqxTKj87Aozslmkn0KlUSeEx/SSAhwbVbMnpcbiEb+emoZ/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d636515-d785-4615-5ab8-08d644707e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:18:47.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
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
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx7d-sdb-reva.dts | 40 ++++++++++++++++++++++++++++++++=
++++
 arch/arm/boot/dts/imx7d-sdb.dts      | 21 ++++++++++++++++---
 3 files changed, 59 insertions(+), 3 deletions(-)
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
index 0000000..c57c13d
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
+		gpio =3D <&gpio4 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&fec2 {
+	pinctrl-0 =3D <&pinctrl_enet2>;
+	/delete-property/pinctrl-assert-gpios;
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
index f1bafda..b89d9f6 100644
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
@@ -203,7 +203,8 @@
=20
 &fec2 {
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_enet2>;
+	pinctrl-0 =3D <&pinctrl_enet2 &pinctrl_enet2_epdc0_en>;
+	pinctrl-assert-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
 	assigned-clocks =3D <&clks IMX7D_ENET2_TIME_ROOT_SRC>,
 			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
 	assigned-clock-parents =3D <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
@@ -491,6 +492,12 @@
 			>;
 		};
=20
+		pinctrl_enet2_epdc0_en: enet2_epdc0_grp {
+			fsl,pins =3D <
+				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x14
+			>;
+		};
+
 		pinctrl_flexcan2: flexcan2grp {
 			fsl,pins =3D <
 				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
@@ -513,7 +520,6 @@
=20
 		pinctrl_hog: hoggrp {
 			fsl,pins =3D <
-				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
 				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
 			>;
 		};
@@ -724,6 +730,9 @@
 };
=20
 &iomuxc_lpsr {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_hog_2>;
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins =3D <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
@@ -735,4 +744,10 @@
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

