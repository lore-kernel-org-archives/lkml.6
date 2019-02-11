Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B33C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E9421B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfBKQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:41:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:60661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfBKQlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:41:32 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFz0E-1gqSwy2aqU-00EueT; Mon, 11
 Feb 2019 17:41:18 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx5: Fix i.MX50 clock registers
Date:   Mon, 11 Feb 2019 17:40:48 +0100
Message-Id: <20190211164048.7841-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IdxlX8NnucCXMJu2Q197A2OeOch1sGo/NRkaqBOBZEhqAB+7pbM
 abrnJ+Nqys6nCZSsscArXAzZ0lfEMFiuLWkeuwM/SfqeF923YvQxfnjoJ+L9HWA7IJ1l4pm
 ymPnX5jBxgz1+/au9q3mfL9+230hvmIVE+YGBOQnOK7u+Ez188iAT5On4fJCzaVu0BiVBQA
 uH11Y0d75ruSMaKXU4xWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OD+qXThc5o8=:OsCGIYMPwCeZbu+1eWoTV2
 UjukHZZKj+tkf0aA4hIYCJbFk+aS018NeCvZM1f8W6lNdbCV+vgshmG6i5EeOsSDbe0C3QSSj
 yk36JmgCiE/K9R1bHwNh1oBRqVNCgwlsm0a3QUPBUPzXYCf+Dhfe5wxaOHn14q/QXd+XtPAD8
 sG+DVYM43j7v+DHOP4RCxSCKEy+KtpH4MAOC+9zZNfv/BE5YZ2H46XhK3/44ViLrLpBox2K+L
 kMMlKsNifXa9wGb4gFlmxBeZ/+iua50iudP3tlKhL3/4Jmh4j0GLXW8LgKAgNBb/wJoOOkUo3
 nWYZDjwn8TriKSx0OTtYXNv72Uy549bpDCk+7j4q2k4d+Ar+gYG+VoM5KWHrbc1uhjzBwdXic
 R1yWsfRvoqlZ9yjNZfUk0+kVUGj6iP5PbdiEC9IRLARkXSon6d4dA+l6xrPFEtKErXnygrWJj
 JWHF0gPm3VcGfPH5PV685ycH6a5FNO7jfkrgGL3nZ1NBauU7/5W4yIJMWeQL2hKeO0zNk9wys
 wMUwTf1XuSsTSGh9wsRkbRgWCkTM/yz5/PRf+SrCJE3x73FtOKzfz4ICXOa4cUMtVklGNN9DI
 hWqFiaOHT6a2tAxBmvDlFAM+yxngJkHbYDQT0XXf2qOqI69Ij5U08qmqgWQOzjELFvyRT0s3f
 o6zEPOtaqXmONMOjoMs3AtXbNzqLKZ98NK7+sJyFiYKy3DmRG3FUUOiiYVdqb8uK71dupBVDx
 YKokzE6jbT4k61+kS2cPUVhqV7xHgt/VH97uG+ce0x3rLEU/k5nW2xXje0v8+LzDSfQ+yS5Wl
 q8bEpGr5ik6m7KvsX5tFSg3hKqVOKr6JOJy2SP57GVDRvkz8I5yKM10/W02EbWFfFOIo6Jt73
 Zjh4yAf4WAgG2bEL69f/H/5jJPpdOUL6OuzHxs7zek/tawJHAa37Hri8rjXExRmQbqJZqRU51
 V2nXEtHAkWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few differences between the i.MX50 clock tree and those of
i.MX51 and i.MX53 that are not yet handled in clk-imx51-imx53.c.
This patch handles the following differences:

- i.MX50 does not have a periph_apm clock. Instead, the main bus clock
  (a.k.a. periph_clk) comes directly from a MUX between pll1_sw,
  pll2_sw, pll3_sw, and lp_apm.
- The MUX bits for esdhc_{a,c,d}_sel are shifted by one bit within
  CSCMR1.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Because I'm touching a critical driver that's shared between all i.MX5
