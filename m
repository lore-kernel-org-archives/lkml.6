Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeC1GrW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:47:22 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43380
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752319AbeC1GrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:16 -0400
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
Subject: [RESEND 4/4] clk: imx7d: Move clks_init_on before any clock operations
Date: Wed, 28 Mar 2018 09:46:39 +0300
Message-Id: <1522219599-10831-6-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a5e7d9d-cefc-442f-7a26-08d59477b93d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:x0zJuAa/CBFf7VC5mW6JJNtamWM8XOMnXSuChK2723oPzVuwO0q1P7bOf7Agvs1CtE52EJBRoMojF1L7GC3njfilkMplGnjyiyhAFPwBCGaGhxXKNwQ6152MO1yHsG1HJy+ugWme1qg+TXlQMxMqw/Zt3eVR7ZTqNo7uyWA8qEOqLAGALDiQigVm7SyqZa3+CfpGp+trlFgKzkxx3xnKb+Z3cyTDUelI7ToR6Hoa5SW4iyy/Idmbzp+sfyYsH06x;25:F6WstYqvjIq8S+aTxHQZuZ5wWgZ3daYQJypHoqnhT+QI1QWheSu25cPG7gfnd82Uu8ejJ5AI2xzeT18NFt/7SJ/nTsQvp7zPcTKRshsEewij6mWEUhupSs09817psjDEBAoejbl59OOBGXIS4j9yvtb+ehyPVUJ7n+RH/fJ6lgHrwrH8Gsi2wBwq1tNmiD16JaieUZMgR/gg1wsMArOj+Fwsy6Ku70Tc1jFChoiyTrVkbSi818h7g5fnBTgU+fMZJFpWd3VTtltjLDIhx22VUCgt7CrNeQGsE6wvQHfnXkfKlJNjtan4b6Y+cTmzoBg4UUu4Y4PSZdYNjVdbfqJbMA==;31:V6HVq/VxL4v0m/7k9XoTcknCaf18SxB4T1cM6mtRbRoyX5m/8YnFLxj6ckyG/U3LR6g+u2oqVi6qS7/7acZ02phH49srJVnZGECLMoPplermM0fxRwPv9gcCTllv8SRiI3Kt71CXLUMhvinuUrbKRN4Vq1OIInTJ6KTIV7xLjKXoZk9CK3CbRVo2mzeXOUy4gzZhbz1HtXVCAXwvYRB9H6TaSovrKJk6FMiNO2SV8As=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:cAMEzNa1WGKWWdC968b5Z9HkP1y4rHkiHg4cnBUnY6fa4B5O30GJbrT57a3vZXQMmN8IncPAWIYTXIwug938SKzPX/meOA7J3ZDzEJ6M7VH2NQePzO6GQitqvyPF8Wd7+DoPus4tTlsXJHxAK4UMVFSD/W/Rk6/qhrxVspQL5y32WxFTPN0Rm4jKOyRg1lH5/yHF0e/+Dd6HAa6WuwZFNxfrGu2M3/qMb+Szl777ZTOwd+53FND7nQKX6orHRMFt5dgdSkrFzC7yovFnAySKRsg5C9nh8CHnp3dG6+EeQYoClYuAl2CC+Oz2v4f53IoPeYcZQ0/Pvs89hx42QI0bfwrs9aqErBiOzYKkKZxuUAElrBlySKoRDe2bN+nS0z5w632DzISirA3G9sh5Nhy56D0GWEBWfAlF5+9A0WI9h9G6e06A5ifrYnHIWzCA9LbtRMOw2VBjhyCv3vixsa6g/ces2savgeFij69tiScdq/IGljbBOHzu34borclV5kZ4;4:YqzVAgWdxg2yzl6/mVdxBsGYlPFyL3tgQEJc0BEAeB4CWCS4L17hiQb44mcauA0fW/TS79lr9waazrd+i1P42npTlGPjUXh0d1VOfB4hOgMQ9qhmlII8fEIqK074nWUcWdgVy6ZbQ7EJIfoV1j6wMHCFW5HM5KGIHSSz5/pvArVUSxruzw281pxr9T95gUx7b4ppEqyJr0Tv6WibF39ZYWjSvsa0tgdk95TiQ2lOvtMgCr3IRkgCBnzohpgMyI25BBU4YQtw7ygOJOXKZcyJXNVIuX0qImIqYkUQS/tVzi9z4lY2Jy14X0+e6+z9WGObApfdWY1I/MjUQMQS6eCl5rUsOqgKMpgLtogm50H9qEo=
X-Microsoft-Antispam-PRVS: <AM4PR04MB21291EEA5CA2ABAA5B6558B2F6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(3846002)(51416003)(6116002)(36756003)(26005)(76176011)(6512007)(50466002)(446003)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(11346002)(6486002)(97736004)(53936002)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:ulPkAdv1W2Tw8GTSOzgdoFZ/iYs5QaJ12Bm4Nr20M?=
 =?us-ascii?Q?6CMvzlO10aUgMiC5Z97LLgHmKQUmlehL5u74g03BlGf+q8MSFtrNln30Q8zf?=
 =?us-ascii?Q?sjmIWMhv1i1inb8LpYGBBkB4GQp2VX5Aubgp3SLWmLvptR0fYU1GUZtsmSd1?=
 =?us-ascii?Q?LQk1c4cNw2+BTtROyhZVIzayUyG7C/AWWLRFq/8VIWzBCKmFOURBLAzMW9EZ?=
 =?us-ascii?Q?AYfzcnzp0/pxQ8+U+b1pqsE5u+ryZRPzvzCvprrlf30AvV5B5ULWgKLYSJPh?=
 =?us-ascii?Q?fdeh+2G44nFUSNotXcDf/ObBh8uewNeqqzPP4qZIrRjmETkWin3pFIQXvKKY?=
 =?us-ascii?Q?o3oVTTeWow2ZOsObZ3r2dPJHNWP0sMkqHRYqPiWgZjnFhh6Rxg0ZnS2CHMV9?=
 =?us-ascii?Q?uYzL7HkukPq2cK7kUshVm5n0YbEW+LoibxwQ5TU508YwoJcng66ZAqiPvd7B?=
 =?us-ascii?Q?d4jTAMJmhGOuYR4rC14hGRJyfYe88pgn2xvaz/e3AZI3bJy3dU38CROcQNbQ?=
 =?us-ascii?Q?OScJf8GL8jI8OG2RJVskOv/D+IuOzcNhkCmNWVUbk7Dt56lNIhSK8UriPUrh?=
 =?us-ascii?Q?IU8cBz7Yz+d8kCpd7MGsMBmtCwq0meGbLi9yRjpFAQXcbfeGTaflqQ1uyaRw?=
 =?us-ascii?Q?4WO+ysZcqusDaQKVBG6u1+l0N59fgf3wsuJ7kh3iZA9HyIOcSpHXFXobb9Ta?=
 =?us-ascii?Q?fnEETNy3bFnM5QFF8slEWtQSUchjiokgVkmFNUPpFlJuvJHJooevqx3OYKAq?=
 =?us-ascii?Q?btWbdgIVE1laG8FjEzIXv/lKhGXJXXNyMPvt/iEXbjFL/2zQdHQf8Qh/ndAo?=
 =?us-ascii?Q?rnfRxeK+jnwg8a3k6mwkOXVEs/WHUJLbDErz8wldC3nT6040o7l+E18HFTIr?=
 =?us-ascii?Q?J99XpC2dsAyA61Sv4lutjSHK4jQZEFWIu5Hpw1IXPlxi+YRGHRy4LFwC0ZPr?=
 =?us-ascii?Q?l9ScJ2TGy5S1VjnyEmh4ccO8Sa/P8x8xNjql4dTOJzE2MbpJ/AAitb3pY4bn?=
 =?us-ascii?Q?+qDVD88UJGDo6shddYJNSNaemzSR09NBE1BUEMcaMDBHJ2ZOd+bzSjdc4Aw5?=
 =?us-ascii?Q?xtVvUcHimjRLx3JfIMrDu1ToiGlfEtIJSJ0AuPA5o98G5ExSRfAbhj34QyZ/?=
 =?us-ascii?Q?SWHuqW7ppliSUhXPezOmd7I8MCr0E12t8UpB7RSMU1+a6CcWjYr6dmFCc2w5?=
 =?us-ascii?Q?9jTe2Q37VDG2AannOThcLxTkCNeDOeLyUOeR3Jya7BNvrMfhUR6rUQw0g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 2b2Bxo4X70DEN3bfRjjRv8ij8wsBgSIxGiRwAUk2SgEp/PwVGtu7DefKjXDBtNW9jhQtvPpm3JkI+Vtodu4T3wKRfcRamKzOdkaHPJh6ado51Kewbu0q3axyaN3ulqOSFEfIk+3xnmvYx85L0pdBXF7pkRJvYBIx229SL/+FzTKNua8XkHS1X1r7SyJFWHsq
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:svdazxOAOh51qLp52j+QshQZpkpGo//zmSr1GyW59I4HocXrfAoYENVxKJNyVz4iF+oT5DVfWm7gw9PMjDHqYSLyb9xtMUUp4U2G2WINZ38gWDIkGnbzaDeb2nE9M2ltiuXVzt49Ya+90BMMcPn4Zexi/qjH88EFlMrSwO3b7ujAdcO9BUFfqEwAskgNJUm77jWaS5oki5LBAuECtStIbAXWvKXFx8oRJrEjPwQT61fvOc6R8ojS3WBgpXn4x6r1gwjvLydjv9tPZhbvtTWrjMgjJeIypu8PfwefofuGRAL0KoB9FhINEp14kbeAmeNA9231Itu/zwl0DUsgv1Pk8S6htT6GKxH8fwQqIcKtGQKQJJwPNzACie2XMA4neQ4bmgBN1g+DTYB6DzUJCPdAFjk7duzrj609ncP9n0jWcJmmyfbbaYNTcnu7Zx7xkdZqV2/ONLYxNH8UW4Dp8ILyKw==;5:4F3cg/OrQapwMR5BNzR6Plm/3QLrF7nBW/WavpI4VGAoXpqvXfUZDWmPQsD8x1yzULww6Bs+PmvfBoj660j7PsHfN24/xsQP4LTR+E2ON4xo4/8xgV7E9hYibGWGIbIUoSERaP7kExVv3hTEZ472RiemZmz4ji9z8fA6bJViLX0=;24:U8A5Ov7ZjXK8uqcGvIJikSVY6bH3C1gK+GXr1z5AcMO93X3f4rT/bNAv+WSgPH5TCb8baidSGOjD3t4RqzIJ4CciVyynI8ZCZitONWuBGnY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:WiEw4ALRn99sajjLPsonEnOjfWE9OM2MticF+B0bjDE0fL9Iz3gjwNEI4LWGDKpEp1xPJReeRRgviSrFXM4oIq6Qz9Sz30qz0KtBtBc5iOOJ6L/a1okK7A27f6nancKbRiHjeYcDbqq8B4ERs0e/dB3VDFgon+lBwcrF/58X1EUyOi30Twm0WekGibtJjEaxkdGzIjtis7NdkZPgk8uqO7iUqpnHEECD5W6nd6rYnFhLur0v+y78mY9aLQJjVncs
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:06.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5e7d9d-cefc-442f-7a26-08d59477b93d
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
index 50da4cb..975a20d 100644
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
 	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
@@ -891,6 +884,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
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
