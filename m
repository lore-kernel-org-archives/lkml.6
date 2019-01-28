Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3942148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="khHDF6ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfA1TWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58474 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfA1TVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:21:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190128192153euoutp012e6e46664e36be56272a4613d6b70dc4~_GXVFcxrI3243432434euoutp01Z
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190128192153euoutp012e6e46664e36be56272a4613d6b70dc4~_GXVFcxrI3243432434euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548703313;
        bh=/B+NB4uqgeDOd3dvQHPUDWOagHz1W+WijPmr921u0mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khHDF6ww7EQVfIWsolhxXdTZz6SvamIoD3rQu2f0eOJWEN2+UQejphBTl5yEQnoy+
         1gfKUTc5aGN96bx+CKFowqLseHzi0yeK/UYxrrp1oFO3hix3dTPIoDPtP2+sGG4bVu
         W58S00wx+uwdkp/bn+R54bcjOV6yzqoKJI9Wbt/Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128192152eucas1p236338a6b2a20a183eaa83c4dff30f510~_GXUgMX-G3066330663eucas1p2n;
        Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6A.C5.04294.0565F4C5; Mon, 28
        Jan 2019 19:21:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192151eucas1p1d5ad3a851ffc8b56a7a62febdb6d5677~_GXTlDcx00390603906eucas1p1F;
        Mon, 28 Jan 2019 19:21:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128192151eusmtrp1541b7d32d5d3239894d2a6661f5b3f80~_GXTWRIdy2976329763eusmtrp1L;
        Mon, 28 Jan 2019 19:21:51 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-98-5c4f56501487
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.2F.04128.F465F4C5; Mon, 28
        Jan 2019 19:21:51 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192150eusmtip16ab53501587aff53b3ece06932ac5468~_GXSwLihc0143401434eusmtip1J;
        Mon, 28 Jan 2019 19:21:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] clk: samsung: add new clocks for DMC for Exynos5422 SoC
Date:   Mon, 28 Jan 2019 20:21:33 +0100
Message-Id: <1548703299-15806-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzvd8/LPeTs1zF+caNuM2o6etl6tpS0yvWGra2abquLZ1gc7kHI
        1mkrL7skb0mGlkVXC8ekI9YhO+Zt3oUprYwkczRLynlO/ff5fr6fl+9++1GYsIhwoMIUMYxS
        IQ8Xk5Z47fuV7j0BF/xlnup7DnRVfgVBDxm/EnRxSxdB35+axeju7ko+PaoS0dqpQYJeUE8Q
        dJ+ukKTzuxt5dG/7CfpDcjlJN39LIei1wSr8qLV0fvgOX6rVpJHS6tJb0nffG3jSjBoNkC5q
        nQLIQEuvYCY8LI5Rehy5ahm6OP6EiOrxiO8fMxAq8NstHVhQCB5AyfWjZDqwpISwHKAHQ1Xm
        wQhQ//y0eVgE6PPtZ9imxdCaiZuwEJYB1NjD/nPUrxrXRRRFQgmq00SbNLbQCY0sjW8EYbAJ
        Q02PszbMNvAs6p+b5Zv0OHRBxtxwEy2Ap1GvthLnuta9XWkbvRbwDOrIKAGmHAQ1fJTT0Gg+
        6DiaXnxFcNgGzbTV8DksQh3ZanMQizpTNSSHk1CKoc6sOYSa23oJ0w0Y3IUqdB4c7YMmqpaA
        iUbQGg3PbTPR2DrMqn2IcbQApd4Vcmo3VKPu4XHYDpW9zDOHS1HBi0d87nWKAMpsWSEzgXPB
        /7ISADTAnollI0IYdp+CuSFh5RFsrCJEEhQZoQXrv6Zjrc1YB3Sr1/QAUkBsJfAk/WVCQh7H
        JkToAaIwsa0gd8hPJhQEyxMSGWXkFWVsOMPqgSOFi+0FN7dMXhbCEHkMc51hohjl5pZHWTio
        QDWymmsobl82QC9r90mf+B8j6Z0gR4Qf9hzwzePpty4M/AlU7fhJJSXCc/h+7/MgrV5UInlz
        cuytInt7wcHOT0GlM9RFl9HWdt3oR7vCXzJrOqb41HPiWHRTM+kWzCtSO35xZ0LVT5fto/yo
        7FnXwbGdzq/lSX3sJVdv31Z/Mc6GyvfuxpSs/C/vveZQMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4XV3/MP8Yg0sHJC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotbDTIWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eJ24wo2i8Nv
        2lkt/l3byOLA5/H+Riu7x6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii9GyK8ktLUhUy8otL
        bJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI+313IWnBBv+LKnZOsDYx/
        NboYOTkkBEwkTh6dwNLFyMUhJLCUUeLOvxnsEAkxiUn7tkPZwhJ/rnWxgdhCAp8YJf7sU+pi
        5OBgE9CT2LGqECQsIiAncfPrXTaQOcwCp5kldj34wwKSEBbwkbjy9jU7SD2LgKrEl6k5IGFe
        AS+Ji5s2sECMB+o918kMYnMKeEuc7lvACLHKS2L65BcsExj5FjAyrGIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAgM/W3Hfm7Zwdj1LvgQowAHoxIPrwGbf4wQa2JZcWXuIUYJDmYlEd6p1/1i
        hHhTEiurUovy44tKc1KLDzGaAt00kVlKNDkfGJd5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE
        0hNLUrNTUwtSi2D6mDg4pRoYxb7Y3wzXqHlw6IBJG09g0+FTly+LyL91Zb/wgc3sZMCO7vPl
        NgHG12dbr/z//3bytJ+pU5b/dnlQ+P2x0dO/D9aIqKhnXFvrLfbdN0cgQf+OW/Sy7sDUVR48
        f1z4r4ttTDnu1v4hUadzlYla7exz6ctWfNmwM/Z7X5cjh5Mq04ssucUCGWnLlViKMxINtZiL
        ihMBQLV8/ZMCAAA=
X-CMS-MailID: 20190128192151eucas1p1d5ad3a851ffc8b56a7a62febdb6d5677
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192151eucas1p1d5ad3a851ffc8b56a7a62febdb6d5677
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192151eucas1p1d5ad3a851ffc8b56a7a62febdb6d5677
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192151eucas1p1d5ad3a851ffc8b56a7a62febdb6d5677@eucas1p1.samsung.com>
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

