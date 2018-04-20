Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeDTHmb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:42:31 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:11907
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753729AbeDTHm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:42:28 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, shengjiu.wang@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V3 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
Date: Fri, 20 Apr 2018 15:38:10 +0800
Message-Id: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:/BwLhZtjphvNiMlb7FFCvk7zV7DDEc5s+fyVrT33lwTKVzXbLeR2aTuqm7CYXQQY3R8+lPRdwh1xZaxS6OE2+GKqOC/Jlsv9kJyXUz3OH3+HcLdxXKAnfO765ipb5OzjpO5WW+ofmTo0ccaewpFpTp/bYVG1Hs4lGqmFApI+FSOwVsdlk8jvO5B/4WSskY0JWF9Y6ReprnCPOgQqbdBXh7cJPElZAiCcI0OITI1DOpkwqfx7uv4/xhPTXUMFfGzJ;25:qSzNLxsE+y/KDD1AWYeQdqpD1JKTy6ZkPaUwy1AEKupuncZy0Ur1QJrdePtAidRC8QxkHo8FrS9RxtYprqTBiXGnJEYIV9BmFXYvTDdlTsiyEU/VtlpjAGXsCVxZfOmVWA61z7IDc8U4iKu3UxhzlngvNMQTsekOQTf9t72e5FB7DrFU3OPeU2OSwmxSWwdqPGxujfl7CTLoNchGGN+ptg3I9bAnFMiaeVil/PLalYNjMsQ4zqr4PUjSoYWd1uRcPbPJUJV4nrOCuf0KStCQQjPfYmJ96k8h3X1ZbEMEl5BZW9AmlsAf1MlwhPep/A/L9cvxW7HuKQDlJnQJD9xEIQ==;31:NJwSX7JDn5KjNsi+kV7YT42MRYqg/WZ26ENzyLdvC2GEFOJx17f69q0a+WuwHkVQiEJ8nrP81gPmK0vno7SblbQs/kHwXAU3JIP5AV2WL+uvWZkTpu6xUI/8prKz+2OWprl7PqRGs1KJk5walUtirhR3ic6Apjkr+87Rq3wKciqxxq09HrviPNJ1BJYs4JDwKW2JvVYD80I1x0ZtdSLIEp+OusMP2cihQyej33hcyKc=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:hV2b4JNZ3/4IcPHCH2bEfZsXqthPoakqj1nnv5B16Exl+B4Q4u/4Hx3M2uKSuh2d+bngBAQR8JLMi8iAu5bh+d2nmTB8DHGWpg+pIZWjhkC455NIs3kQdzK4pDA2WdrSTazXqVBMRBValz/PmS3pryjjIyMppbN8RnKZoM/ZdBso78YexN+Opb5FpMwJRqIEC8wuX8wuI7/O7fe/wkyUgqYS6fpvzmO6svZ5/Jg3RSlp4XVV/HdmKy4lkECCDs5AkcNTCTik1x4e3UljGREGChHAHgRiWlDGQYeDS31Hu/7deQfBPoqLQSicDdLDKAdv7MWW/sO5NRLN2NAnwz1uh5Htod0akSUS35U7vb3gwFCCSYFwgNGXgDFhmYayyRuX8iNXoEQi7WT6AKd0fOQJ4xkU7NBsh2dzUl18XRtPC442rwP0qvXCuLSsitp2Z+bDKWXbsS6QofxrOPYwJ5Z9u3JuM0L6N5cJ9w6zZWHQFXT+MBuzTrwDaurj9kzH0Tsm;4:fH9LMW7qgWr1OuuM0DOw9LroYEXQIxwfQalx8Pyp96h4VI8EnMFoSLmSxBnrU0mtAdAUUpRvG88ocIRsCpwyJA6n1+FHGBN4KwxuzRkXRNMBWUhkzIvqMzkSqdlWFjwKpXjfGV+B7/cLO8fPSzrN9iWHJE546dzPcirEoqmJZhtgNE6IsH/y61cPFFs7uACfH38RqJro7PRHEa7FnJtq68gXJhmEW9jKGQROEno1ANeKfgG4dbF0lCoRMhTBiEYvgstrw9Tfsly5WguqZpvMb6YMs4inTQy5kSCC+xqgOnvtDQ7/oJN20bfxHmuzGOhU
X-Microsoft-Antispam-PRVS: <HE1PR04MB13241F168DBBF4409D67AFBCF5B40@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501391)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(305945005)(25786009)(52116002)(53936002)(478600001)(26005)(476003)(16586007)(66066001)(2616005)(6506007)(316002)(186003)(86362001)(16526019)(386003)(4326008)(2906002)(3846002)(6116002)(6512007)(6666003)(7416002)(47776003)(956004)(6486002)(6636002)(50466002)(8676002)(36756003)(81166006)(48376002)(8936002)(7736002)(50226002)(5660300001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:RW6gMdCsTF/rTf+nPd9Drk6g9C4uGZs954zjSN3a5?=
 =?us-ascii?Q?y/daZGMCIpzpWG83Zvmlbsz2VsXK3cXy7cckMkPNRUvWoZQ9qwj3r6L5DkSo?=
 =?us-ascii?Q?cx3VN3IqoYZEp5RarHusY7HwD9wobxo8M1GzVhA0xVjvK/siB76qqyIbAJvJ?=
 =?us-ascii?Q?kpXq9fRb0GHQXv0GeUSq9Umf/rS+EvAhE8AHaYazvS5vui4R3GQgcWOiO6Zf?=
 =?us-ascii?Q?yzEgF5BzqXkAML+WceTTZ2TOyxQQbbzX+fMLzP6gzmwRUIQn76zi+HNqm4Eq?=
 =?us-ascii?Q?BPl+z4gvCvPz8ZOZ2hoGJdU8KL5L/7RMU2cpPE8WKzPxv2Q7pv/TfD9lNUhE?=
 =?us-ascii?Q?R4HXPodAgnMFCp9dqcv2zkk/o5AIhAcetYsRSljDsSAN+SQSGywFYu/K3pFW?=
 =?us-ascii?Q?S6lunKVL+UV7ybY2+N2m6g0ZMRpDG9ARgXGG+nCX1HzYE6BfXh41QmCvWQrF?=
 =?us-ascii?Q?ziXgCvc/T7jQOUvOKjjyorsI4XWuyrOUIKFTPIVPt2qZ76LiMHlTETxYfpPs?=
 =?us-ascii?Q?wGDM0fl/NXSNTRIIi4L8lf7utvIEnEKSPMO/4jYF9Bv0Ux6LNHSFBZJIGbA7?=
 =?us-ascii?Q?hNxIi20JJXlFr7/ull1m/TSTBwBEGF0xtWsTmdTTfOVaOvyLvm6cr/sBVA5v?=
 =?us-ascii?Q?c68+NwaPsogmjOdHOxyKzk1tL9pMGAa593oIr2HferSHAGn9wfDfWaOzR45X?=
 =?us-ascii?Q?oXxcO8GEy/2g3w1BS3tKA05OL1q+7IDQisiCPi45Dqtnw1SkH1T3To/idWTX?=
 =?us-ascii?Q?VhOP2Y3cYcjXlJU3bIL0op99PYgSWoxaUrx1UqKZmGO6R2J0OBUchZetiK2/?=
 =?us-ascii?Q?bHxTLzNEj4U6pt8e7EXthERhbJI3uYexIluvq90DUS2wIizxREVUX2Gns2vw?=
 =?us-ascii?Q?dqjOpqn70T4n1zlOMfqOfz/SSOw2ZAyz+tqUoCbBPgNfhCDJD8B0++UbBG3Z?=
 =?us-ascii?Q?B2rPC7AzSBOsMCZ3lecorhSm3oRBuQk78zfSqUuGXfib4rAfFgSp7nKvkbR1?=
 =?us-ascii?Q?y0=3D?=
X-Microsoft-Antispam-Message-Info: wUFbEYrRGwRFxRWXM/i9v3TRAMMxVsUrq3twycyA9XiGzy/wDLsWCtVyYJ5cNAmzw9TGTw9lCxzHrEo23JIpVhoGzy2btf+Uuz8QwTwP2GTuoGhsLa11S47iNZOYpummBRX62dOe9tmGeuaxk73v1pvvISwymyr+akgh4N6Rt1099QH+xGnz2b+54xHGRi6D
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:QhJFU4KP2HIeHwzn5HuXxZNom/bohpy6OoSZQDj8GtgpJbbeytZ3kE7sYD8lpOFhrtDzr2adwn/TtHk02u0zZhV+enKyMrRd5OYSHOOP3Ay+crqkKAofrZ06cmvOgfAXwrfsuz+M1fYoQZQzRvuejarh5PYFHVH13BwX9GQgbNGCv5XY6Zgm2rHSXPKTGCO1TUodP+dN8w2uxA18GDZbQnGI86FE7qdHLyvD/R7VWaN8R4Ie5baHIkpnysmrstgY0nQnZM3Xxnl1I8+PKETi4beL6nQpdQFb0AG8IZTGy2nRj5K0CVrQKOG5nxYNvt+p5jevIlIMx+WHTkTS3HT1/OdhPIJiJJTFJkENI1bkpu2VV8qbzfOefz7kOhYPJgxzXa99gUtRpM77ZIReN2I/JhaHcJMS8RCCFGMGAIAdkk4Fa2vSNWehJwUonKQb64ZQf0w4Xd1QicDtGiyAjErdQQ==;5:J7tWBm7UZ1EnuFk/zA2cNuo3DijgMbAnTHKXApgXD1leVXq9ljadpbE0cxPGiDh6anT4cS6CuLzOdES8M8ZFvSvHTHfvNq39/W/eF9tV1fQL+W2EAP1z0fnXIoRB1ox3pvaoWOwZZ558KVR7FC7hF/GWgeHbEDY9piSB9AaFN+k=;24:kXAWPI8d2m6LcziHEJeLmJYUdp4fBq70YjnX6jbfQOXVTxYhkIUJkdr+ODVKeEdonAGm11I4LIG6zMU6nmIXZ0kuiiAjH9vX14DXhKIleuA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:wRaCPsrMecukQNl+OsyUvQmS69eHCiElXgeFheV55lBSzk7k6ekGfMwuHMJs2fsqhYeJYWj/+9mANW9zZe9woF0Mrje+OTAxi8tZgQNKd7dU8a7DA9SsoxX234cxg2irTcVXTbSvcbl3theF1hZ5PvjE82/viy5TEHXAQzevqf8+lxKtkvBIy5aHtVi9B737VOnNkvK+KkxIX5e+yj71N40bvofXm6ewSc9dS22AfpNoJU+R0RSNSVIYkkWOasjU
X-MS-Office365-Filtering-Correlation-Id: 7bc6a6f7-c22d-4c36-dcb2-08d5a6924088
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:42:17.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc6a6f7-c22d-4c36-dcb2-08d5a6924088
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
And this lvds2, along with lvds1, can be used to provide
external clock source to the internal pll, such as pll4_audio
and pll5_video.

This patch mainly adds the lvds2 to the clock tree and fix its
relationship with pll accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since V2:
	use of_clk_get_by_name instead of imx_obtain_fixed_clock for anaclkX node.
 drivers/clk/imx/clk-imx6sx.c             | 10 +++++++---
 include/dt-bindings/clock/imx6sx-clock.h |  6 +++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index bc3f9eb..0178ee2 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
 	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy", "pll5_video_div",
 	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
 };
