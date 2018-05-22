Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeEVD3x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:29:53 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:24873
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751893AbeEVD3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:29:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, michael@amarulasolutions.com,
        matteo.lisi@engicam.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
Date: Tue, 22 May 2018 11:25:59 +0800
Message-Id: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:ENFxactCnPedz2As65NxIClXovGYo3aDap67qFiA/o0aozta+BIkR+cqQj9AYqwjjeNgB/xtctqVpIrsfCNhdV3RpOn3TuktmAH/74wNtwHssr2WYfKargh4HDfTeV7wF2Y79ZWSah7LWR6cK3IWvDyaUMgqQWJb0TJey7AEzaiwsBJCHf4FCtWVCQjxoWO9p8PxP8rA8qYC0C8toFdIOejNw9ZScZ0iBPTlIc20qahleVWbbDAlV9ZB2caabL70;25:xu7xhKZPzWfkOiH8txQmAgOoL2jLyxyB9/iyvljvQoP3axjCbDsG4nKwNEzRT2+b+vkntZJ3EOu+ZS+7RSYLx/JV38aEK3oZjSarq/YDvhzjMz3RR+FpM/kR7BgTNl7gW7KaZdJrmhOOP7V5cXbC6qnJRAF2V79wTHcnjLzGv4RbBVQ3oOr3P1+p0AyGxh9nye8RVtJdtl79en+dkJpLH5Pq0cEDUbpJQpCay4UE6EIrVJA8aXhZor2soc6b79+eEB/nPXt2foI5qGVQV+kqZuhfXkbjvfmzwW/A7+OoDK/zvcEKkmHB8CYyuBNU4Z9SclGho2OM4svq2HiAnv5t2A==;31:cu30x3ZAYUb8fUZxmR08xb35xgPRD+lHu+PmVkmXetIF/QdhJawm83mOvfMPqXxp7Z886BkRAGdv8+GffeWAI8vu6PG4a0gPm5ztoIP75KZJdbsWs6UAKbB7RKkowPcrc1D8NAJd8bXDEbZbFpyzhe6XQd8fOKNDWZo/+VGmO4jsBhl/kDCzEr0p1ppBuwdCoaDaZ1zHXhjZSMN2C98hmjmGGH8rK12uRn0H7eQ2viw=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:Ru3ETKiWFvH6p0zdIV6moKSPIiYgLi/RSWfaBv5EuCGlGASNwc5BpQ4SdX2ELaEtWHy8D//vy2Hv6yIXc37hGjNexKfKL5VL4s443a/gkWZBQsmKk8Jd/M10Ya8i4tXCKBif7R9pbDd+m3aF9i5q/w8bCUE7+DV+kGGZSOuUOyy7hof6gLCfIkL8TSU6gzzcdov5NuF2RNc6I6ANLgNSBxzGrYqAjtQvNmFW9CiBwHoYH4Ubg58u5Qzl6I3tuBY3RoPN7RQE/Zht+/DVxiMSQ93zu+L1dOXAMUY/RqC0AMpZA24u43ZMidg+zFsJZbJi9wgGYbpIxYdNXGcvrWfe52y+EbMFsey5TwQa3lSUZJ5S+f2XcVoPLgcZ47K+6GAkrN4GcQobjz+tz/wekpnYBTouD0vQ/6Rkp3t3wfVest0ltn12HCFQSy/gc7QkVPfDtVxppcKk3HD/65rfH/WwIVcio5YyA6pj11QFicmnCq7of7/ISTAZWl1vnzAlp3v0;4:YycfFuNiCKVG/dsQ1bdWbVvb+OZTsVbylu7pwWMqEQ0WsrW0HVaH+sPZ46XZJWKtcvIOZ+HA+Ct3FDH/ROB5IMT1i0FYtyJTK6RrPTVo68aWZoWNOC87gGlr7mFi5jZee4ba9J2UqT7OaDYMucXBGaHRKCSoacaYxbuAaAoRcLEiOSyZrF9jp2mmC5WS7t0ul9xvFLnenGpiyDJX/H/WHuRo64wgvWLkJmh1TwgoXi3o1gERhYaReeceUmtPZZMzAcq71jRgtDXF8vpdP5j0+riCCyDNu7+0AKa6FGaUHShqgWK3i/4qUDqdvhgdwhS0
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315EE2B8465A7B9A7C4CFC3F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(366004)(346002)(396003)(189003)(199004)(316002)(16586007)(6486002)(68736007)(106356001)(52116002)(4326008)(6666003)(81156014)(25786009)(81166006)(47776003)(3846002)(86362001)(8936002)(305945005)(50226002)(6512007)(105586002)(6116002)(26005)(2906002)(48376002)(5660300001)(36756003)(386003)(53936002)(7416002)(50466002)(7736002)(16526019)(97736004)(486006)(2616005)(956004)(8676002)(6506007)(476003)(51416003)(66066001)(186003)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:3CPuGx2+nRAdCN2+MPQUyQbuUkcqXtjESo0FJmZnr?=
 =?us-ascii?Q?amqWHKZ+s96TjGik7EpI48ewSH0NVmEtrJ22bZK3EKjK0j2qzfXVCzXhcr2g?=
 =?us-ascii?Q?4W/aEK3Jrq+mChYO8ZH2U3XsesCa2/xCbiOCIxB3diYELb8OHtDZyCB8VCog?=
 =?us-ascii?Q?yCWYwEf37gWtXH0Fbgm5rfck44vgVCiJil93dmMD7ez0cUuigdbHa2CmMw+X?=
 =?us-ascii?Q?95TwTP8drtXgbY+zXVFoPr53a+c4VpDWakdLXuZrttLBoCd1Rs3f11HnO9w0?=
 =?us-ascii?Q?POxbF9xCZZ9NN/Z3R68yw8nd4aDTJEAzM/X8Mlj8LFRLy+W/wujf38bHASIB?=
 =?us-ascii?Q?S1Vx/9bXn/miQIpeZR2fbNN/2ihZOn9Bc8DSiHK2uT9HRwemSX1gCg2sAT3C?=
 =?us-ascii?Q?sWfYUynjvmusaOsT+9ZwA1/4qN1MYl+muwl153iUD9bb2cssjBe5jeMBDtpC?=
 =?us-ascii?Q?ZNVWmTp1xvNCfnai1VLU60eS9/vUxuwc1f4YBTRyghCNKdX96nuuDPEPMHdk?=
 =?us-ascii?Q?1SzzsoE8hdfNRufBR5PQ2xU7xCDlpeKkeDwm6U9offbcCZLM/mn0yfjLFuew?=
 =?us-ascii?Q?po3QCV3a6EXrWy2xW/DEN5pY/Azsy+3IJvgfg/nCG+aaZTwsM3+irPgonKJs?=
 =?us-ascii?Q?CbAxzvoCx/NFB9I43zUa5g70d6Ag+cLme2cM5rcepU6KlKXMT1noecDH+ZLZ?=
 =?us-ascii?Q?feVPYxTxccD9ntPSXSAPn59f2PjKNTaDFs/BI1/ZzwxJKxjxLvJhW3UU0EED?=
 =?us-ascii?Q?BJV+8wN7/QQL0LqNTRbGESTywVkcDm+3niW4aoNFo7iGtQFm2zgugw9TZywW?=
 =?us-ascii?Q?lQW+ralSQ0FsijJVw4/HTeBAthw+PnWZcDv4AbKzat6za2CTg5WtOB2xadsc?=
 =?us-ascii?Q?i+jvfgZ7Dk137H7I32ce/u4r3aAWmCIL6uw0dBnzxGyioSnxosWuI4+lDxzn?=
 =?us-ascii?Q?vHRnLy7wC4Zp8kr6ZFWMlRxYjGaWOz5bSGvi6WGGf6owN6R492McNU0UBJhV?=
 =?us-ascii?Q?WZNSig+gckZbJWxO5Do+uUEE13pUmLYj30C0uyF2DysT0yJt9oLWXe64K7e8?=
 =?us-ascii?Q?VkN5wcDVF5zgEi+3+xk3ERi7P8qT21JiLHyFnwU3co0VH5LAj/tS6bwMe4vo?=
 =?us-ascii?Q?vkEll/p/sY1i4cjyULya09J3Pwvsh9b?=
