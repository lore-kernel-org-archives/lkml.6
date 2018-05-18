Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeERBE4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:04:56 -0400
Received: from mail-he1eur01on0080.outbound.protection.outlook.com ([104.47.0.80]:35265
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751530AbeERBEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:04:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, stefan@agner.ch, adriana.reus@nxp.com,
        rui.silva@linaro.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
Date: Fri, 18 May 2018 09:01:05 +0800
Message-Id: <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:G5iAb0qdaL9KuYv7F7vS1bINbka37v0TwlAZNlj1ywSe7pbXTkd7GKC1mKrzxmEM/Oi6gfx5UXAc4T5T/sjFEjURuCNQBrRmTyBZRTdsaoqH/jtomqKjod9ndto/GFOae9owesGcvuViK6rc8fMRAGkbClzBdcmaEW5PNmu8SCHN0vwdQcPbsoPXYvATyVYvmsTzZ+etEuncStIADNW1cy379KnMDfOFoOhSI9SZyGN6XYYQRErGx2mahF29AsUC;25:TH+hC0FZVxmXDrM8K+qg2HMk9VYEt0N9krNploMRIYsmPyC4mSU9wOPsXT8e5B/BbCNYDWvRRiCjn12Qvp1YL68WLsDk9W1yb54g3ZT3tilvo2XhkP/rk/sHBZFLBc3rjjMwO1hKmqCTmdphHtOoN6Sl7VxkMftQScaaIgnHQ2hSk621dIvs3ydsrPtOADk9sQmNlyNcTMnEgmyouc2pXFmQjzgm99JLZfraN5b3zuc4BdfZEm7a0Y3PCYzuMTKXqX6G1LkoHRqkywxi/N0chzqcKRjYLBda89X3Xg03dJVXck+1iJF2CTG4sNywe4iUW/yKpkLlzUyadQWQqwXzhA==;31:0C7k0iG+x4NpnMYZMh9LY7wXNQlm9aBXfTswkM03Zn66TU73UgDAugU2cJvs3kdcmhh2ZIjatSAKXfKRjYT57oRiRruMp3nNlb+Y8dWtmRNQCvY6s/swgyRU/q0n9pMw5NK/Ry1eEyq5tZuK4WFA3NuAQBOiZ7f+jWuYoYtQQRFyM3+IBMhcm65owvEGDULijIKNyUGp4/GM24Csbg98Yrg7GUwLWhgeRJuvPY8wL7U=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:jNJo1kpEpNN2RYxFJ7kRF2Cgc5KgOrJdcNSJHY2FgYnvw2FGuAIiyJT7cbv2PegoGHMfGOecSXsPyFHocdUbmgaUGyalLcdI6luWSUDdM3LQDmmx53HS6xr+JQ+f4fOfEdzT7VdbQX38NHMR1qhPjEA1nhO+L3uzl6879u5iqwq+pbtlRLzilxV0xqv59p6cQk3EmuyYNYf8RhGK7eeDXV9mg024swiFTWHlqOAjzcUGemvXNhWQ50hLsT8ES6XAdIewYPgndYI9Lvym4MSsn7YYIZao/QXg9edvYyPHraxl93xmClFbihiJe6AcOjNTLR3W2L3LUXqMgBc3d4JYmMuAYeg6EWihb9CJzjMmwLNRTgNM4E1XAyReiVRlg+jinGOOEyD80bv/viOsgS/jDsU8nlPUEeZupQLixxRxxn+hv41QAYRCnIvye5dpz2gvqNwAioEtEKiM5IJL0bUSj17EEOmp+J5copDiVp3mclr4GTFB9p0FZI7dHiQYMECu;4:nFDoFSuCWmKYE8+Gjw9vcCeXjaqaHZayLPmaVA4BYG9DE2FUsUb7Fk0pNPe3J8ZMamTZiR5iLjCFWB+FI7zDEnHgLKszbKZkQQKi/EVEiCUsd3HcL2uTld4yBHp4ksAi5sEVitYkVXszIRJUt42BSPx3sB6mUn8beZoleo/MQrkiWqnYYPU6bA+GO63xF/OQxRGYNh97zWXOZ1cTItqNAxSUYj2YYN7Vj3KlHFhGr8E98wbla5rQufE4oJPHoFaTU7kj+tjSeAPL+gCdLtKqCu3FJgVk5wmY9gIZd9LfkZAF4qzIX/DOPd5YRRWTPedU
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318EFB5EE80AA86A86C1EEAF5900@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(189003)(199004)(476003)(6116002)(11346002)(5660300001)(50466002)(81166006)(81156014)(446003)(2906002)(105586002)(486006)(3846002)(106356001)(316002)(956004)(25786009)(2616005)(186003)(8936002)(47776003)(97736004)(51416003)(478600001)(16526019)(66066001)(16586007)(50226002)(8676002)(26005)(48376002)(7416002)(6506007)(4326008)(7736002)(305945005)(386003)(6512007)(53936002)(52116002)(6666003)(36756003)(6486002)(76176011)(86362001)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:hA597copWlToGQaYjULS/ytUY1cPFkgEZFug9uOIX?=
 =?us-ascii?Q?6i48u5UnxVt0wcpFeavbzVqABtc7+VZZ5gxM551F/1QhQqdNx9nyR0UGdcr8?=
 =?us-ascii?Q?isAJtVSM2XG5ljqjgswhSgInqa5G+daB176CqMXWnZ+g3s+uSqu3DYIyF9JL?=
 =?us-ascii?Q?suG+xMsA94aA+Y9KmG6bOlXnXVEYLqeqW18cgLieOvowkKCjYPouBL4MPX78?=
 =?us-ascii?Q?qKaoxJgQ03yYSa+gkL7T5AF+504B9L/w+VSgJAxNhgWbTL1Qo0+LOxqojLxL?=
 =?us-ascii?Q?fOusLEmWXKLDyXz4KR6J4Vss4UoA64Fply31myQGkj+7MxRZkw+yWU9dp0PX?=
 =?us-ascii?Q?pNQz67jcn3KI/U9sd6bOKuifAhjm7vsCIQXjDAxQMnH02hyjyzXcZmL1OejD?=
 =?us-ascii?Q?Og5UuS5sB1yJkQLwEmKU+biC6AHNzhyY3oK9Jts82p90YcY2pkzoDEKz7hls?=
 =?us-ascii?Q?IiPT4LrlatqpmPb/ZlNBPykCiUeUnmsAugNXCkcdwSl7hqGjGSa1BjwWkzVu?=
 =?us-ascii?Q?v9/od66N7CFR0ErR5JbsRB/wj7KQDjL1TWpDkQO/dBGFyfdysoTIqWhXwtMD?=
 =?us-ascii?Q?i6q7APRMKT2LNM7f7EucLrsIwex6ejENDfEgj6Cf3S3KD16EzWkbmmgRYo14?=
 =?us-ascii?Q?VyIaiszQ+5eaPANTosl9j3tOyl1fFi1n6pQtu1EbG3t/Tf0C6tg6mJ16IBPM?=
 =?us-ascii?Q?WUKZQPehW/wlaaHHMjpqDzJFQ7T9jNOaTNjD6OoYdMqtvkC/veYEIm+X5gkW?=
 =?us-ascii?Q?V0kt1u38tJXmL1GHE36NA1vv8s/LR9z+4tpsfnDtgmIE4dt/td/Lhii4atlx?=
 =?us-ascii?Q?StwUyGLXZOLvE3FoHXXGUxc7ROtrYxXls4Yt4PKr6JJi57dkO2FClSlHFVU2?=
 =?us-ascii?Q?SI//3grzkx0HAcueJNrnuZTlGV6mM9yT92o4+tCc2A8dOfVLRZWrjjOgL20T?=
 =?us-ascii?Q?51bF9b1JGvORAzv0saevNWrNPj8BcicOQ8g15JP6S7nI5wQERjHy8lwnoop/?=
 =?us-ascii?Q?UmoWg1tS7cmAA4W4fAoVW+SpCw/YWcqkbYPS9YK/UCh0Qz6w6qGrQQOaItrF?=
 =?us-ascii?Q?ryQvBWnicQiU+x06sXawIBPKzq0NEHYtG1S3UKsVSHLJfsh3m91M0WAlmJXg?=
 =?us-ascii?Q?IWDelwquFuKn6i3e/5RdFYkVaYBs/U64O1idlkx8ZzY/qlIG5N3gARX1c1un?=
 =?us-ascii?Q?AMr6m2VTbvv+KvSn4cf/sNp3Vhj5ECjrzMe?=
X-Microsoft-Antispam-Message-Info: VXGLLofawbLgXt6sFyrluCVbpPs0aPGVcpHw8cvrCn3YDlSy3SPIyk/Jpf9SzhhuQbthpsWd1aPyWtB4QNNJjNzYkOiwhi3QbiYWOvdaSpZhzn4f8LBK0u5HvPTg9QlGA3WXRcD7ufz/MOF+rbTj3ztqKh5Aw9JMdlXMNXeWIk10bYmtQl4gZ0F9DyUqyIgV
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:+8/9wCm1+RdS1qJtv1srbWhy+e90a3CpnN8gDU99inu7TTn/xSUxUvhWQXOHDB4Qs1mAB8QKEvbhIkjMDtM5tK/i3uX3bpBmKShS7nBRTEY9g7olDh2/jdABXsK6mGLBmFmTli/8E1zy24E9Q0Br4Yi0zezXSrFpFMChrcdUBuO2nkQ9IzBTMQackLeeSszwdaOuzPC2ZhRF9TNsCjGOznj+eJYNrc/Spfhr1ZMTkujQLZmaxbRQ+LUcGp9WmB5Ga4Z63dtsJraPaiumXOPArGleTGeTaxSMC72VL+RB/71helWMssbHKYEC85cEd4jZYSZeyhqqn551mvXnf+VAER4vdj10U1Qwunf79D61RbWPMJwq98F9jQvFEwTw3cLb0pdbNCuqyGDvPTlpvNCJQlJtCDCJ3aqSKZ69/Z6/XRxWYsbnLOON/tlD5SRXvhNpEdFve7fjPmocVFdwmp5hNw==;5:m+5wrZHSpwbWiKtmRc+1Vc/Z1pNZNnC5XbRO5y9OrU0zd/IAU4JLu68arpxwKAW6k7xrXLlmBIunrbSreyWYkzLkTI0+paA2V/o0H7qNVVQ8j8IiWTCP3aLWpswt7Sd6uacU0xhefwBpXOrZIAjkVC2SERP9UQzi2fj5zhR60EA=;24:EIr/iTs/lE1rC8rk9lt3fpHrG6bJgOG1/sqdQCmsjpJeugAhawABhhPtwqx64aRNmEWwF7iAqC4f1DjdqO0HqR6s6E8pd71lU4lwXBb9S2w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:c8VrLQHoHTyM1yNthFPntKgYYxGQAlyMMJALFVHBtcnMFIXh2jtPeF7ZlxUZFc87MIwo/MUls2GjSlW+SwQ7QkYP0i7vufO1ORjvbkTOFdeMlvxHPPcJ0Tn3xe27k7kBjDjX0cy6ExC0SaK9/4zsbGfYHVQjGDHHOya3Vg/P0zHEfcEf/5h4o5KvIfMhK8aWsGGFQu0s4ykipE+lmAhEjTfuUbHLpzyAnegH2UvTmZVxqoRc3rDtCQ7qoOyI49ch
X-MS-Office365-Filtering-Correlation-Id: 10134164-03bc-478b-1162-08d5bc5b5a8d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 01:04:44.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10134164-03bc-478b-1162-08d5bc5b5a8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct enet clock gates as below:

CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK

Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c             | 10 ++++++----
 include/dt-bindings/clock/imx7d-clock.h |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 23d5090a..d4936b9 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -26,6 +26,8 @@ static u32 share_count_sai1;
 static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_nand;
+static u32 share_count_enet1;
+static u32 share_count_enet2;
 
 static const struct clk_div_table test_div_table[] = {
 	{ .val = 3, .div = 1, },
@@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk", "mipi_dsi_post_div", base + 0x4650, 0);
 	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk", "mipi_csi_post_div", base + 0x4640, 0);
 	clks[IMX7D_MIPI_DPHY_ROOT_CLK] = imx_clk_gate4("mipi_dphy_root_clk", "mipi_dphy_post_div", base + 0x4660, 0);
+	clks[IMX7D_ENET1_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div", base + 0x4700, 0, &share_count_enet1);
+	clks[IMX7D_ENET2_IPG_ROOT_CLK] = imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base + 0x4710, 0, &share_count_enet2);
+	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div", base + 0x4710, 0, &share_count_enet2);
 	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk", "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk",  "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
 	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk", "sai2_post_div", base + 0x48d0, 0, &share_count_sai2);
@@ -812,10 +818,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk", "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk",  "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
 	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk", "spdif_post_div", base + 0x44d0, 0);
-	clks[IMX7D_ENET1_REF_ROOT_CLK] = imx_clk_gate4("enet1_ref_root_clk", "enet1_ref_post_div", base + 0x44e0, 0);
-	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0, 0);
-	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
-	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
 	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk", "eim_post_div", base + 0x4160, 0);
 	clks[IMX7D_NAND_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
 	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nand);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index b2325d3e2..0d67f53 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -168,7 +168,7 @@
 #define IMX7D_SPDIF_ROOT_SRC		155
 #define IMX7D_SPDIF_ROOT_CG		156
 #define IMX7D_SPDIF_ROOT_DIV		157
-#define IMX7D_ENET1_REF_ROOT_CLK	158
+#define IMX7D_ENET1_IPG_ROOT_CLK        158
 #define IMX7D_ENET1_REF_ROOT_SRC	159
 #define IMX7D_ENET1_REF_ROOT_CG		160
 #define IMX7D_ENET1_REF_ROOT_DIV	161
@@ -176,7 +176,7 @@
 #define IMX7D_ENET1_TIME_ROOT_SRC	163
 #define IMX7D_ENET1_TIME_ROOT_CG	164
 #define IMX7D_ENET1_TIME_ROOT_DIV	165
-#define IMX7D_ENET2_REF_ROOT_CLK	166
+#define IMX7D_ENET2_IPG_ROOT_CLK        166
 #define IMX7D_ENET2_REF_ROOT_SRC	167
 #define IMX7D_ENET2_REF_ROOT_CG		168
 #define IMX7D_ENET2_REF_ROOT_DIV	169
-- 
2.7.4
