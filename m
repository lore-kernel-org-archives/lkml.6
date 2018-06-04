Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeFDBLS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:11:18 -0400
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:7419
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751393AbeFDBKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:10:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] clk: imx6sx: remove clks_init_on array
Date: Mon,  4 Jun 2018 09:06:45 +0800
Message-Id: <1528074406-11735-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:SeTpG3e1qthtN0jx9y5SpEAJsgoUITkcf0IvnsQb9Rk+YCs3xz+xo/5UK+Sn4hbso+Mr7i28VWHA5nb8zKQjyfMytQVRKrQ32PDjUcPzMDSwGXhgCRYIoAibrDHoTQDpPZB0HrXHCs2b/VwoRYLyHqIWld9tt/fVKZ8UV5Otr75xfiuqZahW7rOMAHEQjYCrpWH5YmOxlNVUYEqWoi1X2BAd3nzjKpqUty6A/W/4HLlQ0L1B6a07ZlRqsjgZ9yz5;25:1xZpqrjGrmx/u+uj+pRdGnfjli4bM9+JdlzOYnV8kMwkxgUllTjBfIMXCcqq7kAcjJ0wr3Dux/QFFc9wQsjcpzprgu3Hz14G27imWIvH66NWIPnEtgHUEG4wGmZ2cBWp9C+7N8FcydHVFIyhxeXWXATWQ7WrUkC/2zC/H8BZJP4TzCV9ScP3Esjl6t317bV7uvAVrhZFQ5tIKGPKewo5BlfcLbx3u1ZSNNG1bfkYB5o9qT9WPUsj9j6eC6DhTrbrMjn7EHMLIWXdZAfKGQ0OkvJwe7jzAXNI2fOE4dZJ4l8dWKPgUyOmnasbv9DtOvU/5Nc+zbJK3J2xNX1R13S2Yg==;31:noVVfOE7ONMO4Q24g3AcR/g3vVnUap8jMEPfd6uA+5DBCEue7JMVwmXcbAD9rT4didLedxFmTqN4l8M+VqSE4oJDP8Fb1vBEuoKiraVsWoZ45TZNGwHK/SIh/wj2ijJLx5f1YRzNiiv9UCSvMgzCigIVtZOmzpfcwCb9JFMmOKH4Vym2ZDBa9ldKRMKBLLqiHLtxuXaH+z0KeQUnHZsjDm35WsicP1HNg8Gw9mCZUZI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:8S894QLL5rKBf/c3EaSsJ0dT5CAx8OhagLFl7yg6acIVWnbX5IALcMQd9EwwexqSDSFtZzm+qy51gjm5vCbrNFPUqACycC4qMoyS/T3Y57kkH2vcqquUypRmW1yH/+UIEUqh5hFLUGukxYfDSGnHyECquRrESQetPZIR1kGXORDGx1zcfwta/n35R5P6rq1IPxNJOEJ+Ld44CWgJCZUFNTU12OP4i9lZkekDyLkraHx7upxEQu45EThkEA//b/VanmrlCKZKfZqEbUMTeJikJ/TmzaHT51cGe4RBB8L8QiG/fSkGZxtZdZB0hfjz+VaDzKGOYsll9ADyGoXU51AcWOuTcijlOmAnTQ7aYy0ACvvHQckQ3aMml8lR4V3FB0xS9hiZptzpB2sHphYygqLfVYufFnuVfVis5z/X7aiITOmZJpZK5jpAMg6AIjZ1Yo4RnUByQUPiOt8844Jhmhv1TppZtFv/QcGXH+cj0pNJ/IGgt6YCGm/9HC4S4zaHX2Vu;4:7Mthjptp5DvjArspGerbWTmjfn93HtLq5n00YfefXXYJJ/Mq0QqU/M9dHWZeJO79Y5UhgrCAxPl77MpxIwcMfvrhvJFsHhkF0vDFjC7k2zzczS3QMo6Ga41dWaen3asoSQOvzHWdzc+UHm1cmyvyyeVWz8qgCFKIzlawmtqe+SZZAlrOCoEU+JwaRbUWlB5l5MTwkXngIhiHDx8xrg7rHKJwYGR0qcOqVKh1Yn0wF3DoyqKbjUsLdZoeOlKCto1w7OqbAy+vinLGJSlD/yyuKQHWwxfOUNlqNJ7C5GysWO90vvXyK/D1b2/aFZdfAoRk
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323C76944C0C3BE6719A625F5670@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(53936002)(105586002)(305945005)(97736004)(86362001)(106356001)(2906002)(478600001)(446003)(8676002)(66066001)(8936002)(7736002)(48376002)(51416003)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(81166006)(52116002)(16526019)(11346002)(81156014)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(316002)(386003)(6506007)(25786009)(6512007)(50226002)(4326008)(5660300001)(68736007)(26005)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:zSKVJHILPeY00Bb6Dbcn/pPh4Tf4Pxat3vfOhCxyK?=
 =?us-ascii?Q?4vwgAMX3LhFGt9Rnx1vYDVBz2Vf87pXQDfIqWkWs9+9CNg0VzgdPR8LkiGYF?=
 =?us-ascii?Q?j8by45LWnW33pbcX3QdaeE0OAtJ3N436cKmACeoPmMZkrz1Z+F6T8f2KGIy4?=
 =?us-ascii?Q?6Dywhwx0Z15dW7R5VlIo8axSUsdbhQ8yT7pSMQfx79IOInuhOZ5KlF0KG1ma?=
 =?us-ascii?Q?QfaO8Uz5RRtx0rD2bfzMPLs2WDO82ZAvc2FCrO81VF0CpFLkUXypkvpCvhx5?=
 =?us-ascii?Q?a8/8PkpJczKLY0nQoLLHKSOpFQnWU9wDs4HsAsLuertpLXtgxyqI9i3upPPy?=
 =?us-ascii?Q?Jmxm7pu6FW3GdFxlqbjXq2jJ7ruCvuqTVrvVUMb7QKeDOswPtEABftGv2HgR?=
 =?us-ascii?Q?bXTlgdHdPk6e0NRJC4APp5LOYUr+pyqQ8U9ftAG0hIYhGbOmYpLoRdFejss5?=
 =?us-ascii?Q?GyIbmm9h2Mu/G4mBhUBjaBc/CzzbAio0JfkhFe8F68UlUEgEBuwMp8F2Cs1E?=
 =?us-ascii?Q?vz2hvzCZjE168NsInuBvdwLet/yzHbrG1dt32Nw1tw+ErjfWdDvoXFJcA0fz?=
 =?us-ascii?Q?qcAM/iGpds7qmR8Uror39r6vbsjOuduIwZgvfM2KPX0Tjn3LFVD1N6WYgKlM?=
 =?us-ascii?Q?M0g1ZoXWzEce+mpI1kXe8DgQqJUJexv9OpPxxEd10x6ut2hiIgDzDFE/Cn+b?=
 =?us-ascii?Q?hDysi3TdwXXjZdyDajrS9FAOSqCCKEnxeQFKGdCsb7y7yyM+437PHsDZdlrw?=
 =?us-ascii?Q?8/NZukD0wZefab3f2brDLZVWK6s5683tkFhrJR3eJ0QWydCt1t4aZIyD0r7o?=
 =?us-ascii?Q?pneAM2LO9gWJUe+zuA+bfS5W7Q5/DJJuFEG9Q1qyx+aCmLYcdTgU7bJe0eBZ?=
 =?us-ascii?Q?Z0NLOb+bpvkMYTfcapW43WU1TLkiaGYQdiwbJYz0XNpF4dJqZ2mYPIiKg0Cz?=
 =?us-ascii?Q?KWPNUohAT3uhmMMhbpriVgAXfzgR2OHD2OaE3IxCZaAIEsSDAO18MMdi5Wjc?=
 =?us-ascii?Q?Icvmz2hlT3BXK28mH6k/MXGEMPytHoupQFHCu88XFiOclJtb7aXufhca2OIp?=
 =?us-ascii?Q?G8Up7vGrlwqSYGCfd2ZDiWe1VuMv+2EcUG7Z1hhFavI4i1hy0OKIzmaQTCaa?=
 =?us-ascii?Q?zSOlaz8OkT7JY41rQzdxLByO8nPgbro2xN77oG5xlNfUFchhEWfwj/VNnlmL?=
 =?us-ascii?Q?c6Co/PAQOpneMU=3D?=
