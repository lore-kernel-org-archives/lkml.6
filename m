Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeCVM4W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:56:22 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:20800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754732AbeCVMzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:55:50 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-imx@nxp.com>, <anson.huang@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 4/4] arm: imx: Update clk driver for imx7d
Date: Thu, 22 Mar 2018 11:55:29 +0200
Message-ID: <1521712529-632-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131661969442369596;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(6666003)(2950100002)(450100002)(86362001)(2201001)(54906003)(48376002)(110136005)(50466002)(316002)(106466001)(16586007)(4326008)(5660300001)(356003)(305945005)(53936002)(97736004)(8936002)(8676002)(81156014)(81166006)(50226002)(47776003)(2906002)(15650500001)(26826003)(105606002)(68736007)(104016004)(956003)(446003)(51416003)(76176011)(336012)(36756003)(85426001)(498600001)(26005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2876;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC004;1:VEfkFPEdfQYylI9TuX5D5/KhJAl50ceucqfycTMzUd4Hcay40Br2eHsIe0ufm+62ouWEju45OXXa8x32lDSXIo9fww0vxO3e1YTt+w+FlR7moi+PtFYrl/zpQerwuVhQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41d3b84-c658-4dcf-654c-08d58ff4396e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR03MB2876;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2876;3:AyVkM2gTfNrYROzthhWGB1kCPPmgBEy9J85H4SXOLMR17mqNMVRYoNrEQbMYDDlpL7YAXoiEbI5a1OGveZCnQyf2ePgJHhwQVC8O1viajDDBg1YtIr+tjU+c57sPPwMBXiNYFlrZfz9uBMmzuP/43mBcGOqIBECp/q9ld0iTO2cprpveKsi3ZS5EMkDbM8mNffMQDaBBxPnCq5eNGH02IziYBACWF7cUe/77ODQFGGM0IuViHqm1hdJI55BIeo5Zt2hgH+JpeKNxpaMLhgtjC0IwGwqBDPAGzZSWn1Q3SKwjZj4QuY2o1lMpcqwqsHM7Omk/2tl5Ve5iMvheff5Wl/sN4KJTqExJoe0//yYItU8=;25:Mrzk8LNn96zFkUl1Lcf1l6aUuUrd/IfAL1tu3enhqu+5T2VvsJrzFIHdFYkRFzBNkCcWiASH8vI7GYvT50u1cBytYuXAC5Vhh+MeZQDlfICwCkyCRgAS9/xmRmYp1A015e4SCr+NAy1n8brrceTxfI9kihotHbXVp8lu/vdkhhtnIF/D2Rqt/0XIIjiYDM3wlC8uSK2ME/6ciSdYLHe1UFo6EVj3nIQ7SbdWAYiVhbpB1bVY9OSIdwlohQqR1sx3BYkuXliDceLZ2Epq1wmV+b5FcsbYk6uriVNofMWSga/upsjeqq15E1v66i7ZSVisD8es0OFyt6JPV3cla/hAOA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB2876:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2876;31:O2vDgTQZdHuzaF+Q+xJWfr+L+o0QZZDEa3Qy3TMissXPPYqXJsXMhxlkkRwLiOeEOCSbGRiXE9gsMNRm7GMTxrjj350lpXMUemLNO6jc3bqFeEh0+AtYFxfBe6zFDW6vybx4pWNOkLB0Yyl0B7IqZ7e2zAZYt5rjyPb9tg6loVvs2g183mqzT2IQHnDiCso9/sCdCyjrs+I82W0Nluy0i7vCljNPgM6Sb0TGMYrtWi4=;4:dqoq3MaS4HxOsh9mYkdQOKNX9d+k6X9ZelXUoIm2XDvUo6TIp7dXcONQ2G5KpX3UHkxFO7/G/Z5toSZkk6o2AKE7n4f0BjWGgbl1s2CFZUOSv1/LIFjyw0BCgtfmGMq+xDyFgSAmofOGeiOvrJbAsEMnlL25D3R9w7HIc4KGlZQWWecf4qetgVKfvd+ZVt3sZC6dbik4KuE5TR2PkLGA72ynr2Z225FM/pnWu8RMYA+JsQagv7/fX1QghV/xTlPgnwxZtlF/fVBLyIWI+vE6sZPJSvWsYJ05kYozjChMa4OSmNVvVIB/8VvLTXLwY3jD
X-Microsoft-Antispam-PRVS: <DM5PR03MB2876EB07F5EE69C21838F72CF6A90@DM5PR03MB2876.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011);SRVR:DM5PR03MB2876;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR03MB2876;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2876;23:Sv/CBQn5rT9nz3HCGF+/scnzPf3ZjSbPi8+XBNwMH?=
 =?us-ascii?Q?ZX5LViOzzvxkBRpL4H1eOQ6Rp/UI4asQigELonOQNf9j05hEjLYyx4EIqeMm?=
 =?us-ascii?Q?s6PBII2f1mr/fmkwz8pW/5F4hoC13gf9jXzBBXTF3L46sxqSurAo0ZLYqRDB?=
 =?us-ascii?Q?/Mqk2UcQwJ8AqMG6c5IPhOVs/DJ6tgNkEwgokBieDifECUAgRHAJATpbIxY9?=
 =?us-ascii?Q?7MhhQsMtOsb16VrGKkZT5dAyneh9KZ4VSuLwKDDnA+E5MubU38L4MjBMhmmF?=
 =?us-ascii?Q?OptDYQ7xHzgj7gd7ZPh4Nb7dmzB6gsguxiot+UtAus5nzE0E4zYbIqrT7AWw?=
 =?us-ascii?Q?EIgv1ELAdCVVNjupCtCz5c94/cjXbC60DWuVE4TQt81Yumaod3zcWDu2bTEV?=
 =?us-ascii?Q?YVrvMpehCxvB5xyMhLkUms9M0n4T+DA9R9pY8gCsTR4mIhNDtIX/OX8VFpFC?=
 =?us-ascii?Q?t8OLyqkqrDeupsrfCM97QGnaYyQbvuNYlgGSUDIGZSt0tizIZRsFRNMvOcXH?=
 =?us-ascii?Q?IqrvZ0y3GZUCppBSug2UsAANUMrfUMGwmTLiyJY18jgw6epOL6j/G3yRiOVr?=
 =?us-ascii?Q?tDVavNhg9g1B5bZR5mO9TQhdIOp16IvJU4IZMvK338EdP4I0iYUVoY9dobt5?=
 =?us-ascii?Q?4IabcoIuFcDl1hrk5CcwkTWPE9+b4h49l/urPycA66Ozusn2D3yRl8s/ClCn?=
 =?us-ascii?Q?SpgfFStk7A9ffs6UPdt8AtUJE/0g/nk/P56dglcEck2hftrS3WPCu1X5U3M1?=
 =?us-ascii?Q?fMdpcW0dj9B3jwObOEUx/MgYQ1aCd2dqqLfetToyprFCwYb2hkbHNhGTJrTN?=
 =?us-ascii?Q?FS8lqi9fDkXrXG9A0Wppq2twU1yGBAxtn8ThBA/VZMjj2SyU1IO/D4izGu8A?=
 =?us-ascii?Q?KmuiTo//Au0eznd7O9XSBrh7987T6+J4izJiS6HJ2C9SJufLw9hGm+ZJnASE?=
 =?us-ascii?Q?dl2Z54bw/p1XL5GH38m4nT1PwMCbo9SG9omyQYJ8ZiwUxC4ZsuL7oPigzatu?=
 =?us-ascii?Q?IUJdsW04wWIncQC/uvdZ8Sr4Qkg6/jLbJd+Nzxtole9HswV6xPxj4knnVGQz?=
 =?us-ascii?Q?cb8cfNR9KscqES8zM4u8N9lTnqFua3mpJtcR5NGU5IhclRSbT9rOXB0z2tJx?=
 =?us-ascii?Q?M3fPYI8pDv2Ad/levzc5rQ4APplT9HWOZBOQBX0ur6UGriLA8N7amYMMeK6X?=
 =?us-ascii?Q?8MtoOeBqdwNhNE=3D?=
