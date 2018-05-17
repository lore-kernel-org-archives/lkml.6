Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeEQFEm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:04:42 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:62940
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbeEQFEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:04:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx6sl: correct ocram_podf clock type
Date: Thu, 17 May 2018 13:00:48 +0800
Message-Id: <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:2e::28) To HE1PR04MB1321.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1321;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;3:IdkCQlTa8XrHfgOzcFtw3Wz+XpKRlWRKRRHCl39T+x8M2iHJTc0xtsxB6NLkN6kn80MWDkM8USXThZLQ0st94sPNGKQhL0DjmgPMR9az5sS2OxeiKSYYCJqFgDsv6UmTF5tf7bDGX0NC3kgQe5SXMrl71MRpL57P7+VIFf+QKCu66gYDdCyl0Z0QvP1gkS3kP/zYcpuVkEK1npOHCyaJwc+FO3QMmLhkI8ck3ISmFRCTLhj1pVAz+rA60bxT+W+e;25://ZJl+a7ZsbojercAgqFky4SC4eqmLBw7KtPa7KeoVslbWQiGX/RdTDju8vbDMCIHNqKmWFGnPtSO23gqC2TAgNzt9Kq2s3HJMQCrJda2SV13F+Puxce5eEyzy9+ip0WkKGLUb+A20gk0bQUCDAk0K1TZaWVpg05tr/4B4pPVApNRg39MmhG0P1zmj7lZ9BFerteOSNKo7/NlPp5Dy6KDXBE5R7C+xSenuPAoGA8jY70sw4H2igoUDxYTqXguVAOc7YilPCB4PYcaC1k1nyk8OZH5V01XLAjX/Er7QLEp3gxRmNQLIFgP7uWNTNzl4AVbSu+te6Al1dHHIqgukgE2w==;31:Y03trbvruMTTA0T7t9GeVJ0ISU8igqjwkIq+QcnnjZd/1pJVg1qRZU0cruRqhSdHqPVneqUQSvn2il19Z/FZqxbpE0LS1aV/j01cdYo1OvLAuDy+falpSkwQzgEmqGA6FM5fSFzQnHTFFgq7ukxLeeGHgGmw1lKr1luHKqMX4dZZWsqOScKxsaCrxg0AJmOuqddIfyOtHB08BPUvjwnznn4O2OxjiCVtkmjNjsrX82s=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1321:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;20:oADtLHzPhqeIlbP3ASi+Y9ZWEcAXyFuvh7gxY/Z5nPbrOpkaa1oSsRU2JGFGO9L9GnoxuwSABzZK4d3J3QHfEa9X0KJ8SHgPKKDVMiSMPv7LpwkkqJJ3b6IDeaLS708LBqfGFcZzPFHriddLc4cmkYzFpBxaFt2Z0HW7x+1lYkWdjPcVt9Ju5t6nBBbH5wQawe9j2JoQ+PYoPYz5CAONMozIWWx+ZCaV/+XrwTwJfRA3iiSsH8ahSKAb3kFlAojI6b7BJwXjbEqqAzuT4Or4o6o1sb/i74afSGFNK6/rhVmnvhLV4Q3O3YE1xoBRuvZRw7eem7V45WO4lwiw4HPQ9LiuMogQYqcWPqYNwkp4rQ3YW1HWBOFrVPe9VRpELOKwNgyv/iEp94dUbckdT8yaXXDqVY9bBk7TW69R2LHN8TEIigNkAxiIE3GvmyxM37FEM7b0gPrpBhXo0KdBrI/quQ0TN/GJxRPyE1tltXiIZescbWImvD7jfyOGxUZrCU0u;4:Swd0IWVjHCX7E6Qx71kZkTgopmB6HHaeqvBzeMcMUxqtSDjqPPOjE0cWJl4Nip2n8TBuOpFOZ5n9f0ccokr4DF8G7HkoIGQSSoQLh0ooIj5+4TzU4oSq3aPzH/gabGygCa0DCTyeJjVrwDoVvrhiQTF8EMu3za/0aym2wj4fsKELrBJCnNgDIUQSZEKzGzELLgLTqGJgyxHX89DjaPxMqLWbEDSlHfM851LmyXiQWUGxsLZjNR8VGiohvetBU1Pf8jtCaTFqW2+eu7avsNNUk5dBAWu7c2yCH0lkad/knWlxO7/r+Ztne9xzbfUVSt18
X-Microsoft-Antispam-PRVS: <HE1PR04MB1321E9D53B5EC843C5C8B822F5910@HE1PR04MB1321.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1321;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1321;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(486006)(48376002)(6486002)(1857600001)(53936002)(50466002)(68736007)(16586007)(446003)(956004)(11346002)(476003)(2616005)(6666003)(6116002)(4326008)(76176011)(52116002)(66066001)(47776003)(305945005)(86362001)(6512007)(51416003)(2906002)(3846002)(386003)(97736004)(6506007)(25786009)(105586002)(186003)(59450400001)(106356001)(36756003)(26005)(5660300001)(81156014)(8676002)(316002)(81166006)(8936002)(7736002)(50226002)(478600001)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1321;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1321;23:j2N+zHtMTr2v1JgUT+zBY/CRJIIV6QlmZgzegFxSj?=
 =?us-ascii?Q?0z8VLsl1lwdxcoNp7wM9SHqtjrlNxoaqagL5jTxZI1P68HIhZzuc8LJL04I1?=
 =?us-ascii?Q?dm3MHhQ9XWk0Xi/O+JzotVBLeKPzFeZgaOphehk9XUaNCEGCp2cceOxqocMw?=
 =?us-ascii?Q?wYzv5qxhsrGf/ya8aCkAVblKtmGf882diKX6dyhDMmPW0DsygwaTbcs8VY8d?=
 =?us-ascii?Q?qU1LAkKxcIldav6KrxxORQIZU+7X+zr6Ywg/9D4kVcwcOo6u6ssh8WG4g4TP?=
 =?us-ascii?Q?Tz/+br/oS54+nQdCS7eK1iztATLeuJ5WLRv8K55JtJApCnyeFp6W2wlAIl0N?=
 =?us-ascii?Q?zDStECXJzzEZqfuWaRd/Idk/WQIXW+AYzW2cFrhRWn1RijryCRmgj51oRtH+?=
 =?us-ascii?Q?gNG7d27RxAVWVlCQLcO54ho6Is7nSZlkq+gRTedXu7Oxaf3d+4El8y1p48yN?=
 =?us-ascii?Q?U3oWg7gM0mi906+G2F07ihK++hYBPp0y/JNDHcY3tpVKL6P8tIO3Pl947WPr?=
 =?us-ascii?Q?4hZHg2kOXYU5cjQyUM4CCwx2/aDLwefDqCO7BjBdli9Ug91IrH7W7dcpK2jp?=
 =?us-ascii?Q?TL2eXxrDxWxqbLEmjiMOhGqgbYtdEOj1JnLBk6l2iLx4Lh/Rr6vcKte5fnr0?=
 =?us-ascii?Q?Imi20NqVIUW1dLr9RQ39439icz1ATWyKJAGqGYcPdpru3h+PmrUySHhpGcs7?=
 =?us-ascii?Q?kQwkVo88WRJdrLVAm9y/ged476TA4Mg9Y7U9122s7L/Qz+OYdFhnD8kW1KCS?=
 =?us-ascii?Q?y91LkFF82SMF5GWFn8K3lh6hyciNCkbPQ3yekV3b6nie7hOyPNjtsyCN/xAN?=
 =?us-ascii?Q?qOWzIgxsN5j02SyDbCL49y1BxaLMe25P3KPzp/txPClg516ayQAjPfwkdlQV?=
 =?us-ascii?Q?C7dGuuFCEgVZ5O2uGKpXQp2NBeub+lP+Pp7H0BrA1ZjgQm1OGyql3Sxivhd5?=
 =?us-ascii?Q?L2dmMszrsETvtS3NOrykXYHGj7YjX5cv3deggLVEXFBx21BL8CJdE8oTAzDk?=
 =?us-ascii?Q?PBZlaVZftdCfuF8A9nMXiglSoaoOPih7c49K1KIPGCBOf8jhvSUOzaHlJMFq?=
 =?us-ascii?Q?Rs96W6WZRrvxutsapAZcyGx5a3Ol1QSlpNMDMfcnmTdDKIuk7lZFeyzvwpvj?=
 =?us-ascii?Q?ya3hefXqBtMXHq8+Xb5Znlz+fFltIa3A5HtNaPkbJ3XaEWapuYZf1NAXPW7u?=
 =?us-ascii?Q?Dz+g9CUAaVAoyLW0BwPCrrtsUEqXiNdfMUIlljQ4rDqOsek1Gw24SuTmw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: IoFq/PcVdFGJUjvcNOwPuzG6G4pefZLw9htY0nA+9M2J6zudd9vOswnrLkKcz/q81jK0ydS8cy4ZybSGCALVaQR/ZO/booXCpMj/VyIbgepziTjK2Ep1ZiFpv5rJeQY4URl5B8/inoRy/vU08cNAAIrjjcZ3l0T01f0ujETkhKw9MXeg03yuuzfwNuZMt6A/
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;6:bsGA5Id8Kr3Cg9/PWfJKm/1tgsFK7Px+LeOH+a1kXHT7V8tjJINl9+j2/SE0FyUPjEea//veF9lPqaQ93+8Qsq6MPTzXrecHmlZUHIwknFKyDgKhLlgkCwU2LGzDNQcfi2uALJSpciVtaLnDUi8k7tvwOI6I7BYFjzd2DMMTB5myxsGwmxoObEK+gYFcBYoHIAdw9bBvywZoU7waJISna9/ZMB9XQ6qHaWpRX31oR8BYslWDlPwtY7RQe6TcOtVwUzdE2DlNC8X2A1FWXpkfJh+fjWWXt3jERKZ3HLasPFrP20/Tk9vNQHNkbR3Tcg0NYzue8ZIcdsezMlD2i5SU8BOmM5XvqhVcBU5YyxCfaEpDDiu3y3+14sQMxkf/xqd6Hes9xdmw8uKRDneHIm95Q7jBc3dQbjbE0634Lr+Pr94RXS1WU2p0wucCZQIWcW46oDXNpu50pPBg3o8ESRubWg==;5:dgz3yw/K6xcJZMKTcpIzKa/ToLYBmvBeZm2DkX6JIkMFSWZ6FO7hm+Tjqfn8Ut4khkpsPaF+Mut9uNtkLap7EfQ7BHe0wWz8F9bAupV67ns62jEchV/1nYt/ofnSZqtoyv9QYlqOFsQpxetDKLbx9KStPOLg3hRkNwnMQOH1Umk=;24:2cAFouRWrkRZKWhKAuFOo+nemib/ZtsZog5m6iRezho+9EB+GyfEM0vEOvI6r+CH+34B1mXLF3H9XlIm3d/nw/VN+bOlxNZ4aKkHYAyTtGU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;7:VYP1Zm1caE4da5ROGQlm9hJSPPYC/NUepE/NBfQNY59E9dcGb93ghMWohTskOKckk34ENT2p/6paHYUNazZJFp18g5/fD16dmipl2c+fooZkt+7f2rv9Y9RFJC3PSLl9Vqqhn5LZuCrOqoD0GVX+CC5eGX/0s/clL9TBzKHcck4Qq/QIR2uyUi28Gis5JVp95emwR/WPY91/14fU+bvwYpCuVBDpoW6olqWZdK7bRupTBEYgaxMjqg/qDhTADWW1
X-MS-Office365-Filtering-Correlation-Id: fc4256e9-5a8d-41e1-0598-08d5bbb3aaeb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 05:04:25.3079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4256e9-5a8d-41e1-0598-08d5bbb3aaeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1321
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX6SL_CLK_OCRAM_PODF is a busy divider, its name in
CCM_CDHIPR register of Reference Manual CCM chapter
is axi_podf_busy, correct its clock type.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 9642cdf..66b1dd1 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -330,7 +330,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PERIPH2] = imx_clk_busy_mux("periph2", base + 0x14, 26,  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
 
 	/*                                                   name                 parent_name          reg       shift width */
-	clks[IMX6SL_CLK_OCRAM_PODF]        = imx_clk_divider("ocram_podf",        "ocram_sel",         base + 0x14, 16, 3);
+	clks[IMX6SL_CLK_OCRAM_PODF]        = imx_clk_busy_divider("ocram_podf",   "ocram_sel",         base + 0x14, 16, 3, base + 0x48, 0);
 	clks[IMX6SL_CLK_PERIPH_CLK2_PODF]  = imx_clk_divider("periph_clk2_podf",  "periph_clk2_sel",   base + 0x14, 27, 3);
 	clks[IMX6SL_CLK_PERIPH2_CLK2_PODF] = imx_clk_divider("periph2_clk2_podf", "periph2_clk2_sel",  base + 0x14, 0,  3);
 	clks[IMX6SL_CLK_IPG]               = imx_clk_divider("ipg",               "ahb",               base + 0x14, 8,  2);
-- 
2.7.4