-static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
+static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", "lvds2_in", "dummy", };
 static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
 static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
 static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
@@ -158,8 +158,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
 	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
 
-	/* Clock source from external clock via CLK1 PAD */
-	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
+	/* Clock source from external clock via CLK1/2 PAD */
+	clks[IMX6SX_CLK_ANACLK1] = of_clk_get_by_name(ccm_node, "anaclk1");
+	clks[IMX6SX_CLK_ANACLK2] = of_clk_get_by_name(ccm_node, "anaclk2");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
@@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
 
 	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
+	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
 	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
+	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
 
 	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
@@ -270,6 +273,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
+	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
 
 	np = ccm_node;
 	base = of_iomap(np, 0);
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index 36f0324..cd2d6c5 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -275,6 +275,10 @@
 #define IMX6SX_PLL6_BYPASS		262
 #define IMX6SX_PLL7_BYPASS		263
 #define IMX6SX_CLK_SPDIF_GCLK		264
-#define IMX6SX_CLK_CLK_END		265
+#define IMX6SX_CLK_LVDS2_SEL		265
+#define IMX6SX_CLK_LVDS2_OUT		266
+#define IMX6SX_CLK_LVDS2_IN		267
+#define IMX6SX_CLK_ANACLK2		268
+#define IMX6SX_CLK_CLK_END		269
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4
