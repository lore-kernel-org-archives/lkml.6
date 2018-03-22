Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeCVM4z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:56:55 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:54012
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754672AbeCVMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-imx@nxp.com>, <anson.huang@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/4] arm: imx: Correct dram pll type
Date: Thu, 22 Mar 2018 11:55:27 +0200
Message-ID: <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131661969442434598;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(53936002)(26826003)(110136005)(86362001)(16586007)(2201001)(305945005)(316002)(97736004)(51416003)(59450400001)(2906002)(76176011)(68736007)(26005)(356003)(81156014)(8936002)(47776003)(956003)(106466001)(6666003)(5660300001)(2950100002)(104016004)(54906003)(105606002)(85426001)(50226002)(446003)(48376002)(36756003)(498600001)(4326008)(336012)(50466002)(81166006)(450100002)(8676002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3300;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC013;1:kpltfY2jE0kwLLW6wWXtVu4cbZSVaGOkYxm1B5aGQ29LS/ukTEo0kLRC+yt2+JorrYyao7FSQGpjA+j6sx2CKnp8XeipFAoxFt3oH6rRCFRqiRg9ZmrZlAMCojzGAOiV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9367c1f2-ad22-4ae7-ab6a-08d58ff4397d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB3300;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3300;3:VvHwlgWhwsoZ+ZjJJZ1knR1+nOoXTtqUYhaT09FVcRAomgdPranHsDt6NpQpygHMcnti9JE1G4mCbBBKJPKBPIMJsK+yqmmyGV0sCkt+T2HAiFQi1GxQfzVtYjC8RM/IHrpTuK6JZzkN6j9KgK/Mf5U1kCYQeZqDcdc4aWjH5v9R0DPSGHi2cMy57o2Zd5SlBGMYRy4j2xwSPPXkxQDJgcK3lKoA049HUz7DzfO173lSndIPA9q9XLFk5qVCW6xV5bJf3x3imjLKG6a6hrZuUKEgddC2JO2h016a1kkzQAI4zPwnFa0NY9q09nIdok7yA3/5WJ53ejJIayrcrF8ixThzpGfVqxrluhIz8ZHzNjY=;25:Mcnw21OJ+pah/r42x7OOjnrKU+V2G6gktvKIaouX3ZbDuEHm7Avqh+U3VbTIJgFb01BTNWXmlz/eAWR6zgX5INGfjUvjv4WIEh5vLsjM0lIEgLbENvioEEmMUWS4R9GoFdyDW1PZglIhuJTKE+G8KUw93yAFBTIjGBgLdQoeVHpuKWC0WCKfoPdVJZpTVp7XWV3CN+ay/vCxtopIj64MraCHeSfrbscwAEk29IKs/vucGL0gxPUAVGvgD0yCKA6yAEKRzVE/UjO8OmRsYmfZplUhiY5OgJ/dNC3xaMD030hoTlwk1K8QtyGYslXyMG1YmrzOyK16EpopoKHlldwp5g==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3300:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3300;31:vHMf+Lnx6tttXFHmc6qJYAp5HlOErdOqdzn+ZYoNjxndYvnb4tjfB1FabP0Znp/AsCqpHtT/X6afwTax74eHdjOYI5kLGAmNFnfNN7ZBltnF7Pky3/906REyP9IaBsNVP/yytI3aqRXW/Y551ZzBjtLBmfk13Pu6yyY2rkm8PmAmpFWLlo4NYaq100ufcugvMIBzMnXTREsFOUjWh93OvyMjCSvaMkBeLVKPb80A5Gc=;4:TVwtuXHQLkQ2JtDCOIyKWKhJTev8qIVUfWQ4ZpuW7t9BWSvb0WNfvdDIV4yywzgDrM9NIhX8/v3sbEhYyLfhWiuOCya3pczkozKc7T/3wBwEOzMQLiRHqMu5r9a5LZVWtPPI8J/YUv4BLYiLyRRNrCvm4SnzEUJ0KR2rF1zeq63a/dQjlfJwRNSXr4AZi9rUTzjdFz14eDyyeiS0iBzunYa92gNaQetONJYw/jbTaImTOn9lgZHxLZ4Rrno4xLE1oPj5K1bDIcn0wj5qiEPQcUSiCYb7WtSC76LZlUkv5gv/jXY7XDERmye16PByQLi/
X-Microsoft-Antispam-PRVS: <BN6PR03MB3300536F31BE918064CC1255F6A90@BN6PR03MB3300.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011);SRVR:BN6PR03MB3300;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB3300;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3300;23:582U0m8lm8CsMhJr4SMLESqS3Six271UBz8KuDqda?=
 =?us-ascii?Q?kY26moz2QDvAT/H9FC/7gyphefdotRsxQ5xLYL95hZ2+a3lvKy5LjUjbuVCs?=
 =?us-ascii?Q?B6P3zrToYm/lq6g7srD8/BKwzy4VHPXORQt3syDrJU1qareg6FYgRafnOCb/?=
 =?us-ascii?Q?P2xicOYPowxYs0HjKSibAl+4YE9K5IBvFjVQWBJmHC6ZrkoyumUWCT+rz6/i?=
 =?us-ascii?Q?KKcrcEzBbP0Xt4pJYPiVccRpXTFsvwKlbNNIeQxaPLPoSN1q4HJ40Ynz1IH2?=
 =?us-ascii?Q?bg3B71qow8SxnrprWwoyxw74+chVz8VhN4fVI18d7j9IMYMDSQMJ7FSG1mB9?=
 =?us-ascii?Q?sEnE7LdnPB0l4IiUrzNdGP31VhFVnMmgEvlsEa+P9JcNRIA16kfnJZpoQQab?=
 =?us-ascii?Q?Up/5mcRILKiScE4OW8GwnqOxjAYe06CBygsllqC0ACPVuwZMEuXPQf+7476e?=
 =?us-ascii?Q?rlkpkL2/nW5VPnEHb1CfT52yuVuSea3VQhhJsakDUwMHq6YbUCWkWa9b9rl+?=
 =?us-ascii?Q?GgrAM80r5mjWBBYdJs1VYkVSkE+PRSk+Iw5gDvGrxs3w2ogoZSv1nYtCVIHv?=
 =?us-ascii?Q?dhB9wtX2q49n7UMQmaQtCpcJ6qC4GZQlK7LPsCBrTY8Xazs5k//AQ8Mk/3Kq?=
 =?us-ascii?Q?UjVsoeC3CBgkUs8fQukEEufrv8VLbPdSAg6mUPf0RQ+bzY2cynjNVNNRX+bM?=
 =?us-ascii?Q?ADce7iytCXbFvOJRble8ncfcDU/lf/i3DXC2TWWBdehfFd5AjnH0czDFMhtL?=
 =?us-ascii?Q?xIqfFw2LsmE4jiVrcUMUYn89JLy7VwpW3olb6C7WMNE5Ex14tG6Bz/+vAIpS?=
 =?us-ascii?Q?JR4fimCVF8iTTB3iCf2zqQWtSUQu5q2HlexbgiOBZDTN10MMvndB/zMePNc+?=
 =?us-ascii?Q?Tnyv03QbJ+WsW04Ehb0HFoxWIXL0QS8qs8ufpQ9pfRCKWp32imkXU6/MErRU?=
 =?us-ascii?Q?2DJzY3y8p7lNC+TsYR4W+1e9+6AxzKCMDBex4x6cP9Y3OGVf3XIy/0sIWKAO?=
 =?us-ascii?Q?RXv6JMHvVDWXpqyAaIjLhZS2JdHEB2ZQLsO50xvzz2kVpvIitIbskZTn/48H?=
 =?us-ascii?Q?QoO6zmU78ckPYrr9Wx2IzfQWP4u8sdcGHVEnO7AAP+/C39cE8IVl4eAZv/3p?=
 =?us-ascii?Q?v/sucHLd1SrEC1RaQhSxjAmxqt29iBI+86I9PyO3FH3ps6eGJxLzwprErMKR?=
 =?us-ascii?Q?wVHzhXYx9nQ0Bw=3D?=
