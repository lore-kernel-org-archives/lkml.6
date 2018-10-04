Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF020652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cY5i7JH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FF020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeJDWlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:41:11 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:1281
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeJDWlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPZueDI9V7X/5NThWpzOgOWSIyC9NZv7f0nYEgdKiWw=;
 b=cY5i7JH+5ADSjuKZxf9FWIwI0vHtk02RCSb3B/lclbDLN4LhETRem40KdFDDoV0Tc/hhuGE6qiSXlGKcBgpm3op29I5CLOJuYfqTA44KVBEAaQIhD3uDgPgw9I0+juo3e2o5quxziQ55zbSJORdCsXWag66Fno0kXKASR9lRy2s=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5012.eurprd04.prod.outlook.com (20.177.40.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 15:47:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 15:47:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Andy Duan <fugang.duan@nxp.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH v2] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUW/mFEvH7cglHbUuy4iC9ILMEkw==
Date:   Thu, 4 Oct 2018 15:47:14 +0000
Message-ID: <c7161f1258c7cd12093af1d8919a8a95e5e65a73.1538667700.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HE1PR0802CA0013.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::23) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5012;6:pFFAk+H3GtYi34rNkyslelBGeEK2/GssK7YCEHDJR+NNRpab7HDcpP+gobsjaYE0udX+fSibOz/pACkCVUSrfYRhiW1ornlq0mGUAkgLaEyLwuOYBxyQ0ckwhCZImpvlTb4EYm/joOAZavn7dGxpNYyL4zG2Ix2gCBy+zPJgZ5A+MX3s2RGXxhgUf8XfivXGikbIQ4/h4x0EFJ3tiLAxmYzWiXImBiU+hjoyAqAEXFAhBMwp/5YcZ6mMFTnsWQVpBlA+hBl9qfGyYp2xkZEVU8vGkfAQ3LqvJYUIUpYtFNtdJ4vjwQU6qAvMnQg3lMrZWLh1dbIvTzqlFn85PFAyXOpVwL4IzIB/Jr21Fir6YW+OkJvPoOVZNYtvP4FodTs2xKqEcPjiY4NIgq4dye6yl5F0trfvrD2owZWRoatSfBbqbph/jUHlfo3BW6bEhMdDba7+HoZelttjh1d30jj20w==;5:5OmFxlsRojFke3EFMYYGZaXQm/EohsSaPUlAzxQ0gcnu2khqz5K6PVdWWaXIZkbbvz/DPzeZPH7Kli0zs04OMZbWHnbXXw0TlIJdVOkiOU9926nq61xal+GFEU8WqP2eCtT9PU8gghHB09btH3YpqHdehk/wMMjsOy1uqq6pBGQ=;7:jgtLdkkpMeXcGCKyAxJ6AicS8nH6HU6rNZM5nA7pRLcX3MKuT9cWUCabgvYgLikkaoy5oEa0IIidUMuF+QugcS7OrAxsVtGP5jR57Ps0tmnxG4mw5nKOCsAC/vCSYEwad/b6CJnPDkjBU/ziRcSdSAr0sSZzMV3ebv7sGKgQCymCbcQnmXNmcsj2KOsuDqr6Vf6TO582w+wX3s+yX9JGKkkt2IE4q94ieoiqIeZxUpckVDE96ms5GyKV4d1c8y35
x-ms-office365-filtering-correlation-id: d07e7e14-ed61-49b3-f7ad-08d62a10a75a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5012;
x-ms-traffictypediagnostic: AM0PR04MB5012:
x-microsoft-antispam-prvs: <AM0PR04MB50127B7FE67E5A3275CFD69BEEEA0@AM0PR04MB5012.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991048);SRVR:AM0PR04MB5012;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5012;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(7736002)(71200400001)(305945005)(6636002)(81156014)(81166006)(26005)(8676002)(106356001)(6486002)(5250100002)(105586002)(316002)(102836004)(2616005)(476003)(3846002)(68736007)(2906002)(118296001)(8936002)(6436002)(14444005)(6116002)(6306002)(256004)(6512007)(71190400001)(50226002)(5660300001)(575784001)(14454004)(39060400002)(186003)(97736004)(110136005)(44832011)(6506007)(478600001)(99286004)(25786009)(54906003)(36756003)(2900100001)(66066001)(4326008)(386003)(53936002)(86362001)(966005)(486006)(52116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5012;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J4+00sWpqYRZccUJjJj7wrBS5AgraKT8NG/HkWpFcTB59sSbpuKc09Zw7PJi0aMgKL3Yq/fKSMoB6l2INefLh8HWD58rE+is8S5lPaex+LnrwVFb0VVuo7YcB6kqaxkwuKt387xPOx43jzWD8e2bOW1cZYb1b4B5BtPgmoxmGUnfexik5JD8/neCVD6kbSgk0uSOSTzFFIIphsMyZLHbn02Ljr/J49Z2frnLhx2yK1WX5/gVdU6YQjBQXsle9bq8NFopwNNT0UOXTZBvhfmSnFHRD7Ge1KzGrzsqyYj+Hw38iC8+Uzem0JBaxDikpRW4hrcgI85iEW2DPeD6FIg4cGFVAPkXaijiF6xEFR9QYlM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07e7e14-ed61-49b3-f7ad-08d62a10a75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 15:47:14.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5012
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
effect, PHY reset was only handled in the the bootloader.

This fixes linux-next boot failures previously reported here:
 https://lore.kernel.org/patchwork/patch/982437/#1177900
 https://lore.kernel.org/patchwork/patch/994091/#1178304

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes since v1:
 * Use 0x10b0 for phy reset pinctrl value (Fabio)
 * Link to v1: https://lore.kernel.org/patchwork/patch/994871/

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-s=
db.dtsi
index 53b3408b5fab..29196476ce0c 100644
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
+				MX6SX_PAD_ENET2_CRS__GPIO2_IO_7		0x10b0
 			>;
 		};
=20
 		pinctrl_enet_3v3: enet3v3grp {
 			fsl,pins =3D <
--=20
2.17.1

