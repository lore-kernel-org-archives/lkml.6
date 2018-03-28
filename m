Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeC1GrL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:47:11 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43380
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeC1GrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 1/4] clk: imx7d: Add USB clock information
Date: Wed, 28 Mar 2018 09:46:35 +0300
Message-Id: <1522219599-10831-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::29) To AM4PR04MB2129.eurprd04.prod.outlook.com
 (2603:10a6:200:12::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b547377-d6dc-4723-25ef-08d59477b6a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:PH3EYMdeSqrue1oBXAzuZTFEgtrpR47kTib6qMd3GmRytJjoNay1jGkCodlz0ld6/HZQrF4n16kzcoasfJRkKI7YyDEV1dx/lzVjk/VE0n6H5591kbgpO2l5UxQChVvZ/3woK8NdPdQPaB0iAyX/wxayoAIzL6i5OJI9p5wLhmRoPJZHpX25MSO61eDzM/aimRtjzz4poiw4trhvaQADQHg1njVl8WQex7Y8kd69RK+YKYJCrnPvBymc7wn0IH5x;25:XFJ9c6aotZOTKEwgE/64QT4TbhvkbBV48YSuYlPW4NODgxnqZrV76Gp4g+5rn6RG0ijnhF4Y/ppFP/Dox9cB9Y4/L4Nkg1NGMWJh0swnfnqWhbt4UXhtmnPi/2SzVxlrdMauxKgm/ikcmz2E/ODNjFGtzeI2FK2dx53vz23m+tfgUpHo8uG1kLiUsFJ5/2lAayOxFCgDyNph3kKXRjKHRfpxyyOqJsvcKkDR3DoFMdYSZJ+uD6i8Q4KCR04aZXwmuejVsbJxyk94J3kFuCE3REvi0EyEYbKxZHc57ZhLenchILtMkOnCB3gXcgy7syr1OeROThupOVhS0meZJtEuCQ==;31:lHqv1l3k8gKt35oHlunw9g1o46wcoiati+LWYwjuHHAmc7iHFL9GLHYz64lfZ5z/LqPRQ0zXDKeDBnGIH13i1ic4dxqDZAKRrONgpBurjglNy6x0UGkeKDG7KwJTPATuFGwFypzk0r2iO/f4IRw+wCun3oOvnawTGvrF3q5HcPRDYsV9c/XrhfZMFzrRBlc9bbsJPPKKteDTjIo/sTEAJoe8dLtKZBGUMQoxm9hZ40E=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:JYf6MFvbaem1trmRxg6tCbdlIL+y4AM6SMm/C5m7B9rRMarBKcDu8NR/rA6vx2pf1C9owwIZa1qx3dBtGloH3FnIyeRWQDUZouCEFA/yd8vm4G/1Of/OVDcL1deY4FuWuBKyR8i4Y/i4EHGg02OjWCZSzsuz1EpTyJwXKKVdKWpl0V+hQJhZZDS5drKJYjEJeC7l4jLLKD+uREEUW4D3y/9MmvOkbxL4ePXLa6Kj0A8tHCiSUMpYPIQKzVJ2UGH+gD8P0pq+GSeOc7DD/NxtFE/uqQYGwyg2Taldmqs603zjQs4/9Ot90+P6AQIcyonRyGLapIBAoTHps7/Hzr8yyZEMU0ewD4ULV0b91I57GT/681By0XIQabUa4jVzZurTv03C7phgFriRMIibFNGyNxY1Gv9PX0nfB6vkRCkyjMGJukrR10IXvfjHGXshBFFPezCdEE15M7SCOS/KgFicWmq/frlG3J9i8NF/iIv7GUE26kP+lXbSBsqrKYlc/v6a;4:Bm5bJHJIDHJ01Ccv1yxRx1jtOZ/gBi1OXpHR/wevFPbW5//gkSdUqiF4B+xqyo9MAt4Ht01e5AOIBUux6NuaBtt2o/nUv1R/35GgNqguSXYqurZHZAJuPNPjF0wToY52bkLsNdKoNrMj/7xx2QnZ40gfoFLt0SalsVkInGrLwIo8w2s0hwl/GvxzfQEWQ6Jp9K07B9TDs1SiqFIrFW8aYCJqSBqsQZy1P4NAgFzL8ahnLK5frnjzvB1II/ikkUsrdLiCD3xvJ/1A1U8zFFUXgNTthqln58G4k/gTjM/SKtUOxtjD5MuMIk9TdwHvH9dZWb9O8l/Otpm1CdclMVnYd2+1rW80rV0po0ESr+E8O5c=
X-Microsoft-Antispam-PRVS: <AM4PR04MB21297D47AAE98B63D2EC47ECF6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(59450400001)(3846002)(51416003)(6116002)(36756003)(26005)(76176011)(6512007)(50466002)(446003)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(11346002)(6486002)(97736004)(53936002)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:4TI/USNcRfwP9mrlv4jmehAY5uPG64TS029f8DtdD?=
 =?us-ascii?Q?rvHyR6LKI/P5ZXXTJaVoJbYdYifBQA0ZMdX2a+3crU6N6uwJ2YakF/T06Zzz?=
 =?us-ascii?Q?3YBp7VEGkDhuMeVv5SInLiiWLRCBOH5tBxChVcvT+/XQbavCGm8eBihh0zeY?=
 =?us-ascii?Q?05eDDZELKmSuumh/GLz6vKQGWwqR7RpkMlm0gOKv/HkLyFtgqV4JqcjeOE/K?=
 =?us-ascii?Q?G5bsr/xm9iBrfl66kn4bzavNlVgKgkkFpQU8EuOhXD/y1jfKNoGQG+AL07kS?=
 =?us-ascii?Q?tKPIPzt+eLsIG/GWpKr4tmZoM+gMBkBLetlk2grwoFU+Z6OZ3jUzt9Y1bqxH?=
 =?us-ascii?Q?rNENZXGkQxmXG4Ob6Rz0BmcROjr9HRyFq9rYs7hJHiNbqY05Ht/V7ucC1zZ5?=
 =?us-ascii?Q?qucRDByX91N0jWhSVjVdGJUIbSnvjPMAwhXgDohyEZT8SahEdcnF8Po3JnvP?=
 =?us-ascii?Q?DFNo5w1o66jhT0BhlMOudPCNpp/e4Q99wIpfzwHpw7ayYymqrWy8zi2tOYp1?=
 =?us-ascii?Q?WZqv/67AvFU9Q3fMEdlOZIPFO//8TzzTLEqEU0j2YQAOnokvyGPqIdPcoMyH?=
 =?us-ascii?Q?blhytnwFSxKqBm/qH/2xZSJ0jvoIE9EbPOA5isgOafPfJGo416AcEB8fdgMl?=
 =?us-ascii?Q?40PzhQLgyXFav7zKsA1Vcn/V10h5sJeOzaB1UnKriA1BKRJQYZ+a2dTh7xPd?=
 =?us-ascii?Q?orfgeutOj/rbdVuVcA1sI+Gp2Q/zv2TNTHkMFM4akxKP8GyvwPIQgcpH983V?=
 =?us-ascii?Q?r4hV8KR8B+LbsJGiYpqxU5XJHgJn3WFvQaCesCd3QaZzXcKNaOwgZAMll1DH?=
 =?us-ascii?Q?MJbn6416ZLUJStoX6wI+4SJEpTVm+JSU4TFIh8nX82wze3LCPILuttgDVrZR?=
 =?us-ascii?Q?gtj9Ujztfgj+eC3hKFochwlA+Yq//8u3GypmbgiFqkZJLLt8Th+NQjkC4QE0?=
 =?us-ascii?Q?kxHvLoAiO3qS8kjmyGLsXVuobTiquIGG335TxpPL3DV36ZUi2rWx1YYazbH0?=
 =?us-ascii?Q?lBN9w/Qo7M9VStKoLLQnY9zH+do+ynoy68xUApeLMQ1Tx/A4ZDz0wM9sxKrq?=
 =?us-ascii?Q?5SE7vfod1x56fOyXBC8Ala/I7tWHbyT4WOdNMHvKsEjelMpeMXxj6s9rafkp?=
 =?us-ascii?Q?fKPvEghSZgrysoEbQ2vUqaRZoaBzDpqc2OrvweGxSECCBYXR0YhgxWn6MVMI?=
 =?us-ascii?Q?Zxiolt8Vid29bMppvxsn6iNPhDdcNSDF1YYVrlOygIXVCl8Fszf4mTXex6EM?=
 =?us-ascii?Q?YXd3zm6m3WDtOjNAQHPCRWI6cY6mkUkeP6Cu3Pb?=
X-Microsoft-Antispam-Message-Info: YAGK11OeIwe0xBzFfc67jugqkGz+m9chyc5cXYFmjBeuPyh2kUFH50WrqPgGqyNcPYm5/3g0Gb9UL1UgFByUxZffperBVQLhu1FeNq51LxqAD97tUwo5TIvMxARr4SgvYAf34ZnJJ7mdh78q72VpgtTh+B1Fka1skGQleTriPzSjrp79Vkd3SqSFujMVd85t
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:oe+xBO9JaEy4GgPRA4abGfaOKnjmlSXP/T+UiFhHAeDIFcotOcX9N22TJv7/5tsEHkJ870xPdJ8WvWpugey7XmFHu2lTqr1iuGZ9Puk5479qX0HJffJvaDK/HTUfxZSpbzOtw2cxIQm8gGNbYA7VcumdhZ5RkUKGSxBgApJGTZp57LBCqavGyH3+caObTwGLapMdItTzbjNchWsFeVDH+3yjvNw/x4+nTeWWps4tO8meuU7KZDKZ6ZlAgTtDk80DqP34Oc4yXZZfD/QcS7JKg2tsFjJ/neBjk3+2P37JTi3JgNkNLhDFqrRzRC4M8AIVKkuln3yC4xGD+wcZCOPpjHL8jAkhsJGYSyG7t5UPLnXybEK+EQnYFxKY4WKoBsHhFv2EHhrv5JteqG8DAAni/8yDjjqfenOO4G9lc/Q8PY++6JKGcVwsAANLlXom2AflXhuMuY676ai1omEW2Ks25w==;5:XUzgafqXruTI2Rhq5+vBNfPa2/PtKVwrUh2r7jbTR40IS0DFMRi56V4yLUXNpetgbyF8wa4UUQKQWAOo5GlRgojYpEJFCNw1UpGpQY34y78RpMw2Q32yeMwBsg0hLAc3FSK1mXNxzh0cHW+w6sDqSrU164NR4gFqZSDXFv67Aw0=;24:PsFy4MbjPfYsw93FcalD51gisokXkSX/U2snYPYqkzxs5egJXwnS69KL61wdyUagGTHoq9yK5aV2316Fd67ZrItrOspbMRCDFW17JB1BYiQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:0qHZjyQXKornhW1+KnmevezqkrLljOvq9EV9yGCnl66SrgXshCuCaCJ1X3uYICf3kZwlHxRpkKOhLUBjrBWgNUxOYaQV+tk1AvRyraJwmgp+jOl9ZRNfLTGXSwmY12qbH/XobSrJIAX603FJ0NSlzubn11smxMsuvEYmgvGKavytQvkseeQpYB8MJZAa0GtDmKZoYeRsIhJgutc1NvohYSycMfknqz5uXkB94tponEPsyJNiVHRBM/bZLT5cNJ8V
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:02.1259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b547377-d6dc-4723-25ef-08d59477b6a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@freescale.com>

Add USB clock information, the pll_usb_main_clk is USB_PLL at CCM
which is the output of USBOTG2 PHY.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 89bfa75..39d110b 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -801,7 +801,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk", base + 0x4230, 0);
 	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk", base + 0x4250, 0);
 	clks[IMX7D_CAAM_CLK] = imx_clk_gate4("caam_clk", "ipg_root_clk", base + 0x4240, 0);
-	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4420, 0);
+	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4690, 0);
 	clks[IMX7D_SDMA_CORE_CLK] = imx_clk_gate4("sdma_root_clk", "ahb_root_clk", base + 0x4480, 0);
 	clks[IMX7D_PCIE_CTRL_ROOT_CLK] = imx_clk_gate4("pcie_ctrl_root_clk", "pcie_ctrl_post_div", base + 0x4600, 0);
 	clks[IMX7D_PCIE_PHY_ROOT_CLK] = imx_clk_gate4("pcie_phy_root_clk", "pcie_phy_post_div", base + 0x4600, 0);
@@ -867,6 +867,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
 	clks[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
 	clks[IMX7D_WRCLK_ROOT_CLK] = imx_clk_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
+	clks[IMX7D_USB_CTRL_CLK] = imx_clk_gate4("usb_ctrl_clk", "ahb_root_clk", base + 0x4680, 0);
+	clks[IMX7D_USB_PHY1_CLK] = imx_clk_gate4("usb_phy1_clk", "pll_usb1_main_clk", base + 0x46a0, 0);
+	clks[IMX7D_USB_PHY2_CLK] = imx_clk_gate4("usb_phy2_clk", "pll_usb_main_clk", base + 0x46b0, 0);
 	clks[IMX7D_ADC_ROOT_CLK] = imx_clk_gate4("adc_root_clk", "ipg_root_clk", base + 0x4200, 0);
 
 	clks[IMX7D_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc", 1, 8);
@@ -892,6 +895,10 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
+	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
+	clks[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
+	clks[IMX7D_USB_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
+
 	imx_register_uart_clocks(uart_clks);
 
 }
-- 
2.7.4
