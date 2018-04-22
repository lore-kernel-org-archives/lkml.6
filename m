Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JpR7qMbRMYFWJRGK9olwZeM6jXdrnxF8VSxwyhaFAuhUxValtgqVAo21x3/R365QNXGvU
ARC-Seal: i=1; a=rsa-sha256; t=1524405648; cv=none;
        d=google.com; s=arc-20160816;
        b=lEfQEYeWPKc0F6IO56/gMVIXr2MIda7TJ/MstmqSxpskS5/jBLFf42ySaAdf7l9noH
         0hN1/02w5gBqjsbXU/lzQ/6NENcXgIa9vLb+oNEPY77xTSCi13ZJQaqKhycoim8iGSwj
         GQW4Kfgf2is+4xcuswm5sjUKObVTghbaKNR7Lc8mJI73RgmBBH3+obN2OOmGA1A1KUnj
         vhG5No0hA39RwCPNLOc3ERptc27EVQTidsnNc/3vQZwC2NBR8gnA7NypGlAOrQzb1KYQ
         T+EGdKLRaOsZIf1VBNWS6yuh8pTSzL/2gaz6xBJonr99LVZDs+ks/OQ+ESySxqoB4Q0D
         a03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oegcSTdKciG0HkHRmSiLxLMKY2UOKLYn2ZTIOpZEuAI=;
        b=cJ8gwn12776senQDTBTRqJEaGLt7xX/Pv8X6EHOy/UsBS9uqC3ws4qy+vNjJYYRDkv
         e+oRVDDWThvWeAEcUEn+Ff8VJg8o+dIicYZ1l4Ow2GSLM3lyPVcI2fhk4UbSKJ9p8/t7
         hSpqJ9KOTtHDggfnxR4ux9MGbOLwaA50ZRsu001g0/+WWyk52Z9gP1uli9gm0FiZ4pBb
         uX0vHEjBeca2cKW0BP3H+lwyczmYDb3PV2UDROUNPLnYVJ4xo97lwyWcr8ugTLkonduQ
         ZMZhuU6dh6v3RnMpmk8VYMrIdxtjEZxEtNuAPEh0LPgHEsAewH3x+V+qwH1qEBXC3Ytj
         RUkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Osipenko <digetx@gmail.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.16 143/196] clk: tegra: Mark HCLK, SCLK and EMC as critical
Date: Sun, 22 Apr 2018 15:52:43 +0200
Message-Id: <20180422135111.627376552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455176862252953?=
X-GMAIL-MSGID: =?utf-8?q?1598455176862252953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <digetx@gmail.com>

commit 2dcabf053c6ecde46f7aa3612c5a57fb8bd185c4 upstream.

Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these clocks
as critical.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: <stable@vger.kernel.org> # v4.16
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/tegra/clk-emc.c              |    2 +-
 drivers/clk/tegra/clk-tegra-periph.c     |    2 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c |    8 +++++---
 drivers/clk/tegra/clk-tegra114.c         |    3 +--
 drivers/clk/tegra/clk-tegra124.c         |    7 +++----
 drivers/clk/tegra/clk-tegra20.c          |   23 ++++++++++-------------
 drivers/clk/tegra/clk-tegra210.c         |    3 +--
 drivers/clk/tegra/clk-tegra30.c          |   14 ++++----------
 8 files changed, 26 insertions(+), 36 deletions(-)