X-Microsoft-Antispam-Message-Info: /S1Snd6MNLCRaX4wq17SwU9ZaUffF+6cEsXeCwqT5aoRYiNqOBbRBZAearhahUFx7Avxo2rP73pl5p3PorBQxS1ZpAO3b0VvtTlO1d9dSSOb4BunZFioYo5+w1bh8uPa1GODM5XnEQK/b7UB8Yx7KCiNJznx/DYNZjug4HQgxg/MdTCSrh1T0J+AhwHsgLr/
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3300;6:JDCDHfpvJJJqZ33lsNCOe3mFRPiATmFVR2XDNaHnUObnOMDj7Zuh7lFuzhsNlWuarTO67aR4PoZR+/tMDUKurHNnZZnMMpbzajmhQVfTF6LYF5S0X4GU4EcLXuSFtY0GqusNMfnjiN97/UlL2E8Y5zlvuT6Fmqf1yYKweMziUh7C8RSWVvNyfDILptlIeW2HbtUKAdjrScA6gm7kD87EVBUVw0K8Vl9JWkOfQf1H5FmXPVvALcVfWvu0wPj0KIHIZYzO+38TYWdteMUX4vK1x7uq1H+e9H4w7YtWasDHSCtQ/PFfZ61IbRh1V0Kl4pWC7rz3k4msOCB4XZCT6g335LXtDAPdDe2vV49rSaY80H8kacrJewGf0FY7TiaI0A6whlWX9XJz6eEy9wjRPhnBuiQkFEDsPEfk1N34sOJMTbgvh0AUDdxxsgZRmpbXDwhVZS5kpUUo0+MMbQk0/ZAzMw==;5:bOXKl/su8LFhSj3cl63d4WMB2+aLvLeUNa73lSVWWHSnDI3BPpB60x+vnG1+papMIf1v10AY/Mtl6cBKDNDKdFX9a7KkC4p5qitX0H3tYDfHmSV8i0i2WSs7GSrMz7WdGhj1WrFKmy2g15fvxLf/bFzhOId/bVm/fpxwUbyy/ME=;24:l61YA7JKT/CNQYBJhp2tkC7E5fKq6SVSBFyV36+Rq0j+nZ8CpfFqJp8YoMV6SaQbdrpEZopPsrz97txEnqeX+gLMxt52Yihub8xk7VCdHqU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3300;7:Obw9JReWQBgO8vU7VDqf1HV4TBNFT0hN+xndbcCR245NgTRowl97ZTmdfJ/YD+2j0oRKkbLnkGELm6Z2F5EmNfsBkiTvRjBEzHZObcFnazhX5byqm7nqApi2nSGdlP+XLTpo6S2Y1+3QU0RU3CTQ9ZNzMqH+UK7tU9DGdTQl6vOw5X2qDviKmTSlJZwlL+8APYQkQ/bW1XkJglI3ZrhklSSe7wTsNKHedjE6AXxSJxdAsllbhdrlE3AMIpb0Vo8Q
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:55:43.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9367c1f2-ad22-4ae7-ab6a-08d58ff4397d
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3300
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

