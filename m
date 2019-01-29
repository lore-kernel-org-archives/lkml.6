Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B9C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TSpT+wgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfA2Rz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45675 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfA2Rz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175525euoutp011756e31333fe02c5662fc5d162961c52~_Y1H-6FQV0797207972euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190129175525euoutp011756e31333fe02c5662fc5d162961c52~_Y1H-6FQV0797207972euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784525;
        bh=/B+NB4uqgeDOd3dvQHPUDWOagHz1W+WijPmr921u0mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSpT+wglSeiBNGk5eb+LSC6ZTdKnCZtqxsQd2PE/tTrCAkO9mr1EtSr0OkjNCsp9z
         3eyHbwgz2Az7KFxwYceBZQCMtzOMWpgKHxRpDNJ8kmfMK31ZfdAzy6kswNgGjpfOGl
         3PNgOPgNm3HoToCpQ8HPkyjasfErjXsVAZ/xRAGc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175524eucas1p1d1408cac43dcc05a0ddd844f4b6d0bd8~_Y1HQX_WV2455524555eucas1p1T;
        Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.D0.04294.C83905C5; Tue, 29
        Jan 2019 17:55:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129175524eucas1p26604f138793648903533eb367fdfa0e1~_Y1Gh_yjr2848028480eucas1p2y;
        Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175523eusmtrp28dd6c5a2b7e3f1a0abf6ee8ed4e3c442~_Y1GTCc-N0424104241eusmtrp2X;
        Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-2c-5c50938c424d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.09.04284.B83905C5; Tue, 29
        Jan 2019 17:55:23 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175523eusmtip1537a596492e5a8bc6f25335681391aeb~_Y1FoB6RH2140821408eusmtip1w;
        Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/8] clk: samsung: add new clocks for DMC for Exynos5422
 SoC
Date:   Tue, 29 Jan 2019 18:55:08 +0100
Message-Id: <1548784514-26649-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUhUURjtzpu3ODT5HLeLmdVQMgVplsSFJIoMhkK0MoISaqzXaK7Nc0md
        yMRdK9PIVpesRqfJcsWGMjc019HczY0UhNIWlcrKMZ9P69/5zvKdy8elMMkz3IbyDQxhVIEK
        fykhEpbXzxm2pWZ4eG1vKLdHRbef46h3dgJH2XVtOLo+9glDBsMLErXGTJJoINoWFY/14Ohb
        6jCOOvX3CTRztQ6g24ZKAXpWN0SijqYD6P2VfALVTibgyNhTJNxrJv/SF0fKi7VJhLzk0WV5
        9edXAvm1Ui2QzxTbeRAnRC5nGX/fMEbluOe0yGdmKBcPbne82DXYiEeDeVkyoChIO8OWHJdk
        IKIkdD6AcyN3cH6YBXA0IYfkhxkAh6t/LiomS4myRxqMFzQAfv9lJP9F3o7fANxegnaAFdoL
        XMCCjoKDvW+WAhgdjcGKmDQhJ5jTh+Hjlnckh4X0ZqhvHSM4LKYPwuH0ryTfZgf725IwDpvQ
        h2Di2CDgFkG6koQF3eMC3uQKc2sqlgPm8GND6TK2hQsvs5c9LGxN1BI8VsOExhX/bljb0IFz
        j8boLfC53pGn98GUhSGCv9Ea2DdlxtHYIkwvz8R4WgwT4yW8WwZLU9uXi6ygRneL5C1yOD8r
        5q+TBaDxdRKRBtbf/d+VA4AWWDOhbICSYXcEMuEOrCKADQ1UOpwJCigGi5+o2dgwWwH0f7xr
        AE0B6WrxqqMeXhJcEcZGBNQASGFSC7HTb3cvifisIiKSUQWdUoX6M2wNWEsJpdbiqFWjJyW0
        UhHC+DFMMKNaUQWUiU00yGtXyjw1Dx4WbKi2UsfrdMonyaZP1sfOpXW5V33QyFzVNiPOVTof
        wfScpUH/tDDtpjr2h+mxSvsjuxzCZTFZYFPh6HRzntHGLKX/UlPJVMZ5N5NJXVn81sLInRsT
        B0aFavt7caK+dcdHPP3mtfXe1ud0+907G6djLIMnqtwyu+VSIeujcNqKqVjFX1/RPoJAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xu7rdkwNiDO7+NLbYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VouPPfdYLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnHxlKvF7cYVbBaH37SzWvy7tpHFQdDj/Y1Wdo9NqzrZPDYvqfc4+G4Pk0ffllWMHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        fL67kLXggn7FlTsnWRsY/2p0MXJySAiYSGxdspy5i5GLQ0hgKaPE6ae32SASYhKT9m1nh7CF
        Jf5c6wKLCwl8YpR4+7ysi5GDg01AT2LHqkKQsIhAvUT/m0tsIHOYBfqYJRqPL2YFSQgL+Eus
        3gPRyyKgKrHr7GMwm1fAS+LepA9Q8+Ukbp7rZAaxOQW8JToe32GE2OUl8e31D7YJjHwLGBlW
        MYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbGtmM/N+9gvLQx+BCjAAejEg8vQ3BAjBBrYllx
        Ze4hRgkOZiURXsPf/jFCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+M27ySeENTQ3MLS0Nz
        Y3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYyzdVQuz+25dddsf+L2c/5aIQHvz5vo
        WeWe7xYxSXN8eXT1jJAgA9GSKjWlz8rHFtwRjbZ5asmwf5v+xAOZ/9SrXaKOvC5psrlcsunV
        x3f3/D6e5fzE8XnnRYUZ6sU9sbULf2a7vFqQKd+1zybc+kjVbI58Kb6ful6Lti3adKPHz3DN
        iY5PftZKLMUZiYZazEXFiQCrpC9cowIAAA==