--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -515,7 +515,7 @@ struct clk *tegra_clk_register_emc(void
 
 	init.name = "emc";
 	init.ops = &tegra_clk_emc_ops;
-	init.flags = 0;
+	init.flags = CLK_IS_CRITICAL;
 	init.parent_names = emc_parent_clk_names;
 	init.num_parents = ARRAY_SIZE(emc_parent_clk_names);
 
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -830,7 +830,7 @@ static struct tegra_periph_init_data gat
 	GATE("xusb_host", "xusb_host_src", 89, 0, tegra_clk_xusb_host, 0),
 	GATE("xusb_ss", "xusb_ss_src", 156, 0, tegra_clk_xusb_ss, 0),
 	GATE("xusb_dev", "xusb_dev_src", 95, 0, tegra_clk_xusb_dev, 0),
-	GATE("emc", "emc_mux", 57, 0, tegra_clk_emc, CLK_IGNORE_UNUSED),
+	GATE("emc", "emc_mux", 57, 0, tegra_clk_emc, CLK_IS_CRITICAL),
 	GATE("sata_cold", "clk_m", 129, TEGRA_PERIPH_ON_APB, tegra_clk_sata_cold, 0),
 	GATE("ispa", "isp", 23, 0, tegra_clk_ispa, 0),
 	GATE("ispb", "isp", 3, 0, tegra_clk_ispb, 0),
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -125,7 +125,8 @@ static void __init tegra_sclk_init(void
 		/* SCLK */
 		dt_clk = tegra_lookup_dt_id(tegra_clk_sclk, tegra_clks);
 		if (dt_clk) {
-			clk = clk_register_divider(NULL, "sclk", "sclk_mux", 0,
+			clk = clk_register_divider(NULL, "sclk", "sclk_mux",
+						CLK_IS_CRITICAL,
 						clk_base + SCLK_DIVIDER, 0, 8,
 						0, &sysrate_lock);
 			*dt_clk = clk;
@@ -137,7 +138,8 @@ static void __init tegra_sclk_init(void
 			clk = tegra_clk_register_super_mux("sclk",
 						gen_info->sclk_parents,
 						gen_info->num_sclk_parents,
-						CLK_SET_RATE_PARENT,
+						CLK_SET_RATE_PARENT |
+						CLK_IS_CRITICAL,
 						clk_base + SCLK_BURST_POLICY,
 						0, 4, 0, 0, NULL);
 			*dt_clk = clk;
@@ -151,7 +153,7 @@ static void __init tegra_sclk_init(void
 				   clk_base + SYSTEM_CLK_RATE, 4, 2, 0,
 				   &sysrate_lock);
 		clk = clk_register_gate(NULL, "hclk", "hclk_div",
-				CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+				CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 				clk_base + SYSTEM_CLK_RATE,
 				7, CLK_GATE_SET_TO_DISABLE, &sysrate_lock);
 		*dt_clk = clk;
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -955,8 +955,7 @@ static void __init tegra114_pll_init(voi
 
 	/* PLLM */
 	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base, pmc,
-			     CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-			     &pll_m_params, NULL);
+			     CLK_SET_RATE_GATE, &pll_m_params, NULL);
 	clks[TEGRA114_CLK_PLL_M] = clk;
 
 	/* PLLM_OUT1 */
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1089,8 +1089,7 @@ static void __init tegra124_pll_init(voi
 
 	/* PLLM */
 	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base, pmc,
-			     CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-			     &pll_m_params, NULL);
+			     CLK_SET_RATE_GATE, &pll_m_params, NULL);
 	clk_register_clkdev(clk, "pll_m", NULL);
 	clks[TEGRA124_CLK_PLL_M] = clk;
 
@@ -1099,7 +1098,7 @@ static void __init tegra124_pll_init(voi
 				clk_base + PLLM_OUT, 0, TEGRA_DIVIDER_ROUND_UP,
 				8, 8, 1, NULL);
 	clk = tegra_clk_register_pll_out("pll_m_out1", "pll_m_out1_div",
-				clk_base + PLLM_OUT, 1, 0, CLK_IGNORE_UNUSED |
+				clk_base + PLLM_OUT, 1, 0,
 				CLK_SET_RATE_PARENT, 0, NULL);
 	clk_register_clkdev(clk, "pll_m_out1", NULL);
 	clks[TEGRA124_CLK_PLL_M_OUT1] = clk;
@@ -1272,7 +1271,7 @@ static struct tegra_clk_init_table commo
 	{ TEGRA124_CLK_HOST1X, TEGRA124_CLK_PLL_P, 136000000, 1 },
 	{ TEGRA124_CLK_DSIALP, TEGRA124_CLK_PLL_P, 68000000, 0 },
 	{ TEGRA124_CLK_DSIBLP, TEGRA124_CLK_PLL_P, 68000000, 0 },
-	{ TEGRA124_CLK_SCLK, TEGRA124_CLK_PLL_P_OUT2, 102000000, 1 },
+	{ TEGRA124_CLK_SCLK, TEGRA124_CLK_PLL_P_OUT2, 102000000, 0 },
 	{ TEGRA124_CLK_DFLL_SOC, TEGRA124_CLK_PLL_P, 51000000, 1 },
 	{ TEGRA124_CLK_DFLL_REF, TEGRA124_CLK_PLL_P, 51000000, 1 },
 	{ TEGRA124_CLK_PLL_C, TEGRA124_CLK_CLK_MAX, 768000000, 0 },
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -576,6 +576,7 @@ static struct tegra_clk tegra20_clks[teg
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
 	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
 	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
+	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
@@ -651,8 +652,7 @@ static void tegra20_pll_init(void)
 
 	/* PLLM */
 	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base, NULL,
-			    CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-			    &pll_m_params, NULL);
+			    CLK_SET_RATE_GATE, &pll_m_params, NULL);
 	clks[TEGRA20_CLK_PLL_M] = clk;
 
 	/* PLLM_OUT1 */
@@ -660,7 +660,7 @@ static void tegra20_pll_init(void)
 				clk_base + PLLM_OUT, 0, TEGRA_DIVIDER_ROUND_UP,
 				8, 8, 1, NULL);
 	clk = tegra_clk_register_pll_out("pll_m_out1", "pll_m_out1_div",
-				clk_base + PLLM_OUT, 1, 0, CLK_IGNORE_UNUSED |
+				clk_base + PLLM_OUT, 1, 0,
 				CLK_SET_RATE_PARENT, 0, NULL);
 	clks[TEGRA20_CLK_PLL_M_OUT1] = clk;
 
@@ -723,7 +723,8 @@ static void tegra20_super_clk_init(void)
 
 	/* SCLK */
 	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
-			      ARRAY_SIZE(sclk_parents), CLK_SET_RATE_PARENT,
+			      ARRAY_SIZE(sclk_parents),
+			      CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			      clk_base + SCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
 	clks[TEGRA20_CLK_SCLK] = clk;
 
@@ -814,9 +815,6 @@ static void __init tegra20_periph_clk_in
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, &emc_lock);
-	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
-				    57, periph_clk_enb_refcnt);
-	clks[TEGRA20_CLK_EMC] = clk;
 
 	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
 				    &emc_lock);
