Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932859AbeDXCK1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:10:27 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:8537
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932791AbeDXCJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:24 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Tue, 24 Apr 2018 10:04:59 +0800
Message-Id: <1524535501-8567-3-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:FU/Rg6w2eN7FEpPMi2S6nGhDTa27sIurr0Be4s5i96Zdpwod+KnqZfVCJLFCrgQZwmZyozkomVcqj0LWWyMvaJWqVlP08WHTXrNk3M00tq2oP72CrGHG5uLLey3T5HkWzX5QeVDVwWthda3yGzlwv8FS6xj6jcgsszg/xwFA85keLvTjSAFt1M2/Z+Ib0pG4bHZ52oE3Jdq5LRxyYzjTvHnR1WGGTJO1nJ9s4y0F/Xj5Xqr7MiNr9WKbWKRUD6AY;25:SUWs5panCO4P3xPqYcJ07g+9IJ4EoAzO4+IWSTl+HqVLexocuKrKLrE0JXtJaOKSbo4vhtHg0g/TBTPQpN4TrJzMzISqCfArjYvyjokrVwn7rmwp+EOD01Ll3gMr2trFL9zcM0Z9znfv0v6FBBg2bgm7n3vOtTQqOolsVxmjZQ7HkEAfe0Z0uV5vUoTE60QH/WNP3B8Yxp99/P8gD1yAtEYtqpR1VD2Gtxwsu0jvI6qPnRAxvBD/21MmfXs1cFX9Ldd53ErU+tcjugYC4Wm/abcVmMkCkAzmLka9ytV7f2ZVwCooxy20TiANav3UJUsci2vSsxEFTUGrQWVj7TJkOw==;31:4/5iXYkQUu1zXmahAlGNpESwuhFNP1RHgdx1rxid9Gj8V1jayx2OVP/Swgctm7PeqbocBe+DxGjI9g4TYkF7Q8ub9voIG+0ng+NkISI582Qm5F0EQ9NJrh7SbLcTXYbFGnHDYOty4sH2JnVmLNp3e0pF8LufHlrgrJrT1hG8GlGtidt4mGpTfGTxMYy3B8bnjTQU6ReOWpj7szlXKnLsBMQmyfdbfxL5laPRzttcZg0=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:G5riPHluqIHi5/plFpkJX1xlq63KN6PjsZMS21IbwDgkvk27Gk2hAx//AfdkR38HDNHaNzhC09aI8m3+uHwAOCkbaNVQmp8wu7CmOkqwtaBwAsfC/qUdivfGRPcPSMcnUIbXGE0+lvxtV//RNi0hGSuxLr6GZzaFoI6f34zsrnNXWxEEwRRpUn1jRYDiHQxqPpb8GKu0emXiCeVc6dPd+mvgLP3l2X6Zr6se5Z0fYJZmsrIA6mSFKr+2F8qBfYTBoCcxInacBbTqpaNWnfrOK3nzGKwKTd4rUeof8nIoZ25wTji90/m5EPOY9/xCcvcjQn7pNYovic9pfiYIytALRV6GAHg9cFd4oiOFSh6lxKG1hNjuJPFfmy7r0CN5wERf7bnqRNtadaAAQaqvNOJgdN6vdTQAEQfe+puD/eqpS/gRnoFgE2YEcOB+YJbM9CbDXZwDMqtC0VluToSU8+DTBEz1fQtYzsGzO+I+OpvHPZ5bGpO8tB1uPhHamqEspx8H;4:dX1T1qcDwu4hdoViWBhGWOd+NRQQcBqiE+Syg3wVJjz5RjDeuegFW3X2D21pcFMCYhQL4HymrzBruJ1PoyvP56TTCwS8izTIef6HrM5GqZ9VEP+7hsCZZTSRLnIBeeByrfvIeEsCID868Yw6JYKz1KWLGoonpEAqTDPQN4nmwFtbpgG6y90cQxSkQRGKaAFRDlkxnHN7S9nncl4ISGR5JfWi/XSpS00LWZSrv+/XEyohkYlinBa4SAXyFiFYn3VFAQbD1tNLIbW/4g0z+xChTStTrQ64EM1e27kZu2n8ZAtHE5lEKAC1qpB1McnZL9kO
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315EB405ACE4C481DE3BCB2F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39380400002)(39860400002)(376002)(6486002)(956004)(305945005)(7736002)(4326008)(50226002)(86362001)(6666003)(8936002)(25786009)(575784001)(47776003)(66066001)(8676002)(81166006)(50466002)(478600001)(5660300001)(2906002)(36756003)(3846002)(316002)(53936002)(6512007)(16586007)(48376002)(6116002)(386003)(6506007)(52116002)(26005)(76176011)(446003)(11346002)(2616005)(476003)(186003)(16526019)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:xTESTGhfuNbMQMHlmovibXAIBzTYPD5ZookxffMTf?=
 =?us-ascii?Q?iXAbBY1rZLe3ihu8Zf8XRVOT438wJohluKmXFvCmOKuiyNPUHt8r13skK0gm?=
 =?us-ascii?Q?YOchmHsYAsN7Uwj4ceEU4GaK7zu92Z4PJ68NbJ5sfyplJlJo9j4YYBjfyv1g?=
 =?us-ascii?Q?nlqFPKl8Rg7m7dpwrxk5cjQzdo/Ba4Fe0lnNxuoXGQx6tKeUz172LBpg1Vnj?=
 =?us-ascii?Q?Qofr1ATGE6jlx6iidMrUNfbH9AEgZlTVW+jMumSHl1bYFs+wtILLrMznNjux?=
 =?us-ascii?Q?AZi6LZYzcniX/etdTyjiFfRDNSOtfAB1jBk6NyWBNgevHdrLQNX0lQTIBRxF?=
 =?us-ascii?Q?sByjksqX1tqrd8LVvAIf4OFG4Dm/l7lDjTqIjpwrK1cxzsyaY+3eHz37brJy?=
 =?us-ascii?Q?yAe6UkHubs/Yj1ARi1NqbeuFWaT6lqtqx/kcsvonRc3NZNOzqOSzfoEU2cit?=
 =?us-ascii?Q?6m8cSVPmvVJFSgTi/r8JKOvjuzrE+d9c3Dtt1yu3hIjPAzN07gz3dhm0m1Fu?=
 =?us-ascii?Q?YVXg8lp+1f/ok9M1+qDZiGX7CeeIfOToQqM0YrNNdVVN7s48wFJ9yDeJtGRu?=
 =?us-ascii?Q?JDYKiUEofpMlnCFv81Jmbv3yP0CMTmvrEwU2DHRL3Nsv6omyebd12a3qy5ia?=
 =?us-ascii?Q?TI4cLDFdshNy+HKBi+1KgVfLRezj0S12UxZ8qCAVh5uGvYyG/8/sAwm1LD+J?=
 =?us-ascii?Q?9cGmQjxaKS5HPoto4+Q2fulHlZCO/sd9M4VJPuTxvxssWBZQ5SbnoCJAo9nn?=
 =?us-ascii?Q?2OI7Hio/rHE8go/K6k41zEp0kgWe5qm9cMCus2lf650p6sqbZqaPu06WFZa4?=
 =?us-ascii?Q?b/YnbqYlCkJrC7l3YReb++qKmXDZs9L4T1+hzcoJzQM5By2d3cko7ZinLo3b?=
 =?us-ascii?Q?W/OMqI1t/0R+meyLYo3poBHXMGGcBBAaVH9XWe1tj7cf6FZoE9HcZbjbp6E9?=
 =?us-ascii?Q?EedSo7dHTzRyPZJBIi/aHXNwl0TK50WgWPg4+jwkFLG6xfWpFE/TLO/CmNck?=
 =?us-ascii?Q?k17hJSRZbW/ivRYmhFs6rEsAiIj9lz7+HZjveu//PCQAY3PLXKw9Tb6GCKoz?=
 =?us-ascii?Q?zb8+Do=3D?=
