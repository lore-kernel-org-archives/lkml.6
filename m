Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7572EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385E4206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PlvbBo79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfBXCuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:50:40 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:51747
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbfBXCui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jECv9KS8lurSuS/XHs7jTu3QMY3Yt3F9cWt1RKtLK/Q=;
 b=PlvbBo794nc3r29D5yiyX+5SHO8wt3fOquaeNgs4VxIUOWNe42uYKvXpCpomPTMXG6Iegp405iTZ98AUCh9ez3bQeQHVUk8EE+p+DweruRxhUZtAYvk2037oH/GrM8fW9i4168HZ/bWeQLQkYrql5EgNMqTqTOYY38m1vXhBHDk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:50:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:50:32 +0000
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
Subject: [PATCH V9 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V9 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUy+u1czRhHiwCAUylWKsapUD+8A==
Date:   Sun, 24 Feb 2019 02:50:32 +0000
Message-ID: <1550976319-20216-4-git-send-email-Anson.Huang@nxp.com>
References: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a14dbd6-1ce1-4cd3-4d53-08d69a02d7cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3931;23:KxI04JIME1ibqilJnWLaOF0OAegLdqfddRyW+?=
 =?iso-8859-1?Q?YXsEIyxmBGIOLAlA98oobPVOrLW9D1w2eDf0bjJ9QeHfBsMsKDtAps2GPX?=
 =?iso-8859-1?Q?MBlEKayOOp/qeQw2KMB7LV7w5oOferTBmR6W/QVYdq8VvrRk9BBCp62hzt?=
 =?iso-8859-1?Q?vy0ayjYd9IRURbiXUQLmvwZ/E22X2YbWcAbEHAvwxO/zx1LAQRMUOWou3s?=
 =?iso-8859-1?Q?PZDBWmHimCWrSBhh1Rw/+yG6+RCzO5mKKhGOzN+JAbAzNfnvm+OT4NqcnE?=
 =?iso-8859-1?Q?ahz7NHWIpEDYBc61sjL99VUUWOx5p41xyG7sWDtfoX+u/XNhWGG3FIxGeU?=
 =?iso-8859-1?Q?k0P1o007SZ+rtsvYRalWoUQrishjqFEV2FAQtiESQtr6CzuJ/1DDGTM22C?=
 =?iso-8859-1?Q?10s+SqoFIAd18WKpvy4vd65RBL4TzXfY/U6ObSJX06QEc9fEKa6wMvOoc9?=
 =?iso-8859-1?Q?dFt14b/Wiv300SPgTvzpNQA0sixFJGnxZYzTQr7SLw5DqnyKi5RqW13vxI?=
 =?iso-8859-1?Q?N425XBNoqQfsW9Kk2E1Herijyur76//EmpRDFRoWHmyo8q1Oby+QGC4vME?=
 =?iso-8859-1?Q?6/fHJU+8WnGPoYcDw4jcrz58f1uPaF2+KPjTAMWnLhgh8QtziOUITEt+YI?=
 =?iso-8859-1?Q?XdNWGeN4gv+srKfnVSHBFCKwQQjc7oIhrtlg4+IO+HVfh8eb16mdC4DxG8?=
 =?iso-8859-1?Q?s7acpSBD35pAEIRqwLEibhcVDZKOJyYZkrZfJJ6ijuBj9kvBzWSHDx6pzF?=
 =?iso-8859-1?Q?42eVMSrAWja0qzZmXMH7WNuQu9oTLohYmdx04A1JQnSt03Yjz1Ez1xXFi2?=
 =?iso-8859-1?Q?Z5NB3d1+FVM2cwQa1MIPsOmEJCK30GT9+AHgR8TpkUIhMRBMtc7VUlhi16?=
 =?iso-8859-1?Q?dn52Sd9YF+DtD8efR0nhgznnIt6Z8XZR1bIJiosPl+dQjEWlmEfCtNfb9v?=
 =?iso-8859-1?Q?5DWwC3UweCXabSDvvzlKh51BKuqDcJJ7JI4lWMTiCrqGBpEAsVOx5tZtr+?=
 =?iso-8859-1?Q?DRg+IlNonBTp4loc5j17iY7bHVy1IP1cWRqzQ8zmvoc6egz5BLtmWqQYlZ?=
 =?iso-8859-1?Q?UZeZwvAfLHfNjTBk0W0GMVwbsK9vws+sGAvGlTDI1oUj1+w64Enzwbf6EV?=
 =?iso-8859-1?Q?/jppbyUYkaw5PQNme3lUCaoffMxS0iMykN78SMzTggQQFatDtY2zBXSd+x?=
 =?iso-8859-1?Q?5NlYVEuHuUMpRyZFpzXDF0VDDy6+TYS6UYRcpaCzji23X4UBgrwv5v39LY?=
 =?iso-8859-1?Q?xBYGiGoKEhdSi86IPjInMR7RSuKwoy55FUtOgdwCiyAUw6mEfnyEErYMeD?=
 =?iso-8859-1?Q?/WIgEPdFEW0Tc34eiR2PaOVk3yeuJSnX51cUELQMGrXmi1WD02KugSbQ0A?=
 =?iso-8859-1?Q?o7SJiTtatg=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB39314D186B3387D1CCE2BA66F5790@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39850400004)(396003)(136003)(189003)(199004)(71200400001)(71190400001)(36756003)(26005)(6116002)(6506007)(6436002)(6486002)(3846002)(97736004)(316002)(386003)(86362001)(7416002)(5660300002)(14444005)(102836004)(110136005)(68736007)(2201001)(25786009)(81156014)(7736002)(256004)(186003)(81166006)(8676002)(305945005)(4326008)(446003)(76176011)(2501003)(14454004)(2616005)(476003)(486006)(966005)(53936002)(66066001)(105586002)(50226002)(52116002)(2906002)(478600001)(11346002)(6306002)(99286004)(8936002)(6512007)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r1n/1tjpIbN6ZKdk10SBWHEL5GSYI/mUHUOVuxWwmMHKQ7/cniJ+F46KUiouvoyTilovsUjte/GZdWQBfu5JRfW6amoaGQpQsklJMNeSF65YJk7tmnnuGO93LZOnXYbSZfUKi33lFxeRmXR+Px2lcvDXpfPeFPXXhFoCzrARPtqn8UK/QYNYObSOmGXoCHrzdG9oFBglfeuba0mSnL9tEcabE515krKl3An4e2fmqGha+X2Vqq8KvqlkOiMd6oXub63sd4gqrpbZImv2glteuAUvR7Hgx4lqLGuXi6CuwJUC4HG4dyKqr7qdmFG56ULkKQZEAEymtDIJzuMZd7FPbY0FM+p0E/qcG3uOi+llxoQgcu3qISRqZEztR8wtUz8KLh08wCwpgmYOm7e9/UUxWNhAKLoNiPTUJEK96F8jwI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a14dbd6-1ce1-4cd3-4d53-08d69a02d7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:50:23.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V8:
	- remove "#cooling-cells" since it is already included in cpu-freq opp tab=
le patch:
	  https://patchwork.kernel.org/patch/10825081/
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 34 ++++++++++++++++++++++++++=
++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..85c90e0 100644
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
@@ -116,6 +117,12 @@
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
@@ -443,4 +450,31 @@
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