X-Microsoft-Antispam-Message-Info: 4yRLDZs/4SqtRx7U1I2I+NKqXtzLwq666Hbw3uRc7UrZsLFDMscEnmTMlO9nttfg1VNHNVCbiyG048OCZqBwbt0fhr6T2q3z/MCyT5idovRXWx6cvUf+pmwTXMd4pQQUPWCBUyoyXpRGAAL5UEBLfLaEuiWIBEgQz0INJzEaY3O4OeZ0cgQ67F3Mj94V3yZK
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:Bxq9cuB+QfBv+UbFxcVXRWS/OxHKK0vjhQ8hnsUxD7ahNZPAIE+JFXguu7tgdsLogQq4F4mdOIYWFw7dgcxnEHU/fpqUcV5svQYJA2cLJkYcoUV/GyeoE4WsQVe/C3CIRuGMieKxlIvVsl0KvnPjTN2oZJLCQ14/v0Ps7uVA/LuP7tPOapDLsrdTBTP13RuQK4qRlM6PPQYXRuFdIJH6wBOfgdcoDiNq0wumLltBQZ0NyiTrhMLmKJHfWWu/7YLfU1qV+vZhWlRaujRmPPKBP1tb3JPTQ5I4URgCfmjfQlv5HKof23EGQ5Em2M6RDzZij8wNpq486iQM4Au7EjEyQYlBx8/b4294qnUqovidIZghdQkdH3wh6SqavLQy3EzDyWViWEV0d7w8qP4mzhTEPYyayai1F1bFiZvgo/vF8ddKc6wTDRlRSCGvaK2RhWQdufPb7z4MBmicjQWn3aTQow==;5:Zq2ie5wsx0oVyAhHibXgsEtikft4oA528tKfoUeki3EoF4VdhhXjD9uSkN7JpiH922k5UZCOZJxx8Ss37CfP/J0A3fvvZ6S8ikpTPC8aJMA4g/fTUe96ELIELgfKQLy/c4zGG6by9f4TCb6Z4ApkKvQmHQ17TJ6jrH5hschMFz8=;24:U0YhtVehC/Wr34pTJ2+ObAmceAz0NLC9pdmfTLyXWvAItFCVHo+zzYDAUxFnyiONI6/SYB1JRtryRbVFd2jtLuK0ilsOWqVDVYRfoUIZDNY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:70/AE6PCKsrWiuYh2/JcsezoGoErC8kqNynzO+XQ/QP9+zFgr+kmdDpePsSb23T9Sxtb4BJX/NABbvMrXZ0ocRGs4EzL3o8UL9LwA56PNo/6wUizNixkgpy11IkdAlW1vGbsFvYCaF55mxgJCRagtqi59NgIAtQnGlXVJST9viZ6WGNdZnWL+AYECGdqEQQaFQ74n8lvfhQJpb7GwgqbZOMB3P9ZUv5U33c6mQf6B+Or3rKBke8pcPL7vOW535IW
X-MS-Office365-Filtering-Correlation-Id: 5f1c0576-7ef7-48e8-f322-08d5c9b7fa36
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 01:10:32.5801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1c0576-7ef7-48e8-f322-08d5c9b7fa36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