X-Microsoft-Antispam-Message-Info: Rs/QcjbyKM4SLhTX76THeB2d5xBnT1cKIrlhAwfSM8V9FE3JC86mCQVWlmv1dNIzTFNWTjxriKoSdTZu5AVKa6jgCGI0QCgYUyVELe6zvbuMXu5ko6Tg9UhyN6VlbPC3hhG0qJHahFCu/3HtY28hqfxVPV2sWokTeK480Oq2aBAFmgfWonmmQiXzKlnK1s59
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:BmDN/S/+uBlEMpDG8k+9F0m/um5ShCL5HSkzrers6N2wp5kX9iRsGhFAURQApsFbZcQ/R1cVhgQNftDNyWQRB1zzd2+rX4fZrwhQT4rn8XizTlLdgLIEM6CiLvK3rPJjL0Dq7Yv47B3wFW4AeBQjHvIi3f2IikslhU7n9pEUhqq1i5DPZ92/DpcHR3UgVev45w5+7ls9lcc1hWkvdE8tXOjS50bHZ6Zsw80EqAEONd7/m5nqsbfgTabNmryv81i7+vRogQ3liAOBvK1VA/K8yoJqu4/GwS3GdyzbXX3r/uwI7itKSpcdwHgARGWvNstFcG7gyjIDQuOePYBldF7qq6DhXaYjmbsSyVCgE0aYdNkU2l0PeWRgTtNaWE1FolZ9aP9ONF6o7xQLYbEyQOner5BGxJhqNODPn13GBYYKngn/mUd142ds20S14LDG9N3qwwZe37+yEjndji3yB5sXLg==;5:kjsUiCU4bqg7PoiWgbanlDLOJVz9cZQwYFB7LVEz9OvjS1zchQqp5JSNUFwnMejzzygIpF6XOQfqyFkdH/dgdISv7vSTGDhEtiCia5yKbvw81wg90pScDQIuP8TUR97U4usME5WYb7oqiEsVeli08tB9y6+02F7RSxUEJ+dnPto=;24:Pp4dg0BEBdd8yvIqxWmR1gGoQkmNw2eb3RFOpUBE5f9pHXohOLLQlpHo9i67ujA2ckKfa++mdJPrGpQusUtHfFJuNpEfkuqcAkJATL3ZHw0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:Hy/Dblck+apP5w4Ehkgf7uSbzCKkskZQ6upMlAtuomXj+q9tGSLBJ6T0rY5tlSls/NJ78qUeSxwyLH8GnF+KyEdXffoCeBA+2noo/49CGM1Qwmq00e6BtSYQ8g33nMfZDoB+QsIeHh/6HrCqtZk8MIKQdSVFan+vrlU9QDzUwmpbkmudgP8h7TXF1Kkv0qU/XoUZggkOtlTtrWi6ydugO0HKlsPhPdABDEfWJqiXP5QzR8zVrg4c0fY2XNMqWnQM
X-MS-Office365-Filtering-Correlation-Id: bdefee48-75d4-42d0-7b23-08d5a9886484
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 02:09:17.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdefee48-75d4-42d0-7b23-08d5a9886484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander
on I2C3 bus, add support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V1.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index d59084f..812f40b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -82,6 +82,13 @@
 			>;
 		};
 
+		pinctrl_i2c3_2: i2c3grp-2 {
+			fsl,pins = <
+				MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+				MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -272,3 +279,24 @@
 		};
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_2>;
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
