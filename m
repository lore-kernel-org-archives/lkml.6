Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeDXCJh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:09:37 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:12000
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932786AbeDXCJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:28 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Date: Tue, 24 Apr 2018 10:05:00 +0800
Message-Id: <1524535501-8567-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
References: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:iscLxewjAe/zUc+wuyNfGO5PliXjP5SmVQWACVitSsjRTPspdTAF3j8E8jtttVSqlUC3es1HCeJV9N2FiE+PpxEquGIFPXpcrYOSAINnwlu6JHakeiI7Dl2eGRDnbHeYWZ5VuvrgegB5YtqLu89VPPp7WF3runSHmsr1HzPoEnOU3taNWmkoqN3szMfTIL0tgznSh0pLSTgoy9fxIGXTjpbaqcvsh6jeNhc3pxxPxwoh6hS4mhd8KXS4xv4o363i;25:LeawyoRbNJQhSGp/2Q2huRg+nyHL0T3fO7iu++oBo0VO9MZDGj5LAbpotNgJyYzL4KRtv4q44wajl0YU1MWMabw2ElXML1L3ToFmPN3wdtLIMc0p19tTFYw5INfqsN3i20jp86+OEjXnh3vkNt5hFExPH4RrTnxpdaSxtm+8O3K0VLjuZ8q8l66r+hKtAorDrhJF5MmXvOlo9h9ua9y8GhUMZLXgnrawTYQFjoNMuM2/TGW13APYzrUnyVpftLFbQsch306wnHfRLKm8zdkwv238Kn/JsvsKnuPSC6HWfk7NnTqFTqoyQekmFS2WnuI4xwfttMqkXTvbpfmToeZbLQ==;31:tV3wsonER+3wtV+kXk6xDSZiS6ZK4jADuoLXe0m/2fKPDl7Jm1LTuLXF+kZvVb8+R8fHcqniZwGQkIafFrRdiL2F076Kqeu96TLG/1RlwBiPgMW2NYcFQS0UC6YK16v96xVi81hdS/8XYRKuvgAQx4KgWxLqwFo0YBWo6bO/jfqTICFOfxR/IsHwKVfSPgO98B3rSaUqmML1tZtLodwugLmXyzhyNtDWjKOELfaROlo=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:JjKXa4ii09kzlB6/yScmDyhqgGyZZ30fKP7pDdH679hzFzvUTeJDK3COlbvoC2trT7v7U2144YPHL0HRt9nrkwRxTYffuG2f8trWPlcSwnHcVg/2Gs8A+oclVsk/T35RHYALgFqoQhvo/w+ZwLi+/Id14K1CXMdHvQITqjhuvf9iX3R3e/7/9MG3Zz1VuBvcNMGqVRd1GHi1HF//GcmX1SFNriv26Zwqf6kfc+2L3QRrj1JeK3rqr5nBdWVnsYiQGer2NAxtQMFkjt3ei3QJRrnjAN6jGWxgrxX/TYGjCxp7U8i8Wulb6KV9bbWfMZwBN15MwMa35Iind3P6CmPezqpGW/gKwaktsd/htdgEQy/pF99pHPlyRMyw0x1ZNIX8Urmoc9IMwlYyjJ+P8AzPcu7E+zhUW/5tMM105WsivNz+FXRjP3pr/jFoR2i9+4qR43DF5SmrQFoxxhMeutsX+ZprjZk8bqkWjvdWZuwMfLrm3DUeoBDy+sOaTvK3w1DY;4:veVpd08BqlBsr40HoOEMg51Jcsqgovk/FceyiME60vaTJ3VHW7bkHvg35CsE7574WuneLOV+UrXkSsiIBq2i/kYQeG+UppI+FQXJ+9LedFQBbg5wQXqmk+rYbdxIw38ihKneOkl/R6QUl5OKywS0zxBgxaNRhPVqKjGZ9LT2AgydiPEcYhs0P4JHtSDKdt1QOdS2uIGZ/JBWY1JFck+ZNljw/Jq9h9S7WaPO+rXwpfKUSFCeCealUnw56sW2I0RB6qRqIFcU6Ye4ppDSId+72FLK6VIknx7jhLm/rN2DgnC+sua6C9AmUrn4oWJZu7PB
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315724A1098497E4382DE80F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39380400002)(39860400002)(376002)(6486002)(956004)(305945005)(7736002)(4326008)(50226002)(86362001)(6666003)(8936002)(25786009)(575784001)(47776003)(66066001)(8676002)(81166006)(50466002)(478600001)(5660300001)(2906002)(36756003)(3846002)(316002)(53936002)(6512007)(16586007)(48376002)(6116002)(386003)(6506007)(52116002)(26005)(76176011)(446003)(11346002)(2616005)(476003)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:4LTRevALJMORoWnC8zyT6iMt2zaYGRbONMlbQwcqm?=
 =?us-ascii?Q?d5FFkoatE7HtFZbM0SOMRMRQkMH5b19II9zB+ttYaZNfnXLNbDaIgtVBnVDH?=
 =?us-ascii?Q?7lnZt3u3jULX735ahCLBYYf3EHhECUK7K4Kxpa13df5hmgoYGixCF7uRgYpH?=
 =?us-ascii?Q?DQ+4OQ26yHMwmSxsp0XQca0WrmLQJ9i29koYrUEhjO3/4GqrX3O4bV+DeCzL?=
 =?us-ascii?Q?R+W5OpsSDmuNkczNAAhcWSIv57DpDFSuPn/fmW5hLGGfR8XLjHEqTY2t1CRe?=
 =?us-ascii?Q?m5e44Vm15U5A5/Z6V3DOT5UnZmlU22QlGLttRcmiDzcAxXHnYuBjhCiWVnYJ?=
 =?us-ascii?Q?lx5rwEuRF6ngWWdhC9pKNuvWU9Tk59Ob4KPStDcC8mYHLyCR8JDOI5CUwomQ?=
 =?us-ascii?Q?vntfuuAmtNPNCLDkUSG1+zwagVH5oh/BjjK1LCZS9mDQpdjTujfEyvWnSSNL?=
 =?us-ascii?Q?uclqfofy1RSg4xX9cKnVlZ/rOheP5VomemCyED6OY3oEB4oQO1WOU4vHn9iv?=
 =?us-ascii?Q?8NpPRDcAHabVXGXyAQUoO8ewXEuYakRh9CJwHKkrsMJELOFuPHeL7e9C67/a?=
 =?us-ascii?Q?1G4jSc1Tf2q78B5m7DyfdGckQvOCv3QhKhfEBW8KO1riqvpah3M2n8+dUJa4?=
 =?us-ascii?Q?tU+o1yOjM+wXEQg9JO1rOSIGDaGr/47dAeB9sjXQRKcK+6MBHUvm4CATSQho?=
 =?us-ascii?Q?iH3DQu0Z7ybSzu5E3yGre8WKwLkpJiLiu0I2F9+aE+vW7V99ODaDl78uCis5?=
 =?us-ascii?Q?+jm3U5GzBl1MSg65ClsZ5dFOrua2NzYTYCzj0Gw6ksJ9zHHBe3SxjbqEm3D8?=
 =?us-ascii?Q?OK/z5YM5pMGtdyVK7AO5EKsuPYZmuPVLKC1q9MwseA7JhV08lr3OeHksCvGZ?=
 =?us-ascii?Q?Y/7XFewJHDMy5U6xzvJJefMihUOrIpq240cv1WDA4kICPuhu5uG1Jn7wEsS4?=
 =?us-ascii?Q?NEwHZ+VGrOKB4nwNm8SlOnMrQVIcm9HZQkHRUc/AKUZmhZzAtUye+7KfihbA?=
 =?us-ascii?Q?PvppFb1yW97FoiTGmsz5HMvO0tX93h80Wv2fvwr0ub67g=3D=3D?=
