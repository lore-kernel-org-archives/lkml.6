Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeDWDvi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:51:38 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:6050
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754038AbeDWDva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:51:30 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Date: Mon, 23 Apr 2018 11:46:58 +0800
Message-Id: <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:HFwDC+w51TR9a5ywKagPvdAWTkxOzXIb2H0+6IuGXzutFZQXjkUGUiiKFXLr/gvL5C7TdTvkGHlUKCfknxd/W68LYsseMAg3ajy0LM2O+xH4DajDOeELUUoxR33IehEUZJssKswu4XVfbk8fXKi6X2w9VAmwPwoEecKpCRBTJHoBtcBwIL+GyM/aqSJtaS+UQ6iXvSGYX8m7pwWEkxzRFzaEy12VXd1bzDPmxrxG4/Tc9syC4IHLMSnZudKvf8K3;25:/ehdKhMqkU4qHln5tb/Rxz+v0jwoKJPwADwUPvpTuKkb8tMG1pt6TUge2ddEH+xuvFBEL8EBzmo3Yd10wBkRscLAYFYlGc98KGtvraa/ixln570/faLeMnQzILqvpQqBYJsI7DSMRKHxw+QW+pXRy3B2mNG4T+uEpXlwlMR+Xc14Jhy30W2990s8XK1puT+ovtYPBR152wWy8QtBp/ZxprMbvFcDZKxSg8ZjEuGUuMTeY4aQGd7zagZrHILsGj99bUDyxfHulFA5ssi76X3sbI5mkA0CFR6y/1lOQ7LZnZOHqtJnn1ESLfmpnjQ0ivZ9Rk1do/X47ljinC+t05e42A==;31:WNMrDl+9ncZgiYLlZCIZVfd9bzNCsS3UuQbMh/RMUHxMXOt5BGMsSpreVNLkiYt4/8Yk7wdHh28i8GSbcw8LnZt9MlJ8s/fv8nRKd/Nosa8JR4GHSx136et8nrKvYiH+1bYrr6Vmvi4vT07bppHi6QRWtm9+s9G/MT3w39VyUA01nbBWrqFGTqmJSIcgsssYTXYN8kMOYKIZp85eFfY+eN4l/1QYRdeOfObVaeWkWGA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:DspQ1R/eb3gTRavqwY1KtnYMfQc+Tx1fbWFLqnjMLV+lasrFM3cLdwEHYQmA07BMI9YTi6l1BSnXxTtII2o0nCcQAfZh/xQgruqMDpxQzsQqE2p1hQ8ol9QWEoOXYxH4V1+Cgh2vGDZQ1I0v5n+7Kixmub786ImDda0XZCbfPztkyQkflKzHf5jHBsmtev6lhV7tYZEo8My65u/AL78qLANJWisPgyxSdQiLFpTxJycfg64P1GCboEZYPdz4s7a9U1oHLKea22I3ga8TWk2qx6JLUfBPeyVhCWhCGAw0rsTtX1Cy5JAOt3LOxBPmPKtK73YgJupnYWmJmuNzsPE9n8uu+xRvGHci1Uao/NferP39cVDmN4bQLai2CszCwNHj8i4ppOIXU+WIaJ5ZSYSRrDIP/Adpkb31o3XQMWinyjKAsQtjUTT412aMuTHneFD5w+Ul63U3XSXR6lF7286sseuuKF51kSJrLBxOZa7HsKpghxnzPnbRBAfWUYiGkuIW;4:GAsfaZGcjXhY37IOSivwQwwngG8qzxtA+IoDAGhrSVxmOjqyBescFRkD8CmP0hFF3toosg35rw60+qNTEmHb6JvNw6d5vX9j7X5QOSzeNqUTL7qcSikUl6LwrO2ak6Obc7p+FdVxhPfB0UU7Pj2GDuA59EWUX8Hi3puHT+lNQqtQQFvXGLbyMr6Il37oxmmWJduft89loNnPd7cUxJco3ELXcgTdHILNrkdyMJSSv3ngF6xp7r7ft2vtXUHzltoL/uxk0rcFDOzoHv/n263LP83GjejGWWfM/0yM4w6/98mrhvaQfE5j1Vc+BVQc3RYY
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324F858C37B62AA39BB5049F5890@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(8936002)(6666003)(26005)(186003)(16526019)(386003)(7736002)(6506007)(6486002)(2906002)(316002)(16586007)(478600001)(76176011)(52116002)(25786009)(4326008)(575784001)(86362001)(36756003)(50466002)(6512007)(53936002)(446003)(11346002)(956004)(2616005)(3846002)(6116002)(47776003)(476003)(50226002)(305945005)(5660300001)(81166006)(8676002)(66066001)(48376002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:t3xPcAsgDRkeG9fhNMMGhIShBskRaQfMvWqHz289p?=
 =?us-ascii?Q?Wkv4W/KcZRxqpnh/EEcwpTnLlfdKALOt6EPyk9jgTzfKT0ZZxQrVcx/DXITV?=
 =?us-ascii?Q?QAHO/YNNhEVvYkcxIW824xcaGTyQeuEvOD+zsDQt2m9ZI603dXzriZtQYqNQ?=
 =?us-ascii?Q?q0FEA4FzTaSYcnXHuY9W/22xzcqszCpoYSfltSK6UtP2zWgBReQkeeyfXvbn?=
 =?us-ascii?Q?FtkBHhHUO3yGKP4858ngqHL1kja1eeCedBIb05iTXuEmQttTJQ/gPZJf8Nhu?=
 =?us-ascii?Q?382sqB2vlJTOgdNzirV2x/BaYB0GDVPCvWov1yYEef8ETANDw5zxj53AEGwF?=
 =?us-ascii?Q?w6sq2kvclxlE2OWQFoUogpPLsw95JQITKD8szjg4A9s0Mc+5vvj2jBX4BZqQ?=
 =?us-ascii?Q?SlGfEqF+T3OZIHakpGvPaamEb+AaKKeID5mfQBwjr+DaydAJyOrnYyWhC/r5?=
 =?us-ascii?Q?vkit6U9/eTbqKXBImLWq46lCDMQnrTclBnBvBRtNbyyOIZZMYIHKVLFO9m3V?=
 =?us-ascii?Q?DzOKVANbvktxXkxomN85VApvJy3TNI5onyEzBFkNAZAwecanlISiteYe1JWF?=
 =?us-ascii?Q?y9tHR/uaj+8HvNr4rFDnSzBn0uaAbwIiYbFWW2rQsRscFvv7P/07RgOmm74/?=
 =?us-ascii?Q?RAFk+u0qtwYECQoOWwEtv5P8H//ZMa/u0ZRSEgzzAC+ubNKaWW+Q0UWMkCKs?=
 =?us-ascii?Q?bEz3dTlPvx4q5XVtzXXKIcin5O+cSXvom9hk0637iyzKOfHJstlHxG42767S?=
 =?us-ascii?Q?tGTfvP7986RMbG5oLVhDZ+IEeO7l613BvkmtQO2wunO729mkRiUDSqSLkSuj?=
 =?us-ascii?Q?ag7QEV0CrhIuG6CQG+nYk8FoWWtBfFCt64NfFmGyj+uWvIoYeXqZhOpXAM+7?=
 =?us-ascii?Q?iXDZfc9jOLel8sidH1kMR+NhxjYsZdG/QxorjABO3gMRJZE5rLQQ7N1p56KW?=
 =?us-ascii?Q?3DMaoI2J0Zu6v+Zs0UEYd5ya5SHbIZhJm4FTjbPd6Xg35SbTW7ygKVNpB3Wn?=
 =?us-ascii?Q?ogjcDgtwjd9HfYP4g0BKpYC82sBBg0YGhC7InYttjytKw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0/xE6zRamUMXbPdboNZCpYhw/hJNsC3DKCMmhqSfo0sPoQG5z5fUFC30VXw3Y7NPMs0cUZoBYueV7dEwAlx56X7+NwClnveDOP7LhdAIVG0O/v47ujegJMaVxymvlHVRccdG7CGN/ek+czDgyGqmuudhjUzoxmcaHaSb3cxyRS++JEUrOXzF7HxWy8YgQquZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:3Xx8LOANaeqWKPvHrL0hGoTmDa+Ifx48ovofo+B9ytRR4/UDY0Q8Rr7EjKpXpY0/vmZqgHdVUavw0fq2g+Lvqn2faF+/QgFtwT4r/DayPcQkItSzXhv6PqffOhjA/SXzmn72bEejlgXIsvBvOFx4tmGkmibiwjFRhx7q6rexR1hEK5WBLjCtXIpMfPexgImPISbTyAzPpCmp1L697vLn8M21sWWYt8TXUfglDlNK8c0qbfds+0eW1kZ3F6sujRh8uMxMO37nG7unVaHfl4NNY8ycb1QxpuAVgygWdM4K7F5CwhITlVF7D078RvGLbdJqyGPnS//PfTIwMe5gx+lzhWTgpO0BGfrzThd2bdHWY1Y8jBzxThLnJHo2DoxFwyi79h4Shx9aohxLO5ml8+wVqSHAzG28PiH6hUZifbEvRq79rfFoLqecIsaZaHoCygXFTZ4er03pgMVn1G8BhvGNJQ==;5:HzgCrERn/FanfH7mJIhUZ7CSj+5OEG6Aq0iKPLAQYwozOEGKhzu4ZqFq0BL9v9wm0/kPettXmJh4ovA2TaymbXKYpRBokN+8RiOcfP4UqaFQsOVkdanucTqDlEuEDORBB655XLjIR2gbNDoyblvnPcuU8OOFx4W6SPxShyNW018=;24:mOJa2FEFj6RU9SjvEXUYlbYhSMNB23ggtWLia/YJ1B+0P3fveTJsuspnyJfmGMCj+mdGhls4y/7tWdLBguOOXkTlGBWygMpOfjj/i+HnZD4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:3lP0iet+QR/9meIBwCh1VBf/PRX/aHXc3LQj9jHfBvedFq9t/7gL0+djp4eGhVG9o+JtPTDWueBKnIzIRkZaIExHJRAIOamdWNm4+Fuvno5MYxaBXJkcz0tlY1EKQJNEpeZqmssvF96VFw5z7ZDX/Pzz0xf0rN9qIgsWwBgX0oiQWVg1y/4MZ4LxEy8RTikRhbLqNOj9UULugAy3yNwUcPBzHixBKTe3yORJcmiCcDtOExhIBkhaEKG0kYI5twPJ
X-MS-Office365-Filtering-Correlation-Id: 9defdf2c-e5ff-4b23-cd2e-08d5a8cd7cba
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 03:51:22.4202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9defdf2c-e5ff-4b23-cd2e-08d5a8cd7cba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..eadd483 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -41,6 +41,40 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
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
@@ -75,6 +109,42 @@
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
