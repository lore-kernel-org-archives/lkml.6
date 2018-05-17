Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQIoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:44:15 -0400
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:59712
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeEQIoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:44:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, stefan@agner.ch, adriana.reus@nxp.com,
        rui.silva@linaro.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: imx7d: correct enet clock CCGR register offset
Date: Thu, 17 May 2018 16:40:21 +0800
Message-Id: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:CwxmhEx+0sCCJ/w07F2GiAPQOzu/Tj59epgDZyafggv8GeHyPHItEmJREGGqyE++KWtlYgwkorz9gYpP8tsbE+j+LmQW2zD/GvdW3hNO/4gwrtc3KI2qKkMdBQTDuNckTYdivquQYuKVyhIgIqW1esdPQPUMdz0gqMz+hc4DKiUNh4Tft4H5s56TUYyj5lDsYQI2N6Hmv8lD7zGvxzbB4Dvm78IoW4a9FB9AXP+MyPvB0X4HvVWXgx5D7mnWqrKg;25:c0291vJUASOkdFyifMksD4Yqh1f74hxpQ1b/dpp5nre8YwZYQcQjBfCr0HaF9AWtYOz3/BXRNHv4p1uMq0z5Hx0KIaMAf6pm697uVYRVgmdROUNNRXFpCLDT/c9y2+mPuQLArpRseMYxwGvSbVQE4cSdzVJcD57fOsLkHq9KCOpPky4osrLoqrW9dy1uxc8Q5vpF1O7ODnqLcvbJ9QhKIQmPjiR5ciZs+9m6yWSGQzT7eGT3sPfkWwSezYuIOu9Sp7/Kk4iTIjdylVwDXUJw9M8O0gQ6Ajaiw5PSTsdGYLY8o9+/DB055hqaYgIJcp1mSRvo6udBOVXQurwHaWVG0g==;31:G66GuNT0o4DDc5M9n/A5uAUwpevSiieN12xuErjBnxm80bK/IWOAlSHx4Db8haaQ8r5fvHva4uchD1xEzV2o4XC1uyuncIGnneedAKiSeO1QG1cRkkaQeiqH5ymtz11aLO1hk3VanjJoLOx+V2DzfXrfrhu1xvQ41LyIH6p0YqlWR69PdDy072fbHaO1C57pGKq2F6atB2gfJpzAOUnMnqsYZHqjViTa11mW1HGncf8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:Nbtgb1+jQX4QJfBq2yeJDCWNQZCRzhFOR38b6W5sDCbcTUbHuxKskSUIyBmP8DHew/2CIxLCVBn+mcGBgaYNgYvAFRyiM6MgC7Sb8Ez3TU0FicqkCd51BsGw6svdx2INmaRBAWrKh5liqY8YjfHZdOabS3HE36nEzZR1kfRShpDWdKHFUvZ5flXsWZv6bwHr6QiA69C3MpjvGrQTBD0mVdYCwe0PuguhE/8AxDL6JYqCo6P/QzaJi9coFi+J2SdT1QnwGq60rCzIZdpWEhkIxXye+EHP7Odmcfag1KRYQ5WQD5mvQ/AzXZCktvP+HT3GhpBdyVxFiunedf2AZW5O73xQUCOkrrMRabO0bZkzNb57IQeHQBUBlTh5gqeqTxBFr+H06KXn9g62egxp01JhpDoSRarfz1/7+arru/LopinGl4+kTgP1or+fdSXgvx/zJzDT1gT+9ruFpoUADzoerfm1+Xg7OKwuNMww9jshVmvorAvahd4rvsnEg0HyKfv0;4:DmmhRA6g35TiaRDyvD91ewQ4F34KFTgPz/Ozac2yCoXs8iZ0MEig89W40huQ3uHiX2YzQiBrfV7Zx6SBt++RTx7nB6HIUWRs0nCa1WoMF7LoXJ2lvafEYvbK7qrhSeXRm+rXU4U1enlZ9xInSC8X2fjAYb6kDpYxPWFPuPJyqLjG6uZs47lO6G3ZafQkxrUS2TsuBaafrCiZRD4UtlE2R4PJo2EVDlDh7cSswskYhB7NsAVgJk+8Sn05v9NlfOl0CplVC5PacgznFI3gzdb4lAX9IUl83UbxHBgR3lkghTlxSp46FpvCWERrP+1J/NB4
X-Microsoft-Antispam-PRVS: <HE1PR04MB132327C085D74C994BBE1F6AF5910@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(68736007)(3846002)(316002)(16586007)(4326008)(48376002)(6512007)(956004)(6666003)(2616005)(97736004)(53936002)(476003)(50466002)(2906002)(106356001)(478600001)(105586002)(305945005)(52116002)(16526019)(186003)(6116002)(7736002)(8676002)(25786009)(66066001)(81166006)(8936002)(47776003)(26005)(51416003)(6486002)(6506007)(386003)(86362001)(7416002)(5660300001)(81156014)(486006)(36756003)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:njc8rBVG7p5kP6MB26V8D+X7OkHCjAwu/47Tg3pEE?=
 =?us-ascii?Q?CJc9paSxukxwgwPdsccauUMgKaur242M3zId6y+4oSQ6Yy1f2GUu37X72xf9?=
 =?us-ascii?Q?95+fwYIozgnFe21xkuwOMJ3+4TOzQAxjbW9zyhubER2uz9gdbi93fbp2+7D7?=
 =?us-ascii?Q?gyC3KBPVt8B6R787uAHtNIp+SXjq+p80rZrZRL3UCNXGyXBCN+esdyZ1n3QC?=
 =?us-ascii?Q?gdXRMqmTTuKk7j9zwR2bYxi47Z4rCAk0t5xuxjDstpqtcoZ4T3HhmsbNn88+?=
 =?us-ascii?Q?UQ3pMuZVNI6NkxaB59aILhpSGwJIaF1E0bR9Ac5bneve5ICxNJxvPr3HzBMi?=
 =?us-ascii?Q?NzKpG/3rjk81hMw+wdykRTF8R8ZO60/DaPUQgSPdiW/K1JOZ4TYu1pe4mCy0?=
 =?us-ascii?Q?LfIHu1mjQQYx4BTqoQEv7waYby8r1QpaKRcQqeLqAdFNG7n/fYmfNj4diOKS?=
 =?us-ascii?Q?ETB6X+0S7bGWxGT7cyCXk3HdJzU0G32HQUhgpNJRWKFIdQNMsEDd+sGpFtcw?=
 =?us-ascii?Q?sDFZiWbAmrKHZjWGxAidCrFHGQnkosks21Lv6ASujIYS68vlCd/1/AdU5Uzg?=
 =?us-ascii?Q?qtAtEthhlulEXMJI4PPrIZ1Vnx5TwMqdLEX9VArCHq6SONBFRUM5EgvLigNc?=
 =?us-ascii?Q?DJgjkgl+a4bJHuRCipAhRZz3kgiGiEDYDbBbTERK1trlc3HrOQWyi+Fqio7g?=
 =?us-ascii?Q?OCvzWgFpDUhb0zRwW/vpy7BWoEoURciG7IN9Oentv3I0rHbEGJk1Hlay8bts?=
 =?us-ascii?Q?bAwe+ldvYTst+NhJABnzID8vQEc/5pUo4jIv/NMofdIvMIolfMc39uQmyCUM?=
 =?us-ascii?Q?lpNuPbGtPqR6jL+0mWdQirOBBVRdSr31tbdyyoEcQO2JUvooSACyh7NS4w0i?=
 =?us-ascii?Q?xi8n0o8kL5WLB7OZJMTeNODENrnpPhrRYElpnJemVkYPlU9i91i3WVLMAivq?=
 =?us-ascii?Q?i2Pt4Y2GongiH+10SzEBcWPJBW/A8lUeIg2KgTSopjlWDGHx1AbRwpFAyAWx?=
 =?us-ascii?Q?i+UAi6nLbWOGPz2GErjiuufSYCdvMYcSkTiYJOVzXfzNCaXxBQVz3a4zsdWh?=
 =?us-ascii?Q?FH7QDoc44xQZKuSGaEPSyt+NMQSA3H2nzBi4CWOrlluMRsYiPsb09R7A7fLD?=
 =?us-ascii?Q?eXa3+wharXmp1Em3Ox70ugJcvkcbKOlheV6uJx8V71PP/ZVBzx+tw=3D=3D?=