DRAM PLL is a audio/video type PLL, need to correct it to get correct ops of
PLL.

There is a test_div placed before DRAM PLL's gate, so add this test div clk.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 97 ++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 80dc211..d786f98 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -51,20 +51,20 @@ static const char *arm_a7_sel[] = { "osc", "pll_arm_main_clk",
 
 static const char *arm_m4_sel[] = { "osc", "pll_sys_main_240m_clk",
 	"pll_enet_250m_clk", "pll_sys_pfd2_270m_clk",
-	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *axi_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk", "pll_sys_pfd5_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_sys_pfd7_clk", };
+	"pll_audio_post_div", "pll_video_post_div", "pll_sys_pfd7_clk", };
 
 static const char *disp_axi_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk", "pll_sys_pfd6_clk",
-	"pll_sys_pfd7_clk", "pll_audio_post_div", "pll_video_main_clk", };
+	"pll_sys_pfd7_clk", "pll_audio_post_div", "pll_video_post_div", };
 
 static const char *enet_axi_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk",
-	"pll_sys_main_240m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_240m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_sys_pfd4_clk", };
 
 static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
@@ -75,7 +75,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
 	"pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_post_div",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *dram_phym_sel[] = { "pll_dram_main_clk",
 	"dram_phym_alt_clk", };
