Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeC1GtL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:49:11 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43380
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752462AbeC1GrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Dong Aisheng <b29396@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
Date: Wed, 28 Mar 2018 09:46:36 +0300
Message-Id: <1522219599-10831-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::29) To AM4PR04MB2129.eurprd04.prod.outlook.com
 (2603:10a6:200:12::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c390919-be49-41fa-e45e-08d59477b746
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:9KwMHrv5u1zKamPq5VGyIAgXE0k4Mhd3VM1A/NgO5Sc5PwSG6pXIvhJxLwgQv6lxi2n4r5BjoEnCbR6/50K8ENbK7a/M/BEF/BY5knT/mlM7tMxl1d8JygLN5SmfxTUvN/EKr7vhV0lv1fLxgFtgKVrkRAUuNuV8DVERmPIDgTsOpd13aowEXN1WZfuu9gsvOYZRbFK1eMYd1EjL9mDFBg86+rYM+0JPgnbhXVq3OWfNLtqRclX2WULpYIRoCNOk;25:WgqzW80K22l9DRTdVXK+zls43jqnYnDVcz6TUP3bDweHGfs16GKk+er24wVEmlvaCd4vIjy20lQq1u8w6TFBaKAYzrcPTrCyMG/t8dH9TGAOxewd61U+BsBgUuWPyyLyoVgKbVD4/t7fanpK9aJehfYcoC0VaWn8BFRwkEoOAdU/GYBsJTxxEVOugoS9d1tk4dFusvZyJKkmdNiVpwZui9Covxw9BN5YI0dZ3V+zHg6dFT9jqPyHGkHwL/+SLrOBnzRdFd/W4HNvc0uW0IcaTZAojCPWpfhhPsK+sIspNqgP3bdxwUMmUD7VMYdpJ+efpKmQyg5DUYPlL3zSZBSdXQ==;31:wadrQaF4tX8m0LjYxTh8c1U5zohQ1FpVPFO0qdcAH1hQSixgeDyImT3ZC394IeafYbV154cZrVTU9F87GgDs9n0nCTMAWoge1xbOEYKjLXAVDYAFQex5SwhRQlMS9ZCWvTCbCU7fIVt6+8LGE3OCrL2WDZ7qfKZwBYXxSfjEkU9khCA82QRUYN0otnMJmekjpYEtJ7JuoYTcf8xYyK3oRnW3zF1k9bMMar7ZsLvYCkI=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:09R4hI8ze4+dtLaZqwNearRzkSDGD3YtsCsBJFOOSjN/eGFiu05wR/7P00s5kj9PvhXfLekGYqoYoexeQI0kcvEFoP3dnRmk1daAN0QFtuvFkvH6q2yi9A/VXNGunboWODV2SypgVOvyzejtSMsRI7i3LQlS+n31siOCh4qqiaof0zbhvvkVVXVVaev4rpIuS0BnBBC1XLlrcqxOgR8RmMOUYh1hqgXggmJ8/OiCNpSTPKiZw2QiEK58fi7KTIgkzJPJMctWcBLbgvR45xJEAAYhvqQEao7eYVMmLPeClpp8GqcZnPWIAs4lZRXPRo6cGLYu9iinHB7KA+EVVnb8fplLgZy12vaJXw3qWUpFGrGEsf/pr+xi4ba194HwC2etwZ4gXphAG6YH/jJHo2+BM+JCgjbphBi9Gi43od7VGupt+TvocJcekQqBzpJ+5rss9DlQEPQh+oEGOqTf6p4gC0Z0yt/9Rj68BiPJcAlChUhK/eZT4OWOA3d1Ek5STi2K;4:8s8qgCZHnyrk31ZxfvaHdnBs8DpXSCrqbp/Tmr/FNei+OeywU6Ua9fqQp3XhSDUmlfyDM/upixhSfCGrzgZeboagn2X7W1T8loDCofkb9Xu7gYv6K5fgFpjYb9f278333W5LqCuCw465penDrND/or9lW+o7kxZOCGTlIBT+yiRaoCGQHeAhIBxxfREtTnRARXGcWqq7U2Taaz39rLDqWufbfOlohm2x1EXWtpYTObcg88XEFtxhmabWC43i/RYpZOCi3UsiggbmKB0NcAm8VyvmfzT5VTMNnUuaIkchwQHmgxWmYEdyuHw0F5+7qZKo04/cgO6lz+Rtb66BOPK9ZanuRRFMIObIKIpk/etJGhk=
X-Microsoft-Antispam-PRVS: <AM4PR04MB2129091AF646A68F4AE17149F6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(3846002)(51416003)(6116002)(36756003)(26005)(76176011)(6512007)(50466002)(446003)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(11346002)(6486002)(97736004)(53936002)(1857600001)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:NvPvxKeS6yfd9diJXyNoi/5NTwMmXn5mv7YSOepDh?=
 =?us-ascii?Q?Jb76mI2FsW4CaCMIF3HBz4e2U354uf0M+LStZw2/WzPFko5M2JyLvWDS23ZV?=
 =?us-ascii?Q?n5WVHbfzJWhpx1Xqywy/WbfAftAw5vr2yXkliWqPHIInBvkUYAnlaP+QwdKq?=
 =?us-ascii?Q?omt65cSfq24NEEWyEPAO2NTdCdrwOzk0QT860glNE3ziGdsL/STOHU0Wsw3S?=
 =?us-ascii?Q?sgwyMMmQZIxXG4VyrWMsgdJk4JxlWusQvCj6xzsaeY9pT+MTvzm6ScvL4RqI?=
 =?us-ascii?Q?1DnN6NLL7mOu09o52zrjtMXipTvrPAhJiUbHZhabRNP4IwnT3bWow1OLbWnK?=
 =?us-ascii?Q?haRn/a8LncTkHPYPN7/g+uh580FswIE6Kj6tfoPpD2orhvplUSMm/g905q1u?=
 =?us-ascii?Q?UX14P3lfyYNmYYMhg6lZ+a6RL8X+H/b7oiAjhjfH4iYwNIHz9vu9LfdXd3Nk?=
 =?us-ascii?Q?4jGz+q8u7/qL47dgCgOmbDBZNWnvUCXQtCvtFJZ0PagHcu4ilIxLH/m709yH?=
 =?us-ascii?Q?hZExs2dEqW7Xt3YLQ2kbRHozl9W+/UtjQd/9ovX9Nd8PIwPCtnuM8HILLhun?=
 =?us-ascii?Q?6vvajbcKGZjB3Jx2L3BeD/bNRpNKlVU9xvfjhsr9BKoYR2SuiiNMWqTCyHw7?=
 =?us-ascii?Q?mhX2lvmsyzOqefyHGWikMUxV+U2zKtCU0NO8jAAWbcyz4Gdzeq5tZCyAVpnO?=
 =?us-ascii?Q?4CuZv1DtObhzIZP6AMUwOvpfr2eW4DLtpzUP3pQmJ7zukf5LPhfDds9nA6P9?=
 =?us-ascii?Q?Hw7TbG45glyqNtX3wS02uTfqZ5PpJnEVxO9l9155nKMMZ8ZbdG0FSkhgIhVb?=
 =?us-ascii?Q?YqN2kpeqU5w2hv2V6hT04Gs1fb6UvJsGoi8AzzYug8IGJYr1xjBTrEOr2Lrn?=
 =?us-ascii?Q?4LJ1NOn6oVp/Mml2ItayZ51NXOA2qnu6+v/9OXlZceBZU++NcZL8gnrj7rVo?=
 =?us-ascii?Q?J9sjJAnBlhCb0MdfUQEwvNaAW4a+7ei2Kp2dnveQ8/7lDnPYkg51i98Y+vnn?=
 =?us-ascii?Q?cEcfpr4P8XlYmbuD5gmmSA6yGrUXJ+yv79PjhII+kLnA8/50w+CF1whODxyT?=
 =?us-ascii?Q?qsuxe6fRzy9ijZUw2BrJisA4MFLMn7mfvuxfjgg9WRP6ZH+tA951urDHwyVF?=
 =?us-ascii?Q?XxiG0Ujaw4AoAiOjxFdjWoBSCYJ698Ma2mONdQJn9e155mbwBl1q+xyWbE4Z?=
 =?us-ascii?Q?O0Bx+Y9wlYMKNjUBEDUORgy7VU6SfRP8cJfm+7Gg/a3NKmywmPRQgLvmXQtG?=
 =?us-ascii?Q?1JN2aVkCIANhWkxeNBB7xGlGANKsWLOfsoiBEOg?=
X-Microsoft-Antispam-Message-Info: PznC2y20bg/sid79Funu2q2GjREpMoq7ngvSLP0ZceC2XH5fC1ZFnYQJob/x7gZFFYi4w8Y3laczRZQPR7iB5xislfWjaizXl/Fh+WEDQUcayujTcmNZnJNrxQgrbzWBfrawpdwditQeY0Ogxz8Af4OSoSd4ohnNiM/H/CDq3h8EQIs/mYy1XN5uoXgQmUd3
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:ggJWwbp9gWvI4zuxvm+72YQclNPy90IqEE0bDc1nQA+VlIW2cR96YArcIRtZkaQDorvEDpEf8uG3907g0Ltie6EYe0yy816fNZ6NFPzkb9v/QG0l/ej//D5PVpoY5ysVNftRAaupRHlYW6ZaQJgjmTHMC+/7qaDY8noVVYnzQC15ugL7IfRNung1rXkJsja6YbzQCbSvXhExF5NFhE/ACQ2jy9+EZdm2ten7OJ6lQVpL8lhfdDOOvNfL18tu1eUtXs+6OuSnWPlrLP+G0vdEjD48Cmx7HQGEId4hLXx2F8QJ6snbpFAAhY3kq5yyGa9pJGQrf8bb8davWijRAz4qCE2PK3nbyViFmUCbtzeaVuJn7UFYtjg0saAbWf+vQ6mtveLiDLTFgyJZ9Ei9QS8Ntdcp3GNn9SKinvxmC+SlIQek8ryJMFdhdRXumOM58HA08XfrKbOk//MRPfvdKYh/5w==;5:MzUjhXQ3USh5KOQmAqzkKERnUjFfU5eGVb6MRFugajCTNT0lXr8s1qB3NHY64t5h6xsxpnHRbmTqs2ayk8Oz7zK7a8oNlr6jlwIP4kmfUTDXIOSeHG6kT0s5Wd9LGQ4bYJjS9Y4EH9HW9kzcZRoWJWV2T1yjAqETVrji6zckAHc=;24:S081dx7SRVynFCeQHyHqQi24DnEz8NkaXR/hXOysr+XO20sMQOgT74mNZn9hm9hs8H4LR7dVEIiQtHlVNN3eK77qGMaMfY7eHHWou/E/UGM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:W+ibCsgjFCgwtRQuusGcqDHSRe53qaM9HrzdbG5U+gQV9Aq0H5cjcFhTckdhZK1o5XZTkVSos90dZzgbZSZWcqPoxtMJHIVbpcpEhtmJPLEPAbkXa0LQmgeGLD/G/HL3JlKAZKzy3t17sOLUgtCU2lav8Q9wTQIiA00vrxFb6uwaD5vvZTo0bfBhsoqMKpLgoh6DlpPszdvIDz9A1o3VYumfxrgafiFY8CoJUZrnpde1+sMPCfKQzpo7IYkV1lTA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:03.1684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c390919-be49-41fa-e45e-08d59477b746
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <b29396@freescale.com>

For init on clocks we should move it at the first place in imx7d_clocks_init()
before any clock operations, else the clock operation may fail in case the clock
is still not on.

Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 89bfa75..9b17805 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -433,13 +433,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] = imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel), CLK_SET_RATE_PARENT);
 	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] = imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel), CLK_SET_RATE_PARENT);
 
-	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
-
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
 	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
@@ -886,6 +879,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
+	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
+
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-- 
2.7.4
