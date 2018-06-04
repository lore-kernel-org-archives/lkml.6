Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeFDBKw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:10:52 -0400
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:53300
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeFDBKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:10:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] clk: imx6ul: remove clks_init_on array
Date: Mon,  4 Jun 2018 09:06:46 +0800
Message-Id: <1528074406-11735-4-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:rG0oj5lMY55mZbKVT7D+Wz81/G6tmR+5ktEl6u4N9UIh5N5YgRloDkii/ZUmQExzUAigvfm48b8Dmj0C0IcWp7miNPDA70/YnR/LmvlmMsv1xeVjd4Hka8nGAL80g3nEVYo4bQ1Ql7sxIbeA9T2JNR7kaEUqK3xvWToCBlxmtBDPTbSQnIL/fETb8nfox5C0qoCgP+Ejt/bmRPLCacNG0vxHsW6rnRzY8tRjO8J4og1GYu2jaPKbGWFrjgVfB23X;25:fMUpqIjwpdThBfEu1cWRUhGUWXX0K5OrpWS0t00tw/6043oiDS3yN4oC6h1yP4imJXmS86I/pdYMF4El1+nFmWHRiVObXL3hUkLK34UnpuoqsDTHtBKYeo5ayJy7v1dxQ9ze8hVzJuILSP0hIWmhQ0MMhxIpW/4SyePix6pD0CFigicPFNYDujCVvIm0L7gysEDXhULkTOS+O/kKS+yrjkdrawdtHJ77q8DLAHx+xXhLlh/V2ZIrrcWLUpmzcSqKlgoHP8mv52XsKb+JUpyBEsMWTUUuMoi76lXtHgFTytOM+AT+pYVt3vFy34bKs1lGfSED75h9DGcojmS4WCUTLw==;31:oe2Hd77f1M3HNFYj8QFp+0vWBWyoKNkQL7Ab5ZLEuyrqQgaihNT8h8GaFpoeqxclAlfXCdopp6gKc9ESppbEGXAYN/yH1Bf67wvfX8IYCkhMKQvpdah0bFoWBTqyyScu+kgTy3KMIoL5VHuW+Ixx6p3eQfENiD/EDy+nr02HAJA7BrNhQh2yzsETpybEBlqp1KJ3vOE0u/Fe5bVbV0BpvOMWYZ0pPds+9+I8vkkIX+E=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:whyGnl/4VDHlHjeH/ROQaHE0/8ehCUw7cndUzG7wPiPKQSHRl2MgXlU10QQJXqUZBRJ0JzzHAJvth+MyrpH4G36/ZSTi8G1oF4DSn2KXwJMAh2UzC4LK0zxOXKMUmtyhHXlrlRG9MD++z6dBch6KzqbrOErFprwY39sz9Bpux28iBjb9Yr+k+FCr/0QOh8QUqkBYMUNBYusYR9lhGqLYILhf2J1ghtQtCtdBj3UKrT/96+2YfTx8Jn0uUqLDnz5+iCTFjZWbff53+j8VPcL6EJ8HS2PFC6Mbo7SF5BIqIC7yLWvcgxtkOgvjwITUFizux5xBJAzINWmFFROi99XeFjizSXQV8baYHcQ+kRKJXN415GNgEAGPFwf/3lFvfZ9z09feVL+egRY5aNR4OqUAP1K0O7hgLuZYD2DUYFDuDGomFSXwUFk6FarhqAXOsena0Z7X0jQvfy7hN9OHuB826N+y1XziffFghDTOPs2DtctlMwz4abm7rJFe4qlInUuS;4:nMNvzujq2vGKdggzCh52BSbjiZTCdGUvZML09Nq6kLVBdVIRFv/GB9dbX/l+hIhdoUuko+WOIMnMnkhU1lM7iu1RajV8DxZhGdq2dkzuNCri9XMLflyNLVUkUtrpYzp11OfQEYYyLkLe4xlA+HjimTmxzeofq569A4g37GNDYAeIl9RDTmGUBYs5oRVwui12yTcEEkq4982RTYaQJ0enFXv3iYFJjgqLw8FaeXcssUypQM591nM8/5zZGYlIC1VHSTXGnCaI5vO1vuCyoCYhoNkTdCwCxulEtTQ8Np7J4aAgS1a4OAKS2sHTz0SGe2Qk
X-Microsoft-Antispam-PRVS: <HE1PR04MB13235F7C01AF7D848BD62CE1F5670@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(53936002)(105586002)(305945005)(97736004)(86362001)(106356001)(2906002)(478600001)(446003)(8676002)(66066001)(8936002)(7736002)(48376002)(51416003)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(81166006)(52116002)(16526019)(11346002)(81156014)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(316002)(386003)(6506007)(25786009)(6512007)(50226002)(4326008)(5660300001)(68736007)(26005)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:gs8uJmG2LznmUVdp9GS8m2pkoE+WevLWkVH0BgZhT?=
 =?us-ascii?Q?AFWDuda0dFnp6EzSXFX23SCvhx4/5RrsZTvS9IXmYSlL2mRcLyT7ug4/vqsY?=
 =?us-ascii?Q?YFS0mGoIxH1uCsr6YmMrPpe+SX0d5axP1w2FCdbWpGZ8NMMnIkx9oib3WYue?=
 =?us-ascii?Q?eYhy4cQOlCa7hycWx29xYXYYQPoAmJFbJrdppu/3k6pl7UAGlbHR/50gmXKl?=
 =?us-ascii?Q?ws9f7T4tgWLjXPbNiRWUnPmz+nbBUFtpwZ1w+41zlSnfMp4nOvFPELN+Bboc?=
 =?us-ascii?Q?lJ6tRykEAsE5oO+zkajIBbxvFpJU2rCsmulJ5N/q7j+k2jrlqAGjQ+Nm76bh?=
 =?us-ascii?Q?liG8kh8eryeAy9YOIBOBuq9wvU/Wz27ip/dATAv+9w2+iTYzH2IDsotH/+dB?=
 =?us-ascii?Q?G2QupJ+pvTj7CIdtMM3Mphj3v58K76+dDTcBMqEsAJayUycyUTf07D6l0n1B?=
 =?us-ascii?Q?QGXJYiL0xAaLkha/WbMO4Cn2fs61N1zBLkDzv7rsbGZLCvBpg8CmIhwn6kdo?=
 =?us-ascii?Q?60s+M8kyHkXZW80d14zvgwTMV2v7h/xA3vBFbzMnb0OZ+mqY8L52wvBl+fcd?=
 =?us-ascii?Q?UZjsvN7tKUf0hAHtdB1p99m4ano5yKLaWBQZZB0TEmBwrBt8WLT39cIhow4u?=
 =?us-ascii?Q?g6rwwD5vfTP4cVgFsEEdyBvJEokb9qC0nEPk3/m7zOT9yWzqEo/626ytZ5KL?=
 =?us-ascii?Q?Rx6tqJCb69lfZRKKm7Vc+Z4vlfde3d3fg6BztItAAgPbkBgSY8U+1MT3EtPF?=
 =?us-ascii?Q?FwPnWyDghZJkvWy5CPYbsqs1yYEL8ZO8+6sl609vJmkgmwZXVBQT3MLAbl2X?=
 =?us-ascii?Q?HtZyXsGMMNUb28oPpJriPoDNjTt6BFTxWcc2NTuy+06EXk7hwfu7pqM7lSgg?=
 =?us-ascii?Q?HcHB15OinMzCcbIG0JjP/1uUWtnvH6NWvPyrYyWOOJ/oU5qKanRxDjW3WnA0?=
 =?us-ascii?Q?ov/+0imE99e8NovWqUjf5kHhFNuj5YHFncyNSJW0FoEGTTH73Vh2kU0+Tzgx?=
 =?us-ascii?Q?hjM6Qk4VC0q24OPyU9A+Y5Z7k5wawuaEuE8nV3nHmhcKdjcuchcAgy9NnnV5?=
 =?us-ascii?Q?wNqEW5LGH4wWWwVPAyRoORm5yay8K3PfVPVFNaFhsCu2Ow3yIa2UhUW6oO+Y?=
 =?us-ascii?Q?RkX173ZhFTHMZtFaQR6Q/qzb48T1EFl6YOXY9dbNQWfFFVGmjpAgpZ5XSOdk?=
 =?us-ascii?Q?nRxUOyKpfIbjzA=3D?=