@@ -86,7 +86,7 @@ static const char *dram_sel[] = { "pll_dram_main_clk",
 static const char *dram_phym_alt_sel[] = { "osc", "pll_dram_533m_clk",
 	"pll_sys_main_clk", "pll_enet_500m_clk",
 	"pll_usb_main_clk", "pll_sys_pfd7_clk", "pll_audio_post_div",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *dram_alt_sel[] = { "osc", "pll_dram_533m_clk",
 	"pll_sys_main_clk", "pll_enet_500m_clk",
@@ -108,62 +108,62 @@ static const char *pcie_phy_sel[] = { "osc", "pll_enet_100m_clk",
 
 static const char *epdc_pixel_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_sys_main_clk", "pll_sys_pfd5_clk",
-	"pll_sys_pfd6_clk", "pll_sys_pfd7_clk", "pll_video_main_clk", };
+	"pll_sys_pfd6_clk", "pll_sys_pfd7_clk", "pll_video_post_div", };
 
 static const char *lcdif_pixel_sel[] = { "osc", "pll_sys_pfd5_clk",
 	"pll_dram_533m_clk", "ext_clk_3", "pll_sys_pfd4_clk",
-	"pll_sys_pfd2_270m_clk", "pll_video_main_clk",
+	"pll_sys_pfd2_270m_clk", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *mipi_dsi_sel[] = { "osc", "pll_sys_pfd5_clk",
 	"pll_sys_pfd3_clk", "pll_sys_main_clk", "pll_sys_pfd0_196m_clk",
-	"pll_dram_533m_clk", "pll_video_main_clk", "pll_audio_post_div", };
+	"pll_dram_533m_clk", "pll_video_post_div", "pll_audio_post_div", };
 
 static const char *mipi_csi_sel[] = { "osc", "pll_sys_pfd4_clk",
 	"pll_sys_pfd3_clk", "pll_sys_main_clk", "pll_sys_pfd0_196m_clk",
-	"pll_dram_533m_clk", "pll_video_main_clk", "pll_audio_post_div", };
+	"pll_dram_533m_clk", "pll_video_post_div", "pll_audio_post_div", };
 
 static const char *mipi_dphy_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd5_clk", "ref_1m_clk", "ext_clk_2",
-	"pll_video_main_clk", "ext_clk_3", };
+	"pll_video_post_div", "ext_clk_3", };
 
 static const char *sai1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_2", };
 
 static const char *sai2_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_2", };
 
 static const char *sai3_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_3", };
 
 static const char *spdif_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_3_clk", };
 
 static const char *enet1_ref_sel[] = { "osc", "pll_enet_125m_clk",
 	"pll_enet_50m_clk", "pll_enet_25m_clk",
-	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"ext_clk_4", };
 
 static const char *enet1_time_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_audio_post_div", "ext_clk_1", "ext_clk_2", "ext_clk_3",
-	"ext_clk_4", "pll_video_main_clk", };
+	"ext_clk_4", "pll_video_post_div", };
 
 static const char *enet2_ref_sel[] = { "osc", "pll_enet_125m_clk",
 	"pll_enet_50m_clk", "pll_enet_25m_clk",
-	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"ext_clk_4", };
 
 static const char *enet2_time_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_audio_post_div", "ext_clk_1", "ext_clk_2", "ext_clk_3",