ARM clock is busy divider type which has the
CLK_IS_CRITICAL flag set by default when registered.

IPG clock has no clock gate and its parent AHB clock
is busy divider type, so no need to add CLK_IS_CRITICAL
flag for IPG clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	improve commit log to explain why no need to add CLK_IS_CRITICAL flag for ARM and IPG clocks.
 drivers/clk/imx/clk-imx6sx.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 10c771b..aed4391 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -92,14 +92,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
 static struct clk *clks[IMX6SX_CLK_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static int const clks_init_on[] __initconst = {
-	IMX6SX_CLK_AIPS_TZ1, IMX6SX_CLK_AIPS_TZ2, IMX6SX_CLK_AIPS_TZ3,
-	IMX6SX_CLK_IPMUX1, IMX6SX_CLK_IPMUX2, IMX6SX_CLK_IPMUX3,
-	IMX6SX_CLK_WAKEUP, IMX6SX_CLK_MMDC_P0_FAST, IMX6SX_CLK_MMDC_P0_IPG,
-	IMX6SX_CLK_ROM, IMX6SX_CLK_ARM, IMX6SX_CLK_IPG, IMX6SX_CLK_OCRAM,
-	IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_TZASC1,
-};
-
 static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
@@ -142,7 +134,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clks[IMX6SX_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 
@@ -332,7 +323,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_QSPI1_PODF]         = imx_clk_divider("qspi1_podf",     "qspi1_sel",         base + 0x1c, 26,   3);
 	clks[IMX6SX_CLK_EIM_SLOW_PODF]      = imx_clk_divider("eim_slow_podf",  "eim_slow_sel",      base + 0x1c, 23,   3);
 	clks[IMX6SX_CLK_LCDIF2_PODF]        = imx_clk_divider("lcdif2_podf",    "lcdif2_pred",       base + 0x1c, 20,   3);
-	clks[IMX6SX_CLK_PERCLK]             = imx_clk_divider("perclk",         "perclk_sel",        base + 0x1c, 0,    6);
+	clks[IMX6SX_CLK_PERCLK]             = imx_clk_divider_flags("perclk", "perclk_sel", base + 0x1c, 0, 6, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_VID_PODF]           = imx_clk_divider("vid_podf",       "vid_sel",           base + 0x20, 24,   2);
 	clks[IMX6SX_CLK_CAN_PODF]           = imx_clk_divider("can_podf",       "can_sel",           base + 0x20, 2,    6);
 	clks[IMX6SX_CLK_USDHC4_PODF]        = imx_clk_divider("usdhc4_podf",    "usdhc4_sel",        base + 0x24, 22,   3);
@@ -380,8 +371,8 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/*                                            name             parent_name          reg         shift */
 	/* CCGR0 */
-	clks[IMX6SX_CLK_AIPS_TZ1]     = imx_clk_gate2("aips_tz1",      "ahb",               base + 0x68, 0);
-	clks[IMX6SX_CLK_AIPS_TZ2]     = imx_clk_gate2("aips_tz2",      "ahb",               base + 0x68, 2);
+	clks[IMX6SX_CLK_AIPS_TZ1]     = imx_clk_gate2_flags("aips_tz1", "ahb", base + 0x68, 0, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_AIPS_TZ2]     = imx_clk_gate2_flags("aips_tz2", "ahb", base + 0x68, 2, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_APBH_DMA]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
 	clks[IMX6SX_CLK_ASRC_MEM]     = imx_clk_gate2_shared("asrc_mem", "ahb",             base + 0x68, 6, &share_count_asrc);
 	clks[IMX6SX_CLK_ASRC_IPG]     = imx_clk_gate2_shared("asrc_ipg", "ahb",             base + 0x68, 6, &share_count_asrc);
@@ -394,7 +385,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_CAN2_SERIAL]  = imx_clk_gate2("can2_serial",   "can_podf",          base + 0x68, 20);
 	clks[IMX6SX_CLK_DCIC1]        = imx_clk_gate2("dcic1",         "display_podf",      base + 0x68, 24);
 	clks[IMX6SX_CLK_DCIC2]        = imx_clk_gate2("dcic2",         "display_podf",      base + 0x68, 26);
