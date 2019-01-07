Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0372C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E4206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8r1gmoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAGN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:28:54 -0500
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:64586
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbfAGN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20EZNhc/Sn/fm5Yw0wextXJ2M/tI7qqrsqPho+Z81mw=;
 b=K8r1gmoHqUkl+NzN9YUQKN7dE7d2SWL7hrQgkIOOUl2ZHaZCBGOGA0JO7AYm6yu0l6XSsWYQ8EtqeoE1Y3HUvumfdIAWCXkN6arBgvvufPNtmJjjxpGMBDmdHCkQRAP4Kgdh/M92ykx8MNBlLti2qdtiBlgeooaTMFcJnU8NfLo=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB1679.eurprd04.prod.outlook.com (10.164.85.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Mon, 7 Jan 2019 13:28:48 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 13:28:48 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain support
Thread-Topic: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain
 support
Thread-Index: AQHUpozrZMkpjBu84Uy0kvzHp7j9nw==
Date:   Mon, 7 Jan 2019 13:28:48 +0000
Message-ID: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0201CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::30) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1679;6:t3Rq6dT80BElCMK41K6w2ycXZMdsulc3Eq52RC410tiM607jNXyvNSE6/XG9Bhk65EAfo274/Ki8HqmcmzQR9em6//Jv3/eEd0DSd0sVuwfmaFx9+kv44B33lgyTTz1lelt6EwYMsN+iP89CgDHdvDsKOIY/9knBVXQmUssro1YD2fU1+phQNOEnhRVFiKO39Z+rNYfzxtVLt8rzBU/5C+Bg73bk8Vt5WwL3FHyR+upqYjSgyTzwO7OW29guVoVpVCa/MlzJHc79nqarfVjVZ6mu2g5xsXaEWubtum5kVg14C2fhQ2sGWXZ/CG7Dfrm7xLfkTndy5GFEBQgyR2H4D3+V3Lq+YH3i+aw6rwt1JCzCYyRka639SH6ClDQKIC6D3Nx/KdWL7NW1j04xfam7CxX0tWSf+WtdGpP8ws2/jZYnxFVa5Uo2TYXBeQCs+cllHf3ggAtqpuw5Fp9z1MtyZw==;5:MD5GZeDZfVc8fj5JkFmGD7GPFQBHbWGWx1x4IWLoYvx9vk82ULxzvXZMJeZ9KSO6pBo7XqrJynCVFlOT83tk1nfqRmymFZ4zCorJ7YCHqOcmK6lr1TYoVfokS2SG2n5kRfeBCqMcQcJlYz9NvwTvXCcyY1vXDTldwUDOw4BahQcbORt0sEalIEsCQ69m9QBVgcbnKwgC0ZBSmRoVUAVm+A==;7:ys7JyxUG7tlXwcCAjBAmargj6OVzXyk/TiZC4Ndz9fJhXLttj8tz/BvaS73tpfDDetbko59e2fwQesiEAuw5XC7mdCd9cl9D2KMFDBoBYF3DBjTBWZL2KAc1X7JE7KVtrzwgbDRV5YPwCZ8iDxs4zw==
x-ms-office365-filtering-correlation-id: 641ba89d-f848-4909-fc79-08d674a40dc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1679;
x-ms-traffictypediagnostic: VI1PR04MB1679:
x-microsoft-antispam-prvs: <VI1PR04MB167928609AC1654192E29308EE890@VI1PR04MB1679.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1679;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1679;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(99286004)(6506007)(86362001)(2906002)(486006)(476003)(36756003)(6116002)(3846002)(118296001)(50226002)(105586002)(106356001)(2501003)(8676002)(81156014)(8936002)(316002)(81166006)(966005)(54906003)(110136005)(14454004)(68736007)(44832011)(386003)(478600001)(7736002)(6486002)(305945005)(52116002)(25786009)(6436002)(97736004)(4326008)(6306002)(6512007)(66066001)(71190400001)(71200400001)(53936002)(102836004)(186003)(26005)(575784001)(5660300001)(2616005)(256004)(14444005)(2201001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1679;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IICHbpa43X22FhbzSw4M9Qv8EZmnNtUFgj7hSyg5Ext9lZhM5xSW9mKQJ/tagaYYodC9TbBjot4gyq0k069/dTcujl3xWsEYHebt6rl9QfK9syPEiswifpmWbmGUA//8bXMTHzXa5BampDjukKxhATinXyads/ixTxqAl5sbDLcAkCYm2/hbH3N1KtSV6OFO772WPPWO4P9f565JNRcl1HF1F7yThpK6N9UNWn3toobWBmFJ8PzoobGcF4GeB9z9JaCxAZCBEMn2f7J0TKfRsAgjXIzMc+AeheDBPhjs2U3Php/t70/ZjprdXbuIlrT1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641ba89d-f848-4909-fc79-08d674a40dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 13:28:46.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was implemented in the driver but not actually defined and
referenced in dts. This makes it always on.

From reference manual in section "10.4.1.4.1 Power Distribution":

"Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
PCIe, DCIC, and LDB. It is supplied by internal regulator."

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. Handle this by adding the pcie node
in both power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

This is the last part of a series which was previously accepted, it was
delayed because it depends on PCI multi-pd support. All driver
dependencies have landed in 5.0-rc1, resending for 5.1 as discussed:

	https://lore.kernel.org/patchwork/patch/996812/#1190746

Only change is a minor conflict with removing a pxp clk.

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 272ff6133ec1..ecf3f3e5c0a0 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -783,10 +783,22 @@
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_soc>;
 						clocks =3D <&clks IMX6SX_CLK_GPU>;
 					};
=20
+					pd_disp: power-domain@2 {
+						reg =3D <2>;
+						#power-domain-cells =3D <0>;
+						clocks =3D <&clks IMX6SX_CLK_PXP_AXI>,
+							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
+							 <&clks IMX6SX_CLK_LCDIF_APB>,
+							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
+							 <&clks IMX6SX_CLK_CSI>,
+							 <&clks IMX6SX_CLK_VADC>;
+					};
+
 					pd_pci: power-domain@3 {
 						reg =3D <3>;
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_pcie>;
 					};
@@ -1203,10 +1215,11 @@
 					compatible =3D "fsl,imx6sx-pxp", "fsl,imx6ull-pxp";
 					reg =3D <0x02218000 0x4000>;
 					interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6SX_CLK_PXP_AXI>;
 					clock-names =3D "axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				csi2: csi@221c000 {
 					reg =3D <0x0221c000 0x4000>;
@@ -1224,10 +1237,11 @@
 					interrupts =3D <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF1_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				lcdif2: lcdif@2224000 {
 					compatible =3D "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
@@ -1235,19 +1249,21 @@
 					interrupts =3D <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF2_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				vadc: vadc@2228000 {
 					reg =3D <0x02228000 0x4000>, <0x0222c000 0x4000>;
 					reg-names =3D "vadc-vafe", "vadc-vdec";
 					clocks =3D <&clks IMX6SX_CLK_VADC>,
 						 <&clks IMX6SX_CLK_CSI>;
 					clock-names =3D "vadc", "csi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
 			};
=20
 			adc1: adc@2280000 {
@@ -1368,10 +1384,11 @@
 			clocks =3D <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
-			power-domains =3D <&pd_pci>;
+			power-domains =3D <&pd_disp>, <&pd_pci>;
+			power-domain-names =3D "pcie", "pcie_phy";
 			status =3D "disabled";
 		};
 	};
 };
--=20
2.17.1

