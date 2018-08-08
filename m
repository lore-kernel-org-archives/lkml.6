Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E421718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLpwpjCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E421718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeHHHCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:02:18 -0400
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:5085
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726745AbeHHHCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdDSSSVt+oppma+wxN6de2F0rd9Cuh7/Yu4mVj2W/cs=;
 b=DLpwpjCGkwCu8gopfWD0XvpnFqA/BIBj4YWzd5sZZj0GzJY+9Fg8xjSb93xxR/6Nplg7LjzXA6rhwOAMc5eMs1YYqU17Kq1vo/jsn6SFWIXwlkpFtf/CGAi9Ro1SYMorUE5eUO8jGFXRAw/NwJwVSgaglmMvxpcnH2RIpB/Fk9c=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 04:43:44 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Date:   Wed,  8 Aug 2018 12:39:27 +0800
Message-Id: <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:203:52::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b24eacb-0d27-403d-fa0f-08d5fce9879d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:8alQoTAREFamTWrar44udkZhTqiT6zkLguXaKQpHaPmwm8uA9db+o/QaFro1eah/XzB9o3MtCG2gR77XnF6glNr+OhIP+ZTwSwYkUF729XLpYgiHQ5cviLSU1fENGPqZMy1Be5cg4ylcarxUH292wZs8n13GRG0QLsv26X8vumj8VEgF+mA9DY1dLQK2zEmJJxEwlNyzPe2IUE69xU81ShV3/4GyKki76lqDhz/XfpopaQ9NjN3b6sEMhkjc0aiE;25:jCzMFEOlThCvphjjxJCWEMSfYRFqIJceeGaKrELkAb1OZ/9sEyPAxdHiY1dl2RmpxAVB6zOVtSD2S9z0MpYHkuS20Pc525mXFXf3FIfUk3WZgxK3ZaGcEVHw7tMTo6Se53uzBDOnkPv0j+1a+N3QxVaImZpdBX2nCQAOnYnrf5DEydSW4aWnrpg1lcCe2+cOyp9ysLR/Qn3WFpc7esCc/UxjhDfT4kAekxpInOX9nZxA8Q+KW52HENqDbpgij6wXNHLyaW4Qg0h7eBqgJyv3fRbSLCnnzZ2sBNuOE6quuIzv47+eYPefgCZ4SoIVjz9NlJqs9JsKY91QVj96pMqieA==;31:mhKcwJmbVJgnkjdUuQ8xjfk2oUUxXhMS7jNon+62cPSEhws6iuYGtiqGB2esrsAvnREVVo4N1blGDt2v+5OR4x2P4eIFKvcIVAe68XGcaGqoR4Grvs+aOvWKUDf9Q7bKBq5VuAV5BQrtghX5tDxHAscoFsuWcCfsifTWbuIZBpk0SunoJb17yYkOvNR0NYuDqZHO+eXbyuepTEHQeKQyEYhnd4cN2cKPJ324Qy4h+gY=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:rCMggfnJx/J3xzo6zzK9x8bvOhAJVW8AsL/6KPhVvZnw5pEbGb85SgQV7G4jiduLPvxjAqZCYaA/pmw76FcPWpE2jaK58Cxr2xJf5ODSJaz618GttSBuAFTCY3VKM78kYNqwJSOcG8DQo6D7+Kz0pe9eTNvPROigezzLZyuGYneuzzt2HPr0qAbxj/t759TowMefizmms4Y+0LS47MgDh6OWiM60OkQy/J9VyLIUX7uIxXi5ikroj4ag0SpBr8V4nRweOYZmfSGLKX0aiBurMSzL5lxWVuflav60daQ3pnJUqJzCo3P4dR+aLfkaJ1IPM4pAPgScILZ9db+HFyoX4GvI4LRT782JxYdv5OVEfVaez/gyuuwz0+pPSwHqE39tPVrrP4P5Cj2gDGuSn7IXOR/DBXWWkeWrfO3I7NbLnkgHEBPc2pCF7iNWV/ltj8VKJ4aSUmJIWwBl4h2QS2w4IAsFgwzFFWM5uvnGyKh5Ak99Fo+6vQd3FkNw71IfcDjb;4:cGRI/q/kGKOEtxdWHdiiVgThMfSHSzUIDCfNX7kSEmz5TulJvKEsHCQ4QwNVWmVPZGY/DStB7ewhiNBtqsILRC21CnGKyfhGo/LLV4LOYoV2mv6LdgQiboJ6UuYfDDR2UT59LjO4J1P7c7BVsxfjvp5HUVeQiPnq55uN24dCm4p9yQqBWQB1snCwZv+pB+c/jqNlywGp7wxqFyAnqClsNNWCByyv2I66eiiqqL5blUP+grLHztLJfVcDKd5krmQ0EAaB5bEbIN1UynSNLtfmzlzFSDauNPP6HZrZtEZAaoTRoB1IB2xWj/UGrIkwCyna
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916061691D4C094C4D562D4F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(26005)(16526019)(2616005)(956004)(11346002)(476003)(486006)(6506007)(446003)(25786009)(47776003)(386003)(66066001)(50226002)(53936002)(186003)(68736007)(4326008)(36756003)(16586007)(316002)(2906002)(50466002)(14444005)(51416003)(105586002)(106356001)(48376002)(3846002)(5660300001)(6116002)(52116002)(6666003)(76176011)(86362001)(97736004)(8936002)(6486002)(81156014)(305945005)(7736002)(478600001)(6512007)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:I+CMDV1rkbHmqeTyHXWEjVCYT/YEsGpIHxRALi8?=
 =?us-ascii?Q?n+bplquEAWnvF3EvYehvkUcxIANzXqcmM+j5amu5mC0+QHBFbN+pK3aR8WXo?=
 =?us-ascii?Q?aFevtp7IIdnfRpxDdLrhVMS8l+U0FkWk2AlYdZpnTC5vE0lOXCHXOvt/aF72?=
 =?us-ascii?Q?36ucsluciwwiQF31euK/BovbDnQuX6HvH4nzhU6O1lDeC8axqDGmc/8TDgWg?=
 =?us-ascii?Q?/2FHwDQ0BTl3yuLo6oVhD4/jVg0H5mbyrJkvdT0jm0LjTVLbwvyw9TO/qInG?=
 =?us-ascii?Q?fAb1jualQ/RdWjuFDbjEXFZ9cQKnAqPUd0HYMumqVTLjUIC3UgALSAhxW/UR?=
 =?us-ascii?Q?yy1bpY1Tq9oxiUOFHAgY+0nk7tiHQmWExzjrQLlPhPhXkEy9gnUxMAJRMbcG?=
 =?us-ascii?Q?3eh9Uwrrq8KqQqr8LfmBCXxUeoSIyS0fq156/icw8spKhbh065MKc7+Z6mC+?=
 =?us-ascii?Q?H6NQawWMEdsZjPwHpq+P8IcNF8fuXnlPgmwrlaHzVRrq2c1TYWNMZDSLaa3w?=
 =?us-ascii?Q?pXseJPRAd8P+6qvSvE+gBgTyxxTRoACuhqBPyfi/MZ6FpbfXy7hmyp3wfQBl?=
 =?us-ascii?Q?avbVMjfMfqdsGEPNF/IFFiNGRKA32xWUbk9RTnyZduTSl4ZFSEQcm5zOOfLd?=
 =?us-ascii?Q?lCHDpSQ8cIrKtT2Y+sg6FaUKm6065Tv/PZRidOQa8KciOHwMeGDBQtL5NsmH?=
 =?us-ascii?Q?ZDPIJiKZdTk2YMzSZEFzOeYviHzLTbD5Z6fiD2tMN0SEv8O58K6bpT8S5gWx?=
 =?us-ascii?Q?rotOIsIOfDWz3M+aI9LqbYpxeqU31dFXSwLJyGzK8fYd/C9VuOCSt+d5Y7Sj?=
 =?us-ascii?Q?jwzUtgS72/rO7vcZDNwDMDRE76Nv1aIfR1tK9N5kqoK8e+JKmAnIEW3B7LE3?=
 =?us-ascii?Q?z3MaP4wHu8VBiMfP8pFya+BdkmhK6k6Mq+ZVck5h1CrWGRb4YLdJ/8pX108D?=
 =?us-ascii?Q?nI01d3FjJVgJ7pNNf9T8uLmCg9koMLB8ujiKwEfSsjnCRmN7MzCTQZrTvOs1?=
 =?us-ascii?Q?ho6MNdTMA7EBR6NB1cRFGyibDPPgexDPjc2gP4UCdR2/CrzyaCdVAga8K/AR?=
 =?us-ascii?Q?ryDH9vyzrmLbG/64npJpXeb15efXArZe/7OYCMENYvDF41wgwCtJOgz1KrV6?=
 =?us-ascii?Q?VyrxQ0p7NyWcB4RaSXDROj9q/1SmQRE1TkTF060N6qTOpmM/Q4vtBUQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +rTQsR9y1ZrymuVla4g3vyg+4zpToiDyj9anIV54SZArbTJFijS5pLP/bHLy8coY1b0f1LNtqziIL4VbaAeW0PE55l5eEk04/taplfzasp2jXLsyVW1WBcyZI8+LvjaVNGtTYgYJ1MbWJl1b1dY5HXX3JwUv1GGavc6bEE3J6UjDkQFQ0Ys5jt6j2teKGXf8UKAUGSc/7GEmSNXYrJcog4bXD+saJQG2VDTbkl+vDBdgafINttxS5kpK7DWL9RtoJDF1dXG7xGDNmJrAiKLsGs2+u2Lpdi4i3cKm+CyWZSZA8TxpoGmuTkW9mWxGwc4oLBMUNTZb44N9SAvSAjhd9mqRAHrNgC2XUsr3LU/kqQs=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:+D8LDPkwd67MtV5NPqVLTFSScXzMMzc0eZcQ1sv7C5i3azdRZWj+XtOpmrnlxCr4B/WnQLbEeCYYhhrIk0SfSu7yR+Aatk5hZSl4szcuiFRTOge3LrhxyogDqG58LyuhzN0CSkpJevtNl5YVHMG7ji6V4WgRp20HOBvgwns/rpGcNwi+TgGUJRLie/9fjlcZYRTSHipsezhPE0ZnNbtaSPLM8GO8jvKLwn/FND1KIWwTzPnQqFsUvXRqtfCyngcn2rcdF6ZkNI3UlzNkAt/V9Qtb+1g91VuWKnHhafxE7+6uZxQiJj7uLw1bCpnbQNXAkCFZ1o9bCpaVDFPwWwgLHiuGFBxyaEcJ14No+aiu9iYs7GXmxT/Y6L8tx+9dCiaPDmweNqDzZeWE2hvrPlptRqd31WRgwL57C1NEvy29L+hiDBdWoHNbbau4gkf+mGSEfn8WS/MPB33gUxj4F/5k7w==;5:sQBIWVQ03ZcCJjEtsvGr+btBQzU4rnL6FTYP1Pj1b+VmJZJnREUvjl4LmLas8qUoCyoa+GkWSixDJZWE3zc+r+PpvalAftjLhYAsHO4/msYScqri3hbO+w2iTH2tgCZ6bJm+Q1XidZxR6ETvM7leCPYmgKiwuh+cI+MakCBJXGc=;7:ovz2lLelbt+ZSzqg5KC5b6Nh43CzChtv9IkdztXJjrXkJljSofaHJAaXDQvw4vrD1ZSrwEO5QzoEJMXTVVnktXj0P+K7GkPZ442wjvcR1eAVyrhT7gkdZI81H7sAAHowoPlRjizxsjHT1SopN+r5bx+ujpaG00DBVPl27TcD8EisRtgQ17g1n7Azzn6KujqUKx43lb7H3KfLTICV/Vua8HhYeK1gS2SrdiRFKdOw2nirYWiu2IG8thK9Nw7+mk7L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 04:43:44.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b24eacb-0d27-403d-fa0f-08d5fce9879d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 27 ++++++++-------------------
 drivers/clk/imx/clk.h       |  7 +++++++
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index c4518d7..076460b 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -379,13 +379,6 @@ static const char *pll_enet_bypass_sel[] = { "pll_enet_main", "pll_enet_main_src
 static const char *pll_audio_bypass_sel[] = { "pll_audio_main", "pll_audio_main_src", };
 static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_src", };
 
-static int const clks_init_on[] __initconst = {
-	IMX7D_ARM_A7_ROOT_CLK, IMX7D_MAIN_AXI_ROOT_CLK,
-	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_IPG_ROOT_CLK,
-	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
-	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
-};
-
 static struct clk_onecell_data clk_data;
 
 static struct clk ** const uart_clks[] __initconst = {
@@ -403,7 +396,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clks[IMX7D_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 	clks[IMX7D_OSC_24M_CLK] = of_clk_get_by_name(ccm_node, "osc");
@@ -466,7 +458,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PLL_SYS_MAIN_120M] = imx_clk_fixed_factor("pll_sys_main_120m", "pll_sys_main_clk", 1, 4);
 	clks[IMX7D_PLL_DRAM_MAIN_533M] = imx_clk_fixed_factor("pll_dram_533m", "pll_dram_main_clk", 1, 2);
 
-	clks[IMX7D_PLL_SYS_MAIN_480M_CLK] = imx_clk_gate_dis("pll_sys_main_480m_clk", "pll_sys_main_480m", base + 0xb0, 4);
+	clks[IMX7D_PLL_SYS_MAIN_480M_CLK] = imx_clk_gate_dis_flags("pll_sys_main_480m_clk", "pll_sys_main_480m", base + 0xb0, 4, CLK_IS_CRITICAL);
 	clks[IMX7D_PLL_SYS_MAIN_240M_CLK] = imx_clk_gate_dis("pll_sys_main_240m_clk", "pll_sys_main_240m", base + 0xb0, 5);
 	clks[IMX7D_PLL_SYS_MAIN_120M_CLK] = imx_clk_gate_dis("pll_sys_main_120m_clk", "pll_sys_main_120m", base + 0xb0, 6);
 	clks[IMX7D_PLL_DRAM_MAIN_533M_CLK] = imx_clk_gate("pll_dram_533m_clk", "pll_dram_533m", base + 0x70, 12);
@@ -719,7 +711,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_ENET_AXI_ROOT_DIV] = imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0, 6);
 	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_divider2("nand_usdhc_root_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
 	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6);