X-CMS-MailID: 20190129175524eucas1p26604f138793648903533eb367fdfa0e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175524eucas1p26604f138793648903533eb367fdfa0e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175524eucas1p26604f138793648903533eb367fdfa0e1
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175524eucas1p26604f138793648903533eb367fdfa0e1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: linux-clk@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 48 +++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c..3e87421 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -132,6 +132,8 @@
 #define BPLL_LOCK		0x20010
 #define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
+#define GATE_BUS_CDREX0		0x20700
+#define GATE_BUS_CDREX1		0x20704
 #define DIV_CDREX0		0x20500
 #define DIV_CDREX1		0x20504
 #define KPLL_LOCK		0x28000
@@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	DIV_CDREX1,
 	SRC_KFC,
 	DIV_KFC0,
+	GATE_BUS_CDREX0,
+	GATE_BUS_CDREX1,
 };
 
 static const unsigned long exynos5800_clk_regs[] __initconst = {
@@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
 PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
 PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
 PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
+PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_dpll_ctrl",
+					"mout_mpll_ctrl", "ff_dout_spll2",
+					"mout_sclk_spll"};
+
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock
@@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
 static const struct samsung_fixed_factor_clock
 		exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
-	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
+	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
@@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
 
+	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
+		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
+
 	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
-			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
+			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
 	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
 			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
-	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
+	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
 	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
 
 	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
@@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
@@ -814,9 +825,13 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 			DIV_CDREX0, 16, 3),
 	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
 			DIV_CDREX0, 8, 3),
+	DIV(0, "dout_cclk_drex1", "dout_clk2x_phy0", DIV_CDREX0, 8, 3),
 	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
 			DIV_CDREX0, 3, 5),
 
+	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
+	DIV(0, "dout_pclk_drex1", "dout_cclk_drex1", DIV_CDREX0, 28, 3),
+
 	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
 			DIV_CDREX1, 8, 3),
 
@@ -1170,6 +1185,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
 
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
+
+	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 0, 0, 0),
+	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 1, 0, 0),
+	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
+			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
 };
 
 static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
-- 
2.7.4

