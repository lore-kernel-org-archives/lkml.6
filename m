Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA8FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9C92064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmW5dwBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJSRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:48:11 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:49328
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTIUrWXiAyqIyYUT95tOkooadWTkroiTXDiwtIWqF/w=;
 b=HmW5dwBqoIDo13PIaE0ITpbA18mmtxIGX3Uy21YHhKJ4vG2tS3u7fhxEamqvdlA16arMV/rxPpLAJCNqNjFd7c18XoicF4fOnwuUAKTlcbE84Trzxi5piOHfvkUF8PT8nEiwpcyh+tinckhwJ4wdupLaIVCa0ZrTyEfGAV940YQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB3993.eurprd04.prod.outlook.com (52.134.107.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 19 Oct 2018 09:42:47 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2%4]) with mapi id 15.20.1228.035; Fri, 19 Oct 2018
 09:42:47 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Index: AQHUZ5AX9bFhc2fvBEqua6kfXbFzXQ==
Date:   Fri, 19 Oct 2018 09:42:47 +0000
Message-ID: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB3993;6:s8fEYoR9JZ2ugIUOzyN7Zk+f62YPFQC/K2F8dtyb0KzX1RjQjbijZNlw1ga4vfcl7rcwFkWFghA8ORU/VOeESssaNCJHHkk+8lmxb+VC3jMev7UuPI7oif9JGrcZyLTOf3KQSTu1l4j91lWafsO+lc/KNtvFKQ7RaWFuOqYkKFcLmEM5Qw0+SIncPKJWKjH49aH0Bn4WHYLcxm5yw29+XDaCzzUWeZg1JXHDXIDxaYZxGRdhXjMvH5+3B5YrM7tofFG9e5u4IxRh77INMsee8//rBzOGw5G4KnuSdpNwv5JSFmyEqMD32dzBiD1aaF4yIWahWspekZthgpvNyRXlvzfhZkw0hjZkyF0LsZmbgzlBxiuDh/pts1TnwBg/tB2ijICteNKJX0mhX3FYuloMqQBgd6hPsyrLvvin7Huu1gvRjZaRmGdiqG4yp3uPJrNgu1E7ybRUmFk1xH6I+ja8mA==;5:+zqlxzs31lrvNA5rSEPHV8WzDYbwt6xwskKHuyZxSr/AjHTA9Jd0inoKeUyCedxgVGBuF0KUBgzGFnALjCNSlv3uWbykzcWuEYLudBLT5GGS55v5BmAaLz+jahFc/733UPqpQ1BlaaTsYr0nyj1MjFY/eeGBqQN56Rbw5FOoZIY=;7:baBkKZ65OQcLic8DV03nkeJBzthItnW2Gq2NKU+0wqs3BkdlFKqn7ShWPOzfGJlxf1gH1ykHYsv2Sav/yS/ohOYfIig0XetV7GgeiXhedp8IR39bx3SM330o+bZqe4oipazkrGpI0ieJOZGgIC/QPKToHb8bZzVeGQ+WhJk5pJn8ENh0mfs9lSSr2YOw2MMBdU4PdgfA2Ysjky1nPCL7FBc4csPHsAa2iXmfegsbxIlimBsgNEjbejftquKvYHsG
x-ms-office365-filtering-correlation-id: 1692cb8a-0f67-418b-d2b9-08d635a73a0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB3993;
x-ms-traffictypediagnostic: DB7PR04MB3993:
x-microsoft-antispam-prvs: <DB7PR04MB3993BEA2E8E63F29B0C13D7BE6F90@DB7PR04MB3993.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB3993;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB3993;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(106356001)(476003)(2501003)(1076002)(486006)(6512007)(6506007)(99286004)(386003)(2900100001)(14454004)(5660300001)(4326008)(68736007)(2616005)(81156014)(478600001)(81166006)(5250100002)(102836004)(6436002)(50226002)(8936002)(316002)(6486002)(52116002)(6116002)(3846002)(186003)(26005)(1857600001)(25786009)(53936002)(8676002)(66066001)(110136005)(256004)(105586002)(2906002)(54906003)(2201001)(575784001)(305945005)(86362001)(7736002)(36756003)(71190400001)(97736004)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3993;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /XuKXudOldfKQ9/AKal6SbflhcMHqVXmH8uAwBTN7s3W9HWnw9UoVYsg8MVOFq/TFJSBWpjOa8Hx3VndN1II4wSstdxq+/cviRNqiwapfkk77TpmDgaj44feXpMh/+z9LG3hpd4nxsuBMRCAEvCwn3pqXLjGi8uTbhRLVr842d4z0GzQuL4q/DiwNvY1KyDGfuV87at6tu20IHSueW6wqiGh2tGbVio/qnixKeQhkIjOKyHlvACKMIPVXtuHygIqV0PjsgcqLtxWxuGawzSr0KHyCe4BQDc+oC50XBrCS+ivF9ukSLgJLt/XUxOz3RZUbTjIh186l+D6e+xvywf6hCWcs9GP+p1GD2yrVpAEDJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1692cb8a-0f67-418b-d2b9-08d635a73a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 09:42:47.5548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

CAN transceiver is different on RevA and RevB board.
It's active high on RevA while active low on Rev B.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts  |  5 ++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 42 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sd=
b.dts
index 6dd9bebfe027..092b8de142a8 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -10,6 +10,11 @@
=20
 / {
 	model =3D "Freescale i.MX6 SoloX SDB RevB Board";
+
+	/* Transceiver EN/STBY is active low on RevB board */
+	reg_can_stby: regulator-can-stby {
+		gpio =3D <&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
 };
=20
 &i2c1 {
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-s=
db.dtsi
index f8f31872fa14..e37ec4b396a2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -136,6 +136,20 @@
 		regulator-max-microvolt =3D <5000000>;
 	};
=20
+	reg_can_en: regulator-can-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-en";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "can-stby";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
 	sound {
 		compatible =3D "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
 		model =3D "wm8962-audio";
@@ -202,6 +216,20 @@
 	status =3D "okay";
 };
=20
+&flexcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "okay";
+};
+
+&flexcan2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	xceiver-supply =3D <&reg_can_stby>;
+	status =3D "okay";
+};
+
 &i2c3 {
 	clock-frequency =3D <100000>;
 	pinctrl-names =3D "default";
@@ -397,6 +425,20 @@
 			>;
 		};
=20
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins =3D <
+				MX6SX_PAD_QSPI1B_DQS__CAN1_TX		0x1b020
+				MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX		0x1b020
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins =3D <
+				MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX		0x1b020
+				MX6SX_PAD_QSPI1A_DQS__CAN2_TX		0x1b020
+			>;
+		};
+
 		pinctrl_gpio_keys: gpio_keysgrp {
 			fsl,pins =3D <
 				MX6SX_PAD_CSI_DATA04__GPIO1_IO_18 0x17059
--=20
2.17.1

