Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeFCDFA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:05:00 -0400
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:64880
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750931AbeFCDEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:04:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] clk: imx6sx: remove clks_init_on array
Date: Sun,  3 Jun 2018 11:00:46 +0800
Message-Id: <1527994847-2363-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:M98Sor/tCX48dEp319B31n/8CIkb1/oJEx3xCMKVC1k7O949N9Lc2kGJ/nu8JQl3crZwnhqBpXJ8mhko6qvEdt4IFjy6jwo6cHgW11HhK9HKqR2YUjg7sHtA0HJoBoAWFO61M/rZavo2EwH94uv+SVcXdxf9RzhFMbMNIqf/kcnpcrrbiZTFtWSjTsfFhHyMikIdzcmAx+vkboOz9zjxtNFdGOGktcWLOC9uMjG2Oi+pZvHrd3ZWegPfyVwf2SC4;25:/yBRwImG4EWUURd6+JH819jNq7hzp6Yua2i2n8+4upSn0SM740YCl8/iwoRZWy+Ox2svcswABOW0zt5UxDKkUOW5B0mIO+PvoeHgQvu38Sc7jXxr0IzrimuiNYbXs7HcXbx3yQUgCaMQwQ/vPIsskeaMlkSxHDFg1VJQLV75CXCQhfE3mwwTI2eMOjVyhEQ61mck82II1wdBX/Gu3smD/391bMgPB98wGmGpMxYn3XCczoS0ETzvEZ2FiAhyoZCa2Xu9QLOZkYI+KPqo0A0hsP9ROImAwwched/iJHrRmHEQMF7Ib2CDJoES+V907MXMAJToiZaFoFQEFiF9nOUTSg==;31:4QJvzRwmU2TLo50rM6R0JeShDFY0YYxwpDo/O1OW35FQ+S7SrDHCh3+oNBM+ssis+7QkqKVjRw4ngXDexbXfbg3FpqVDPR+R7Pbc1wvdRIIwTRAb9QFv0W3VUYZQTcwVQyBVcvyQ4VvIyK9jdCH4SOSC16wjXjdkwwFUf9Tt0X9TsA0y84ryohtipP3SbeFULgExO3YGQLiRozohUpLUfcr4UrZAxZzIHN0GPxixSA4=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:l1pH1LQ4jE9fnh42GA7RVixO7SBlvlWEIb5s5guGNX+kdNARUbiUMMmEW5QIlRKMWpyVAStYkpENck9cH2S5QDcZL7WKraJ3/9TRKBcvtijc9GOr9ZJaEQ2IKHvQ7NQ6Rl0YmRPTroBt6y1SjWmjG7/vTkHIOoNpxmfurkIENHQugyQ8ySRRq4WA31waapsw3mdurD1JEn7rumhBWhk5HnxoI2rvoVWkQKkoDaov10Rg2ymp+TeCTLEXBgPjKNY4PuWY+2TWOGHh87H7m9JR4Z3iIyWCBx2hKgeXEJzD1sc2IQXUMOlx3mZG7YQr14x6+ulEfjkZV0HQsahr/VK+BBNPggGKgMdEkpCbyFssUz4t7I5y0ZU4fRQspwLWg6hTbUlGViT4ifXClIVp7237pQjwULjdJXwxjpiBEv6oMDnL0d7ta9nbh8cZ39eW7GOvhrcBFCwqYXs1KpjTy9D75Znzi4K8M1ow43/9BDKiXevQLJgwuHkR58sZUvE659qi;4:gvfS5CUEeV+15sQVlZkw/gfZskyCp5Qg+3NAj3JcU9dXeW6cQF5UrxjXfOhLZdFFu49reVg0Rs7PBJ5K+M3eIlo7Wx1l5KhaLhlmWZosiZAWCwaJpt/KyDey5cf3ZTghIookcMqlnhshj9fRUAhau9KhRLMbKLNUx8u6upsqN/XXaxJjP8UxbfSAbOjiH0diUc4PdkeTzLtdGqyqcsi7w0olRdcqp04hWYXXRkTA52N4XxQQClh3+1IECzjQM4bcHh9StpOgRKvRD/ZhXe/BnZnIRC1Q3Z68F3WvoG6Clwh6MxA4/1Fdrnqezw1s3XUc
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323E442DBD8A28DDABE69AAF5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(8936002)(48376002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(476003)(2616005)(52116002)(16526019)(11346002)(446003)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:qQ3FI55nI7MSIBcHQ4BadGbCrWvzip1xF1ctn1FDP?=
 =?us-ascii?Q?Je0bBkC+EuHb8YAsEpUveOUa1h50hwK9mlbhDR2IUe9ihIKTKceI497UW9kS?=
 =?us-ascii?Q?ZaRAfmfaIIYqM1YxBVDEq7ulcfJSUbA6DaPPE+132uuODWEu3xbpAnljhGB0?=
 =?us-ascii?Q?yBqpwNj/CeVonP3SNK0lHLwK+bg+Rr25p7Xj2dokliZT71xDFXnywl+29zhe?=
 =?us-ascii?Q?+bilKOmF3D20/ppFHhgcWHScISnGRqj+NqmuN+KxoJVODgWsj9VeeTkHxMOu?=
 =?us-ascii?Q?qObsDg7tJYvMXhUx5K5NZjICKwn/o1EFzbsA/A216DrFkUgWXEogcxNK1Tkr?=
 =?us-ascii?Q?qG4i4vF8rBLawDBuKKNIhlFxH0XHn8IU1q/ecAa0MkYepaWv8jrh+iXGNv/o?=
 =?us-ascii?Q?AIC4WyzIHvf9TC3wga+kFdFWvRHI8ADcikGc5urrbf1vP3dVllLdmP9LgbiR?=
 =?us-ascii?Q?yi6Y/wxLZVR/Up2amwldN3jYNP5ZrZSmNKbN7IAlaSadpJMsVSwkbo0++aPQ?=
 =?us-ascii?Q?ZjAt+8pAHMqmKxLBwp5LdIrCs6fcQR1lTJEG2wGhquxaiWIrEKIuHVFuUXz+?=
 =?us-ascii?Q?7aKgtsENbnDU8IauQ7HE2I6NSdjmjjOA95H9pvkjxupNwCdMVt/ijpNozTjT?=
 =?us-ascii?Q?O9RobFHS8tPRizX4T77KO4A8WC+/5B6aCBHXsk3pmEKKCkszShRW6/rGWP3U?=
 =?us-ascii?Q?h+b2eQnOLSB/WnDSTzRe7pdbO/ARH6AkogA8AoZubnTd02wll/ERyCUQLcJP?=
 =?us-ascii?Q?fnABF9TgEgkbGGsi4r7TDzAt2Jnd/4n0OYTpdBjpfwTsWahUdg7ReimnLLm4?=
 =?us-ascii?Q?/3ZC6jJS5oe6kHPXpjkhjKOdTXGvcuZvRwsmPkNE51wNeN5nY8b49Bkoo4HR?=
 =?us-ascii?Q?KW1Ym7uo70SFYw2H5tZZJMzLdIN9g0TURd1Aa0SwacWa0pzAthJYUwR0WEYx?=
 =?us-ascii?Q?2iceBPHLCkVfLVmtxMyG9heBaN2ShFCFBE9yVjIf1CGtEoTGtCyzZo4Cjp6d?=
 =?us-ascii?Q?9uKthPmZzLOiTMaGgrWXHfrhDP0Uk6UyPVmwCWOd8V69LwGTTB8pmEE2w6eq?=
 =?us-ascii?Q?TNEDWV9eWsGichMFcYJPZNICbmN8hVmMMXrWRtLNvzI2imNFeov2IrlQQZSl?=
 =?us-ascii?Q?G+RC+dtBeQpnjIO5x0kIQT/bW0Up+IXqNdfsmC5+kHp+yWDUkERyLKc3IXoB?=
 =?us-ascii?Q?LMAYIf6gBFoQRQ=3D?=
X-Microsoft-Antispam-Message-Info: 0meVMfHQY5vz/fEmEexy8a8awFi/HseIJt+lq8Lb6yakblpDlQPKHGsM0O3YoJK9OkNL2U2Xv2c/sEETxJpwQ0mquERTKhqf6TWj5oInC7RjXmun/Oyl9OgXvTeOZZTFpu/gmlpahfwco9WLjmTQjmHfbu0wIJHZiYhitV9QLHGxhI8FFQWvTfatKceI13Bo
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:F7d5maGFsE7aWkDmlC7JDRe4oQkVZ15ISIBOAG1UxZ3WyP5hQe7yPyvfZUIDLDuq9eJMGFEaBNBaupitocfkRoO/thiIQIdpbLwZI0QAsIAYUXkOnPeSNBeUnxIr479rEJeRVhsinbTxOuTWn1mZQDtJB66kmePURE0OZDBpYcQYkMloav9n+P2IhNj9AmWfwYb84CfWVlYCGgv+zaygFC6shOBL/lEDJqRvvTx0uzntP9J1rCplzN3NZL04NIdQ/St1F6Qxhn7B0OjQpn68x1RzLjng9lXQlyTFdx4nr6sXAmjV1+K1BoYJHy9/qyinYuZBS8ObduwSgcfKchDkRJmQsyBFJgN/dAUcFKY1hZA9JPhtr/lZrEmyNB89VhGfPokXAafKfUIWwR348etLMKV1O6MI9UpvFrnI6diGTAopzHg61/9LBx4nMr555v5LDtxQ6Q0ZFL2MTt4bXXqBHw==;5:kYVsQpQX3I+GH0/04HhorAGZexm8C0XS+h+cs3TigrRPaTQj/G0LtxYsVKWiOVSz9N0CRDF6a8xK8GaBirarYouhrYkYKd5NTXJt9vRm3rlyaLDXfvPlhcKLhdKU3r/cHT66QrfrrAgiZfaSXOJgyhpUsqjoerDsmTi9GsXFNH4=;24:HXe+4i0pjBqznyWlGLT9kn6998wOyt/q417HQFjlaWQN2/UWzvx5cPaw0NSdciwhJo+pmCw4BkBLd7Xf8VgR0psOCiilJBgKukmGr3LJo8I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:DMAzkuTz99HzYCcaZc1iynGC/7eu7HGD9E0s5EEQIkUaWlNZlHF3iHEQpXsDozT+Qw7z9uvGlHUxKDHwXVf/J8KPpWIPwS5yOdg4E8V0wG0xMMSRLsqn57PL5hsFwXF+QQM2ZG0gx9voWHzGyvljXv08yKdBhllzU6LJaxo3QSldq0rptF3SusakSAPIRd+28j3LIHxA3OcFrFy5stU6Xz/PqCMYHXLYvwd6jKh/IRj7Bqw4puO5D0GAwoAK31ga
X-MS-Office365-Filtering-Correlation-Id: 1f649308-b3df-47de-0aad-08d5c8febc44
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 03:04:31.7990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f649308-b3df-47de-0aad-08d5c8febc44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
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