X-Microsoft-Antispam-Message-Info: EdYy3NOlfrq/qBU003FyDkOc94f/+eUOd9iNrfvfWBUy4WPwlwASpZj/sQuLWG2ZQ8rIgim7F0kF8YY9FIJDnr7SusnWQf2B1YiyI2FfJ0BK7CO4h5u6KVLdFvgVHMkHkLCdd3BkDN8Do/Y7AgO7LMfEXTaUHpYkC5yPf6mgYrApAfsvddGREzRpHxvct9eM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:lMM2TUkXYduLew8sgPYWr/OlbmZ3e7JeWmGB9lB4iF3947DxOjVYNkjQB16c7NvWBZhIG2IPxe8dhQR6KiE9E9+4koIyi7Qw9FD90KENrE06cStjVw/Kiqznp/csv3Y79FBY6k0GzuIURoeUVi/ARe7oE78WgGblWL7BaCx2kbh4fZneFyHNY+HaAbWnZlfQUrBbP8O4ricLIe7esyAt64k+GpZlXKwgk0mquHu0rCPdkJrfjMSlxgwoFxsf0YOax9VzVISw0037qBCN9OuOJIFe+BtevASrwq38NcB0m7VYdF8Fz/IyW2f7N1Qypbvs+heBupycnsc05KicWtHjUGxscl4r9vzjq/hl2G7klCTWp00LIhvOe4UL4Gdyn9g2CREoxbeweeN68aejYcNqKkdDm3BKgBlMp6+k02xzFMz06jR8DXVoYxthJQZcDCo3v2aMoJo0zNGKxEHfme7XFA==;5:FliGhKxPxVI62tNZbDIGkNJYo6lWt7bkyic62cU6Qk4gZJgmohYCuNfr780zsM7F2wWnJKmL/26yVY9MoE7bEL4SerFNHZA0PnSw6xHZwKoL4HyWXXPIbJOOYxTCyJRts80+OFjwVWMFhwqZjpXv6SD30jNQi3BOcjrRYbS91kg=;24:4mP4bd1GlAzlrshiHRv+R+9VB5UMT+HkYii2kbrGXKFHX3J+amNX7fHaxJK+AMeN1QysEx35Eka9RwL5jBRimrlr8olE5DI78A6l52V1JrM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:NnimltxbrefHWDMx5H1kvNczRphTy7NiC7uJjZWVwQBst92CPMfQBpH1U3hf4jv4E88AjTKnEebWWh8SjVfMZaNzEHJlLF5AWxAfUs+2x8wjnHawtxZ1VXzh5w//4ps3Gsbp9jm4lZ5KTuvvxEBDqLjdYXF/Chi2FB3QhkPqIZ86V5xkw5Qvgtfv3vXxYtv0kg5AJMERAqavI+4f2I1cmHXkTKC79LraCdhfslAXhrMF8rVg/Za/NKxCDFZDsxXF
X-MS-Office365-Filtering-Correlation-Id: 131d4e54-3393-48ec-400e-08d5c9b7fee6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 01:10:36.4709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131d4e54-3393-48ec-400e-08d5c9b7fee6
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

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	This patch is based on "[V2,1/2] clk: imx6ul: add GPIO clock gates".
changes since V1:
	improve commit log to explain why no need to add CLK_IS_CRITICAL flag for ARM clock.
 drivers/clk/imx/clk-imx6ul.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 3ea2d97..d3f7f4d 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -79,12 +79,6 @@ static const char *cko_sels[] = { "cko1", "cko2", };
 static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static int const clks_init_on[] __initconst = {
-	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
-	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
-	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
-};
-
 static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
