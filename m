Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeFCBrv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:47:51 -0400
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:32160
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750952AbeFCBrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:47:48 -0400
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
Subject: [PATCH V2 1/2] clk: imx6ul: add GPIO clock gates
Date: Sun,  3 Jun 2018 09:44:04 +0800
Message-Id: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:MYFuLw34wJPvWPylVyq/aaus7nPrQVBnxYjS6CQ0dH9ngVmqZvEao2VpTVzHJDazacl7tQ5Z9SJNoCVflRViPJBOtQTmUlKKUEPzN1vLwNlJEO3Mp8U36BdcdFI0j8wQ4tbPJNp2nqTaPN6AN0VU8gexBov+kwKYrjDsBrBCDH4pL8kgvIThSCbYXMz6HOLvUbssEHHuua0l0/2kaX7/0ISAJONSIdduCGCTXMeZcAo9m8p21SIEljP9aCMKC9T5;25:bfABOesLTQa8cpEt0ilYoEIXNflYFufKxGvrot80E2Ex6YOGYjTcLSNv5pj7vQiQwmm1VGICxLpW00g4X5sqBWoZSrNCL4OrhRAptExm4pLHMa+CIgaqe1KvmwZ7BRwjlyiMIjemFQWw7c34ybmNuJctqe84md6xhsBJ9bJGJVXMg/YURGqk4tKpXHn9oNdETgUhFjGh9f6CwuD3er3kngFToh2DOZKWlMHZrjP1EKbkLEbeTZrcCFNdASyhvg3GQheC3ld1AgmeIQXkALe13KgWjKP/itdLd2BJEMJfc484yQLCvzffxQE6CT4jTSDfU6NuGakDiec2e1j1/lod9w==;31:A8RCv4uY6WHavSoEYFYwZ1WIOkiV+SdSjHbVWv962Vu/VIcAVl7k+fPdOlxut/cJSwt+Z8HqrwVZt3Ka9pHAb77KO/NffbpnHW9EAj1geGd8c8UnTvfMyRBMm8J46mi+PcLOj2yrbST16GwpG3nM38UtuZj+YJuIITsdXiDo1gBep0+/6NEyW/2icit6SHypprcwU6eSS8DYcmSANdFO4rSKLTar/8fTmfxPDvGQHjs=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:2AMwvApeG4NdiS6OjXI+8PFDN1FNpbp77xv57jFkz9j1c5KjdY53rdMCZAlgWoiF4SXLhSydUqILeIynw0iA6K7sFbHIJ6yuN97TBGr0hKcSXHcWuFDcs3ABCwiTHzNzcSRt8N8qb+/RopEbW+pqgd5tPu/UFuj9uh9EC3p70pL72nQoZ00ipu8I/JaeFcfS7uwxfwFvMxNGbVOkzgZRrW+gtpHlw2p5TDapUqnaP+70iDRLRPWkcIEt2as8ImLKvfQgu2WL+IEj92i0FtgpF/NFRXNzvuPL2roeb5vyTtBWdp3aBZmt6g9XSgJg/WM04+IksXJeE2hQr9+tSYIIiHoeWzfKPXjN9+wiRQxfNbr1M4SzOilhRI7PY3lAZe7zeYQhVPDXZzU9BRfsECvDtHH61690qgMwtrpj5V/9VWcatBOg3Phb7PwrjVVps+/d5cfZqBMB9izVpIPys/s8LX3NnHNJrwQ974Tk+VSfvVYSkPXqTokjmKcaBYSDER3k;4:6rbkRw9+ayEO0XaM4XgKlQdRSARRP/SRqxwRTXZtsZAlip2PNa4Oeb9d+aaxBPqysYx4OVNhh8j8VFpzpaHrT1NZrIY0v6Sn80uxlueqGuhE6qf7O+iyHQC8DSyyz9IC7UkJH0nO9ktZfSrm3sf4D46/vivDcnu+73vcZ0Bqsq7V2vouRKj1YfB4Gv48XwlBg5+JCdFVtWh+/D+3of4DZf9rCHg95gWOFRLFMbgS+6L7kECkCWzmsZlDhGecUrz78ZFuxAje0bXI6lb/CA6bmxVNy9mdIhwQyYsjD1dfc7Q7wbwA+agENyBzDcJg5LhE
X-Microsoft-Antispam-PRVS: <DB5PR04MB132088B4FE3A0695F237E5FEF5600@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(39380400002)(396003)(199004)(189003)(8936002)(305945005)(36756003)(16586007)(81156014)(81166006)(8676002)(6486002)(7736002)(53936002)(316002)(6116002)(25786009)(7416002)(48376002)(50466002)(68736007)(3846002)(50226002)(97736004)(86362001)(2616005)(47776003)(956004)(2906002)(6506007)(52116002)(476003)(106356001)(51416003)(59450400001)(4326008)(6666003)(26005)(5660300001)(386003)(105586002)(486006)(186003)(66066001)(478600001)(6512007)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:DcZU6hKaOS3BVnFnDPYiZccR68MpPCmIqOx0zzPtn?=
 =?us-ascii?Q?pvd5hgZuedL4F0O+uIuDh0gp5V/p+ATKiJIDY+bh6Ouarw4IC6dWmGQWeo/D?=
 =?us-ascii?Q?TlJ4CrKO8IRxRSzkPNrID+7enUICbvki771bnsyrkyGqZ9FEEOz1HbLxAHoA?=
 =?us-ascii?Q?Af2XuZRx5vfF9ObnLwAVrdBvqptBUwNSHsi/Zo43ak7EGCF5YJiySFhZ+wIM?=
 =?us-ascii?Q?0pkcXlz+mhC842gt+ZXk2r2zChSS7xSyUVn0uyEK0cKPAGnFeslTXGnYfvjC?=
 =?us-ascii?Q?c/jT7Z+CvuPzIHbY19usuko/Vm7B9HKQjA9gcxYQilPb6A4/b9HmSFxQwQD0?=
 =?us-ascii?Q?LGYfKPul/lZjcmnDxB8dhmblXLe2EMSYfPhLHTPXCkXUkd1KI/qnC47wtH50?=
 =?us-ascii?Q?P/WfscyvOsPOJ6Bj38gsUd3csGtR/ojHeO6rLJ2rlhI2MyljZ38wsVkYg3Ul?=
 =?us-ascii?Q?iVjTx0UvAjcrZ0YdxwiZ86E2gJfm1Q0ILk9vRydul80ZcxhOPx9aOqwz3FMP?=
 =?us-ascii?Q?F0r+/rDIh4o+cEkSK7t9Wty+eELPJOIcRN95URLaGhH88eKKG33nqk6ePwiC?=
 =?us-ascii?Q?ZFTYBIuId/f19m/zbcSqNKBvHfY9mnI6NzTN+8ykgczNhNCUzodgHbpsKpjy?=
 =?us-ascii?Q?gDowQfUZKabzv0DRKgN57osGZ+R+D5NQApBqUnZBw7tqXI98a4O9PHGAHAXY?=
 =?us-ascii?Q?RVFhMTfgJHzYF1cBV7V8GKGY2ZXqlB7oIMYN//a5gO4uC1AJ5LpnftRh4gzg?=
 =?us-ascii?Q?oKJB5kVAmzP0NEcRJ4dXZ4xNxCnpS9M91IIL7PPhHs+4HszX5lKcSLUXIzQ7?=
 =?us-ascii?Q?GRgs0UBvT6Ck4WP1yaxSA/lfD7LygAKivwq8gbuEcidYiROPuhj052exQU8c?=
 =?us-ascii?Q?fhQdxcIjyhSXwCMy/tt4LW+P8AojvuFySTIQEzy+GzdU+azjMfUr5E9UXtY0?=
 =?us-ascii?Q?zLuCEMD/SNT4rvz39guKjKUW9l0sAjSJQPVIf+codrV1U9oRyhplxC23qWQs?=
 =?us-ascii?Q?yrhppiqNlB0AqEvE+zX7mZKhC7wi/gNHAyvFD+DmD98bRkDAE+rHSiVKrWu5?=
 =?us-ascii?Q?ynOFdUaqlyDeP+aJn+4w9Io5QET3R3SPM8SEUaLV5/WEKR99MxpGk7En906o?=
 =?us-ascii?Q?zxb4kGLpLVGPh8mtynOfwLd4FbPSs4F6aNgphp5ZqeGeJsA3p+Qyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: IapVULfJ3/vrxlLN2m2v8B9KxCWpxWuEXyUg8HBFbFx3JCyF1aoxIn/L07GAk9c8PphoWq646tP0B8ZBWZgMEhxK/C76KTLwqn/WRhE5r6jBuxl+Agg0cHeboxejcdzdo9iWZ4oA9Y1noaGt63yrNinBn1lXBj46k8wrxWFTaaRI1QLu+zh8KY0dy35Bh6T5
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:FymNrdwLUg0P1Bu2Yzl9783UYVuZHdTwpAHqEPRiXxr4PjzK371hUC15pSttEWGKtvHGg8L/RvE+deWnWz19O5mMbGmN4K6GgoMWJn84E57vZRrnFy0nIPURRoAZu7yzDrxCpieZuOe83LvGjK0X3QuIlF6M1+3TBukTdDl2tq9vol649+s+zP93aaS3ZKIvKHTfuNLuVZbiKXwzgd9CwaFFzZjDHk+65SOzhwsnBixNkLRYb5T+Jg8NDi2dP7WHJquVHo9OdSgTbDqFR6Mvq+GvchXLvLC8ctB9U6ubApO7dQhx2Yt/UsQxnrMm4lvGWRyzkZWipib/AAFRAG1G77d1sEc4MMFDZzLK/fKth4wiXmOlF9IKLXkH174vddHo5fEoEogXTCkE0vE2aKGvh/sbPU8EegiTPsjFlje58Hl3gcWsG+wG2VN0Pt1IlhmQ0NxpvSGgKNOaiC4BpmH0gA==;5:8XWLypC01VwmBOeoA7GHTMSuM54P3ikrquyEofE1rq9DxKwXWZ5r8AAfNFbNMFXA8qV1yEwXgKaL/SaaS0bTZzIksbp+u5L2EbRpyA9pliJSWVHgtQ37I1zPJF0cMbxCpwXnG6piswIwTOxwEvZpETcx+LjwJB2xCL07ve9EnAI=;24:Yu6E6bi/O1vdrA7FQk6Oup5Foj8IhAtlZJYgr4gRHvduKAJjWAZKIZo2jATOoGBcLNP7EP/yfgC2tVa4APQ4q9JN+Od7xv1jxKwdnyKHzeo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:kffPeyj5qiFotmWTQeJe3m9xrjnYek8Le8zArCtdJ1LDVSEBktcOuC6YGqW5YP+g3mnVLWtftoEpM0XQiY7bdO/bNGVmdZPCiRlT3XQ+E9/es3vg/emPyTudWsumBBQJ3zZCvABjeJOL1790qnOu0CsHkPiufSGqn5Y21v5bPpzbUoFhTb7v2HOzeUJ+EflrI5ro3X1WeFR9zUe2iPmipzxgy57ORipez5xhS6rTYzdPri/CrVQHlwR15woWrzK6
X-MS-Office365-Filtering-Correlation-Id: f560ccfb-d798-4b65-4970-08d5c8f40022
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 01:47:40.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f560ccfb-d798-4b65-4970-08d5c8f40022
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL has GPIO clock gates in CCM CCGR,
add them into clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	Move IMX6UL_CLK_GPIOx definition to end of clock table;
	Based on Fabio's patch "[v2] dt-bindings: clock: imx6ul: Do not change the clock definition order".
 drivers/clk/imx/clk-imx6ul.c             | 5 +++++
 include/dt-bindings/clock/imx6ul-clock.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index 0aa1d9c..f8e0476 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -254,6 +254,12 @@
 #define IMX6UL_CLK_CKO2_PODF		241
 #define IMX6UL_CLK_CKO2			242
 #define IMX6UL_CLK_CKO			243
-#define IMX6UL_CLK_END			244
+#define IMX6UL_CLK_GPIO1		244
+#define IMX6UL_CLK_GPIO2		245
+#define IMX6UL_CLK_GPIO3		246
+#define IMX6UL_CLK_GPIO4		247
+#define IMX6UL_CLK_GPIO5		248
+
+#define IMX6UL_CLK_END			249
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4
