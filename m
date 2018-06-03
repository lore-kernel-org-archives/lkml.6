Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeFCDE5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:04:57 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:60887
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751258AbeFCDEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:04:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] clk: imx6ul: remove clks_init_on array
Date: Sun,  3 Jun 2018 11:00:47 +0800
Message-Id: <1527994847-2363-4-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:HOBHOf9m8LGSLv27C5Gv57039T43HoIt6pLKunbbZOmU93AjAr1i3giIA1kYL6BJBduwu8adQwaqL5JLERDscEH9jXQytvegXQiZY7EexzsMB0TlXJqqXAjOxF7I+PsZ+YIA76XgD3VydXpLHV7tg8+BPs/vykf5Z27ZLHX2sMm+NHLNZlW2jKrg6xuwH87Z/vwGEz0G5nnOm4pX4HV2gH9Q7VxO56L1C/uEvX4cgZYQEQSc2ifatQajf2SjV7U3;25:PGA51+pOtUUmyAG61qLVWrqr0RkPSGE1PcCBCh5Ck89nT49P2cTQFpvpvQpj7lVa5jbWqrrGu8o25SaquHr/T26fJzKfJcAZ1EB43z6ZlTLh8IHrGC5dtfd/U3CAgnjpoRrZ7SLm+IUSlXKNTcEhghI2AizYAkK3Z8838FI2Rwspz7jdpETD6ol+IA4Epet8xISkHXSEDLOXK5/KHjnD8EqllC4PLYAB6+HyDp6wSV0/Bj9GqhepmrSWvARrGZmpgRVGdmfUJhNEBrmdtgIxjNeciyrKKYYP/lxgyQ9RuPMQT34JPR7cbIKHlpTaYDd8QhD5IUBAIn14ealzvhuC2g==;31:dzybMsW7U7VC+1m1DI1CD0WBGtDz01mdn8YPEZbrPVg3FjpySa07CuBgIl9LHO2E+zWGbxAz7WYQCq38oB+DVEMeokapVQNrFVGBjcgMFaXHix40Gp+ziJSXHRz1q4/unLLTMEGQiIXtYzk+V5whCszGyR7HEvjaTdA1wLyibu3G+OueRS321oMxCAHOOno2tb1vrZPM7BjL/FBVWyWp3ccdSI3d/8dj6nuoqauyHCo=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:BXB6SQaLrSj7WpKdnbleICNcU21OmaRjbvVSndZDZ/ISkeWNqJfgtx8FQByOs4XkoXEn1yA8ZkicIK7cmtMSTc1QKLa/CAoQcYpI+vY1PNikyNBpXdrmFEfshsxspccUS03OJzjjTGGO2yHh7vvqmI4zHFGwtCwxq9dp20UAuduMPeGeC+J0YmEXTn63wh7WHu0mUgoQ9EYW4mfnLV5b/BNMdCeq6HpcdeH9QalOvlOevlqGKwjxB6hHQhF2YjIhukClpz/bLAtFTl5uR95Cl/Gz+b3oAGSh3fqiVtgvmISg3s9SKzg63LkGk/Xcvmk7GNk5Z5k9kupDWFdUZ9rDqPRbG1J+1HFQhdQ7hDhtWhvEYVXgspLHZyTJq5IG+dGmyVwJPh3w+KBpSZGBuKdBZuKClz2QHrXw/H9xwd1sshqZ5AD+SX/g3uR56IT7mlkJKZSVYzrwfecVkx4JPoOa7/gmoWGQ9/1RCzYM1rk5gt/ORDqf7/5ZBa1oOHi2pXp9;4:5NBw1OLgNGuMSMtTzzrxuzM95l5xYIDgbxrvkhKevj+3s2VJs6OI3KFNcREF3Ke97TQuuScUddu7mKBuBanaJaE1zplGoTmeRzl2ipGhSoiWJu66G6RU1j+F+AzoFC+cD7hPpjE76ThHNQeFaxlnnnFpk0CJU7ECArcv91+8TtMDLbKtVegAi5uk1fSHbpcKfczDEwNdSbKbDBUUU82eq78+HbSieCL8DkjCE2euEvYuoAWZ187r4VeatKeFvffOndhcI1TV9J6x41KH+lpVyiuqOE3p3/K5SLdGnwX969fjlU/Ml+hHoTCFZpFwP7W0
X-Microsoft-Antispam-PRVS: <HE1PR04MB13236710C18CA574ED237BEFF5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(8936002)(48376002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(476003)(2616005)(52116002)(16526019)(11346002)(446003)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:vVwJP3jqT42Oywl7RWLx1ngcxM7yKEkjgACEnWGSX?=
 =?us-ascii?Q?jrfS3ZgucCqi/oFo1YpTBYnmw0SV0Df+Pk/nc5LHV7DwH0OazaULxjwV7imS?=
 =?us-ascii?Q?aa3fUDPfLE7o+8APxSTnfOQ97ViOy6s4ohxh1sQ1XV/sQG+rwmtLXaFPv5uC?=
 =?us-ascii?Q?REnyAjc47dwkaQ6HDIcmMsn+xXIV6LyF9fh4E4FF0SoXYRsSgKDefNC8LE5t?=
 =?us-ascii?Q?q4zhbl4fyBpILUj0hu7Fyby25T9zz1p7LI16bNKrZwbXcVcV0fxV+G+o6TJj?=
 =?us-ascii?Q?jr8U7Lyz2r3nwtq+C7HcYnU8S9ZcORgs6Xx+Qo61iPp8CoI1JWiHEyUmlJ6n?=
 =?us-ascii?Q?xgErDffjx9Yef8laXQjHtY7dqeB9yO8hfWyTDGWe69EXPbE28PjGYPdXCONf?=
 =?us-ascii?Q?NZCnZy0EPRFNlKORPEphkBSsQ9y5LZORdIZYTXA5xUrfqz3l7YGbBsuZyQxL?=
 =?us-ascii?Q?Yzt0ZDUohEOj1U1vU21ID6SOLt/3pMCtjAp4rzfDnRJ7lpqwquNf/1nKsCiz?=
 =?us-ascii?Q?TfvKkbW14fUHx0EXZCQJhJDVA6MFmPkMucEZVL9bvzFDgsYJCx28WHtVF267?=
 =?us-ascii?Q?mtUU/WvSj/OWLzJ3EF7KlhoiX66N2nOgBMZ8o53xfA0SBIwtbPzGIYXckmTi?=
 =?us-ascii?Q?i1cC2kk7GCwV3Lhfp0OaaB+XCwFVJHpxBrl6o4xmb1Kk62qLYSatVisng612?=
 =?us-ascii?Q?DWsV8CGFzV7CZi8Uw2OajcwGgFL1QzFm7vFDbFzcx3+U93g5jiyFod/EO+Np?=
 =?us-ascii?Q?dAFJlVEgx7Lk9FJfQ9+u+Z63BUH4uW4BNoIMfpO5uCRcLg5j0bRBLSHN/dAm?=
 =?us-ascii?Q?2cy1LbUwh2Xnu/NwHnK9JpHWxBiQSVM6hNTonrpwCMFC/vjDqLywGmSxyDbv?=
 =?us-ascii?Q?U34TuGSfKBJCrJzhH7j3D+qqpuwksVKtT9x3SeGN518kMYvU52x0H/E+RzoK?=
 =?us-ascii?Q?xuUiXWVS+YYFqbGbGjm49jGbiSvmJC7jcq2GCSeJ7JffmzlGxFIbKQ9V0xPo?=
 =?us-ascii?Q?qRa8KB0zbAkpdQMCyqE89iIIUXBlmjUh5Fm+357GQbxrwptNG1gG00IO6VI4?=
 =?us-ascii?Q?yVs6dwmX3g/KCw9HbtUMzfD67Wmyya3RtknsV/sjbr0aN2u3hutR43TRYwtC?=
 =?us-ascii?Q?JzfXpnvt9z9Bhy5R3WS1y1ZBjAikWtFPJRDvnmcwvlZLjEOTCrEeywWbr/j1?=
 =?us-ascii?Q?4HYjGqVPwrCYXk=3D?=
X-Microsoft-Antispam-Message-Info: bn4DBQNpvxoplWRGjzOR8bo9q37mdW90tC8LzArllx/KATwHzz9vRfJjvMred/6BckfkRNm64tfhwKzzpUSlYjZWwy+qTcRdmrII+tdrnRms3m/UfII1+Sos9h6oeI0XLP29GKy3tAAFTC5XMN9fhJZOFUDs9pSKhynbiXZRYv8W2z3T1wNcy9kMXCpWAmUy
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:0wklwWhTi7sogG6bk+Ci4odnQKvRqKGs2qV4JVKPfc+79N2mK8it+SzbF8RsxyjgNuqJKFXSCfZB/U70d+GsRmjktypS+/M40J95oAHGo91uuLSnk2/tADVC6QuigCkqbXtNdfSiY8rn+eZagW/3qZIqdclOXczFBwL69p4KZ12F4SoviYolj/WFMqkQ3ah2vLwfSxeNKbpYqrBwQgtKRg/YtGapNlpS6ALksbGMCNys0YexVnv8XNlupD6xNT6hBonq6UqpzFAk0lSrk3tdmV0tG6e0sCR0b36SnF6X2Ix+nZiP40LC9i95hgh2s7KMafP9TFO8vk+eca26nVce0VVI7Y7MGP5HngiyaBmgqarvxJ0GS2A2XzbJ0Miv135TpSi31BrGgKTVlHlbh9tm6RaEwLhZFciV0decxPP5+jxAo5jEojDA69wg3+XK8tqXRSKjxVOV4Mywk1EwK5oPmQ==;5:28wbeLjSsLIjg7k+NALFPLzuypX+2ZbE3QRkfaj/i6AhLojEhgyJf+U8FYvNqy/z6t5OGQzCczdJG1pVx04xen6kwtWwqHsMtu+D53wg1gAiIiA+EXcrW7Tequ4cjOPDpCMtvIozf0cr9Ofeb2lCMIaS9QKFc02MZ+OmGV/sv1Q=;24:wfyNdv1UWK2tuww20PL0QfbsWr2nQnALA7+6hz5tlsHS62W35LASHDaynxE1fGQTOJQW85kk5wfGfxCt0JfdE9FtAj0q8LAYixMscm0T0yc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:HQyeu1L1WYXC6bnG3NY8ZyZ6DR0Y5tGX4KBjIRWFIcyTW/za7H4d9460XZ+sZ+MpLD0B+2vWwYKSO+U8s0/rhbvZ5g3IoABJSNy/D7BHz5+3zpjomE05TgQtO8h6CsLU+mF8YpAS7pAUX8FOehFfMG478PT0gzT3kZ96LC0LYxZ9Q/+xjmQh31UNe4QASGGOpTR8gRPWvZtew7m/hFmzS18nhCFgtiDfCqUHzBU9YCt3YCUyxe1DkfvJeVMKatpt
X-MS-Office365-Filtering-Correlation-Id: e263a541-f93e-46ec-d2f4-08d5c8febe89
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 03:04:35.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e263a541-f93e-46ec-d2f4-08d5c8febe89
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
	This patch is based on "[V2,1/2] clk: imx6ul: add GPIO clock gates".
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