@@ -1019,13 +1017,12 @@ static struct tegra_clk_init_table init_
 	{ TEGRA20_CLK_PLL_P_OUT2, TEGRA20_CLK_CLK_MAX, 48000000, 1 },
 	{ TEGRA20_CLK_PLL_P_OUT3, TEGRA20_CLK_CLK_MAX, 72000000, 1 },
 	{ TEGRA20_CLK_PLL_P_OUT4, TEGRA20_CLK_CLK_MAX, 24000000, 1 },
-	{ TEGRA20_CLK_PLL_C, TEGRA20_CLK_CLK_MAX, 600000000, 1 },
-	{ TEGRA20_CLK_PLL_C_OUT1, TEGRA20_CLK_CLK_MAX, 216000000, 1 },
-	{ TEGRA20_CLK_SCLK, TEGRA20_CLK_PLL_C_OUT1, 0, 1 },
-	{ TEGRA20_CLK_HCLK, TEGRA20_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA20_CLK_PCLK, TEGRA20_CLK_CLK_MAX, 60000000, 1 },
+	{ TEGRA20_CLK_PLL_C, TEGRA20_CLK_CLK_MAX, 600000000, 0 },
+	{ TEGRA20_CLK_PLL_C_OUT1, TEGRA20_CLK_CLK_MAX, 216000000, 0 },
+	{ TEGRA20_CLK_SCLK, TEGRA20_CLK_PLL_C_OUT1, 0, 0 },
+	{ TEGRA20_CLK_HCLK, TEGRA20_CLK_CLK_MAX, 0, 0 },
+	{ TEGRA20_CLK_PCLK, TEGRA20_CLK_CLK_MAX, 60000000, 0 },
 	{ TEGRA20_CLK_CSITE, TEGRA20_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA20_CLK_EMC, TEGRA20_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA20_CLK_CCLK, TEGRA20_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA20_CLK_UARTA, TEGRA20_CLK_PLL_P, 0, 0 },
 	{ TEGRA20_CLK_UARTB, TEGRA20_CLK_PLL_P, 0, 0 },
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3025,7 +3025,7 @@ static struct tegra_clk_init_table init_
 	{ TEGRA210_CLK_I2S4, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_HOST1X, TEGRA210_CLK_PLL_P, 136000000, 1 },
 	{ TEGRA210_CLK_SCLK_MUX, TEGRA210_CLK_PLL_P, 0, 1 },
