Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC65C21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ofvPsIcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfBAQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:48:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45314 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbfBAQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164720euoutp023108dd7cafc165ce49c4c68f965bf8e9~-S1iNUIHc1462914629euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190201164720euoutp023108dd7cafc165ce49c4c68f965bf8e9~-S1iNUIHc1462914629euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039640;
        bh=IHf0ZruyoXp9baj3AvKM+LubnVAzyCAe3bchNNL3iEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofvPsIcX4AY6IK3l0SE2HbV46HL+4pKMjziGJJDAayT68KgmxLG/1Gxya+tEVDd1U
         veFy9nQFLtMR3diOgwUr/TR8wSrAuju0Vv9cZc0V7SCw1E0CeZbNskA4NE7Z7/aoLn
         LHUDQxb48bQ/jEH/QHL2ZG/Vvx7oRFn3mv/40qVM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190201164719eucas1p1b5489daaf84b36b6720be27524a508fa~-S1hqkkkT0905309053eucas1p1f;
        Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.FD.04294.718745C5; Fri,  1
        Feb 2019 16:47:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267~-S1g2HHZT1349813498eucas1p2S;
        Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201164718eusmtrp2712222ac1a753887445b25566bcea5b6~-S1gnGIXN0866308663eusmtrp2g;
        Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-68-5c547817694c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.29.04284.618745C5; Fri,  1
        Feb 2019 16:47:18 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164717eusmtip210860c5217632a58629b64e7003a2003~-S1fpWzDZ0105401054eusmtip2b;
        Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
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
Subject: [PATCH v4 2/8] clk: samsung: add new clocks for DMC for Exynos5422
 SoC
Date:   Fri,  1 Feb 2019 17:46:46 +0100
Message-Id: <1549039612-28905-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87riFSExBufnqFlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XHnnusFpd3zWGz+Nx7hNFixvl9TBZr
        j9xlt7h4ytXiduMKNovDb9pZLf5d28jiIOjx/kYru8emVZ1sHpuX1HscfLeHyaNvyypGj8+b
        5ALYorhsUlJzMstSi/TtErgy+q9cZC24plVxeedp5gbGSypdjJwcEgImElsX97N2MXJxCAms
        YJToOPOIEcL5wihxfPpuJgjnM6NE97lvrDAte478YYdILGeUmHpwCjtcy5Ztj4AcDg42AT2J
        HasKQRpEBKol7lzfzwxSwyzQwCyxo2kCC0hCWCBQYuajfjYQm0VAVeJE6wUwm1fAS2LJ5DZG
        iG1yEjfPdTKD2JwC3hIdj7eD3SchsI9d4vrnK0wQRS4S+xb+YYawhSVeHd/CDmHLSPzfOR+q
        pljibMcqNgi7RqL95A6oGmuJw8cvsoIczSygKbF+lz5E2FFi8dtdTCBhCQE+iRtvBUHCzEDm
        pG3TmSHCvBIdbUIQ1RoSW3ouQC0Sk1i+ZhrUcA+JAx82QoNnHqPE2y99bBMY5WchLFvAyLiK
        UTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMBmd/nf8yw7GXX+SDjEKcDAq8fBu+BUUI8Sa
        WFZcmXuIUYKDWUmE1ykrJEaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC
        1CKYLBMHp1QDo+cUrrnXmCbMLHINqv/qvuT3b6/Nmu9WM545lWZ/pPO7w9dJqvuO5jdfZMv9
        lpLu3vbWZzn3SevKafGPdX4Vu1y6qXrUYcp3lmk/VeatfGaZUWTwPiqbKfnwbOF7d055uwiy
        761kn35XcFtu/yeTL1kZ+b39G6b11z9ctvaEbQGj06bDTHJNlkosxRmJhlrMRcWJAEQYNONC
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xe7piFSExBnsWyltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XHnnusFpd3zWGz+Nx7hNFixvl9TBZr
        j9xlt7h4ytXiduMKNovDb9pZLf5d28jiIOjx/kYru8emVZ1sHpuX1HscfLeHyaNvyypGj8+b
        5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
        +q9cZC24plVxeedp5gbGSypdjJwcEgImEnuO/GHvYuTiEBJYyijxeMkdRoiEmMSkfdvZIWxh
        iT/Xutggij4xSqxauoq1i5GDg01AT2LHqkKQGhGBeon+N5fAapgF+pglGo8vZgVJCAv4S7R1
        7AEbxCKgKnGi9QIbiM0r4CWxZHIb1DI5iZvnOplBbE4Bb4mOx9vB4kJANav+HWCewMi3gJFh
        FaNIamlxbnpusaFecWJucWleul5yfu4mRmB0bDv2c/MOxksbgw8xCnAwKvHwbvgVFCPEmlhW
        XJl7iFGCg1lJhNcpKyRGiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OBkZtXEm9oamhuYWlo
        bmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHRQT3tzs9Tyw105LlnbeLd98NUtCil
        dtbSOZueJl1fstk2tMBvosfDyP4ja02jTH0W3Y+x2ZHTs+DMe+s3Z475tumsU6vZcXpfgLXH
        tFWm6p7RYa+nRp9Mvyv748wt68Jd6do1a53LDRPiD1/Ne3g0J/bsbY9wIUebilWvnssed+zL
        +PZpLsdEJZbijERDLeai4kQAazIxqqQCAAA=
X-CMS-MailID: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164719eucas1p2091c6d41a6cc21a3d36081daf4bc8267@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 46 ++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c..f1a4f56 100644
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
+PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
+					"mout_sclk_mpll", "ff_dout_spll2",
+					"mout_sclk_spll", "mout_sclk_epll"};
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
@@ -817,6 +828,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
 			DIV_CDREX0, 3, 5),
 
+	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
+
 	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
 			DIV_CDREX1, 8, 3),
 
@@ -1170,6 +1183,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
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