-	clks[IMX6SX_CLK_AIPS_TZ3]     = imx_clk_gate2("aips_tz3",      "ahb",               base + 0x68, 30);
+	clks[IMX6SX_CLK_AIPS_TZ3]     = imx_clk_gate2_flags("aips_tz3", "ahb", base + 0x68, 30, CLK_IS_CRITICAL);
 
 	/* CCGR1 */
 	clks[IMX6SX_CLK_ECSPI1]       = imx_clk_gate2("ecspi1",        "ecspi_podf",        base + 0x6c, 0);
@@ -407,7 +398,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal", "esai_podf",     base + 0x6c, 16, &share_count_esai);
 	clks[IMX6SX_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
 	clks[IMX6SX_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem",   "ahb",           base + 0x6c, 16, &share_count_esai);
-	clks[IMX6SX_CLK_WAKEUP]       = imx_clk_gate2("wakeup",        "ipg",               base + 0x6c, 18);
+	clks[IMX6SX_CLK_WAKEUP]       = imx_clk_gate2_flags("wakeup", "ipg", base + 0x6c, 18, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_GPT_BUS]      = imx_clk_gate2("gpt_bus",       "perclk",            base + 0x6c, 20);
 	clks[IMX6SX_CLK_GPT_SERIAL]   = imx_clk_gate2("gpt_serial",    "perclk",            base + 0x6c, 22);
 	clks[IMX6SX_CLK_GPU]          = imx_clk_gate2("gpu",           "gpu_core_podf",     base + 0x6c, 26);
@@ -420,10 +411,10 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_I2C3]         = imx_clk_gate2("i2c3",          "perclk",            base + 0x70, 10);
 	clks[IMX6SX_CLK_OCOTP]        = imx_clk_gate2("ocotp",         "ipg",               base + 0x70, 12);
 	clks[IMX6SX_CLK_IOMUXC]       = imx_clk_gate2("iomuxc",        "lcdif1_podf",       base + 0x70, 14);
-	clks[IMX6SX_CLK_IPMUX1]       = imx_clk_gate2("ipmux1",        "ahb",               base + 0x70, 16);
-	clks[IMX6SX_CLK_IPMUX2]       = imx_clk_gate2("ipmux2",        "ahb",               base + 0x70, 18);
-	clks[IMX6SX_CLK_IPMUX3]       = imx_clk_gate2("ipmux3",        "ahb",               base + 0x70, 20);
-	clks[IMX6SX_CLK_TZASC1]       = imx_clk_gate2("tzasc1",        "mmdc_podf",         base + 0x70, 22);
+	clks[IMX6SX_CLK_IPMUX1]       = imx_clk_gate2_flags("ipmux1", "ahb", base + 0x70, 16, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_IPMUX2]       = imx_clk_gate2_flags("ipmux2", "ahb", base + 0x70, 18, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_IPMUX3]       = imx_clk_gate2_flags("ipmux3", "ahb", base + 0x70, 20, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_TZASC1]       = imx_clk_gate2_flags("tzasc1", "mmdc_podf", base + 0x70, 22, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_LCDIF_APB]    = imx_clk_gate2("lcdif_apb",     "display_podf",      base + 0x70, 28);
 	clks[IMX6SX_CLK_PXP_AXI]      = imx_clk_gate2("pxp_axi",       "display_podf",      base + 0x70, 30);
 
@@ -437,15 +428,15 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_LDB_DI0]      = imx_clk_gate2("ldb_di0",       "ldb_di0_div_sel",   base + 0x74, 12);
 	clks[IMX6SX_CLK_QSPI1]        = imx_clk_gate2("qspi1",         "qspi1_podf",        base + 0x74, 14);
 	clks[IMX6SX_CLK_MLB]          = imx_clk_gate2("mlb",           "ahb",               base + 0x74, 18);
