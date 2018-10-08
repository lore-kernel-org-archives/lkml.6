Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44854C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E1421557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoB+j62T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E1421557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeJHWkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:40:21 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:47856
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728203AbeJHWkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAND/oqFwFNrBK/sbcSBbMqsFGwvOWYU4mIml6u08lc=;
 b=QoB+j62ThxkzNUq21aBIAdqg2krlDvg5Cf2ZRpC8dpxROYhXz7yA17ACUQYcESND/l30MVWUEd/vVOwfKwaUvSMTRUhjLYi/LGMwOvuqkPDBIzZLGpUA0j7Wv2X308SIfo3PCfVedkYakOo5+sqJPxtxgD/PSHgrd806S+KtD0A=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5313.eurprd04.prod.outlook.com (20.177.42.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 15:28:01 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 15:28:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH v3] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUXxt/otjVETax2kKjUwsgexWsHA==
Date:   Mon, 8 Oct 2018 15:28:01 +0000
Message-ID: <c4478a98b0d2c69d58b4ba5cad3c13d73c5b387f.1539012355.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HE1PR0802CA0016.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::26) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5313;6:snEAk67bcgB254oSG0jauba3A1KoyDuVhQCdsSBWKFuwiDlC0KBKA7lGHNi+wtQIAz0fYQ2JEZFObAXEJOqmLQ3Zocih+wOlCnjt82bZKkEFlBK7MAD5wWL4zHbRHrOWMeGq1Z9D/00blzOOgTliqAl2p6j7+acu0bnwohNZF6WAM+SBLdNrbPw3ta5Aa5Oy0ElaTadgJoU9G7YfV7GU6K7bQOiv9FzILDTza8ua4aZObxofo4lzvSp+54wG4A1aXFPFDQcYwT0I0N8ieW907T+lrJc0GdxRSIzLiS8fILlNg4xMFt2Ukf4iTc366Jy9vtsIpcnLBTBcmD/XcuNtS4t0UWqCi02orRpvM5Gqe6Xvtm5dc1FVKAzWjHdI0/1WkdO0XvJlitqJEuHeUpLnARonMqJ0ZN3Q31BKdv4YGdG+1U+3yBHIeOJGiV6xDXortx3qsv4Dp3t5Wn92EhoJ+w==;5:2bGF/sVyyILrMioX/IIWUckbAwaHaosYg2T4mXiS28IrdeJOp+2CFeMJDXPpnbQsom6Bv30s/hSHOcfv3m+aiYlgJute0wIU0W3aiBESbcuhWDzcZbSW3e3MJDnewkRTXh1sDeKUaZlgTs3sAILpW/0ZbHYdsiLy7CZ2HjRjd6s=;7:c+x2TrqoPRbf9jv1K6sYdYyhk+hrLQI15qz7llwWrJViHkhUl1txELqihbKzsR2+oMww4HkOJAJNB+YelrtpccrzfIqDtWIuFRZCENU0KOE92bKrUgTvLB5x8SjxkoCrO4CZsHZDD6uP3qz52YsX43eW9p9Xl5GpAkcL2vr0hrCxD6SlBqKPyT+clQHu8ucNtIxt+aIpT9ua0MVgE+7o/LqlKz8CKkKM0jcno1AgaKW+l2gtrH7esLvtht0VAMZA
x-ms-office365-filtering-correlation-id: ecb958b7-6c98-4372-5584-08d62d32a20f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5313;
x-ms-traffictypediagnostic: AM0PR04MB5313:
x-microsoft-antispam-prvs: <AM0PR04MB531355C3E88E6CFCC8699A62EEE60@AM0PR04MB5313.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB5313;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5313;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(99286004)(118296001)(478600001)(7736002)(4326008)(52116002)(6436002)(8936002)(2616005)(2906002)(316002)(6486002)(6116002)(8676002)(3846002)(68736007)(486006)(106356001)(305945005)(575784001)(86362001)(50226002)(2900100001)(25786009)(476003)(14454004)(186003)(110136005)(102836004)(81156014)(966005)(81166006)(44832011)(97736004)(5660300001)(71200400001)(66066001)(26005)(6506007)(386003)(105586002)(71190400001)(53936002)(5250100002)(14444005)(6512007)(39060400002)(256004)(54906003)(36756003)(6306002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5313;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eHkaajv0AwPNhK0ZwddLiyLESjzCo+oSIcwq8rjGsAMm5KDvnIld4KohmQ+q/9NX740r9LoQWxOR0WgzGLWkzphLoEOyKsg3eEOlUuSaPRTMSD+8R+EYUHJ2zfwIhrcFQjYZ/OYs6GjHA0tS3URU6BedYO+as3dWBcuDtypsDYzxLK4GozcU9gLHoTRJc0bMBWVcqkiGUINr5DSdMFsBj2GW8ZKVxjshlj4hkPsxuvx4va0ZWOAVM80SnS2PA243TLd/Ousg76luflCpmY5hMUZsxPUfkr6+IbHFEAU+38bOk2t3xID2/0c2Ejtzn9vpNtGaKyoz4NoVefFlO50qK0FdzIfpzIUZzqzMcFJb2ZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb958b7-6c98-4372-5584-08d62d32a20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 15:28:01.4685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for "fixed-regulator" only explicitly support "gpio" property,
not "gpios". Fix by correcting the property name.

The enet PHYs on imx6sx-sdb needs to be explicitly reset after a power
cycle, this can be handled by the phy-reset-gpios property. Sadly this
is not handled on suspend: the fec driver turns phy-supply off but
doesn't assert phy-reset-gpios again on resume.

Since additional phy-level work is required to support powering off the
phy in suspend fix the problem by just marking the regulator as
"boot-on" "always-on" so that it's never turned off. This behavior is
equivalent to older releases.

Keep the phy-reset-gpios property on fec anyway because it is a correct
description of board design.

This issue was exposed by commit efdfeb079cc3 ("regulator: fixed:
Convert to use GPIO descriptor only") which causes the "gpios" property
to also be parsed. Before that commit the "gpios" property had no
effect, PHY reset was only handled in the the bootloader.

This fixes linux-next boot failures previously reported here:
 https://lore.kernel.org/patchwork/patch/982437/#1177900
 https://lore.kernel.org/patchwork/patch/994091/#1178304

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
I attempted to fix by asserting phy-reset-gpios on resume but apparently
phy fixups are still lost and need to be reapplied (not sure why/how).

Changes since v2:
 * Mark as always-on boot-enable-on because phy power cycling is hard
 * Clear Reviewed-by because of large behavior change
 * Link to v2: https://lore.kernel.org/patchwork/patch/995520/

Changes since v1:
 * Use 0x10b0 for phy reset pinctrl value (Fabio)
 * Link to v1: https://lore.kernel.org/patchwork/patch/994871/

 arch/arm/boot/dts/imx6sx-sdb.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-s=
db.dtsi
index 53b3408b5fab..7d7d679945d2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -115,11 +115,13 @@
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_enet_3v3>;
 		regulator-name =3D "enet_3v3";
 		regulator-min-microvolt =3D <3300000>;
 		regulator-max-microvolt =3D <3300000>;
-		gpios =3D <&gpio2 6 GPIO_ACTIVE_LOW>;
+		gpio =3D <&gpio2 6 GPIO_ACTIVE_LOW>;
+		regulator-boot-on;
+		regulator-always-on;
 	};
=20
 	reg_pcie_gpio: regulator-pcie-gpio {
 		compatible =3D "regulator-fixed";
 		pinctrl-names =3D "default";
@@ -178,10 +180,11 @@
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
@@ -371,10 +374,12 @@
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