SoC's, I'd prefer to get a confirmation from someone with i.MX51 or
i.MX53 hardware, that the driver still works on that hardware.
---
 drivers/clk/imx/clk-imx51-imx53.c | 59 +++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index fc8e782d817b..6fca0bb97858 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -164,10 +164,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", 0);
 	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", 0);
 
-	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
-						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
-	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
-						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_PER_LP_APM]	= imx_clk_mux("per_lp_apm", MXC_CCM_CBCMR, 1, 1,
 						per_lp_apm_sel, ARRAY_SIZE(per_lp_apm_sel));
 	clk[IMX5_CLK_PER_PRED1]		= imx_clk_divider("per_pred1", "per_lp_apm", MXC_CCM_CBCDR, 6, 2);
@@ -191,16 +187,10 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_UART_PRED]		= imx_clk_divider("uart_pred", "uart_sel", MXC_CCM_CSCDR1, 3, 3);
 	clk[IMX5_CLK_UART_ROOT]		= imx_clk_divider("uart_root", "uart_pred", MXC_CCM_CSCDR1, 0, 3);
 
-	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
-	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
 	clk[IMX5_CLK_ESDHC_A_PRED]	= imx_clk_divider("esdhc_a_pred", "esdhc_a_sel", MXC_CCM_CSCDR1, 16, 3);
 	clk[IMX5_CLK_ESDHC_A_PODF]	= imx_clk_divider("esdhc_a_podf", "esdhc_a_pred", MXC_CCM_CSCDR1, 11, 3);
 	clk[IMX5_CLK_ESDHC_B_PRED]	= imx_clk_divider("esdhc_b_pred", "esdhc_b_sel", MXC_CCM_CSCDR1, 22, 3);
 	clk[IMX5_CLK_ESDHC_B_PODF]	= imx_clk_divider("esdhc_b_podf", "esdhc_b_pred", MXC_CCM_CSCDR1, 19, 3);
-	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
-	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 
 	clk[IMX5_CLK_EMI_SEL]		= imx_clk_mux("emi_sel", MXC_CCM_CBCDR, 26, 1,
 						emi_slow_sel, ARRAY_SIZE(emi_slow_sel));
@@ -311,10 +301,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk_register_clkdev(clk[IMX5_CLK_CPU_PODF], NULL, "cpu0");
 	clk_register_clkdev(clk[IMX5_CLK_GPC_DVFS], "gpc_dvfs", NULL);
 
-	/* Set SDHC parents to be PLL2 */
-	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
-	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
-
 	/* move usb phy clk to 24MHz */
 	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
 }
@@ -342,8 +328,21 @@ static void __init mx50_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	/*
+	 * This clock is called periph_clk in the i.MX50 Reference Manual, but
+	 * it comes closest in scope to the main_bus_clk of i.MX51 and i.MX53
+	 */
+	clk[IMX5_CLK_MAIN_BUS]          = imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 21, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 20, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 10);
@@ -372,6 +371,10 @@ static void __init mx50_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
@@ -410,6 +413,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_IPU_DI0_SEL]	= imx_clk_mux_flags("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
@@ -422,6 +429,12 @@ static void __init mx51_clocks_init(struct device_node *np)
 						mx51_tve_sel, ARRAY_SIZE(mx51_tve_sel));
 	clk[IMX5_CLK_TVE_GATE]		= imx_clk_gate2("tve_gate", "tve_sel", MXC_CCM_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		= imx_clk_divider("tve_pred", "pll3_sw", MXC_CCM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 10);
@@ -451,6 +464,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 	/* set the usboh3 parent to pll2_sw */
 	clk_set_parent(clk[IMX5_CLK_USBOH3_SEL], clk[IMX5_CLK_PLL2_SW]);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 166.25MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 166250000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
@@ -505,6 +522,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_LDB_DI1_DIV_3_5]	= imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
@@ -526,6 +547,12 @@ static void __init mx53_clocks_init(struct device_node *np)
 						mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel), CLK_SET_RATE_PARENT);
 	clk[IMX5_CLK_TVE_GATE]		= imx_clk_gate2("tve_gate", "tve_pred", MXC_CCM_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		= imx_clk_divider("tve_pred", "tve_ext_sel", MXC_CCM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 10);
@@ -588,6 +615,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
-- 
2.20.1

