Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFDBKg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:10:36 -0400
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:6530
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751691AbeFDBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:10:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] clk: imx6q: remove clks_init_on array
Date: Mon,  4 Jun 2018 09:06:43 +0800
Message-Id: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:a8GMRS0qJwOqcBmJJybO+FTRPcWitMFvi2AbqSm4m7mav3yB6/t6/fGyvZ1ni/DZ05kaDL7K6jzFdZQA84Idhbq9hdtXeMZx1nq0PdmZ08TJdY9arDU5VqcSYRWFRVp2GWRW8tCGi6XW/Ycdcgy5HYPecsPjYnuwD1CLI6sfObs3ybv3HIFARDzQ+9ZP7G/mWd0Kad2ux/luYRp8u7swA1cjc2FtPWIyzt6sKFjTXBMTIQ/xydX5Tgmg8dIIWQu2;25:+xunHFBV5XCeccYH/Ltm+d0pEQmSVDkTpDj7yF1BA/PRA6TNoAfItOjdUlXo2tbJ1/UyBrI0l1BiTgGEqxbk2rlugNTFiGvvOuG8Chc/RpcgWKtLkPk+CaqgqlUbnxEb4Vvl/IGSQ+78nL4bpi7irf/sZUM6MGdKpfYkWu2Av2IaxPXuETx6VPGbnDKEDkGQENdC49pAv87WCLqCSyKfOjCFZT3+GLOGj1Y6bVB4lJ1FCKATSBe27oFtBmct+FfF/nDIGqg4SjZgKNxWHnNuzrSA+ywhY3Hsa0BgOoqw0WIlGMcPuIGphaB7t04pEXal9YG83juHucz2aqCLKOtzug==;31:yzuefn6BJDE74BG+4JNHkS18Ug3R3DYoEUYFmEqvrPuediA3fWios2K8I8IK2UUM98jibI4eBBrtE3V0VRtv9Mv/3aG3HaoEUDjn98DtSEfdqT6jkqHvQgjKX1c22ONwyreG+aGzKNylJC8YMANS1LbQ6ITv42JnCQRnCDWrDHXTjKYPmNUJUwFy+bsw80gnx2fcT5PbJ99zVZMtJKKNmO562mQvwFNJDGc6ir8hc6E=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:E2LUuCIEBtrjvI9s6jYDYzOZSOfR2RfQ5Moxk3uHZSR4xXt59DZ3vxQjifUvSACT2JzdQ0xLKXLAdK3qrr1BejJpnmaC20LIji1KpBE8EiLJ7UfoY5mcHRC2wCpGYkBReqycPZtkpGe+UjKRtEVmmS9E5z5u3pS9LurJKfX4/8/WNs4U4Zazd0BkcneIuXlB7mfeoAY/K+PFmFi6tsTeNL0z7Uk+lyCdczmHd6W0i2Q7XKyahuZa1VT5e1DK6KVkJkUxrzfNYGTGzsyMM5XBtnF9EJ6AJt/E58bmbxpGplGXseMNEM/NQxq9HXd/APS24qbewTECJfDg98Zh6sNumB++baM9NiySQB15LQuABQ1qwQrhhwpvp30DEP/xf8HJucjbj0ICNV7Hj8b5lkfI6VMlLA2h/ymN1gk3tod7X7vbULdjcFRryQdlw8F7q0PbRwnw0RfqjRkWAt/3NRXqh0qpgs0Tw4onbcEYzGOmR6iIt2WOR7ODuTqYPqXdMz/W;4:Bv9whFsiKGezKdXw0EQtuRaqnr4Mj9gdpSoeAVdDkLzK/VNuwnXvFfqE0S7gl2Blz33B8TYyu9Jj6Q7nip4lAVzYVnShNFQi3ktc1wyBdcrLv4lEYgqZl9lct1BVts4aCAmhp3UYtt9UCJb/6tamAwmUaK1A7QfkheLumjMnfioXsx+uQV/ZazznSf2+1DoJUROxusWwKyEcYZU60C3z6eEuvdYxYj9i5B8V4AHPiCJgSqVihQJ5X1uwuNxuicviANs3B2FZ9unl0fwrzBUGV5CoE8TTGm1LZSemzGXsHg2/EDsjdEi3htSRdInS8BS0
X-Microsoft-Antispam-PRVS: <HE1PR04MB13239D0D11C1B03028D6A263F5670@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(53936002)(105586002)(305945005)(97736004)(86362001)(106356001)(2906002)(478600001)(8676002)(66066001)(8936002)(7736002)(48376002)(51416003)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(81166006)(52116002)(16526019)(81156014)(16586007)(6486002)(36756003)(3846002)(6666003)(316002)(386003)(6506007)(25786009)(6512007)(50226002)(4326008)(5660300001)(68736007)(26005)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:i563sx9HCiWpTSh1o/nsWICRYq7h1snJT3HiSm8Np?=
 =?us-ascii?Q?xnUDprtwkMGfN13YmipFViXDalpKEteEElslmyiR3mOdZR5+gD7eyIcCaOun?=
 =?us-ascii?Q?VQ9yJMZMKjat3RxgalWmIWy6Ub89bB+wpyYkl0QLxqRdaNZmehfgYU//mRzW?=
 =?us-ascii?Q?3kS605ITn4firePjEMtUUE4MF049LnUebgfWI0sntFyaRlNdHgvR+fn4Sq1+?=
 =?us-ascii?Q?8pQN8JnVabmj7RNUVxRb+vELhsv3TCYB/RIQvkuw66VYqFzD46+mWiiPysU9?=
 =?us-ascii?Q?2gf2NUIq56Hk0REvD0S8z8Ut8IYZSohU9aYUBrewmRc57S3qAnplvrFyv4cB?=
 =?us-ascii?Q?o4O0Ec0InAkUiPuUkD9pkvpGbq6TC54aEVZPMgCe7DX7aDYOPiSMvyrPyE2q?=
 =?us-ascii?Q?NhuK2v2yAcz43h7hSWN9MaE6aT9TwLGVt/K1M2PrrKaNZZIOnHBqFP1Qprki?=
 =?us-ascii?Q?NmoKCRCD5o5sI5jHYKOVrCtZikng/C4qKr0GTZ6jXXgNzTtMYPnb2K0Rj4Aj?=
 =?us-ascii?Q?XCHeFICV+MO0ElTWzQ5iKS0aKwr2rHLIFehdbgD8LoV0Oi6Vx6jVREwl3AhA?=
 =?us-ascii?Q?cPm827heR7UcBTp6rXiCZE389p8WTitE/VxdoNKs+phrgn7YC6lnVnTa2kPv?=
 =?us-ascii?Q?JYOiYi3KcOt/2tAWLmselut1nkgV/6OOehF83GhNB9etZXSFlZO+QWj6YDyq?=
 =?us-ascii?Q?CCYNUVHdj+vMKEcmAJxC1ZksFHzyVuGeNNfBisoEs/5I5ag24Vn5Dsg/y/Ul?=
 =?us-ascii?Q?kcFQJM7gXvMKiKk64kemiLhe4WwNPa30aRX3prj/XwQzdl9y0+aNCQYSXLLu?=
 =?us-ascii?Q?MSC32JqukmY9C0EV9yu00xSFvFn+qV5XHcTLXUKwTxTV08+PKpEK7kmuJzq7?=
 =?us-ascii?Q?00PyWwmKFuBQoLMTFeFKCuMc5iHFVn+BgkxeAtYXq7tz9rFo3Rl3r5l5+5uy?=
 =?us-ascii?Q?nvsxq7uxB8qcRNDKkkVPeWB3IUK8RGH1srM06LA5DqnV3UnRVc9LvTMD3wGZ?=
 =?us-ascii?Q?U8PzCUzd5xgqBq0e0U6zrhX6+zvGnmQu3/GbeFsscE2V4daRSWkMmPCoB31A?=
 =?us-ascii?Q?JDH9uNVqmai8XfyrCKcXVsrPPu/rd6xEuSvc1f/4fOeYxDEms1KZNCDAdTOC?=
 =?us-ascii?Q?9RUNCFvgho=3D?=
