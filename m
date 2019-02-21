Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F67920675
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GnddRqwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfBUGjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:39:05 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:14792
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbfBUGjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/QPUIImObQcTA27E0/VuZ6dbxktCIr6Pzp/g16Sp9k=;
 b=GnddRqwSKCS9h5izFb5KcMCAks7s3UXxKu4i8OsuD4vgVDnmINTul7qk3rquEQD8n9FW6UTXb1dctEFj3wkYQC9AempvgnvTzBiPcFENSLHOehfZhppE5I566s2VYdj3jGh8Ol4nxIuuG/F3DtjbGofi3PZW6l1LN5nkrD0+5Qs=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 06:38:57 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 06:38:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V8 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V8 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUybAeSo37+zULAUSf8sC6yKNW+w==
Date:   Thu, 21 Feb 2019 06:38:57 +0000
Message-ID: <1550730831-14995-4-git-send-email-Anson.Huang@nxp.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c06d5650-8a11-49f4-c64d-08d697c7413e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3863;
x-ms-traffictypediagnostic: AM6PR0402MB3863:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3863;23:dfRriVpXGNgblxuSkzkslAp9QD/otkBKLIM0m?=
 =?iso-8859-1?Q?zBLUeQZR2/2k1pmKYLQVmjCETHRjJ3GGUyO3ybJ3aX5hN35BeIffNfEwem?=
 =?iso-8859-1?Q?aZBQCCPjW8sylPUw6Le/5VICJvpCuEXQ6cPE2qojGbrx+vWQX6RGieGhuS?=
 =?iso-8859-1?Q?PKlnHrRTS7vpF9H+dZCM2RE5rY3TGzscNunlLznHEwEfXPN8mHRazhp9Vg?=
 =?iso-8859-1?Q?oxIpPSLjwhUe7HtyuLDvOtRigAYWJGUZN5UPX4nhMnKC4IcCwy0VKcgVsZ?=
 =?iso-8859-1?Q?wIj1joOjv+C1hw/bTrKXxmtDCA6YI+Wlfytili6TE7XZFUCwiLYZYv5KW9?=
 =?iso-8859-1?Q?Zy1W67QUUMcZX0e8O/rZBrB/d+lhHDAAXo3p7QbVeOC4ZhbWv/FvKsQQUT?=
 =?iso-8859-1?Q?BDW1UnFV2FsdRCqQ8TtQJMQoDLPWqcNuZUHWF2UkRr4rrvcvgcV9zmJAqJ?=
 =?iso-8859-1?Q?2SuYkjy3nXIC0Yst+K7NT87C/7OfBCdkCQbmfkEBUrWudsCY94N3ufyVdZ?=
 =?iso-8859-1?Q?kQfjsSqFaOMnO//8tBjfDi/IeuRCBeP+lQAx0ez6mf1pKQui2o5bbCw5Fg?=
 =?iso-8859-1?Q?14o7MuczuP0ywHhX0bHvd49SLgeAYrzDYAw/FOTvTRpAc9C6NRSOlPHeeB?=
 =?iso-8859-1?Q?JIjYoyh921YvRhXwnAChw2+aIFxrXou5YolNfEZRmd8lepvRon/dkuSmq/?=
 =?iso-8859-1?Q?hV8eORW4u1bqBNKBMX54g1isY3ElszRetMSZce551aKTK0mTamOL+3wMJt?=
 =?iso-8859-1?Q?7fDA6r94IJfJa9B6cN7bRC07Su4kOYnRpXprxKFyHcGMAM/r1fRnv+Ylrc?=
 =?iso-8859-1?Q?Dw8nE5vVRFbY4jRDJqMT7KRnWqqUOAjf/uGrDlcWLhBkeecZzBwIS36iKd?=
 =?iso-8859-1?Q?wqTsC0c7Q6s/G9LKGGSnqoswl4Oeu731zabV5Hav2Wh9/fkRdkp5mE3OaU?=
 =?iso-8859-1?Q?Sh3Rtc/QJXSc2qY0Cu56hvj/gljeDZNxvHsFdpmiNIknbWmtQ4+fobczCe?=
 =?iso-8859-1?Q?BZ2FLQE8XXh4a1semqp2Bek0/c5CY0p+zjTIaeqHYqmt/mZ+HlSaJJ2jlE?=
 =?iso-8859-1?Q?RipOkjdTI8sLyZgjXtQ/9i5kPC0e1LTTTtMwWyKN31Aw/JjuNG/v8tmdj8?=
 =?iso-8859-1?Q?PbemHBLIgL6SguH6lY6Z2epSROg3O4FCx9j9biNiWxwndTJ9oU+IKHOw0D?=
 =?iso-8859-1?Q?lR5gV5/9d5+N+UgrpO/rKe+dAsHrANxRGsrIo9NaGjcd3z1FzUfmimTDwS?=
 =?iso-8859-1?Q?tuqc53f2SW2aEq6P76Pzs/vlxpVThGk/HXRsNo8FkrHqICnF/3yZS2obEc?=
 =?iso-8859-1?Q?v2L1QRiXQfIW8Eq0JFMQlvCWh?=
