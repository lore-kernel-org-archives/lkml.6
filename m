Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeFCDEg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:04:36 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:23376
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750931AbeFCDEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:04:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Date: Sun,  3 Jun 2018 11:00:44 +0800
Message-Id: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:nB9qrnN9HZXrzl4h3AF6B0bNomikof4i51HoZZxxSJzWX1CMMF632An1i1YcRXHELZtTjBGSC+ltp3ABzdJtMrCVAEC/JtcZEtFgrFlsvm4SHuJObBvapih/FbNrQ3RWdUOp9j9shEPrN1S5bM33IWELIN9IjT2CwWknI6CK18tqva4tqvizrBQpRpwLOFsiQb0oK08xlIZaGL1IVJFnnk/L2A97+4m32ptKaPg2wCyKXvFSSZTLxztOQNLzF8jr;25:4I/kEie1/GewsWdlXYOC8JtpQntG/DRtAZLIEj3kUFlRv0BFN35h9hln502+OpN7zFVaejscfM5O1O43Eq/3AD4Qg4P+4dK6YHLbtZhGKE+5TWpb1W2XrlQAQhPSD/SYw5i+v39Tsp65lJGXG5SSrwPoV3HbbJ2z7Oi3q9OWmezb310+WXC3fZcnC26UZMHxuTIiKw0mHDyHF2lOpdV4fWTxqx4eN1Nbe21zQVrf4l0TjFTuEVtpLEmSh0zOcZaP7NzpuCee50tS5CoiCfrRbBc9MOSWEo+z3zRDgbSUgya+Z6tcOtINGklK9nebmwhM+7JwL1hmU4hnfPfVI24fGg==;31:0JcJxvRn8sh3xbdiuGB25KoaQE147o8QWga1Jx83TTOGTthoXOorulN+8J6nWFs3HDzhKgP3w3T1MtmyfXX55gNHf5Z5uQ/cJlvC/vupLSzsOz3Ej+wI0Zs5gaLOPfD9x+8/8Jtl1sZBnW7ulUS/laJlibQfz1AclR0YgToWspSqel/umOkqUIEuy/AsQGU0rGnN2fr/O+yKXNWZnPOyAbxBLakSjW7s1R8Y0Z1P46I=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:XrT/Zq2UqSp3n+Ly7ChHSPpq3X5nX6EYwdtkpxIiBDkHF6fXUSereGzd9qI2Wod4TUwhAVGZdDXIco2lJrybfDfl8U3U4TdCBYb1A+TdEou5o7icwbKVOkcfyX18KaivVclnEuhDC1b+cjUVRSBSq7dp9J+K5rblzQrvi4xZNiGdZrjiga3ALCCpUt8uu8dq3p7TazO3rXAKu2+SHlvbqlDoJPaqFPN54MrKdw+ckZp8sRuX3XzTsX7qGG+mnMW2TWc9gGSLu9sKS6KRlWuQ7kyJFRYbXngdy3GC+WhkJCL6w/QCR4KRXBit0kVZHAwv/DY46idHnT2D+gtPSvAIhuOrNWZETBolbJsSYF+Jlv2xKvyUFeBpofFMm8C5n2/sQOuwkU4CaoWArQv6mn/DFcM/ne/Kb4ht5io3gINJvHssBHE/CPy4lbstMuC0N6rWRXAqpdypdJxRxU97C4a3QCexvXlLr+ZGESAp7K1JiGX2NqH/GDHrHWbE0oYsJdf+;4:nuxLjDXBJAM9JUq151Pf8VlfkmKiW1y6TnlKNkRPNPM+swVWFwcg1peRB3iBhayM0JqQnm24w0lhP/6QRhbQiCo5KyLvc4jqGsKria4Aj8zsaV+uuEzkMLjxwFwykUXqHWDlCl2h1Dbt03R5rSuymoWi6//cKCVcpvmsNXa9+il4A9fOhpbsJ4P9kFM++6mrYFH6OCibFWH5nn6Ha7UcENUgx95LSnYTAiSXQBntsWuNQ3YUpgcKFfUhA2QrykoaruhFsjPTDbOlnhaO07H5fNZcjq3DualAwtJ9rPH71Nk/+nWRD/iuthhu6kBzi7iz
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323D34730F8DDBBCF0BEFE8F5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(8936002)(48376002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(476003)(2616005)(52116002)(16526019)(16586007)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:EM3Df1m70gkwlpRL7vLJx6TeXj0kwUI6korHr5/i5?=
 =?us-ascii?Q?DipO3rGXtH8mYGSEfkLHJAh2QWBAjUUsRiYK9kuP1A0TCnQynwxg901gr6Jq?=
 =?us-ascii?Q?D80iXmcHq20EuKE7T9Tp3YUHEtA4QjYYTJTPbZ68PQOx6oPfY5K+g2TEe0TB?=
 =?us-ascii?Q?4Liu8GZg06zQz2HUkk7+6wjIbBL3Z3MMt9PRD5Gs8AFsPImlxsZZxb47kavh?=
 =?us-ascii?Q?hwY9ZU56Yze2jwRv/pObfXAHs+NauNMtN7Fv28F7uPOWfsLVmSsjOP96SsrA?=
 =?us-ascii?Q?nUu/UASOGkSJY0+gOzFm/doIRV+UIhcF0WetloCVxg0aKD5Md2N9DVm6rzms?=
 =?us-ascii?Q?pvQJSi+dBQRpPzZvksf9gCZMmGo63RNUWlWW61pR3j9TGbM0KJrGmT+qIPeZ?=
 =?us-ascii?Q?mU1VeFVETtFZcaZA0SZHIsdYTn9wKk81mF15q3LobA1wUel0Vq+FhOkzCR7n?=
 =?us-ascii?Q?x8SfjrPDjt0r/Kx5JZRnSRvW7PrT9UJxjVURKx5eK9pALCuiu+eZdP97/bxf?=
 =?us-ascii?Q?fYti19be8ONntPcW9NhD2nzCdNocR3cdNAbrv1PWcwo2H9rDF61OccglTKj6?=
 =?us-ascii?Q?8oT039cWiKtXOlFYOc4HJgMQDtjU58WaUfLcQ2jn550csWTmLe9THliDRvtU?=
 =?us-ascii?Q?874JS1mOyMzbz7FHbU0828J7J17NlTx0eBMQweubjIXXjMt4bSrM1p/yPmUd?=
 =?us-ascii?Q?+Hx/VIYvL86AvhGkj/JJwfxObVVVd9OGtmBeTiDs+NUU6orVkioFLYr0O3ti?=
 =?us-ascii?Q?tmecQGJMBwGzLKQWWlJSd+OSKjvI82Pr3ADNhhGMkNUBzSFqelAtoU5LrfoI?=
 =?us-ascii?Q?liWsJ2mLOjnQvWUwf29qTli28/WopFOu5+C0/Gpw958Cno6mEJ9jxaGwJq09?=
 =?us-ascii?Q?TwKJLjuP1j2HVFZulQkwnaUpACKHtu+TfueiWsYkS5YdCvl+V0a9H8eetBaE?=
 =?us-ascii?Q?mXCv23lLDFliV5WsGFKkCzevdwcVzY0z7rM2w3A/9bpct4NVV+XkGnxpPAo/?=
 =?us-ascii?Q?db6UPxtmbNyjQQiNzNo5FoDHVuHNWL73zlIJdMJbtnni6NCs5SiAmLa81hYx?=
 =?us-ascii?Q?ZPKIjanzY8QROJsuzwBcBKShEuRA5QlC3KbMllzhguYvhCXPQMx0jq7zSEB1?=
 =?us-ascii?Q?OfG1rnOBME=3D?=
X-Microsoft-Antispam-Message-Info: IkFjCSegY6aXvB2HvHYrcWMMWktEohACYwe9FDidx2zWgd92Fjpn/CTnljaBhz7Nl1LQaOwETZaOCXdBO7h6lFDz12G7b+uSnkIRu4OnVzCZHlvt8J3LetgxKzPnw7CBKxa2XalKemcbLOB/2Vtr8BNKwefF/nyaC6YUpiRWoOOryGgQgohKDOrPI/iUzmre
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:/6kwdNwFmkjcHUUIXqNuxNH8IGaBZboSUGuDcRKlQxBtnQoHqTYt+imZbZGx1HybbGHn7BXhaDnRzjlXUGHDouUK1ZiyriiHhy4+w7jRWFOIslBW+BZ8+9NBJ/dm03WACC9OCKmIbAsXtkx36uP/6X9+UUhH4HA7fZ6v41Ve6QunvVM64fWxy6AW5QJ+3f8CH/ZKQO5bvZDJmXAxVbxvQOObFAA2V/4kiy6sFwrFKns+AmYwPdOBwkEFPkr/ix+/ZaLR5asKvaVU4vvzgjMLjOagzrbhgEtMdBj/r8sABIOlDEHTDGwKxlh5VoAHxgyAS+B9G++YHVtLntCfqCAkMXtVrbKWEYJED7Ju//Au1v3r0lgHgNy5BVQzuM8V7/5nNao600jEFxE5+70alyhK2t+ifqIgjnyPi6/lH45ei0MR9qapqdYL/mCQD1wMB/KB1EFGYFG75Zr3qQlQr7oUkw==;5:+QpOOOaYldXJTyJLOjnMzGsGCAKkTYe7bho4If8N2gPGybmN9A1IcEAKHxXV5v6smN/dqhKJOPaqvqgbk2Y+DOLc2M+f9O/wPounzda8U+h5GQqp9GkeVdzJ8iTTO/GTE1oHHt4vybGszV2QjVTIaYHolBNZg7AcT8CJFjSlh7k=;24:PwJLnOqdAms2ZWhScwP+tjHL0WxJhjpp+JklhoYq5vkIKWcNVWviqCkoItbVPSONA3NyD8uOUdP2PpFc/QwK9nVgg4Dpj3lwCNGAsLSB/z4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:pl/ZfJ7l6sm/wfCKxhWmgjpCLJyQ+ucQFW6u+ZTf7V3QQhRn00f8jIWjQ2RI8GO4gkJmYfHj3HnGqFO4g7+tfQT+ni7wJQbEyA4OnALuaccr+e7ZVgyI89bQA62E/7Zgeo80oPNKfuXLkIFrT3lUq9NMWwWbyTa9oQRL0tTJIdZv81vI74HZksaVut9ssGSBUqKkIDlnxi4Tkyqo72s4J47AvB91bcUh5/V8C4/K50jgu87jYgBkubgy2/HCoVpi
X-MS-Office365-Filtering-Correlation-Id: e5b55477-1dc1-4b42-b391-08d5c8feb7f1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 03:04:24.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b55477-1dc1-4b42-b391-08d5c8feb7f1
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
 drivers/clk/imx/clk-imx6q.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b9ea703..8754c61 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -96,12 +96,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
 static struct clk *clk[IMX6QDL_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static unsigned int const clks_init_on[] __initconst = {
-	IMX6QDL_CLK_MMDC_CH0_AXI,
-	IMX6QDL_CLK_ROM,
-	IMX6QDL_CLK_ARM,
-};
-
 static struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
@@ -417,7 +411,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *anatop_base, *base;
-	int i;
 	int ret;
 
 	clk[IMX6QDL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
@@ -794,7 +787,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "mlb_podf",   base + 0x74, 18);
 	else
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
-	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
+	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2_flags("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_MMDC_CH1_AXI] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
 	clk[IMX6QDL_CLK_OCRAM]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
 	clk[IMX6QDL_CLK_OPENVG_AXI]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
@@ -808,7 +801,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_GPMI_BCH]     = imx_clk_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
 	clk[IMX6QDL_CLK_GPMI_IO]      = imx_clk_gate2("gpmi_io",       "enfc",              base + 0x78, 28);
 	clk[IMX6QDL_CLK_GPMI_APB]     = imx_clk_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
-	clk[IMX6QDL_CLK_ROM]          = imx_clk_gate2("rom",           "ahb",               base + 0x7c, 0);
+	clk[IMX6QDL_CLK_ROM]          = imx_clk_gate2_flags("rom",     "ahb",               base + 0x7c, 0, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_SATA]         = imx_clk_gate2("sata",          "ahb",               base + 0x7c, 4);
 	clk[IMX6QDL_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[IMX6QDL_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
@@ -878,9 +871,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 */
 	clk_set_parent(clk[IMX6QDL_CLK_ENFC_SEL], clk[IMX6QDL_CLK_PLL2_PFD2_396M]);
 
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clk[clks_init_on[i]]);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY2_GATE]);
-- 
2.7.4