-	"ext_clk_4", "pll_video_main_clk", };
+	"ext_clk_4", "pll_video_post_div", };
 
 static const char *enet_phy_ref_sel[] = { "osc", "pll_enet_25m_clk",
 	"pll_enet_50m_clk", "pll_enet_125m_clk",
-	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_sys_pfd3_clk", };
 
 static const char *eim_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
@@ -174,7 +174,7 @@ static const char *eim_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 static const char *nand_sel[] = { "osc", "pll_sys_main_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk", "pll_sys_pfd3_clk",
 	"pll_enet_500m_clk", "pll_enet_250m_clk",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *qspi_sel[] = { "osc", "pll_sys_pfd4_clk",
 	"pll_dram_533m_clk", "pll_enet_500m_clk", "pll_sys_pfd3_clk",
@@ -204,22 +204,22 @@ static const char *can2_sel[] = { "osc", "pll_sys_main_120m_clk",
 
 static const char *i2c1_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c2_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c3_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c4_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *uart1_sel[] = { "osc", "pll_sys_main_240m_clk",
@@ -279,27 +279,27 @@ static const char *ecspi4_sel[] = { "osc", "pll_sys_main_240m_clk",
 
 static const char *pwm1_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_1", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_1", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm2_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_1", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_1", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm3_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_2", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_2", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm4_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_2", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_2", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *flextimer1_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_3", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_3", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *flextimer2_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_3", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_3", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *sim1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
@@ -308,23 +308,23 @@ static const char *sim1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 
 static const char *sim2_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_usb_main_clk", "pll_video_main_clk", "pll_enet_125m_clk",
+	"pll_usb_main_clk", "pll_video_post_div", "pll_enet_125m_clk",
 	"pll_sys_pfd7_clk", };
 
 static const char *gpt1_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_1", };
 
 static const char *gpt2_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_2", };
 
 static const char *gpt3_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_3", };
 
 static const char *gpt4_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_4", };
 
 static const char *trace_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
@@ -339,12 +339,12 @@ static const char *wdog_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 
 static const char *csi_mclk_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *audio_mclk_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *wrclk_sel[] = { "osc", "pll_enet_40m_clk",
@@ -358,13 +358,13 @@ static const char *clko1_sel[] = { "osc", "pll_sys_main_clk",
 
 static const char *clko2_sel[] = { "osc", "pll_sys_main_240m_clk",
 	"pll_sys_pfd0_392m_clk", "pll_sys_pfd1_166m_clk", "pll_sys_pfd4_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "ckil", };
+	"pll_audio_post_div", "pll_video_post_div", "ckil", };
 
 static const char *lvds1_sel[] = { "pll_arm_main_clk",
 	"pll_sys_main_clk", "pll_sys_pfd0_392m_clk", "pll_sys_pfd1_332m_clk",
 	"pll_sys_pfd2_270m_clk", "pll_sys_pfd3_clk", "pll_sys_pfd4_clk",
 	"pll_sys_pfd5_clk", "pll_sys_pfd6_clk", "pll_sys_pfd7_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_enet_500m_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_enet_500m_clk",
 	"pll_enet_250m_clk", "pll_enet_125m_clk", "pll_enet_100m_clk",
 	"pll_enet_50m_clk", "pll_enet_40m_clk", "pll_enet_25m_clk",
 	"pll_dram_main_clk", };
@@ -441,15 +441,22 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
 
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
-	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
+	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
-	clks[IMX7D_PLL_AUDIO_MAIN_CLK] = imx_clk_gate("pll_audio_main_clk", "pll_audio_main_bypass", base + 0xf0, 13);
-	clks[IMX7D_PLL_VIDEO_MAIN_CLK] = imx_clk_gate("pll_video_main_clk", "pll_video_main_bypass", base + 0x130, 13);
+	clks[IMX7D_PLL_AUDIO_MAIN_CLK] = imx_clk_gate("pll_audio_main_clk", "pll_audio_test_div", base + 0xf0, 13);
+	clks[IMX7D_PLL_VIDEO_MAIN_CLK] = imx_clk_gate("pll_video_main_clk", "pll_video_test_div", base + 0x130, 13);
 
-	clks[IMX7D_PLL_AUDIO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_audio_test_div", "pll_audio_main_clk",
+	clks[IMX7D_PLL_DRAM_TEST_DIV]  = clk_register_divider_table(NULL, "pll_dram_test_div", "pll_dram_main_bypass",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 21, 2, 0, test_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_AUDIO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_audio_test_div", "pll_audio_main_bypass",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 19, 2, 0, test_div_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_AUDIO_POST_DIV] = clk_register_divider_table(NULL, "pll_audio_post_div", "pll_audio_test_div",
+	clks[IMX7D_PLL_AUDIO_POST_DIV] = clk_register_divider_table(NULL, "pll_audio_post_div", "pll_audio_main_clk",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 22, 2, 0, post_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_VIDEO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_video_test_div", "pll_video_main_bypass",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 19, 2, 0, test_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_VIDEO_POST_DIV] = clk_register_divider_table(NULL, "pll_video_post_div", "pll_video_main_clk",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 22, 2, 0, post_div_table, &imx_ccm_lock);
+
 
 	clks[IMX7D_PLL_SYS_PFD0_392M_CLK] = imx_clk_pfd("pll_sys_pfd0_392m_clk", "pll_sys_main_clk", base + 0xc0, 0);
 	clks[IMX7D_PLL_SYS_PFD1_332M_CLK] = imx_clk_pfd("pll_sys_pfd1_332m_clk", "pll_sys_main_clk", base + 0xc0, 1);
-- 
2.7.4