X-Microsoft-Antispam-Message-Info: zR2NW3DwbeGuKHueiy1H1YM2TV7Pb1A6jm01fV8QUxk6Lr2LdjWBFkq2+zcNFxuX873j1i4MHNkdVFizhnUneUSHA5nYkwArgIuIgstucZCAj3IsQore21/nlOX2esb7RWyORBDy3zyszTfKebEHLTht8AURufk81EZ8/U9BDnctnzdh8x9xFnV3mRF8egVT
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:Ac2xXz15bQuQxyF2tH3Pp5rsMLDWM4KROQX7cwsK6bbMrA3UsdU4/DAYxUVIIIN5K25d1lzZQeEpDPhV6FwNJ+Dpoch1dXFLYNW3EP11BDKQ4JCp7uNcheSrYxoP4NyatIsbULR6Nsq5PX6iiK+KU5EXpoHuF882kqlcKNkwGNro6GtS+xOyO8dmzi5hksB5nLQk8a3ATaNnXnoxixiC1xHw6nh4bJ5WuQTTNkC9IH4h/8jmCTSegswlAuJbO/H1OzTKEQdQIpEmihrNpiYCUikDU/WsjqL0YnuojdpM5tqwYWla+Oq82cT95J5f25J5T6KDtxxiG1ww7lzMmgWlMrEUO3N51YSQmV+uREF8zxUIrFszoRDSMCpZGx8wheUOwrIPMuoV+gsnaFuFVIYAHHpBnjNYmHF6ffFLzwBbv4fX5uuhM82TPArW1Rf1Wchu2kTUbNFVs3/gyw4YMqZ73g==;5:Qb2b/vfSommDEQqKuyLNK27q3xSDNUphj3r9RQoQDcW6LP91344YpZPisrCvwSqw43RO67gWIsv9tXyqBQF9w02yehOPu/EPtyN0PcaCktMJFsiInaLJlS68r4MQ3NyPNhBcklgw9MY09QzY69xn7TTvyDmKcjoREslZn4V4gn8=;24:dKroQ3HqSIbbxUTzJf29NmL56MXWZYV83Akh4ANgLQIsz4d2Q1Aj2ARf3e7k9DKL4Dk8RoCNoCeyUgwssxgrgjxt00ClTV4prS1f3WACons=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:mpz4CU6uiikT+uKQfNAKoGAy+fufd/wfphiVsUtYfWYQHeQ0R64wBwAEjKcUrX21g3GcVm1BOffjYA/55NCspCjpKp7u+Qge2H5CJMODiYhyoSyY6ZGkKKlDxZf1nOeSDX1pOZck+lGAZVm7MPtvTrxdcqi5ZEdW3e5gWXBz54yiEdv4uaBJdTFQtLUAS1fP+BqHoCLLcrgTLxa7O1RWxyA7Pn47sZlVVqn+P4wU4rTixGRluwtdGQxb3Zt4OwdS
X-MS-Office365-Filtering-Correlation-Id: 3651c602-c3fc-40ac-f483-08d5c9b7f595
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 01:10:24.8141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3651c602-c3fc-40ac-f483-08d5c9b7f595
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
changes since V1:
	improve commit log to explain why no need to add CLK_IS_CRITICAL flag for IMX6QDL_CLK_ARM.
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
