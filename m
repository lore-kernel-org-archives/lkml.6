Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC0OLn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:11:43 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:15094
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751092AbeC0OLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:11:40 -0400
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
        Anson Huang <anson.huang@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx7d: Add USB clock information
Date: Tue, 27 Mar 2018 17:11:20 +0300
Message-Id: <1522159880-16694-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::22) To AM4PR04MB2130.eurprd04.prod.outlook.com
 (2603:10a6:200:12::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e58fb0c-3232-4a6a-cfae-08d593eca795
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2130;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2130;3:GgGw1dn6OAjTZ77olKRyd5fY01z8/xnzS7RUVMCRoOfX+WNcNdzUQ+JlpyBbfo2HzCSJTzb+4wDQhtURyPEiUhOoGzkLw58TvNRfnGNNoU3h9EVGukGBziyfOUPCE3/Hir3HGi6eP1zofO3ywI/dGVu7fJ+4KK/dYZL0BJG9Pok/NuOcdGt3e8PGOjz9L0aQn1H8FUDZZb8aZ5+Fuf55z++CjnAIwW0/gqwY85g8oFiT6tSaFZJCte24J/d5cg/1;25:76aEWP7VqOtXmvo1b+cmxvW4dBu4U0BtPiv68NKReIM9MdmX3bwGEs/K5TgDYQFacDjyZ4AthjFX7icBrm30MQI25xgH6AtpGYRah53BW4ERuzomevbYC2hvPU188LxJ5iFd77Y9wIUZj2br87lIzDpJqjIMOU3AXGcZLXFYc/aGs1KPd2XfoiDlU4N2vl4v9/y54+PEccmJkzHzZVWHvN9eWIqk2ylOZc/IoUOGf0/CNMOMcBkUSEzZa4H/0ObD4vuwtt7dIKRXudEH+UvonGQtXPz1CW2PyfOQqBk2tjqvQQLla1gNGHZOs4NcJa3U73u2WcHwD36Q82R7kk5ogw==;31:S/0JaeyTK8unJdSQi0PXDyT6ze/LhM0h5ufMueyDM0IOaReqJlw4ecgJRH41Wi6susSnD+0hHcJxgraLkj11eGfjj9o+jhOza1rCzZBBwHqm84sNzOvhpbOhNBkcTjuzbaCajx/45iCCqXaKMMyxQD8FQtHnH1BH3GKDumH0K6w6UECQaYrC9lkbr0uISSZqTNvKKvZ6c1CtA+a0AEHWvdxha1FDiZY8YoqH/uCLxnw=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2130:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2130;20:gp8l0WwhJvB6VP6GPMZZJSgy+ShKANAE7P8HTqwKRvNQKECgas7fi0E2zUEU8DMhzMpZ5j0opF2iFeo8BhQiQrDWkJ1M5SE2/ustdbq6C6uM2S4Nyh9GAuepCN8A6ZMdV/9GSU9vBWYVlQYOuP8nzM9c3kI5QTCJKNe8CnUdIXP1a7KLAjIWvjjo6ST9h7Jbs86151mh3jEIv9P2qAIfWra9EBReUZlwWynE8Or0kt/zedmMM4tbm5pegDaNPIw1q7E+NfcaLu8u+2uQ2BvlQsDTDdh0P+uiSkKRcEj8/VdcVyr/WgLE9BD9ep+/K0NiAyThcE+aeFD1ludZ5HeA32KgeQiJA8TOWE6h4D9AAj/zJNNpiTGhJthT/M6oHcnIGZ+EilP4gCUop4sGcyKFR4CgnIETt4cMcibxdldda7oUAHBU6nKuarb3W74WfrPq7unrBEXYIw9T1GUdDOgYORymP+XjSwrfxKPOra5tSIXcqJ+rcSOXwwAJxvhTTqtc;4:vKrrEAxqMu/jmPySo7JM4aVj62X0kQxoncIe/ELbB+M/O9spxjptgQ9Jr7+std6LAhFxQyG27HxrVp0kTuF4ZejtGOjjMmBH76M0kySrSevx45g9qGAs1Rx7ub3yuS/KaF8jmYzCHN+lfuhexi1ZEbkIOiUXFIjVqZgfZHFZ1spYdRb+lwfv9UNph9wRrTKK6QmNVd8dkf61MOqj0MY7PpUtnxBcD+X1G/lzIgiAHTgcagV/vmSxlo77BpX0B0y70ryKJfAmLnsrxypbOdNnzK8H7SFItP68NGHoElNpcir/UUoYVHjum69YgoAgoMdjDSJE9ip2Dqqm+92lQNgvHRTcw0u/ZUuIuIQCjPQcWHg=
X-Microsoft-Antispam-PRVS: <AM4PR04MB21309D5276664BC0A476DC94F6AC0@AM4PR04MB2130.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR04MB2130;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2130;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(189003)(199004)(86362001)(6116002)(3846002)(305945005)(7736002)(6512007)(81166006)(2906002)(81156014)(8676002)(8936002)(5660300001)(476003)(16586007)(53936002)(66066001)(50226002)(68736007)(105586002)(36756003)(47776003)(316002)(106356001)(110136005)(25786009)(6506007)(386003)(6636002)(6666003)(26005)(59450400001)(6486002)(4326008)(52116002)(478600001)(48376002)(51416003)(50466002)(54906003)(956004)(186003)(16526019)(1857600001)(2616005)(97736004)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2130;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2130;23:WofRHJ57HHGOWSQKyQ2f0C+kplD2qJJ3sS4ep/316?=
 =?us-ascii?Q?al12Y6IfCBon2u1YkirbTGsnW870Jvi6ohZsSo6vJc9pyHUBd13w1dqSjfZh?=
 =?us-ascii?Q?HUMSXo/m1iSy14VBaIc53JznkwwCJBEvKqc70pkDsl/vDwiIfpijiSvUdWit?=
 =?us-ascii?Q?ICoyVmABKv+lL9mHxXd5IN4NIS4UN1ewWWQSRzMx1p6NpqNZ63QgfRpgVdP5?=
 =?us-ascii?Q?KvXZgI+2mHqA2mw7Bq1yhZxkFnsPspvMb8WV1mjdFqO1soK2ILiGS8EdA1EQ?=
 =?us-ascii?Q?KXr2nK0iJWh6WMIx5ATd068GbJJUqN4nA7/xkVpvuNhuQlrgwqIRdl7lHIFl?=
 =?us-ascii?Q?RpINrkW30PC0S+ICiAGTuQyCocp9Dr+26ja4O3ApcMkw6QgUBlnXVek1O8Cb?=
 =?us-ascii?Q?jZ7/FrYSMIXFYdr2sPfnq7IYKZV4ChVdtpbwypTVVh6q8x7vYy3jSBE3uE5f?=
 =?us-ascii?Q?mpQzzWMGNh/t90PjhmKCClkhlV7rGJH1rhpV81kz1C+AzltpTI/rzFReRnLO?=
 =?us-ascii?Q?e+VR+kpZL4/NP1r/9R0X9dhdjmzqvfbEMmTuRjjOijSWdmOsJBkKizctyEcF?=
 =?us-ascii?Q?g9RcOVFKThcSjyKYFHX0rbSLAiNQNMZ8QObPPReqz3QocIWuNy8mDwZOgIe3?=
 =?us-ascii?Q?RFB9TNoVyrlZ/zMy1g1JmStr5t4O+Qg5K2Vcwnwz5LtkppV8SasGX3tBjyYt?=
 =?us-ascii?Q?3dwXOvrn8jZU6Nl3jPbcx233XHXyx4AhgUh1kCFmB0Zb+dU+jEVrAj2i71Up?=
 =?us-ascii?Q?3pBt169aYoP9cIvKce2gpC9gAI+srmVbC4YdHXh4ulOLBHRHZb6ZKA74OHx3?=
 =?us-ascii?Q?dex5Ng56E39v58CFTxdcUBNvrk0pRWEcMbVfa+dsVPYzfCQezNp4WdaNfn7G?=
 =?us-ascii?Q?9t9RzvdhREGeK0FmjUfAm8XUOoDw9473mu1hiZplOm6TF4Px+b+6xZqAmCR4?=
 =?us-ascii?Q?cjooYj1Ey5NzJw9O6J/JSDKUqpC9ZKk0ja5TS5uOgwBZJXNT3YomzSh82dmd?=
 =?us-ascii?Q?tnTh4gVVSRRKF8LWwb7dvNPHyqdX6WyCzFZMCu4OZ4oQxg3aejALOOi51lJa?=
 =?us-ascii?Q?cF7sSkz6gn9RnKrIdQNszUKNPX1nWvKrEYAnRqFGtFyglpXcEfFBBhkbYtsw?=
 =?us-ascii?Q?sDrZT10oPr88asDraHN6wTw2KdtS5JZO8AG2BGlHWsAtMzpwRiqCjoGIsxlY?=
 =?us-ascii?Q?XuMoUp22XSy9NzJ428mmGr1fG22ycqyz55nxC2unJomjO50JYDtBiK5pQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: qRycs8w5EV/kFFCZVCVJvNeBQKIVculSyRltLSl2W3/TrCFyGBS8munzg2IBBzeaQ+cpveW642NEtTkeCzN+cyxYik3zERHYjWqfQtb2UdZkcS/WB2EJWuamg8cqEWSCxokHaNuR300pzbnH7xR2zBAcsIOOzvYAQ1bkjoFm7Qc8l/Bwo9Vg5FKDGeyg6GxJ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2130;6:HsAiZqTo2djwcF0xcldc5maoWxfuzzI1LB6YMTi90pT9O99VvJvdff/1zNPA/TAt6iuFvhL0S+DSdZ1GcXSH1g9JYxXDTh3b/3UTEwNspgp2xFbHSBIi1+AULTVsk+SbO99FDd6LNzcdXAmWprUM4Mm0i1vGUa8QdMNb32Sv9el2QggEXiyHOnfkegIs5wqf37wlpjt3AZzQl96/aiPlLeFYOYRd93NPkQ+0sjKKthzZ6f4HLLVkhk8VFC7LgZRPVs0l0JGYH4ZdyGPT27LXj/Ez57BG0DApEuK2qG8/a5eopFR3wv5ks01/k3MfT4eNjLScHJ34hiLhHYow2jysHgYjWwOZHPy194uPYywlxquO8r3bZ7q12khr9Fmh7vNEnoALGScM3VIWdaY08EVs135Ot863lua4tncbyFosWaRB7TZ+0sBobgnhoNW3REFZfimxfHTnFjxY8ZZ2BqNp2A==;5:gjkyqTHPhQoJk1AhTgTiSoeXRizHDFVSSYLXej5k6xh0kpIZXVWdXjMUHKRRtEkcS4onP6twqAiICXwyiojBov95d26+XKOXbLw79AThti/j/LB7Kj100X6HwzbTugAlenFgQcrOkhQenkqCcz5l8cBEJKHuqBN3GsNihv9JEHE=;24:JPusiU7+1OvEqeAROVxsVcne5vqap3vb+E2hNri7HLGeLfr/VrMdNA1W6qygLhoBmShtDzMhuruDVYiB0+mWHdCHK2ha3itcIcKTy8Lwgr8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2130;7:R9DMmN2D+64jjSBeulvemAAuaqUDxZ4TJ21eMidojVJIqBVx+wR5dyntdL9RJe9lC22KIFtnDKWtTwfFRYVrv2Egklu9ZviDO+Xpo8exieGuMIdTU5AH+zJTPRDC6w5Nvn0WlQ5zrds3mRihPadi+dS1H8JODDWtIuRdgxSQuXOWlCbokl4Z9WUTP7Hz2ZQbADBXoAWbqPOW8ZMlJvlbpc2Vc+oX7U3Euvk6zHAikUyeq4oKV2m/apwkbnFNhctA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 14:11:36.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e58fb0c-3232-4a6a-cfae-08d593eca795
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2130
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
