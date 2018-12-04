Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EAC208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YuXZEC+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EAC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeLDIyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:54:20 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:31088
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbeLDIyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdfSn1Uzz2Inxfl9eNw7GY9tZlnD3Lt6+GNs5CEqMKE=;
 b=YuXZEC+sVpUOeMz8EMX6aoOkxr6EzTcqh+Eyz/AxutDzkH1SU1Z5PvsuTavkPetIFf3ikyHklG65NTBF15kWya6DPHEv9by5LiRHrkLyKFBBA2kihuo0zEooi0tgETEOYE54HB+M7/oP4iWpIBddZCdEZio5Ed+7JKQrJRMoHMU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 08:54:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 08:54:10 +0000
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
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen support on
 i2c2 bus
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Thread-Index: AQHUi67sJwvwp2WEqEW/kmuV/wO8IQ==
Date:   Tue, 4 Dec 2018 08:54:10 +0000
Message-ID: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3900;6:zoRmK637zqZNDH/oZzPmB7cfT+A0CxyekWhy1Jzjfm+KcxJRrH84k7sNY7MhjiocCtfDSa8B1PI2obELzcfHdW9yLAInD4qsfckhwSPWPYCGs504Xibqw1CR6Hg3jXouD/ipgIvotIc39jJz4M6ccQYXSyNej7dAa2ocUueu1LEBncYsgjxIjZVVqJ/l+UlL5lBErAA4cO1rRj6tECYIID+CEemhbhiv5Y8Q8/cw4U3ITPDztAJWkFbHrLckQhHehbi6tZ5tNvVm73ahYcnxcKI2L2MuUS++/fSyCSrzNq8mYx4TSvpw50IB7O7PiyPSzpzyHk6b/vWs/PTR0WGzx5CcfmQn2yu7G/8zk7xAzXNSEOz1Sn9YfayQVFFg2OSRHEkeYNSXqoFSYNX74fzxHaGdac03tCLL4ThW6NNhKBz4ZisqpDrtoeuWDbhUHVVDpHqXEi84Qa0ngH1y7FFkgg==;5:S6kPOX4ZzJDiSQGAWBE45SsztMZ+B+V8PYmenPlsve05z/xgTSn7Bp7O///QZVPnUbYiLu1ZRPDOM6jm/3NvKzvvJ2d9db6wKKEqHpYixSIRQVAEt4qwl//rXTRUPVVMhUdd/1G2b99Tj/7L6YWY8Oui6i3PFJcphc8KZCrvrPo=;7:LNzl/qhqmYNao3fWMhpDHprwXgNOZNTRJOwsQ0SzhxeEOT3gPBSe2qGcRD6g4WPEYEfWp9VWnfIIlMTBycKW69T6/LPVH5LyUavN4WDNcTgTQQ0RtckVD+iKOmeulb1828uSzHbaW/ldtuMRTJSWPg==
x-ms-office365-filtering-correlation-id: b6a64a61-1f95-48be-a889-08d659c60df9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB390084C2C4CFF84404D5A232F5AF0@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3900;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3900;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(8676002)(25786009)(3846002)(6436002)(86362001)(5660300001)(256004)(26005)(186003)(6116002)(66066001)(575784001)(97736004)(102836004)(110136005)(2616005)(305945005)(14454004)(2906002)(99286004)(6506007)(68736007)(386003)(52116002)(2201001)(476003)(71190400001)(7736002)(50226002)(106356001)(486006)(2501003)(105586002)(316002)(36756003)(53936002)(4326008)(6512007)(8936002)(478600001)(71200400001)(81156014)(81166006)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Sum7La3F/H2K/xs5xANBj2h254r+dj3It95WxctwOY36xaS8OkZdVl8+O7+sMcPzShrdjOGlFFt1O1IswxEdPAj61IVcvICG8LwlZb/ZukyBotRi1TI+aYPDuUZYnhthLnbxqFMLUvTgtDeKM2h2atPTUCIjPzEuXU8tQCdPRSQlnK2gKYw5z1NGxycLmfxmIqPM1/tkNfJKq1TtUDuG7cOAh75wX12YacKFWF4BEr4mfERxE4cVPSEonHwDPHwO0xjT6KqS337QrDAL8A0NMnT09SADGp8cFCKa3txbygRD4e7M6Ye+F0n3Y/rsyPr0FVe2sD1Bi0179n6bGf2Fux310DWcBxu/LyPn3qplOuQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a64a61-1f95-48be-a889-08d659c60df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:54:10.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 6e46a19..d7389b5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -272,6 +272,16 @@
 	pinctrl-0 =3D <&pinctrl_i2c2>;
 	status =3D "okay";
=20
+	touchscreen@4 {
+		compatible =3D "eeti,egalax_ts";
+		reg =3D <0x04>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2c2_egalax_int>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <8 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios =3D <&gpio6 8 GPIO_ACTIVE_HIGH>;
+	};
+
 	ov5640: camera@3c {
 		compatible =3D "ovti,ov5640";
 		pinctrl-names =3D "default";
@@ -498,6 +508,12 @@
 			>;
 		};
=20
+		pinctrl_i2c2_egalax_int: i2c2egalaxintgrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x1b0b0
+			>;
+		};
+
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
--=20
2.7.4