X-Microsoft-Antispam-Message-Info: 0SZvcBGqTu0daTS+XAj6ntogx6/iKeBZpK4GI2F8YV9qDlE7MOLNL+GQwZ2nBzYAnxyjnHPQLpqrpPxf5UCTklFNPm+J5sAz2/Xr/ghPCMCB3HT+c1jJ+Pb8J9osYsDY6nPVtRThp2jSdES6hkfeVrp5IWM+yp8Cuh/PyPe2F6ZaMhEeFY4P+tEdlCW1AsZj
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2876;6:78Dl4Bc1zGW/BieRT1mz3k8N+Q06PvSKKo0fd/d9drw6VJWLxe8eqHwc8OPpVDBwVkTXucVEoyxm/sog6sRCBwZYLn56TjQV5cvtcpMwWsgF5IR5b9gRgawQKRIU7f3BReQI5o5jTn/ZvbHFy1KIysix2lwvtf7/JOkWiGlDOPYxhOqgjTZFz4v8t3f68cX+KQAhR2jUtAyGwyma5DfL7nSgwRV3JS6JniO8aZeo8mJX1a8GAHDckPVFMlpozZmW3iEyHxnCMPs8zYiBrGdXDI3MHsZyRJH2+dBIKJmf7l2Jo3MchSqtnvpmIa7E+VSeaZLghN4rjaNQ5O5xJU8LElGQXZwDXnTi1bnBpxihYEdCIMm4I7/Y9SgpgcoN0MUp21Cfex95WqtyeSSgy/w2qtbtbtEvhzUUP9zURLahEaaFeD21WJpByjwmW907OrLrE/vmfjazxNVtkmGujWgLIA==;5:ii7ffxISyfzMaBs3D23sOY3oOW7tHOTsx6V/SHQkez5Gv1cwHfgejeRSrYbj1XxsjWAa+yvsKVIcPFaWle5qBc7zo4PbN64ZBXCQFQoiXYlTQwcKqono/l0l2WLo1/EfNKOyXcOyeaNiDdPuvu0X9iPsVz6BY6EN2X8DfYf3yQ8=;24:x4+MFAZUXgk2fm3IVMqZAm1mfCv0whoA5gsvf9ElKOj7LlvjXc1aad0HVnYFHLGmoZokVj5/vo+UpIgCOurfA6BW8PNZhJAgYmnIAg7Z9eo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2876;7:gLcJtJjIImxSTB576p8Gu0iDj+mPEGK6pGTqVng4buE5uIJnbbN7Zi1eOiUvLg4UfyIZmXXJ0sBk/3hIup+yhx4DfWBj+pvLpKkjORpMoJ2RDjA4YskjXvu+Kz2mYz1U70Gz331CCVSf3PL3dcXqp+jyRQ/iX7dHt96GOCwFqbplmPTwl9gDrlFQVgo5VYY8waSXm+yNVHumXfIfWw0X9Gi0UlCug3cAfr70oD9vqnRviUyvdbRmfSq/099Z13CS
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:55:43.4101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41d3b84-c658-4dcf-654c-08d58ff4396e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2876
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

