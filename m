Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeEEIdT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:19 -0400
Received: from mail-he1eur01on0060.outbound.protection.outlook.com ([104.47.0.60]:30544
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751158AbeEEIdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
Date: Sat,  5 May 2018 16:29:20 +0800
Message-Id: <1525508963-7986-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:hcezv7qHy5QInwRst0Wz+xrkjtuDc3YJCKuXWhnBPoVk6v975M0LZpFHQUXsPaP4BK35EZYvko+quaa80Rubcar4Z9Dxx8HW616eNPJvH1t9ll7+oXQ1ctSQHhRpUXU31jBvKefmkyafGzSb5USwrntOea7lvcwnFvtTfDnWE3XTDvzpzomGk5mI4oPyb5ybekAdGBXNbYips2qsoeI0YDo/2Y+ETjyJWSNbQCw6wj9bwUaglekNb4j6hNEVJ7jd;25:xkxeNHf3lz1AqAbqoZHPJiaDA+/Il8EOa9/sWxwILSWAi1CPOOGCASjvPDxXS85EvkPWxrxArxRFxdsNHKqmyq8RAC9JTSu+XVt0Xmeo9BtlV1YYWO6CwLs5HPiiB/LS7966awC2RaHOsUZ7sG1oIXtzbLo4a1znOq2r0D9NCdLfjbm5LuNPOTih2a5M0XlzpbL7aZY07uWhHqfEF7fRSkNhCEsPs0BzG2QopZMaY+FrTfgQOExBUBIt50zcohNGKCwuyHUGuVa6ztScN+3KhwPjv7dQ6k9hZiIsV7Pjks1NDmc5Dwzblcv/IblWx/SgP3WAx2UM9wFUICjsfUoj3Q==;31:XqTLkN2P+r1xqed9a7CTpZ8uVC9nZ/b/1UPuCHR9QEjL1BtSK2rskhXAbW1pzNPwgEg6Wy9TazJd6ZsYrFalso8PTjkiDWBA4kN+WkQ4JPThs2VcerKO6LSTzUwKPlwIMisHS+x3F8Mk/XA5DO4kl7UfGGELjhCtEY5ALje7IMMKC65XlUHl/HURz69qIOTFt5fWn5rfJvAJwWizveVu2GrMmDX3UzhBOiB0X1iUChg=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:IlDtU5IPEMpWsZEy8LoIRBWWRvECLHW5OpciRjw8R9gwBzghU8PPXquMFa8JKOUtpps3i9g9Cpq2ul81RuJ61W1k+mgXINHOFvEk55dmCo+Of1EAf0H8kOcH0sDnSetTewYNDl8Blj2XU9naxVFd8XoQ+6DHSQCOf6BdJ+WDYPAUuRHnMyq41Sj+lLPPbF2+oE7EUspwTwf9X0YoilLdl4Pf3Xwim7u1IMrR9rxWIRRqKKeD3WDQUHMXYjFwiVd6c683KzK+q8mGuoov6ZlUZTh0ztOYP6nxZ93ENi9FS42NeWuHXPrAw3SFTaqCHpmz89LzEbqTc6jG1XJ1uCUczSqK1xqS1eRWAfhVUrL+kSuzGWHw4IZnq1+dg9jKfK1LY+hMYN0CdDYCuEA7UgNhZhwdmZ0ZCbpinyDoQCJFsWyTruf5bNCd7gm78sD0Zf350LeGKOrvPXh4DJDerRQux6eaF55MKo1yn+njgghKgr3tDY8zECCeNbLbQDelOkH8;4:vM2HdEn4B9XirB420Vasomi1ljQElY2HXyyleDljyDpeYZb+tJfSp5mi5Px7zEz62/SE8leH/zvhGfIkf4PFVCkTlmd0t1pFfFlC0kDj+wGyhyp+nnE/0XOZ//0NyM8VCM/F2VQacE3cY6fyo0nOISHUrfoNk7Nn+uAZAOo8yWv+lQA2MfmdYE0TBWJPbgvmCEm7wzu4zJTRx56FBYb2AWrdbh24MKVRH0rZ6I/vELy/lVNVV00o/5DYrJVT65zFBsdku68XBrG8lZpk4VNN8E66tigePJJVPyNyun1D5w5lH5Tv51BmXET5qu0R6jtn
X-Microsoft-Antispam-PRVS: <AM3PR04MB13158CE5554652D9DD7C4479F5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:D/FscZo5NFrMi+qTcLw1rDVYTfZrGqcYRhsLP6tH8?=
 =?us-ascii?Q?5xqn6/J2rhSzwCqEaPTp01ds6Sq81QHc36/PZk8+g2fKEuFgFUp2V0bVWKjk?=
 =?us-ascii?Q?ROE24F+pYiUMEUFe/A6TnUEg8WI1hkTQg3oVNd1JbxhIjO3GrRD0feumON36?=
 =?us-ascii?Q?O72CT/vYFs3YIg6GSVBCJcnJbGFYYrfBZVAGP+e91oTc9QF57oR3WUeR7/+L?=
 =?us-ascii?Q?WuVxEnD6twgR8kHZEf3k+otQ7x5/no/YixOosteQ/CAweesnypomqH60VsSg?=
 =?us-ascii?Q?XJdP4Au+dBESRIzDUL4mmeInb+t7U0rCq9bUeHJ5+P3OKuGr8woBmp9QsRDj?=
 =?us-ascii?Q?oz31iTGuD8llWI7Z4AGbPsNlNH/oPMFvprAk3g0gX4dt5c7B8OWmADaQQKk5?=
 =?us-ascii?Q?LHte/tDUFZBhKd+zCd2059ZyIcquwPR8EwrnZYcand3gYWHKXJL32wcl0wId?=
 =?us-ascii?Q?cwxWuqcGS060e4nAoKOXKleaI2/+wmf+IbwsLQIGZCnHMbcQLeQjFtVF1xgp?=
 =?us-ascii?Q?jFjvWURVdqQ+1nTYa58UXXIIkpAJnX6iOOCCOqU0cQAAQc7YbZokFMSfCz1h?=
 =?us-ascii?Q?1ZAfYXuXxl+l4x7vyCi90ATmkVkIuRQYZ+vNEzY6sLMrqHKlWqVlWcFjUs1L?=
 =?us-ascii?Q?8G32qxf4DCbS7m3doUJmqQuaJIZcYtgIjtn+V/h8hb1v4jnVg8aJIwmur/0e?=
 =?us-ascii?Q?bTKIwl4FGJWarFSreS0RwJuZlP9zDc0Ga7l1z0+D58ATa3FnpgtwVS8h/N+S?=
 =?us-ascii?Q?NB5/s0GsGAtTyxwozeEI37wOGhsmu5PqPJ+uJxy+p1zbg/OMl+mXlSdESa7v?=
 =?us-ascii?Q?yypINygFUuj3UtdLsOXOB+qMBc7LQ+HfwQnYP/svP4Ie+tsMfJN9BIanVUhq?=
 =?us-ascii?Q?SIGSApovYFMqQMDg+WTn63twm8+6gZl9hCWgqiFnZM0cdmu+HTf/pDeBCipg?=
 =?us-ascii?Q?1ZduWkFKSPTsYwTUtNcf6PIKAmy4rfKuK9m2RcWUF+nWwrfssnSmO/0p/sCM?=
 =?us-ascii?Q?yjXOc31CAZQN/XejNjdTAdbRRnlbRaqBRh9g+ch3jD8wRq+pzVftS5/d6ybK?=
 =?us-ascii?Q?IdalcoAsrta+SuuWYaZaEx/IKvKTDGE6QwUIOayxHQUUHHs8qPzRebqhIBUF?=
 =?us-ascii?Q?YebHNCLJwCLV5SC1yb7Ou8CVFlBxVUJiZJ3wgPP+qP/AD3l+8ld4Ihkh6+i3?=
 =?us-ascii?Q?etaLI9uXnTz7ArXx0SueHpsuh4j9wpDDUZelRlS/l8hWBfTCoFyn0RRu4qvM?=
 =?us-ascii?Q?TMIvKyst2o4S6ARJZw=3D?=
X-Microsoft-Antispam-Message-Info: FJwbcrcwmJf8miAAv4G032HKToWc207mxHH1P1mb8L+lBh2mkwZAEuuTm2kX/ZaldPWckzm7bJ4kU8ze9abtA5v0NwedCC5iJjSs5lWL5U9ct+V1+49xb4F/2oYQIgIoXnzncY+RD0YOTJdipSOrBYBx5UlTvrklxzNXuIEhTbbtplxc+SFR9d8wopkam4cP
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:ncdxZesEH5mgYNNT2atgpUjGaNDAA3Xupxaz3r1PyKcbUhda+OlD+DPA8aqcRWsYsxVDhNKpDtd68ea4PAMyG35BhPQI/EAKsfN3vRSV34gf88L5YnZSFiruHeWWgZEDOND31HGtupMYMYuUijjg9Wo6WfQp3le/7ESINTAmKdfA7WLy1u57XSyefPsL49q3PiW4zfGjgCOUjQV0Szl7c1NEnLG9pPNTHwI1ssa1UJodvdW8SuEBt3ZdNaAReoma8Kt/2PhZQZMXgVBnwiG1GSwLyPFQYYAJBJ4ZyDSBOaz+drhyCmllOi9q8ouhP0SAMQfVSBxfjcak4C6N3LFYOi8LigMbIYmqIUBZ/Hq+L9a0dXsalZhLSuFhqX4B/r9k3YxzYKG8UaU7DTEMOSrC1z++nnUWOyjMBhWBUQpya6RrSA5vhcrxYyquPRxX15qTxsaUg9ViF/gFF1ZENR+lUA==;5:kd9kZEmKS9zSf2NjfNLiqg2HHFEx336XtXgkMzwe1jep6etDIjuETaBfDxikQFZ5q9rLr3WAJGsGLWJRjWykkS2jUY+41gAhFAo8T16h+Kc4+P8gWzoioElf7NuOaF7SqwV8Ztqt1jSXOgES/9sdZqimp1pSp4kdbtkMlHvyudw=;24:z6tcq7/veT0pXEHIqwgsTkiJmXw7iTGDhzFzA96zTOlznvlpRkVV3CSUPGYj8nF05Wv8QUs+4gmnIMgixtd4Y3K+XaCsimP+ZRhCVe7gv3M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:5qZayeEQdcvQyTq8pM1z7z3f9BiaaKUBK1z2TqA3I2npzh+L8qalSjLKwZCaAsRNZ6H9ZT9A5dRy01mxgeraYPMCMMbIqeOVErTw6g1Bv9xttXWRof9zGPKxL61KuilxFdfCTtwimitxIyi3Wz0lSHvPpMm+q8pJCclQKvlWmP2UsnS2DiIGO1RhGO78mtPEUhcO+huXLL31hM8FZH19pEqAo0kz8fJXK+QsWE4G69yiYz6tIuHMZY0ntaoEaX6C
X-MS-Office365-Filtering-Correlation-Id: d402ec56-6788-47a6-2cbc-08d5b262d6aa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:33:07.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d402ec56-6788-47a6-2cbc-08d5b262d6aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V5:
	use "gpios" instead of "enable-gpio".
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 4d41b4d..7dda741 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,17 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reg_fec: fec_io_supply {
+		compatible = "regulator-gpio";
+		regulator-name = "1.8V_1.5V_FEC";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1800000>;
+		states = <1500000 0x0 1800000 0x1>;
+		gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&sw2_reg>;
+		enable-active-high;
+	};
+
 	vcc_sd3: regulator-vcc-sd3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -34,6 +45,39 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
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
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -66,6 +110,42 @@
 };
 
 &iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
+			MX6SX_PAD_ENET1_MDC__ENET1_MDC          0xa0b1
+			MX6SX_PAD_RGMII1_TXC__ENET1_RGMII_TXC   0xa0b9
+			MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0   0xa0b1
+			MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1   0xa0b1
+			MX6SX_PAD_RGMII1_TD2__ENET1_TX_DATA_2   0xa0b1
+			MX6SX_PAD_RGMII1_TD3__ENET1_TX_DATA_3   0xa0b1
+			MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN    0xa0b1
+			MX6SX_PAD_RGMII1_RXC__ENET1_RX_CLK      0x3081
+			MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0   0x3081
+			MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
+			MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
+			MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
+			MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC   0xa0b9
+			MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0   0xa0b1
+			MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1   0xa0b1
+			MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2   0xa0b1
+			MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3   0xa0b1
+			MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN    0xa0b1
+			MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK      0x3081
+			MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0   0x3081
+			MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1   0x3081
+			MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2   0x3081
+			MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3   0x3081
+			MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN    0x3081
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.7.4