x-microsoft-antispam-prvs: <AM6PR0402MB386366A7B28E17D97A492470F57E0@AM6PR0402MB3863.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(71200400001)(5660300002)(6486002)(97736004)(6512007)(2906002)(86362001)(36756003)(66066001)(2201001)(71190400001)(53936002)(4326008)(486006)(25786009)(68736007)(305945005)(14454004)(6436002)(316002)(386003)(8676002)(6116002)(3846002)(446003)(110136005)(186003)(7736002)(2616005)(76176011)(26005)(256004)(81166006)(102836004)(50226002)(7416002)(14444005)(476003)(2501003)(81156014)(8936002)(6506007)(52116002)(106356001)(99286004)(105586002)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3863;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z+aq3sGMUgSS81pm2/Zm4Ln5C0IfWSP6KkMj0PpoSLaZ7NRn577pB2xX9ffjlMCS1pLLOp2tRehomFkeVhZz48cGtqNxu1xP4d0M8qksqYQRbH/77t7k6t5kD4/UrRHGCZyau10pfqkNXIGvoML86LUlv2hoYDT9w0YZ81Yd2fp4c0OsfKigy8dxrMSjVKFo4zRTCU47dqUFsm9Qczu5HE4inTH7T83qg4iliSJZNOZf58LlPUXLP422aK7lgsC82a16k+5XoNBLUe/HVj+ghCyNRb5Ms7zTW7/y5giUiRdeMjxO0c9XrWdtWMHWr7xQ19AYXYYuO8S4HIGsFZXh493RkRJTyPbzDsoJqJglgK24pRsl7XBf9CTW4euedKn4DQQ/5otRGm/X5d/dmtgMXgWLSAz/GhTpHLzw+HwVdP0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06d5650-8a11-49f4-c64d-08d697c7413e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 06:38:48.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V7:
	- move the "imx,sensor-resource-id" to scu tsens node;
	- correct #thermal-sensor-cells value to be 0 as there is ONLY one thermal=
 zone now;
	- add cooling map for passive mode.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 35 ++++++++++++++++++++++++++=
++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..eccdf28 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
=20
 / {
 	interrupt-parent =3D <&gic>;
@@ -34,6 +35,7 @@
 			reg =3D <0x0 0x0>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A35_L2>;
+			#cooling-cells =3D <2>;
 		};
=20
 		A35_1: cpu@1 {
@@ -116,6 +118,12 @@
 		rtc: rtc {
 			compatible =3D "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible =3D "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			#thermal-sensor-cells =3D <0>;
+			imx,sensor-resource-id =3D <IMX_SC_R_SYSTEM>;
+		};
 	};
=20
 	timer {
@@ -443,4 +451,31 @@
 			power-domains =3D <&pd IMX_SC_R_GPIO_7>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <2000>;
+			thermal-sensors =3D <&tsens 0>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature =3D <107000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+				cpu_crit0: trip1 {
+					temperature =3D <127000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_alert0>;
+					cooling-device =3D
+						<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
--=20
2.7.4