This patch updates the imx7d clk driver to make use of the new imx clk API.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 3553b68..255563b 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -433,13 +433,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] = imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel), CLK_SET_RATE_PARENT);
 	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] = imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel), CLK_SET_RATE_PARENT);
 
-	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
-
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
 	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
@@ -525,7 +518,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_mux2("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel));
 	clks[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_mux2("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel));
 	clks[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_mux2("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel));
-	clks[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_mux2("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel));
+	clks[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_mux_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_mux2("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel));
 	clks[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_mux2("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel));
 	clks[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_mux2("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel));
@@ -719,13 +712,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_PRE_DIV] = imx_clk_divider2("clko1_pre_div", "clko1_cg", base + 0xbd80, 16, 3);
 	clks[IMX7D_CLKO2_ROOT_PRE_DIV] = imx_clk_divider2("clko2_pre_div", "clko2_cg", base + 0xbe00, 16, 3);
 
-	clks[IMX7D_ARM_A7_ROOT_DIV] = imx_clk_divider2("arm_a7_div", "arm_a7_cg", base + 0x8000, 0, 3);
+	clks[IMX7D_ARM_A7_ROOT_DIV] = imx_clk_divider_flags("arm_a7_div", "arm_a7_cg", base + 0x8000, 0, 3, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ARM_M4_ROOT_DIV] = imx_clk_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
-	clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider2("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6);
+	clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider_flags("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6, CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_DISP_AXI_ROOT_DIV] = imx_clk_divider2("disp_axi_post_div", "disp_axi_pre_div", base + 0x8880, 0, 6);
 	clks[IMX7D_ENET_AXI_ROOT_DIV] = imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0, 6);
 	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_divider2("nand_usdhc_root_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
-	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6);
+	clks[IMX7D_AHB_CHANNEL_ROOT_CLK] = imx_clk_divider_flags("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6, CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2);
 	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div", "dram_cg", base + 0x9880, 0, 3);
 	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] = imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div", base + 0xa000, 0, 3);
@@ -790,7 +783,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
 
-	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
+	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
 	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk", "axi_post_div", base + 0x4040, 0);
 	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
@@ -886,11 +879,18 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
+	imx_clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
+	imx_clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
+	imx_clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
+	imx_clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
+	imx_clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
+	imx_clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
+
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
-	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
+	imx_clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
 	/* set uart module clock's parent clock source that must be great then 80MHz */
-	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
+	imx_clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
 	imx_register_uart_clocks(uart_clks);
 
-- 
2.7.4
