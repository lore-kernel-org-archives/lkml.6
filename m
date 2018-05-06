Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeEFGcD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:32:03 -0400
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:55520
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbeEFGb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:31:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 3/7] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Sun,  6 May 2018 14:28:09 +0800
Message-Id: <1525588093-29994-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KAXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::29) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:OoWmyx11yKxiwrHQmnJ8AV6XlyyUjnCmRmZYYFWm+irbGbwFzd3MMYcA8cm8Y/RZSo4/gskopqd5hq8YUy9MNGEv1EcmFcjuJYkcUm7D9Hx5ueo41MOnoEN7pdbiihGUZ5VHb99WQV64m4aj2Yd3LmSOyzqW2jks7O1jyGzN0BltDskBZvfe0RoOMPf0Qmcn27pJKlrpTv95BJyEVbilk2CSTdXgIM0ePfm+BwUXQCnPCwNHknT2q0NX3+kgR9nN;25:o8f4X0pbF25EKhSgJ8bRZhkZFwcPwHsxgpznRXJwciuIVaryWCOsPwYKby7xZ08yXLIJe3VQZ3LHhYevBTk3tvKwyW1qk1j2Q6ateKmmDoJMwiPNL4vMxDt9Zzp/ZtIpcbMTEYby2VOUUlWO5HD7Df2cz1Fgcx3N/d8bVdmZ0McFaz4pZMNEEODLFsi9XDXrrE1sAZBVlHTUY1cK4zdWzwSKGjECQ9nydPHtDpyWJLbYD0/ixPv0FtFKKUMrABCt//WuhTZaRq3wMyuOT1bV8LwdngLkZ7gt248xR9nt2xE/eflWJdYV0S0WiM7UbIgA7Z/g2lHwjPomRA5XK2GJEQ==;31:104ZfG7VGyPQvSyQmPw3dGga/DNnH9p3mG1IYhQ6vtE/oGqj8v+XRQit1817Q4ZqHQVWkP6j5Gv5MWYpDqkZ5fx4PVMxGo1+wGDNIit5vs3AOr5g43lS0/IVzIrogsZyVLR/kt844uBHsABYoB96H+Ijg/e0T48GdsxchIWuvW/EUwcR1FlEItiVArC1b65BkaTE81CHVA776ZeRntnDRPpmhwbhdcODqyM95s3CrpY=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:hK5QU6PtlSwIx78ED+e+gmEa2tiYBFmMJE4BOqcL8kmOplJiajOqxGTDjOcqGGxgoUCQjncqPqeUoYgyOnQ412TJGIw7iZiANV417Jy+icOhqJri+Br+ofDqiNTHOPF57AjCQkicpp8/4MIJ524IQSXf1/OULy+D+rDvXWsExACS2qyVc7LjkuSp0gCEKD8eyibc0RimoRoU4YZEKQH62qu0RUzxUjzdKimFwjuoaOdacZWUv2+X0gFEsXvtG1EoS6LluCXd+IKBUrfeQD9oFy08suIp42/HifDtWr1U7uFCUfhx97zvvjKWAivvn0M8jHdLnltBF0d5S3EXKYRysaV06OVE0iUQGiAe2wTdSShiRtuGUz1lPWhidyBNnoE6Cal/Y7xmVKtRRFYqIXlgLn+31FMJPn1qqi5Xd9QyUulOyzo0yC/NjDga5/4AjIOo0XxZqzU1CEBNKatm8D2DfP0yND8EXNd0BqGCpxXAxjkZZwoH3bLMqSCP861fsiP8;4:hQztoNmnX1c/zHH9kLOeZlhfSHcHnwspbGHM0idChwesrZBEA/2JlmPQkL3mxaXC0wlSEcyQebuHTZ/HOSnBnKLPDUPzpAAp77IFpNzdJ9Ytb2vnp08FedRJT8BlnIrPHv3H6JQlaYSI7S6odUwYQsYon5d8AL1Bn55kQBuo9cq8SWNb5CfeB8vCoq0am8N/rkYLyy1/xWbNOgCaXdijArZZFC2Vb8B8NCvdsIF+Ki0yPjV1uL7FQEUTWROOiBFBFjMGCaGqZ9kZwA5itIKE/0VLMJw7hFtvejixZsqgDQHQGynalHAXvWleSuvwkygw
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323C23DF0C7404F77514A5BF5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:08tWc9xhWqKMtSibcrtyDlUXLt9ddCCHNDoNNTHnO?=
 =?us-ascii?Q?Iyo+M6O8nYe0nzUNGpjUlT7FB+Jdi6Oc0GIRcleV6JtRbR9krK/xoV7+6o2K?=
 =?us-ascii?Q?tzsseZv+2L9b/JjW9yYWWn9RSI4OO6PV4VQgaDzOqazGd1S7NSZ0+yeJZtOO?=
 =?us-ascii?Q?AmpjUgzoDS7XUl+n9wTsx//y1WSYH2urtaybgDKpXEh9M7DS85GhEDvJBucv?=
 =?us-ascii?Q?KN/Lv+YnSqpmrSnrl3bEK7cHeuJHNPkLOqGpMiB2bPWGMA6OPDLDIDkWxDfY?=
 =?us-ascii?Q?V7UlwGaoJMIozIodHudeSgJHHOUUM7UDmol6oGNhgp+2FIfEWnVOEJOu9ZUN?=
 =?us-ascii?Q?Om9MZz0jMwZC6k3vVU+67XWeYc9r3egbJ28G/EuiVTa49YsIQMLSOSuY1hGS?=
 =?us-ascii?Q?TjVFRoPsoG50NBO8JoCSwcpY4QfxnRJI5OFFadk2LloKjAp2yGfnZkgaJeQ0?=
 =?us-ascii?Q?rGIaeGIKzOlr2I/Mkx/WHOM2Vo08X3UGGYp7Sys+0jgwwhPkLoiaoOElpkHr?=
 =?us-ascii?Q?vcsm93P9uJjL/8gDyDlDQLTpJ5IKhhptlRP8j6/YRGrucwAcVkh6ZeIqEfYg?=
 =?us-ascii?Q?edSwLkwQx2/dI/Yq8s3qH0ZHm09LHaOjZ0YdYovsbYUt9v6vkibNpfr3XR9v?=
 =?us-ascii?Q?Ht9O+GD4Fb+5irGq23v09LxL6EaPNgiKDgaR2JiBUb/142RNbqd25NBu0hqq?=
 =?us-ascii?Q?ck/KIh3VNknlM92UesnllQMRG2dEj8haWPRWx9BGiMPtpdM62jJ08HQOZuC1?=
 =?us-ascii?Q?XhpBZwoMLL7WIziUCvja6BDv+IHzJ6T7Deoxr9cfmIQJhsZcIiGdz9AcAWgT?=
 =?us-ascii?Q?VBJzZ7fOfU/XTqW+JWdeebZ2YM+DZbpOqdG0wVU18eNb+AGk/kwNXFOZ99DI?=
 =?us-ascii?Q?eI+gVFHYVh1NXy6gXTxac8QtzF78JzbBhMPMGIbTVtrQ9RLYRF2JsKZgNuow?=
 =?us-ascii?Q?ZSoMt3iQpTMQ6Xodi7SGs65FqqrRmV0Y4rBn4ZWyCsR8WIxApLHkieJONn/p?=
 =?us-ascii?Q?pmE69ANVPfF4K2Yta94hbWIK/Tv9bchZw+DT6tmyvnlqcEu7Whda5QePcfnr?=
 =?us-ascii?Q?Ap76qZC9lJRAUBzYHcWoYCvUVqYPReyCdqAV4ag9UxyBw3Q82Q7nYx8WS3gD?=
 =?us-ascii?Q?qNCDrw5MzcGF/3Yqok1kROoERP2XEno1KA+hLJRwQgePav0Y83a025aGmxts?=
 =?us-ascii?Q?cE/Pl7MEVOQgm1e7UmWUklShEeEyH9kTflKcZAaxC6Nn7ex3oM0yZgCCbUsY?=
 =?us-ascii?Q?o5CzirNkYLIrD1oQNs=3D?=