X-Microsoft-Antispam-Message-Info: zqJojLHQMjHi0lRDPqzdcBAbdYXQp+yhIr1DPTx8Ggvhw9RGBt1Qohpohkk2SUCYyWobML4T5EwYi4lx6Ut+ptTuPne47ITp4LeY0SA47mDSZRuRif6Jj63rAGiWfQAEYMLUl4ds6GYSwkMLVn+D60RKK4K5+1vrxaohI+WM8NePzhI6ckPEgBSuiwPxdKdh
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:SLRHKASFPxsmAOpE6hJnCEd8WcvRrP5ncSprIQmmE5y0VmpHW9qViX3c/MDb47wuggnbDjQ2xIKYlXzvBXmoE9nYLTvMD98+pYOZpQzZx6l7MbGzisi1NNfFxDQWyZV08qRsngT+zonHZILeAh47hLGiWLbC2U1MnBEGZbVNJ+o3PRuf/C9xhtoiIbaEP0eqZ8Mt678LHlwYWjGLl0XEsptBp4lvysCWrpOTzq/+XT7lRcpGNhXRANdFDhvJpguoNykp5dNTEGvKv1To/gTHWo6gQ+w4SQxWL+al9ZE1ITczNf9RgY/m95IzdjLVAWTXa+FtDt1ifRUcAj3jJnzl581Eu15vOd60FdceLg5wCLFeX9gHBqR/kCQVJBySKeDzZN9XJurFx5hK5lr3AbZN54xhy0b83jPLhznkpaIJBAg4sDPQ37agaOgbp8qISCr8sjH01DY6yUen26x0tP2JPg==;5:Gi7HK1FQZHZHgbhCOkJ0Hb5J5zJ62ppNA9/9DiRGkCV6aM6STsl53cuUxyHBH1t9bhrSHyDyCAbZI539kkZAghg0fyFdIoKxjPlwxJB21gk0hwv27nX0pg8+rzE2ftT9MdGPLnIXMVnctwgqIq8xI6EU15mlVNhPrUx0V9gUo40=;24:AVxmWyfHK2pxwpR7EEqHpeRVrvMK+SYgNysRP35ZyKC+4+W4q3qzKf0lHSZPTnUcMj/BvQ9AdGOdgeA8ulX9VInmRY/pqEB5KeUaT2sKnHo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:kwcGEm87gc4jTGtN4PpDHrRmmiscuD6Ufjl/BCSm5MxgaPpVsILmaIoDTjHArAiKUd+akbh45OLHeyDJSezXEjlGP9VfuoTaWpSh0ilnh0KiKqCa1vsRpKxwMou2bi2ZYtwEqJ6Xvs0MDKNCfhV1L6so2Q4oRhOWFaAem57T86unlIMPxVmyedzGAAiNplABHwYQFM27tyuZ+iVHZNoGCRaDw+2jeHIUi5Ff21sWBIZcGVbV5jCpVRaXlK1aWtfu
X-MS-Office365-Filtering-Correlation-Id: d60bf8f8-cdac-4d9b-00c3-08d5bf94422b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 03:29:38.0842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60bf8f8-cdac-4d9b-00c3-08d5bf94422b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL has GPIO clock gates in CCM CCGR, add
them into clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c             |  5 +++++
 include/dt-bindings/clock/imx6ul-clock.h | 31 ++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index ba563ba..3ea2d97 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -360,6 +360,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
 	if (clk_on_imx6ull())
 		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