-	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2);
+	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider_flags("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_PARENT);
 	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div", "dram_cg", base + 0x9880, 0, 3);
 	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] = imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div", base + 0xa000, 0, 3);
 	clks[IMX7D_DRAM_ALT_ROOT_DIV] = imx_clk_divider2("dram_alt_post_div", "dram_alt_pre_div", base + 0xa080, 0, 3);
@@ -783,17 +775,17 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
 
-	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
+	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
-	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk", "axi_post_div", base + 0x4040, 0);
+	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate2_flags("main_axi_root_clk", "axi_post_div", base + 0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
 	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk", "enet_axi_post_div", base + 0x4060, 0);
 	clks[IMX7D_OCRAM_CLK] = imx_clk_gate4("ocram_clk", "main_axi_root_clk", base + 0x4110, 0);
 	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk", "ahb_root_clk", base + 0x4120, 0);
-	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate4("dram_root_clk", "dram_post_div", base + 0x4130, 0);
-	clks[IMX7D_DRAM_PHYM_ROOT_CLK] = imx_clk_gate4("dram_phym_root_clk", "dram_phym_cg", base + 0x4130, 0);
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] = imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0);
-	clks[IMX7D_DRAM_ALT_ROOT_CLK] = imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0);
+	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate2_flags("dram_root_clk", "dram_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_DRAM_PHYM_ROOT_CLK] = imx_clk_gate2_flags("dram_phym_root_clk", "dram_phym_cg", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] = imx_clk_gate2_flags("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_DRAM_ALT_ROOT_CLK] = imx_clk_gate2_flags("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk", base + 0x4230, 0);
 	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk", base + 0x4250, 0);
 	clks[IMX7D_MU_ROOT_CLK] = imx_clk_gate4("mu_root_clk", "ipg_root_clk", base + 0x4270, 0);
@@ -882,9 +874,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
 	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
 	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec0..5895e223 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -137,6 +137,13 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate_dis_flags(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
+			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-- 
2.7.4