-	clks[IMX6SX_CLK_MMDC_P0_FAST] = imx_clk_gate2("mmdc_p0_fast",  "mmdc_podf",         base + 0x74, 20);
-	clks[IMX6SX_CLK_MMDC_P0_IPG]  = imx_clk_gate2("mmdc_p0_ipg",   "ipg",               base + 0x74, 24);
-	clks[IMX6SX_CLK_OCRAM]        = imx_clk_gate2("ocram",         "ocram_podf",        base + 0x74, 28);
+	clks[IMX6SX_CLK_MMDC_P0_FAST] = imx_clk_gate2_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg", "ipg", base + 0x74, 24, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_OCRAM]        = imx_clk_gate2_flags("ocram", "ocram_podf", base + 0x74, 28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
 	clks[IMX6SX_CLK_PCIE_AXI]     = imx_clk_gate2("pcie_axi",      "display_podf",      base + 0x78, 0);
 	clks[IMX6SX_CLK_QSPI2]        = imx_clk_gate2("qspi2",         "qspi2_podf",        base + 0x78, 10);
 	clks[IMX6SX_CLK_PER1_BCH]     = imx_clk_gate2("per1_bch",      "usdhc3",            base + 0x78, 12);
-	clks[IMX6SX_CLK_PER2_MAIN]    = imx_clk_gate2("per2_main",     "ahb",               base + 0x78, 14);
+	clks[IMX6SX_CLK_PER2_MAIN]    = imx_clk_gate2_flags("per2_main", "ahb", base + 0x78, 14, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_PWM1]         = imx_clk_gate2("pwm1",          "perclk",            base + 0x78, 16);
 	clks[IMX6SX_CLK_PWM2]         = imx_clk_gate2("pwm2",          "perclk",            base + 0x78, 18);
 	clks[IMX6SX_CLK_PWM3]         = imx_clk_gate2("pwm3",          "perclk",            base + 0x78, 20);
@@ -456,7 +447,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_GPMI_APB]     = imx_clk_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
 
 	/* CCGR5 */
-	clks[IMX6SX_CLK_ROM]          = imx_clk_gate2("rom",           "ahb",               base + 0x7c, 0);
+	clks[IMX6SX_CLK_ROM]          = imx_clk_gate2_flags("rom", "ahb", base + 0x7c, 0, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clks[IMX6SX_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
 	clks[IMX6SX_CLK_AUDIO]        = imx_clk_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
@@ -502,9 +493,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY2_GATE]);
-- 
2.7.4