X-Microsoft-Antispam-Message-Info: NzM9pso0IfuQwif4LFmJYPkx7mCQynhhj294QKTpWM7yACGa+IziswFBEFPIFCysbUjUzZOzxrVVc0/WcP4QZzfDyBoiPUKif4ZSQ5Ez/iLTB7Aza+JH1R2i1taOederXlhRCNV68NKw2x6npTg68hV/iPTqszHV4eKbkbSlQjHrMlv3uhMssKOODzsIKvbq
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:GN06OSwHYEA/mGVnrKpxkjjAzCTIztXfBqkOPonNQgNDYcoFBDorWQPhs6CcrdatTeG7ZUGJcM5wj7oxOXcFN9fsSSdNVL84T3fE3gMChSDUEJaTEi935t7ZSHazGdi5TTrS7oqMg9YeU4wa7PmRmIfJyaGcM9TsLjqrjGduTKmYhPbcns4fFbSqKkTZ50RygU9xUXescQKVeSc1+WC/KqYoRF7s7fBy4QErVum+sFDJihyqCWK3kD5/7pGK7Ph3OLVA/y+5cWXrXG805JyBVKhWOei3oVy6ySu7/lYpNrzA5aqFDLW8WQYNRy6EILLHH4oW4TTri9+MR/uV+XmLFciNPI26RU5CVreWHE18CihbI1XDIvhhefsHwInsvBSJt7tCMJ3yU2XiVFJnB80BOZHDd5vK7r6hBDhLE+W/IxyaJ7rWXCfMUI1LHK/RF1/HfO4P5Z2y+OMWBqZetvrMiQ==;5:nLpuQsE12IaXx+sSSVlHhoEU/1sVW7wIS2r9ID1NJJdNS7mEjMUZm1Cd2Vd/MaH5haO665nK3oGwTF6ehp10QngTwl8MUKqm/v9CKhJQS5jj5vgsFvcv6yv70wEOyTmcyNhgdikCCuiRZWZJH9yHaivh4BRSXnYw1amPcb6XGWo=;24:bb3b5z5TGJkknKFU4uiQH+zJ6ccN3sq3RMJqX4GtHtIQOoRu9cdGwAEalOAwSPOq/mJ08U4capxrfGZ5ZXDmnjpQh6qZEJMbezTNKPE+7KI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:FUQ71mwO2CPSFG9SgbLwkWdSFbsnTsdWSdyKOWAuKTfo6JECEx4uI8ZrEakau7qhP8pRkEeG0zHP3PcPkQdCrP1J+2AZSPhKzdilkVw4qTKF123Efx+zPs5PLGM22YjXUQ3rHP+R3yVjZnYoyyrXHZnT1yL0StZzp80v0ZW8mQ3f6H00bRfJ7TUr+s6On589Hem2DIAdN7GZA7TAMtUr1tQXpLv5iSoeAA9ri7cOuzX53bVuYseCgmp4ORExIvbg
X-MS-Office365-Filtering-Correlation-Id: 743a97c0-c138-4f9a-9140-08d5bbd256ed
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 08:43:57.2164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743a97c0-c138-4f9a-9140-08d5bbd256ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct enet clock CCGR register offset.

CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK

IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY,
no gate after this clock, its parent clock root has gate.
IMX7D_ENET1_REF_ROOT_DIV/IMX7D_ENET2_REF_ROOT_DIV supplies clocks
for enet IPG_CLK_RMII, no gate after the clock, its parent
clock root has gate.

IMX7D_PLL_ENET_MAIN_125M_CLK (anatop pll) supplies clock for
enet RGMII tx_clk.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c             | 11 ++++++-----
 include/dt-bindings/clock/imx7d-clock.h |  4 +++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 975a20d..485ab49 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -26,6 +26,8 @@ static u32 share_count_sai1;
 static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_nand;
+static u32 share_count_enet1;
+static u32 share_count_enet2;
 
 static const struct clk_div_table test_div_table[] = {
 	{ .val = 3, .div = 1, },
@@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk", "mipi_dsi_post_div", base + 0x4650, 0);
 	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk", "mipi_csi_post_div", base + 0x4640, 0);
 	clks[IMX7D_MIPI_DPHY_ROOT_CLK] = imx_clk_gate4("mipi_dphy_root_clk", "mipi_dphy_post_div", base + 0x4660, 0);
+	clks[IMX7D_ENET1_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET2_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base + 0x4710, 0, &share_count_enet2);
+	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div", base + 0x4710, 0, &share_count_enet2);
 	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk", "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk",  "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk", "sai2_post_div", base + 0x48d0, 0, &share_count_sai2);
@@ -812,11 +818,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk", "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk",  "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk", "spdif_post_div", base + 0x44d0, 0);
-	clks[IMX7D_ENET1_REF_ROOT_CLK] = imx_clk_gate4("enet1_ref_root_clk", "enet1_ref_post_div", base + 0x44e0, 0);
-	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0, 0);
-	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
-	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
-	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base + 0x4520, 0);
 	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk", "eim_post_div", base + 0x4160, 0);
 	clks[IMX7D_NAND_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
 	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nand);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index b2325d3e2..fef0647 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -455,5 +455,7 @@
 #define IMX7D_SNVS_CLK			442
 #define IMX7D_CAAM_CLK			443
 #define IMX7D_KPP_ROOT_CLK		444
-#define IMX7D_CLK_END			445
+#define IMX7D_ENET1_IPG_ROOT_CLK        445
+#define IMX7D_ENET2_IPG_ROOT_CLK        446
+#define IMX7D_CLK_END			447
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
2.7.4
