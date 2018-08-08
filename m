Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CABC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EB321718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBYey2ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EB321718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeHHHBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:01:34 -0400
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:5085
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHHHBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkRNWjKdwxN07OcYykWmzCIbktk39Xbl6AIF+325JtE=;
 b=CBYey2ngl+2gSl/XCSqUk+kS124WvFBweYdSj00EWvd96exek4nQdsdRSCCCgPIDOqJX0N1EQxE/c0oEh8932bkrTo4MBnMX8bgKr+Wo9lGtOgRJ0MP6NNKTk2smj1M8dZ0OWwj+7VWUurNErg0PwdiuvNepLM1XiPWQW4PyB2o=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 04:43:40 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clk: imx: imx7d: remove unnecessary clocks from clks_init_on array
Date:   Wed,  8 Aug 2018 12:39:26 +0800
Message-Id: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:203:52::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5ec6b4-d039-4fc5-3fa8-08d5fce98552
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:Axe5SIuA721VuAtwBrzFbu+RyWEKWr/0xmXLrQGS9k5q0CWdBZvwkkQjKg5h1vAewti36crL/RaYh/UaMW6oJUaWAbLdRLLMy9TporGa/DXEIsNWF+mjG6+U6g8U3jA/enpznZ1nk0l9296kmoPacY3sNbx5Szwrx3hDaL5oy4D2mlLOL2oxshl3oD6OEjnT2VLKTo70nb69sWrsY6S1f4Btmp9PmOBCtFVwsrcJI3hMG7QN08PEdyRVQVr+vz+L;25:gJgPDmVSAGfwVbEQriconmYE8Pzss7UuzR4Gozlh0WTJPtp48L48wSgch9BkD/DVpPAKHCX2XB3KDkUUFUe/wd+JHBfwcWYV+w8ZpTuJrGLITpHMtxbfv0FmYsYvJamqPVF7GPO1mvrci4kCCi+OHIN7MCC8+LKBGBgPCC3VmkPUqpnaGX5n3Db0PzHyRT6XPx0iTXQYMxVmdGMM53WQyLS+FeFBW3huOPI9JhShvOMYXPK/V50z+AMgNdKkS2g9zIyMzjWvD8SkQf6a/kEAich65amtmnYcpsu50UXPoCumyDhznzwI4djL2Wu5n12HsePzfcASEpKxKEI5gNYRJA==;31:5jSDyF1n49Lj5lxizbyErPHVfkIANuQZtcAzFigk78RUdUTEI3us/Z5gQ9k8hefSgSOmDLDsbn+rSIGmy3HCpjwHmkLsoMunctJnmqCr578V8u/XUW0UKPE0fgYUzpUPtfs2J2jqIK0EoYLL6cvgTA4WFllijzN6MhaxjAWQa1KD4IvitYVE5xSBPcRsvTCUYTop8aWsXqCXY/4daGGqj4CzPvlY0S4OJkIxWgD2aRo=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:ZrlbAXuB2s6KDJ/Ga+6toSPVchpLJL3GTZsiY57CbrqzBlCFuGGsxDKJEy0a4SWuKUAcbSP/+5Rtxdv95FlmuIkwtZjsTYLaQ2GZANGZ/BtP1xs1bINh9GEcV7BkxQNLFfvzBDnQSjRjETZsFtb6qIBxNXi7GJO0rqky7KxphIUAnZNwP80+orl2p/etC3THKFL8PmQQrvybUkC/B82v42HnIFUFSZCv6puAHF4/h7A8q9Gni1LzWaEjKoeN8AVk0QXCaZL2jv4oo7w1AJY4I814YVIaWz2C79ZIv5vqMm18zSPtsVshWPPtSPlKMrwnRt/nBhrHENO1IDhEn3bgQbrL1FOWCgNylpKEhD123yews/w02SQx1vQ+vrduagdJYTa2mLE5QRZRofjXs3/GMrKdlIALn2i8lzPyxqpMpVeMpbpDxrlPrOUWrYibF5AwLJVwgf9Vd9uf+crHXosX3bE0xdWLOibk4cqWFbHq2K2aXBQ2VF8EGemrsb1IYuaO;4:2REh/yxWAzIoluzTc/03pSSy4MN3edlyq7l4xWd79njHGcEtbwMrpf8EBpXBg5y6mMnC0ow3C0g8mMIXUZ2hpjD6WUC29mCFKF/+T0ZCIwkWIloENUTGiFD7AbVQpykwARbnad9IQQfYRyWIJ4FGzm8p2jm1eyXXi4jTtLVMKyr2GGYC9glZqdGIuE2wVpvt9FkPmXbY8TgW/5cB6yDusQ7js7Gwg7XOUAnoGuqbFF4HD9drQ3/DowNcw2xEqwQVeqQqnnQq0eN5e8u+ogCpd1vsrqJeU4f2aQRXog1w0CAqRJdKRFEafR5lP8CCMDa5
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916D55111D12AB72D47A9F2F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(26005)(16526019)(2616005)(956004)(476003)(486006)(6506007)(25786009)(47776003)(386003)(66066001)(50226002)(53936002)(186003)(68736007)(4326008)(36756003)(16586007)(316002)(2906002)(50466002)(51416003)(105586002)(106356001)(48376002)(3846002)(5660300001)(6116002)(52116002)(6666003)(86362001)(97736004)(8936002)(6486002)(81156014)(305945005)(7736002)(478600001)(6512007)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:FADADtG9zCqodW6RLSX9thsmE4wUNjOhY5x3LqI?=
 =?us-ascii?Q?gG7XP6cwLBk9BDnE19aRnnqzeefKxfKtFpofTuRJbUNFy/TfqM1aKJYEd/4q?=
 =?us-ascii?Q?YvrGfvNFAHazlABhAlWRq7Bg7ffieqJ8wwwNLS4CROGm9BjMflFfZXUPGmg6?=
 =?us-ascii?Q?zorcd6MUCnsnBM3ilKGaWKgcnw2ChlGjaAY0VXetik62U9NrUzpzpWTI/Tl/?=
 =?us-ascii?Q?lLYgCqfylYe62p4+bmCZUJkV/aC726wfLlosWIzblZpd2orV+snN3QQUirdk?=
 =?us-ascii?Q?bSv6oesi6i97WtKTrC64GRW/Od4bhHQNUJXX75xQouHQpSgMkyDV8PW0gfOW?=
 =?us-ascii?Q?U1sEfl8yBhN6HeCx0XgbjCo1SpTgRSrVdh5gZzPaWrg9PGUfIZTOH02R/GXN?=
 =?us-ascii?Q?cr8L6GDgR9UFrFLfqC14lTIr0qPMuKMfaDfLVhD87ngcRSChq6XXMunlDELn?=
 =?us-ascii?Q?hwp/jJ14gKgLdiuhAoWtMeOK+QL6W6SlSLSgH5neenynp37b6KFefXaEIwtz?=
 =?us-ascii?Q?3KCqeaPTs/i5Lv8jF4TZr9SBZ1WKthqgRy/uwFfp2nRmjrmQYxUQlCu6I4aC?=
 =?us-ascii?Q?YNAiSNllOed4DvepM6ZUBu4VXoi7SlG3wb9ILCoSQdXRHt1Jght8JTNsDBsn?=
 =?us-ascii?Q?2Axx0BTKP4k2mz5dpydvshN6NregWJRM5h1Oi/YDC0Kb/cWIYYLk8bjS2lVe?=
 =?us-ascii?Q?dhT3PpkTpPqrJBmxHwWqlDwEnWloeOfGF+X3GmY4aL2M9EysKnp/2WDOTJbT?=
 =?us-ascii?Q?hqpBKhfsk8SOPTvFpRnIwrDJLAA0SUoiqoEfSmWx4CODJDc0gNzaiN7Vhgja?=
 =?us-ascii?Q?90Ai87PDhFab92H3FtegFsTXCLAwX5aeO7ODualWsKaVKEEZj0xCtvn06JGs?=
 =?us-ascii?Q?XxIyJVHaXty5DdUquXGvTyy/SZvtt96dHx5527Is3yhSzW+WDWIqaNxmDQny?=
 =?us-ascii?Q?WCSps/Ot6+wUbA4fAYnIFkEqRwwX2t72o6IqYhxkyybPuTOek2LHqn3205gh?=
 =?us-ascii?Q?dfurB6PkC5NmCsGwji2i54XfCv0lUFJBVQmEUJRT+q6wh0ENnbqU2q0BhoF1?=
 =?us-ascii?Q?Rjr29dcL5M3WIKAJqoOT6H8ZXDI2WqkeA+CbhvWf0GEXhz8cGXA=3D=3D?=