-	{ TEGRA210_CLK_SCLK, TEGRA210_CLK_CLK_MAX, 102000000, 1 },
+	{ TEGRA210_CLK_SCLK, TEGRA210_CLK_CLK_MAX, 102000000, 0 },
 	{ TEGRA210_CLK_DFLL_SOC, TEGRA210_CLK_PLL_P, 51000000, 1 },
 	{ TEGRA210_CLK_DFLL_REF, TEGRA210_CLK_PLL_P, 51000000, 1 },
 	{ TEGRA210_CLK_SBC4, TEGRA210_CLK_PLL_P, 12000000, 1 },
@@ -3040,7 +3040,6 @@ static struct tegra_clk_init_table init_
 	{ TEGRA210_CLK_XUSB_DEV_SRC, TEGRA210_CLK_PLL_P_OUT_XUSB, 102000000, 0 },
 	{ TEGRA210_CLK_SATA, TEGRA210_CLK_PLL_P, 104000000, 0 },
 	{ TEGRA210_CLK_SATA_OOB, TEGRA210_CLK_PLL_P, 204000000, 0 },
-	{ TEGRA210_CLK_EMC, TEGRA210_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA210_CLK_MSELECT, TEGRA210_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA210_CLK_CSITE, TEGRA210_CLK_CLK_MAX, 0, 1 },
 	/* TODO find a way to enable this on-demand */
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -819,6 +819,7 @@ static struct tegra_clk tegra30_clks[teg
 	[tegra_clk_pll_a] = { .dt_id = TEGRA30_CLK_PLL_A, .present = true },
 	[tegra_clk_pll_a_out0] = { .dt_id = TEGRA30_CLK_PLL_A_OUT0, .present = true },
 	[tegra_clk_cec] = { .dt_id = TEGRA30_CLK_CEC, .present = true },
+	[tegra_clk_emc] = { .dt_id = TEGRA30_CLK_EMC, .present = true },
 };
 
 static const char *pll_e_parents[] = { "pll_ref", "pll_p" };
@@ -843,8 +844,7 @@ static void __init tegra30_pll_init(void
 
 	/* PLLM */
 	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base, pmc_base,
-			    CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-			    &pll_m_params, NULL);
+			    CLK_SET_RATE_GATE, &pll_m_params, NULL);
 	clks[TEGRA30_CLK_PLL_M] = clk;
 
 	/* PLLM_OUT1 */
@@ -852,7 +852,7 @@ static void __init tegra30_pll_init(void
 				clk_base + PLLM_OUT, 0, TEGRA_DIVIDER_ROUND_UP,
 				8, 8, 1, NULL);
 	clk = tegra_clk_register_pll_out("pll_m_out1", "pll_m_out1_div",
-				clk_base + PLLM_OUT, 1, 0, CLK_IGNORE_UNUSED |
+				clk_base + PLLM_OUT, 1, 0,
 				CLK_SET_RATE_PARENT, 0, NULL);
 	clks[TEGRA30_CLK_PLL_M_OUT1] = clk;
 
@@ -990,7 +990,7 @@ static void __init tegra30_super_clk_ini
 	/* SCLK */
 	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
 				  ARRAY_SIZE(sclk_parents),
-				  CLK_SET_RATE_PARENT,
+				  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 				  clk_base + SCLK_BURST_POLICY,
 				  0, 4, 0, 0, NULL);
 	clks[TEGRA30_CLK_SCLK] = clk;
@@ -1060,9 +1060,6 @@ static void __init tegra30_periph_clk_in
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, &emc_lock);
-	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
-				    57, periph_clk_enb_refcnt);
-	clks[TEGRA30_CLK_EMC] = clk;
 
 	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
 				    &emc_lock);
@@ -1252,10 +1249,7 @@ static struct tegra_clk_init_table init_
 	{ TEGRA30_CLK_SDMMC1, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA30_CLK_SDMMC2, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA30_CLK_SDMMC3, TEGRA30_CLK_PLL_P, 48000000, 0 },
-	{ TEGRA30_CLK_PLL_M, TEGRA30_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA30_CLK_PCLK, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_CSITE, TEGRA30_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA30_CLK_EMC, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_MSELECT, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_SBC1, TEGRA30_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA30_CLK_SBC2, TEGRA30_CLK_PLL_P, 100000000, 0 },
