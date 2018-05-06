Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbeEFGbv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:31:51 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:57952
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751041AbeEFGbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:31:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/7] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Sun,  6 May 2018 14:28:07 +0800
Message-Id: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KAXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::29) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:++ZAKpc2DPXJ1Kkkwg15QGWjbmLgRmAPIMywvLA59DjR+sIxtxF5/L/KLDzjoos5jz1RFLI62QKX47smwM6IPrD5XKjOnardApih1y6TURdrMhD7C63cAWcFYxRnKWBq0epO9Nw3mWwJFsI8ugW/l++iTgbk4LQyMqcQPAQbdIIAHydlS63A7SFnRi+37nzJ8hbjp6O0MRIS7X/Q9tXIX+9ERb5IYVy8j1eUq30G1AlbtTv5dQfvn0Z0TlpDcE20;25:Xq5mnT/vVTx2GHhOeeQErcgu7bozKkL85z5FnxUyjExYwTp0o5oSS2DcDW30DvE59CZ9vNaKg7KMN52IHIGDS88RDFYueBmsQF/FUDPBh4045C46U9TE9wTfkMF+vsHKDsWJDi/dh+ep9VD/KHO/oP7YfZwy9W9hFJqSvQi7ImAE1wDnp3iz2OW+9fjHnwMI3xO7GvTr+DoljnFZIFPA3RC/8ObTNVpZAFkUxxkeqrP1qMdJYZAcJStjrXj+dRo3ffO6ilGrFxOVFvPCxCWo3OsJ2J5J1EUOA9//lKIogsKqIqIaKXHJGOTg9BFlBEDV99O43xWmKph4+4tBX5zGww==;31:uz00Wbf9BVGRMGT4zpJOsRZY1FQ5ZttKd1gkOJU54R7QM0ch512AwpiCLOGV+DLIyNVWstah+SyjC/AwDTLUWTSn5kwNK6hFgfrYCEScTyuZRq14B9aWX78XQReyb41dp2IUgipQWRP4UVgo17aHlONYZwg6fH+sQHedTjZwcn5JrfrXtHYM/g/l8OQ0/7qn9/AD1mMTXCN6Tk+zy8L/Bka4af2zLL1VTKjK+ZLVZe4=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:G/iw/r6OqajEp6ay5W0ZKYWlGUiA40gN2a25I+yfuFGMecTAmfi33Z2RTKGtdEFnkkYGsO+P18g5Cvnr6ne5mnsnh8A+3x19LNoO4gJsi1syfZxTc/83RJtLOj8ayZ/RhCVmXvOdsDDfeWczrkLNw9XJw7C99G+lgWWwXei/LMMA9FbUzSNKwb937vLsCZD1x+0uQObMVnGU7Vkqo+GfUTnuWf4dREspz43X/6d6o7SOpbA0IUoDZuvVbbY+Mq7N1KVzqv58l0TSqik79uaiJOg5FLtk3Z8vVWxbHhqFhgFqPpLRXJ3+xX42i3qFBcQCXIX0IG/tWoWmgXpWCcLZC3oIIZcO5AzymjrP+/dPH2/P0I6vq7pXjgCgRPo1oy1q+64EM8cuEBb5HTUtV+ZduDXwh76OBxeWoUgmL9KCq6K4iSwPL2wvQGqZluCQYbEOEK8PUaWo2gy/zArOYyW66CUf2ysu2s7rVkpuobudlnZv4ymM8X1wrQWNP97CfMgz;4:AauCYEI43T/erUrY3177gq9e8qBI+h+BBO21t9By24zx7Ep2D5E0pf4YYGxNki5uPbGIL7MjYzsXWJwqAgxbSmewksErZWzpHGJfNL5Hpi8Flozfwf+zTp1unQkwPrzpp0/4gjQdz+odI042Rt+Bs6hD9EPTgM9Q7qw74Lu7j3OhIWB4Eh/uv2mVvKaMsTgBY7Gr5IVY/0q/rZhqXkfQ/0rO6w1Ijb0nDwMbESdrJmTVpd2DGViUH2fwB6HPKlRabzTxKPWkhru9xa05sK5q4hBCllACKckvJOF0skkqm21wsf0VX9pyLkWO/ZEQwAm9
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323084DDDCE6BF87E19B13FF5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(105586002)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(478600001)(52116002)(7736002)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:I8QOZnpy9FowDGI96olZTus0b2PZVIEmTB+ZjrQ9E?=
 =?us-ascii?Q?uKOhDvN6u509ZHDh7FitmhyxIxbyzq3gKSfOsK/Q2skORjnPOypHShOOBHsX?=
 =?us-ascii?Q?YxvBtV9rqLxlSLtdcGaTh1ha/MsgbiP0UkS26YhqNE6bL2YnkFF7kG/X7OUO?=
 =?us-ascii?Q?nEVIgSDVBw6qhUZptVbDuHw3/yEdxv/Dpytgci1TqM9xIKjb2ZV23EZnznc5?=
 =?us-ascii?Q?fTfiGCZnhi28VEM/jXH80uPcHujBlf9Gsy7N3OnKR3sG6l7w5EeUPplj6pe9?=
 =?us-ascii?Q?lzC+Jd/BaeBM3mYTc7omVndvghlneRG89J9E0KHRuZHbQ8HQrPgc9bXbm95l?=
 =?us-ascii?Q?wNpnAhp0smHewYs7QRTERvZ8MgPjcpPTg1lGiWpeEpvcbIPQ7pQ8SI29QENy?=
 =?us-ascii?Q?p5OxeKkcC1KCvpdsrHZp6J9yDqcSu409LbM+EyCd86NQZMmq20X8E2KAFYMb?=
 =?us-ascii?Q?ZzQkVDo/G+xthKFsAp3bnNnDb7AOFkE0TdRzIHTFfDODx+MAKL53yQEB2yTS?=
 =?us-ascii?Q?s+0PAGfIdsfsyCXidixncjtVf1u147hHI+6EbYgMz+BNFz/I4hdD0ePebL8J?=
 =?us-ascii?Q?ls9W0sFcEIb+uBF+IJEjLg83FnbGfkg6EdtvaR/SiHyX9MvMOUbm/1n5hlpk?=
 =?us-ascii?Q?LwKzAfPHUazS76gJUQb61aAAMkFrlhcLsTPYUFaNSOEPT0e7Ob2YbUD3gEW1?=
 =?us-ascii?Q?+qRYP2uk04+D+v4IlImQWjDDj0MNBcRMsKjSOBIFN7PkrtyYuMZ/XVBizI5r?=
 =?us-ascii?Q?AVM9PNKmA4jZ+qImcR9kVCMymu7qEbEaTUJ0v3/YMn7scYtuycXGSwJEuVzp?=
 =?us-ascii?Q?ZvstJSf0vSzeg4QuB04z/0PE8DwaX1UgROD7q4MzvR0XxiZsuuw3d3CQ0Xdx?=
 =?us-ascii?Q?lNgp8xxgz4TXKl2MNu5hAjOaqE9vEzkToed4ika37Kmnc/oh43QpbS2yKumU?=
 =?us-ascii?Q?EQ7IBeRKKmj0IkFUS8OVMvWdW73kmWd1gvUwPoZb3aQMriG7sKfM6spUasU0?=
 =?us-ascii?Q?MeG5xc1b8YEc57KGMkLwsDtTPo5g4KZZ+O1GTk1l9Qx0j1FWMtv9y9gomIzx?=
 =?us-ascii?Q?nHWvBvZx0w93K6J7rHIDzdBcJPZPhbqnz/BHBxDijf7n+1rU3CJ3zJxU/Bfh?=
 =?us-ascii?Q?2e45Q+ue+zqKMGYEeISulpt2DXwuBCctXncbn+Qt7lI+gdhQWg9kgnIjYcyQ?=
 =?us-ascii?Q?2+g82sdyQj1LWzjOYpGIP/KmYRYpw/4yOrhpHGkd5qyDwM0QgIiYfSVPA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: NCtVMhXeqAbGxNS7v7r0/gV7CT8/TwNwrW45nl8qMyENTCEcWsQJzhg9eLmUqlhGjn951i2Ejmh70zui2Sl50CjkywpDhWqZwhbN4CpO0Ah3GI5EaqyIbtFFrCmOGivXP0IKlC6gJ0oN7F4Da0ZG4aG9ZS9B90KY+V+iQwxAKKTfjDnmCG1dc8zbDM9wI83c
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:p+ZbaamwOM5ooiA8XPZeVFsNJ1psvEcuDeBasH7eRDYapIKO5MerM0OHGYpdkZ2bhu31guKnagtJU2rTCtv4UT6KFIl1Cvj6xF0vHCDeCJ1/XMmKYLU67MpU+I5WxCFSXnzDZVh6c8Vv1sS8M0NQIwzwSfUYwOYB1wYug+7LCK9MuXyl24erN2USIOCz9m1k/nyNcvbSkSWtgvCc46u+wNo5qp4V2CCqKmjQujU7ZgnJXvNXqyv8c3gDlOslCjbF0QqYx44+9LmeMUT0EucFUhukjnNbW2jrJpRnTpYLUYA4OFqGg8ma+k5jdihYoubSvlApmKPk/mw08niXMrRkcZGTOo1S3nZr55+6ekdcl3mESSZ6fl6p04AqlAOfXxTAivMVVABEX6BtECYnaO2AS8aP04xiKQLUjWQcyUbQHBtia2O60FPTf2iIvZISnfcL/uKxam1bG6LByxe4KycsFg==;5:ooRHnVLR7EdUCFBDG4MmMWtsQkvuPO2RT/6Py+RZWlv7w46xv+jZVCuh68kdQt+0wyxExcEbSpfb1LFX9aC/7307EImpJGP3cNi2ekY38lWjp1zjyDQNvG8+3iPBkCPEggaWuiNuJMYAzjBqOEU60/N/KQDSbzIJ9ZzbYoNAAH0=;24:Ym0e1d2MMZ0UaRx09yIOdgxc3MHQJUzHqjAWy1Jo8uy9xHfz9wCrtBNHs6EtkXfCIzqfK3wniH3pUFBR3TXbxZiOTkk4zNgwkV202PcMAVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:iN8PQUG5HoAjUEp1U8QoJ/jseGbrxG34txIXhxknoIcpzfC3bBICUWjkdUb/8LF2HBZXoZLz9TKGV6RoGDJd4a6IDolfVx9jH5BNNwEu8tMrs4aLKK2IOeTAtqPcRkLE8U2G3I2qyoa3jpeu5I4OXH8Pgh4OGwuzh3wvft4F5r87jUUWOCaeBXOji6j0ybU/rwPVN/H51A0JW2l4I3ErF4ETzHU4UMuukMyA24GgMLaMJzg7QPJolT5C7SDUGBCt
X-MS-Office365-Filtering-Correlation-Id: 69320865-b575-4464-889f-08d5b31b0617
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:31:33.8610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69320865-b575-4464-889f-08d5b31b0617
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 116 +++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 87ffe2c..1d8cf0f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -66,6 +66,13 @@
 };
 
 &iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
+			MX6SX_PAD_GPIO1_IO02__I2C2_SCL          0x4001b8b1
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -139,3 +146,112 @@
 		>;
 	};
 };
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pfuze100: pmic@8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.7.4
