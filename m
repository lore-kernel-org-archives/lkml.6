Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F58C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F002087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BVhcXXkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfAaIuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49004 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfAaIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:10 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085008euoutp01c15fba2e5541e38f73cb0786adbf0535~_4rmXCweM2234722347euoutp01e
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190131085008euoutp01c15fba2e5541e38f73cb0786adbf0535~_4rmXCweM2234722347euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924608;
        bh=/B+NB4uqgeDOd3dvQHPUDWOagHz1W+WijPmr921u0mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVhcXXkfu6vZjq1/znzXvIc2QlkNLbpPTappal8gxSTu8hkPa7AuWqgfOBoDhNvBg
         TEoK1dyEHr4BHNretzb8WPtrv3pCCIGxEaQW7KOAj002H3//cEE7YZBUwWefDH2oRD
         lM2plpL1wPugsa7RFHnOg6gXOI0WvRN4JHrV0GEo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085007eucas1p294e27ece6804e3a831b43268ab347fc6~_4rlimOWi2508525085eucas1p2p;
        Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D0.2C.04294.FB6B25C5; Thu, 31
        Jan 2019 08:50:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085006eucas1p1ca478545c107086d427909c88d3b232e~_4rksXToN2032720327eucas1p1q;
        Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085006eusmtrp2048f5d0adfdc48835aae5a645237e5b1~_4rkdHLIl2342023420eusmtrp2r;
        Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-97-5c52b6bf0b12
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.B4.04284.EB6B25C5; Thu, 31
        Jan 2019 08:50:06 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085005eusmtip164823463b7d2551aa862541a86b86d7e~_4rjxTga01330713307eusmtip10;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
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
Subject: [PATCH v3 2/8] clk: samsung: add new clocks for DMC for Exynos5422
 SoC
Date:   Thu, 31 Jan 2019 09:49:48 +0100
Message-Id: <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7r7twXFGMzeLWaxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBYfe+6xWlzeNYfN4nPvEUaLGef3MVms
        PXKX3eLiKVeL240r2CwOv2lntfh3bSOLg6DH+xut7B6bVnWyeWxeUu9x8N0eJo++LasYPT5v
        kgtgi+KySUnNySxLLdK3S+DK+Hx3IWvBBf2KK3dOsjYw/tXoYuTkkBAwkZh9YwNTFyMXh5DA
        CkaJPzcPskM4Xxglfu/4xgbhfAZyZrQxwbQ8ntUCVbWcUWLFzXvMcC1nDqxm6WLk4GAT0JPY
        saoQpEFEoFrizvX9YDXMAg3MEjuaJrCAJIQFAiVe//gBNpVFQFXi4rRn7CC9vAJeEtdnCkEs
        k5O4ea6TGcTmFPCWWNL1lxkivo9d4nVnAITtInFnxgV2CFtY4tXxLVC2jMT/nfOhji6WONux
        ig3CrpFoP7kDqsZa4vDxi6wga5kFNCXW79KHCDtKHNl7jRkkLCHAJ3HjrSBImBnInLRtOlSY
        V6KjDepIDYktPRegFolJLF8zDWq4h8SGZ1uhgTOPUeLDtzOsExjlZyEsW8DIuIpRPLW0ODc9
        tdgoL7Vcrzgxt7g0L10vOT93EyMwEZ3+d/zLDsZdf5IOMQpwMCrx8D5YGxgjxJpYVlyZe4hR
        goNZSYTX8Ld/jBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5O
        qQZGo+uqe6s3m3tV/Y5wuZr6/mFW/qIKeT3dJsFb+icvNFSliRz/tqWmkCFD4guTmdSBORHr
        bu5kOBPz5KCVPsc1I9XnqiVOm3oTmW9uWLRlYsCOg43n1Q8URd2+7e7QuV3QgClhlWtX7Oql
        M8wX/o5NVRHWeF9U6yIR/X5bpE6Jrffsc3K6cbVKLMUZiYZazEXFiQBix1X1QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xu7r7tgXFGEzpVbDYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VouPPfdYLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnHxlKvF7cYVbBaH37SzWvy7tpHFQdDj/Y1Wdo9NqzrZPDYvqfc4+G4Pk0ffllWMHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        fL67kLXggn7FlTsnWRsY/2p0MXJySAiYSDye1cLexcjFISSwlFFi+/8FjBAJMYlJ+7azQ9jC
        En+udbFBFH1ilNg6bzpQEQcHm4CexI5VhSA1IgL1Ev1vLoHVMAv0MUs0Hl/MCpIQFvCXWH7g
        HxuIzSKgKnFx2jN2kF5eAS+J6zOFIObLSdw818kMYnMKeEss6foLZgsBlfz495FxAiPfAkaG
        VYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGxse3Yz807GC9tDD7EKMDBqMTD+2BtYIwQa2JZ
        cWXuIUYJDmYlEV7D3/4xQrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjNu8knhDU0NzC0tD
        c2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MLjp982ebvtsyeeerbpXpoUvkz7Jw
        p8z1S9jxqHF5CZflU9P7q6Yf31i/tOgCM//HS+tFd229E/BHzsD/3Am/nLfeG5dMXcHhwZMt
        xK90Zeox11//2fY+6NKdo9qR/O1dhvBpi8i3NyTM6g/y39EWlAgU6U/NkDtVZC/Hpfv63i1x
        15wr7L3ySizFGYmGWsxFxYkANLs6oaMCAAA=
X-CMS-MailID: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085006eucas1p1ca478545c107086d427909c88d3b232e
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p1ca478545c107086d427909c88d3b232e@eucas1p1.samsung.com>
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