+	clks[IMX6UL_CLK_GPIO2]		= imx_clk_gate2("gpio2",	"ipg",		base + 0x68,	30);
 
 	/* CCGR1 */
 	clks[IMX6UL_CLK_ECSPI1]		= imx_clk_gate2("ecspi1",	"ecspi_podf",	base + 0x6c,	0);
@@ -376,6 +377,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT1_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk",	base + 0x6c,	22);
 	clks[IMX6UL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg",		base + 0x6c,	24);
 	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serial",	"uart_podf",	base + 0x6c,	24);
+	clks[IMX6UL_CLK_GPIO1]		= imx_clk_gate2("gpio1",	"ipg",		base + 0x6c,	26);
+	clks[IMX6UL_CLK_GPIO5]		= imx_clk_gate2("gpio5",	"ipg",		base + 0x6c,	30);
 
 	/* CCGR2 */
 	if (clk_on_imx6ull()) {
@@ -389,6 +392,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	10);
 	clks[IMX6UL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",		base + 0x70,	12);
 	clks[IMX6UL_CLK_IOMUXC]		= imx_clk_gate2("iomuxc",	"lcdif_podf",	base + 0x70,	14);
+	clks[IMX6UL_CLK_GPIO3]		= imx_clk_gate2("gpio3",	"ipg",		base + 0x70,	26);
 	clks[IMX6UL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",		base + 0x70,	28);
 	clks[IMX6UL_CLK_PXP]		= imx_clk_gate2("pxp",		"axi",		base + 0x70,	30);
 
@@ -405,6 +409,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART6_IPG]	= imx_clk_gate2("uart6_ipg",	"ipg",		base + 0x74,	6);
 	clks[IMX6UL_CLK_UART6_SERIAL]	= imx_clk_gate2("uart6_serial",	"uart_podf",	base + 0x74,	6);
 	clks[IMX6UL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74,	10);
+	clks[IMX6UL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	12);
 	clks[IMX6UL_CLK_QSPI]		= imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x74,	14);
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
 	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index 9564597..1291328 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -242,20 +242,25 @@
 #define IMX6UL_CLK_CKO2_PODF		229
 #define IMX6UL_CLK_CKO2			230
 #define IMX6UL_CLK_CKO			231
+#define IMX6UL_CLK_GPIO1		232
+#define IMX6UL_CLK_GPIO2		233
+#define IMX6UL_CLK_GPIO3		234
+#define IMX6UL_CLK_GPIO4		235
+#define IMX6UL_CLK_GPIO5		236
 
 /* For i.MX6ULL */
-#define IMX6ULL_CLK_ESAI_PRED		232
-#define IMX6ULL_CLK_ESAI_PODF		233
-#define IMX6ULL_CLK_ESAI_EXTAL		234
-#define IMX6ULL_CLK_ESAI_MEM		235
-#define IMX6ULL_CLK_ESAI_IPG		236
-#define IMX6ULL_CLK_DCP_CLK		237
-#define IMX6ULL_CLK_EPDC_PRE_SEL	238
-#define IMX6ULL_CLK_EPDC_SEL		239
-#define IMX6ULL_CLK_EPDC_PODF		240
-#define IMX6ULL_CLK_EPDC_ACLK		241
-#define IMX6ULL_CLK_EPDC_PIX		242
-#define IMX6ULL_CLK_ESAI_SEL		243
-#define IMX6UL_CLK_END			244
+#define IMX6ULL_CLK_ESAI_PRED		237
+#define IMX6ULL_CLK_ESAI_PODF		238
+#define IMX6ULL_CLK_ESAI_EXTAL		239
+#define IMX6ULL_CLK_ESAI_MEM		240
+#define IMX6ULL_CLK_ESAI_IPG		241
+#define IMX6ULL_CLK_DCP_CLK		242
+#define IMX6ULL_CLK_EPDC_PRE_SEL	243
+#define IMX6ULL_CLK_EPDC_SEL		244
+#define IMX6ULL_CLK_EPDC_PODF		245
+#define IMX6ULL_CLK_EPDC_ACLK		246
+#define IMX6ULL_CLK_EPDC_PIX		247
+#define IMX6ULL_CLK_ESAI_SEL		248
+#define IMX6UL_CLK_END			249
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4