X-Microsoft-Antispam-Message-Info: 3PqkziR3TNUB015JSSH/CntZlJb4NB1jX02ah8FapZFYv4sYr1GxQpK9G0uyXKgnE7Dg08j7Ur8PIGD8Ml7hqWekqUXFOpAxcgGqU5EO2PEmL9dhmKAVHesPlqXL9YdMegtDw/YChUCk8P/7HnjRTmq/l2wtbV+D1NxQrslp5oGv/2iBVcyUAN56J+8+xGq0
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:CszfPQcvA1mrdX2foKrL2JFtsiYzkQhDSAmCBY1FxxdDPrMW6kZr5wiD2whyneTlvrNS1Fv/PN7LuIUylidp0n6ZQMQE8Lcw6RraZ+ltGRxwFQOVQhL6MNXI1RM2BFBtjsEieQk8uyO+Bl9zAiMYhXEYle4/nKsaIFEjw229x64/lTcIt1J4OTThlih2Q87KYT4eGuOIt4K6wP+ZlackWdsDT9fw5DVgKgnY1ZXCWt3/zCsqMmG0h1D7/YQHoshPXm/JDnMtsxXgkB2UJlorDC2i6l4yVojt6R2wEC7rVZ2SCttXADZLV1izkv1cnwvPLmIqYZOg6E37DzYhr3RDNG/yYGQvbE5rWB8Rm16g8Vq8fMDC/N/mRrl0i3OkMUeGQez7yiDWhf5RBUfpYmlQkN3BbnqhRKKBlWrNDUQvM9D8B4p1mFKNl1N7R4yicYngyNf6LLoBkDUbo3vsmxfYGQ==;5:atB6O7Eesq2huNu0lZCZBaWg1HBjGvypBFlNcsQSlhFobeV9e8FzO4LcVxdD54HmZA6vLSyFL9nJBaaRu1nlpFK01ptPYreNX4JL34mAEpVhN+vKbpYaGYQtDivn9mUwEYv5lPX1l9nXenuNNI8BFusoKEy6dS8o+PbzK9CSOtk=;24:rsG3yh6ngmqjZhZ38l5YR0iDktwtIZer4iHp+PuBXzFrygNE+POG5QjkTvwWEKjFogdEpJmcFlE1L4UwpM1SrFY4eVbZZfcDFUWtRX+G5i4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:OWhFJ+EAkuSnxQ6oBj7DsR8iwQqP27A179Mf39O/SCFNVlc0BIH3LCDd2rb2/eSKznwjesiZc9pG8h4uZGyS8T8IlqqBEfnS7opmhO0HDOzj4ehXtkqc4GjHCf0UMEej833otvgYxW3yzfEE//kcTdGXdtThb2N7Nb3oYNLZHjchKDun0P/F1BBDnNhH/xSWMOuXNhsxCojfNhmlBccnDxR6cIBSL3ngbGA8B/a91qusEsEdPs5BCTvzI1zJy7ib
X-MS-Office365-Filtering-Correlation-Id: f9ac31d4-4ba4-4258-e3cd-08d5b31b0d39
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:31:45.8302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ac31d4-4ba4-4258-e3cd-08d5b31b0d39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander on I2C3 bus, add
support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index ae253af..4d41b4d 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -73,6 +73,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+			MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -262,3 +269,24 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	max7310_a: gpio@30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio@32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.7.4