X-Microsoft-Antispam-Message-Info: BxyE9B9NmSgLVNz3zfcTEHw9fA6cTn2Yn5CTYm4Eyk8NjTPXk6RVOOllkAtTo9+wZsXlYfjMcR9Tfl6XtbPzn/WFRlRR6xLpr3YUcOAN+w7Kjrx7/m6plyES6NskYODnl6Ew9y/DlJP1A61pGFbb6e0urQelZjsUQSTYAJ7azJKLLQeND/roTUhznhFiswzd2FyhPLPsHM5zljMhz0iT3lfyQ5BSUAxPs47qV8Cc8mWpnwu4+fDPcyx764xYYgEil46SjyV3vXMztFKFwN+qgBTvXfpm/KJQBAvIvlke/NfaS0dv8IO/4RojcA8cyDJ3UfBupeBupwCjl4loU/cd35XZPVtMbM587iCp5QaCheA=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:Ex84M3NIg+t7VobzcA1O5dyTB1PxGapM+8HPRXDJr/fsKK3VRnwN/rmHCx58BrrXp7jeCGepbTJR/IfiuKPc1PY0XSGG3DNX4Uj++fISHRRiUZjoNlXYrTKXOeE66urtba/GAgiXbeBlZIl/6x2I6gHJRLE0mmQI+f2d1zQXU3d0mMO/466l8YA52EfDaGAqQv8DUTiB9ibu1lI3sKqhXHIO3hMepRSr32gfkK9Af4TnurQqclXHFpcvUnEb4GiLc6dif/RMtQ6UEv3J/16DiiMu9B6OoYAy8nikNUvyVVIdPxcfC/iC118pFw7qnjPmK6gZMNmKPJQOlyige3yfEbchxPBQCUeOpsj0z3+37EthjrMvo5HIcRHZG/BvesZW64eBztrH0I9uJ3x1VsIb3gfrei7AvzU+OuelK0vruD24EZpQ/l1+mgdxVu1R5vWUvSU2hfA+ipkK0t3hA4PR/g==;5:m8LU0h5gsyPGXzxU9loDidY6UZBiYb9+Vt2hzcD4+7wsQG+bmBVnXcIko719nR3h5vBVrXa7D2t8xzKFfiWKS0KnK9FmT5okvOeHLvIDeWoKeAcHZ7uNBjYHK7EzQO1ksp4SSi1SP0OYgXBr1EsLY+FMrBPEV0DvK1pwX7/ZOMM=;7:XoBF0RVxbw3+GpeyriwkFA+sztamq+g6h7zSgs6Y13bDq/JOSOf4vEaA4c+LWLj+3wo5A16CljnJJuk95zoru2VMsdFU9vJ1rqprF7yEF+pviwMQNY306EfnLRf5+C2I3bf38/aIjfZzoDA/LtVA1l47T+Kc0y/49Dy04LJP3Jj672y056aZxJbNP7QogIWmfcR3tMc+WrlN6BDQX6go1PZKbgHbD3tP+y56mpCh2ISLPtU72yqxZNOmjxpIKK2v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 04:43:40.5720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ec6b4-d039-4fc5-3fa8-08d5fce98552
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX7D, IMX7D_NAND_USDHC_BUS_ROOT_CLK is NOT necessary
for system, and IMX7D_AHB_CHANNEL_ROOT_CLK is NOT existing
at all, remove them from clks_init_on array.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 881b772..c4518d7 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -381,10 +381,9 @@ static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_
 
 static int const clks_init_on[] __initconst = {
 	IMX7D_ARM_A7_ROOT_CLK, IMX7D_MAIN_AXI_ROOT_CLK,
-	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_NAND_USDHC_BUS_ROOT_CLK,
+	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_IPG_ROOT_CLK,
 	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
 	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
-	IMX7D_AHB_CHANNEL_ROOT_CLK, IMX7D_IPG_ROOT_CLK,
 };
 
 static struct clk_onecell_data clk_data;
-- 
2.7.4