@@ -129,7 +123,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clks[IMX6UL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 
@@ -336,8 +329,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_AHB]		= imx_clk_busy_divider("ahb",	    "periph",	base +  0x14, 10, 3,  base + 0x48, 1);
 
 	/* CCGR0 */
-	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2("aips_tz1",	"ahb",		base + 0x68,	0);
-	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2("aips_tz2",	"ahb",		base + 0x68,	2);
+	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2_flags("aips_tz1", "ahb", base + 0x68, 0, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2_flags("aips_tz2", "ahb", base + 0x68, 2, CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_APBHDMA]	= imx_clk_gate2("apbh_dma",	"bch_podf",	base + 0x68,	4);
 	clks[IMX6UL_CLK_ASRC_IPG]	= imx_clk_gate2_shared("asrc_ipg",	"ahb",	base + 0x68,	6, &share_count_asrc);
 	clks[IMX6UL_CLK_ASRC_MEM]	= imx_clk_gate2_shared("asrc_mem",	"ahb",	base + 0x68,	6, &share_count_asrc);
@@ -412,9 +405,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	12);
 	clks[IMX6UL_CLK_QSPI]		= imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x74,	14);
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
-	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20);
-	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2("mmdc_p0_ipg",	"ipg",		base + 0x74,	24);
-	clks[IMX6UL_CLK_AXI]		= imx_clk_gate("axi",	"axi_podf",	base + 0x74,	28);
+	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg",		base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_AXI]		= imx_clk_gate_flags("axi",	"axi_podf",	base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
 	clks[IMX6UL_CLK_PER_BCH]	= imx_clk_gate2("per_bch",	"bch_podf",	base + 0x78,	12);
@@ -428,7 +421,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPMI_APB]	= imx_clk_gate2("gpmi_apb",	"bch_podf",	base + 0x78,	30);
 
 	/* CCGR5 */
-	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2("rom",		"ahb",		base + 0x7c,	0);
+	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2_flags("rom",	"ahb",		base + 0x7c,	0,	CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_SDMA]		= imx_clk_gate2("sdma",		"ahb",		base + 0x7c,	6);
 	clks[IMX6UL_CLK_KPP]		= imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	8);
 	clks[IMX6UL_CLK_WDOG2]		= imx_clk_gate2("wdog2",	"ipg",		base + 0x7c,	10);
@@ -502,10 +495,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
 	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
 
-	/* keep all the clks on just for bringup */
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	if (clk_on_imx6ull())
 		clk_prepare_enable(clks[IMX6UL_CLK_AIPSTZ3]);
 
-- 
2.7.4