X-Microsoft-Antispam-Message-Info: ktFV5bz/0RCIDelkXpfG6zXxe+qdMGtjjc3HCEmB1W8CoX8QUNquCwvAB271yEZwf44fORVFIsP8cSEyqSOotOzGSY8N+7fQctK2VDOA+Ocic8rCsncmfITY+brKLei03g/4aSl9y/9O1VLJQ0ZCJfYc3Ki0CgYQFGTY4Itz/EPqZl0evuUQ2nHLvctJ6oTJ
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:nioqy5OFaRhfvczyh0xMOt8O4i7lbUhf+OzkZpvcmzEQPqdsTEFkZ6HElTbWJeDnW4nj8V1XG/LKtm/zJniMC5bbVvJ0Wj+SHSLsPtBCS50ZXZoaUGQFDEZXjVhpFalqa6X1RWJTxYj4m7ofzY5d0cu+FOBdqyMFh8X1321UYEhZPRfrYuTJsi4CPMOsO37HLAOQAbHRx9MZie5+XZD1Pyx03VCvG/bfYroYPq5PRFa1/FUeCXA7Viju7zjN93iQVBCnLDq54ua4Ooty6JpyOaR25u0MWalGc1OZ3cRkf3nyElW0SOfh8r3GBm1N4wLpB9P6PuFFLJAcol/YXZxi9fA54qqZ6BqZuQkcAtgbnWUU6CI1FhjPSLpIJ1G8UTsShXT0Qrm/wn2UogF+ULSDjB2pD5LCfWy0krdJeOPauTsmMGTwf2Q+9hFraWPwSCLj/O8DVrSsigE983pfKOjxzg==;5:8yi1yBuHKIx6PGx3L2Omlo3s7o/gbj1y+/GcxxhYtfvdnaALAJe+8c652jFQqsJ8X0RUYGLG8shAtiDpNYVJnF9CbcRjADvXaZkUnZ8hsWT1MxpJE73SBKFZPIMHL9rvl4VlIWWB2QzUlYq6zJk6O9acfE1Vzti0ggQECYLBZac=;24:A5XRN1cxt+RfM4SXafN4V5PqmW2pCX1VB/d75vjtpy8ZDOtlZz29SaHuhy7RcefM3fHluso3HA+VkS1qksq+BLU4i0ASa6zdAV+/sdG7bdU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:rGNM3FPsHvIgZi9/Q44sX87nEqk5+OA4uSSBX7ya69ehysZslA4lqlO+yKnL9OCKp6LD5f7jyWXwgaZRqn+KjggRRlob39iREDHM6iRWNKNnAMZZlqijUOq0FLoI8HSPYOd0FfOp8UuNht4SXePFmR6FoZgEhAqjXdBCxhz5GcNwR99YoyfAqiKT4KlwL6o3GbScIxETvfy4PfQRZZy+Z/wKcrKLhR4mXHYLgfDyGZURBZXqqZzs9zza94VWx58w
X-MS-Office365-Filtering-Correlation-Id: 3064f9b1-935a-4214-be29-08d5a9886741
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 02:09:21.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3064f9b1-935a-4214-be29-08d5a9886741
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove unused property "pinctrl-assert-gpios" on fec1.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..fdc642f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -41,6 +41,39 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -75,6 +108,42 @@
 &iomuxc {
 	imx6x-sabreauto {
 
+		pinctrl_enet1_1: enet1grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
+				MX6SX_PAD_ENET1_MDC__ENET1_MDC          0xa0b1
+				MX6SX_PAD_RGMII1_TXC__ENET1_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII1_TD2__ENET1_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII1_TD3__ENET1_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII1_RXC__ENET1_RX_CLK      0x3081
+				MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
+			>;
+		};
+
+		pinctrl_enet2_1: enet2grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK      0x3081
+				MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN    0x3081
+			>;
+		};
+
 		pinctrl_i2c2_1: i2c2grp-1 {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.7.4
