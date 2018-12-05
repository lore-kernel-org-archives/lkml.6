Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D951C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172FB2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RK0XaVkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172FB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeLEJT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:19:59 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:61312
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbeLEJT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+MCTULYAiK9weGUkOIau3UA4T9Cbbb2iKcMBJe1Kno=;
 b=RK0XaVkZpOrXR/uOg53soT4KUO3FF+IoOrY6QvMyptDadqyehzQGriN4RKFMfOAbPq8DuUxsWIZQfbuUZXf7ugtMbjKOSONQh8hoqZJaIdxmWQYUGBpvSTBF6xfABxl732LyUVN0hJOgpfYQZFuuhsiyP/32RvZOwRImP0HOEYc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 09:19:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 09:19:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
Thread-Topic: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
Thread-Index: AQHUjHurf4tHrcB58kqn5WYLMeeHcg==
Date:   Wed, 5 Dec 2018 09:19:48 +0000
Message-ID: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:203:52::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:lw80i2xF7fJLltOBW7mRt7uoGqmiyEoRYUtDFvBhxK2ypj0UDPYag4+7Hwy2C7HPWW+X4Crj3u7PhFBunMIRc2PIew6QDAtPEqWi18ko+SKfI++WCq3I1r8a1NC6fmUCvlgo77o00uMnrmdTjxAWJmDgsSQ9dp1AofT9GXCD2prQo5is0QKFkKSHbuiFnBP+2O2ajwjXkfPliKFtjiWsBGIC3FmNzvh+ATixDuY9L2m4l5e6M3iMhSwjrWSkSPHnCGvlnC+8FohNhh0IUqn8/Xr29XQv00RnFM3T8/yqnAr7YMyHVfdYr6L3C8Frbo0V/b2KEutdXmQk6mqCLXXBiQ+fzukel6QTDwfugNGOvzaKJMUoyvElJMpdEUQo5VjLtja1WCKW8YzcTP2KlQPFbXAlm/FDmKmsRZv2KIB2XZ4WJTLuZNYkWqCIWZl12afjyNlmU8VhhfnxYLFVWEciDg==;5:ezfXLG8dIoA23+psQ7DoryrmqsUYavl6H88UxVtELjiKm5BPig1fCNy8mEs1oXP7IHOhwKr5AVmtl1FrOcONi+95NGRl72iIcVL2yYcaUH06KxfOPJDQEmq/DuImEiX5DfgokW4jZKq0LHoqELKK6Bjw/rz+NPDYkmZHAb/LZTg=;7:z+KxE/BO3oEu1voAf9B7TXkwKP1VgeA+ZxOQnZC5VJZaWgHDiwJQtlvsPAAtVgYAs1KpwTD8cQvWFx8brG7Ckv8S+XL7tMpfOCcH1tI2/bKk3UBW1ffJoFt8V16wGuNYv7ZuBhH7xDBJESH45k8ofA==
x-ms-office365-filtering-correlation-id: 29c5f9d0-e8d1-4aa2-b425-08d65a92cd75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB36904D10BF883247D9E671B5F5A80@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(8676002)(102836004)(316002)(97736004)(81156014)(8936002)(2616005)(6486002)(81166006)(106356001)(476003)(386003)(105586002)(6506007)(4326008)(99286004)(71200400001)(71190400001)(186003)(26005)(5660300001)(110136005)(50226002)(14454004)(2906002)(2501003)(36756003)(2201001)(6512007)(52116002)(6116002)(3846002)(7736002)(66066001)(86362001)(575784001)(68736007)(305945005)(256004)(53936002)(25786009)(486006)(478600001)(6436002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5vAIAsHy5Hx00ouH4vsoYgxFsXkJNL1V8aF/kGNPo4+UUkQUyLCous/GDlUE5LwCy6T9ZHZgGY7tPUjxoRFHOPxpkMbg0Z9oBSUWhexkptSw/8r0SYk0ppid6qdTlj3MfjKHt005af55nWMuhTRJN5ZS9JtjUi/BJc9bu8S/Qo+IV6cdCTO6usGbYTitbbIdsvSkbj6NNz31AU6QySFxqX/xbTok892zF2yRJhB32Bn8mny9scLafc+gAPjqdWndQUXGAUT7l7Mso6WpVYE7RYn8Dw3gLgbQhHuJ4i87VSsc8I+oemb6RcWScad1KKllDniriSjp5eS4N0FO/dLv4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c5f9d0-e8d1-4aa2-b425-08d65a92cd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 09:19:48.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add isl29023 light sensor support on i2c3 bus, the light
sensor's power is controlled by a fixed regulator, since
the isl29023 driver and most of other sensors on same
board like mag3110 and mma8451 do NOT support regulator
operation currently, they are all controlled by this
regulator, so this patch also adds the fixed regulator
support and make it always on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 34 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index d7389b5..f96ae54 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -62,6 +62,19 @@
 			gpio =3D <&gpio3 19 0>;
 			enable-active-high;
 		};
+
+		reg_sensor: regulator@4 {
+			compatible =3D "regulator-fixed";
+			reg =3D <4>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl_sensor_reg>;
+			regulator-name =3D "sensor-supply";
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpio =3D <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-always-on;
+		};
 	};
=20
 	gpio-keys {
@@ -420,6 +433,15 @@
 		interrupts =3D <7 2>;
 		wakeup-gpios =3D <&gpio6 7 0>;
 	};
+
+	isl29023@44 {
+		compatible =3D "isil,isl29023";
+		reg =3D <0x44>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2c3_isl29023_int>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
+	};
 };
=20
 &iomuxc {
@@ -521,6 +543,12 @@
 			>;
 		};
=20
+		pinctrl_i2c3_isl29023_int: i2c3isl29023intgrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0xb0b1
+			>;
+		};
+
 		pinctrl_ipu1_csi0: ipu1csi0grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
@@ -569,6 +597,12 @@
 			>;
 		};
=20
+		pinctrl_sensor_reg: sensorreggrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x1b0b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
--=20
2.7.4

