Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB22083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWnPQeqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABB22083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeJCBWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:22:22 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:57837
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbeJCBWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMVjQu70Kt2BMpm7r/kVvQbNGsCwOXCPMa8dOyMu88E=;
 b=kWnPQeqAXqQa5lAgeD5g8kbRmbwK4Q5Yr8i/vZFHq3dpdDdKaQ4Dph0Zob4CErKX5zf82h5L24zT9HDIKzMUIfG0ayXcmn8O9yVc3rubqM7PrULZ4JmR/25waAh5nuDXCSSFM7d0g5FXB8rI7MY6u5HB5o2jJSCVh3F4DMBHa28=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4292.eurprd04.prod.outlook.com (52.134.126.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 18:37:21 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 18:37:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUWn70L5CxBxcrw0W+NgO3q4rJuA==
Date:   Tue, 2 Oct 2018 18:37:21 +0000
Message-ID: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4292;6:1FCcvh3K4xAUofyxBUT4s6bkM9rsQKgFX5eIemqjrL/5ed8GlrpCVhkfrgmQbVX4K6mA1kBfPerreIoj4/4T1is4A5IaUb5j420663gc1GGBEAdxnCMUZyzwZsc5Kd3w9NSgtmS2fQbc7QoujbC5HssWRB79zAdnKIR0I++1OFE0wMpalDVx48wZ4y58Ymucx7GMBuja8b8tPxI+zJyEBAsPvkJD2EyW/qCwD61Z0nIM4pNXkN7an7tPOOI732oD53rUVRZnNqiExbDYjsmA2cc6kPef1ZVwVZbDQTXt5aOfG97FPIglSEvC0BrPctSJC1ySORw1JaoiQwUsFhKid4rAvYjwqKARFHzN76OO1o6MaAl97s7s3J8LUqIVavzZ0ymnAWXYEMlKkwUwk5fEqwD0Q4HZZFNkRiAMDPy0R1FbEyiwDxJGv/kp2kO9TlWIyH0vh6YTCNT3z1LyrkNBcQ==;5:Fqow8RdjHgs8JzOHiVnFGHpqp/IDTnR1i1BJyranFz4JfRMRkKLvL4a7huj00jnoIL/fl+Os2Va9ChqcFzDvFYGYcQ7Y+jeoc0CpgdNTWiJMP5BMmH0Ca/BdN/NkUrnJR9t8eKPz4VGK9buwNGuSUjrUiQ992KHeDKt4Qmb0mE4=;7:3xiYtNQsj1jBBEdVaEWQeoDP3tNXBGouCg2UjWvsuAmoAcYHdIX/6bPf5X5YhTNrI8AqkqWp5I3U1D+Y4zwnF+ACFMOrm6+IPxmPYW+2n9Oe9SK0q4mEN3XOPZZtp+t/aIewk3gHAAlJG5yz5TD5T5t5ycGbULaJ/EvSLQlW7QOb+nkPjcC4UFZX6KIhcVPIswGTFp4gZXLv6uFR3EEpAuhB1Kuvjpfj+aQ1RCmE2ez6XOGv7nIqX3LPwOHNkU6x
x-ms-office365-filtering-correlation-id: b63d08a2-29b1-4ac0-e148-08d62896166a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4292;
x-ms-traffictypediagnostic: AM0PR04MB4292:
x-microsoft-antispam-prvs: <AM0PR04MB4292D3C278E9C2B662A44DBFEEE80@AM0PR04MB4292.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB4292;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4292;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(6116002)(575784001)(50226002)(305945005)(86362001)(97736004)(106356001)(5250100002)(105586002)(966005)(478600001)(6486002)(81156014)(8676002)(81166006)(53936002)(52116002)(7736002)(6306002)(6512007)(25786009)(2616005)(476003)(256004)(6436002)(14454004)(8936002)(44832011)(14444005)(4326008)(486006)(1857600001)(5660300001)(118296001)(2900100001)(6506007)(386003)(66066001)(54906003)(39060400002)(2906002)(36756003)(316002)(71190400001)(186003)(3846002)(71200400001)(99286004)(26005)(102836004)(68736007)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4292;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IywfzWZZeIgpo+Ccp7vspgGy6d7tBO1TZ5AVecT5kMVpu8gj+JP4KCfm74ySCD/OYKxAUPO9zewl4XRtawT4vlkiINY+PwpNeq0gLSGELiqAyfC/yi3nBCuXOYzwaQEChAbC33GHA8BFg+Qu12UBkPRYvZ/bJDLWEQHrH0GjmhPxq5y+956D4nDbQZ5MngVQAPdGAoDOjtlHQWwf8FNiBjY7Qb+YUIwjifcJ+mmFzmtV5STsTiZ+tfxd1MPnHskvRAKeZTQMAmUGl2sdu4zAviGoxBvgzkErOoPcoCXXx9NXT70bTe4h+0idsa/RX+KqLCoks7LHf5bBlFHN6YET1ePh3+Mz/mjiEp2ozKL8zcQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d08a2-29b1-4ac0-e148-08d62896166a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 18:37:21.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for "fixed-regulator" only explicitly support "gpio" property,
not "gpios". Fix by correcting the property name.

The enet PHYs on imx6sx-sdb needs to be explicitly reset after a power
cycle, handle this by adding the phy-reset-gpios property.

Both phys share a single reset, a scenario similar to imx7d-sdb.

This issue was exposed by commit efdfeb079cc3 ("regulator: fixed:
Convert to use GPIO descriptor only") which causes the "gpios" property
to also be parsed. Before that commit the "gpios" property had no
effect and PHY reset was only handled in the bootloader.

This fixes linux-next netboot failures previously reported here:
 https://lore.kernel.org/patchwork/patch/982437/#1177900
 https://lore.kernel.org/patchwork/patch/994091/#1178304

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

I'm not entirely certain sharing the phy reset is OK, maybe somebody
with more familiarity with the FEC driver can confirm? This design seems
to be similar between multiple imx boards with dual ethernet ports.

This took a surprising amount of digging.

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-s=
db.dtsi
index 53b3408b5fab..1ed7a081c420 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -115,11 +115,11 @@
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_enet_3v3>;
 		regulator-name =3D "enet_3v3";
 		regulator-min-microvolt =3D <3300000>;
 		regulator-max-microvolt =3D <3300000>;
-		gpios =3D <&gpio2 6 GPIO_ACTIVE_LOW>;
+		gpio =3D <&gpio2 6 GPIO_ACTIVE_LOW>;
 	};
=20
 	reg_pcie_gpio: regulator-pcie-gpio {
 		compatible =3D "regulator-fixed";
 		pinctrl-names =3D "default";
@@ -178,10 +178,11 @@
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_enet1>;
 	phy-supply =3D <&reg_enet_3v3>;
 	phy-mode =3D "rgmii";
 	phy-handle =3D <&ethphy1>;
+	phy-reset-gpios =3D <&gpio2 7 GPIO_ACTIVE_LOW>;
 	status =3D "okay";
=20
 	mdio {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
@@ -371,10 +372,12 @@
 				MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1	0x3081
 				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2	0x3081
 				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3	0x3081
 				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN	0x3081
 				MX6SX_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M	0x91
+				/* phy reset */
+				MX6SX_PAD_ENET2_CRS__GPIO2_IO_7		0x80000000
 			>;
 		};
=20
 		pinctrl_enet_3v3: enet3v3grp {
 			fsl,pins =3D <
--=20
2.17.1

