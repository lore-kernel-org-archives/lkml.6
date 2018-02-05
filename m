Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeBEOXV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:23:21 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22906 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:23:13 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205142309epoutp04e35fceefa4f4e7aa9ab58b56698a7b83~Qc-l2Ymrb1852018520epoutp04Y
X-AuditID: b6c32a48-9adff70000000ff0-96-5a7868ccaa66
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
Date: Mon, 05 Feb 2018 15:22:29 +0100
Message-id: <20180205142230.9755-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205142230.9755-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmue6ZjIoogwnX1C02zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVsW3mR5aCLVIVixduYGlgPCbWxcjJISFg
        InFxYSNzFyMXh5DADkaJF6ueMEE43xklWu9dZYWpavi2nREisYFRomHLRCjnF6PE70lfwarY
        BAwleo/2MYLYIgKyEreO/WQDKWIWmMEkcaVzC5DDwSEsECJx4KYKSA2LgKrEtHmdbCA2r4CV
        RPPFHhaIbfIS7xfcB5vDKWAtsbvlETtEfAGbxNUvgiBjJARcJI7tDoMIC0u8Or4FqkRa4tmq
        jWC3SQj0M0qcWNMM5cxglLjTPoEJospa4vDxi2BHMwvwSXQc/ssOMZRXoqNNCKLEQ6LnxAKo
        exwlFpxsYod4uI9R4sixfqYJjFILGBlWMYqlFhTnpqcWGxWY6BUn5haX5qXrJefnbmIER6yW
        xw7GA+d8DjEKcDAq8fBOSCyPEmJNLCuuzD3EKMHBrCTC63QdKMSbklhZlVqUH19UmpNafIhR
        moNFSZy3LcAlSkggPbEkNTs1tSC1CCbLxMEp1cCYtObnpUXnrM9uEOS736j+Y9mhYIN97pbz
        b21o/XPk2m3eru95n1f0Vak43jbWyle9teac6frsM/qBK+c7fxNhtJ1TxPyioZTP98+S+B9r
        XswX6WC5oXVGiLvbXq3scInFftmdihbzUtPPXLxdzXCzrvtTq9GdT+3fRV6uZr4XPculKWft
        /w8NSizFGYmGWsxFxYkAhsvYGdQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd0zGRVRBhtnSFpsnLGe1eL6l+es
        FpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhaH37SzWvw4083iwOXx/kYru8flvl4m
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY9vMjywFW6QqFi/cwNLAeEysi5GTQ0LA
        RKLh23bGLkYuDiGBdYwSGw7eh3J+MUrceXSYEaSKTcBQovdoH5gtIiArcevYTzaQImaBGUwS
        z44+Y+1i5OAQFgiROHBTBaSGRUBVYtq8TjYQm1fASqL5Yg8LxDZ5ifcL7oPN4RSwltjd8ogd
        xBYCqpkyaRLLBEaeBYwMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAgNs22Gt/h2M
        j5fEH2IU4GBU4uEVAAaeEGtiWXFl7iFGCQ5mJRFep+vlUUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYd4jMX72VZx3/piT9naJRptu27DR12/ZbdGZv
        yzTPa4r71bMCspn837p9bNN325W+bK2XSG106NR7O7boblr0X7BrzpvNj/vOrfT9tWyT4FzV
        D0VyUUEf/psaH+swvXhRqzJvWfUTXdN4lTN+ruITlVN0e5S/Xte6etZ2d8PRCukFy7aqmycV
        K7EUZyQaajEXFScCAHOH4iAsAgAA
X-CMS-MailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_SET_RATE_PARENT flag is added to definitions of clocks on a path
starting from CLK_SCLK_I2S1 up to AUD_PLL in order to allow setting
required audio root clock frequency for the I2S1 block. This is now
only done for the I2S1 block, related CMU_TOP, CMU_PERIC clock
definitions are changed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 74b70ddab4d6..d74361736e64 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
 
 static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	/* MUX_SEL_TOP0 */
-	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
-			4, 1),
+	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
 	MUX(CLK_MOUT_ISP_PLL, "mout_isp_pll", mout_isp_pll_p, MUX_SEL_TOP0,
 			0, 1),
 
 	/* MUX_SEL_TOP1 */
-	MUX(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
-			mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1),
+	MUX_F(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
+	      mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1, CLK_SET_RATE_PARENT, 0),
 	MUX(CLK_MOUT_MPHY_PLL_USER, "mout_mphy_pll_user", mout_mphy_pll_user_p,
 			MUX_SEL_TOP1, 8, 1),
 	MUX(CLK_MOUT_MFC_PLL_USER, "mout_mfc_pll_user", mout_mfc_pll_user_p,
@@ -370,8 +370,8 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 			MUX_SEL_TOP_PERIC1, 16, 1),
 	MUX(CLK_MOUT_SCLK_SPDIF, "mout_sclk_spdif", mout_sclk_spdif_p,
 			MUX_SEL_TOP_PERIC1, 12, 2),
-	MUX(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
-			MUX_SEL_TOP_PERIC1, 4, 2),
+	MUX_F(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
+			MUX_SEL_TOP_PERIC1, 4, 2, CLK_SET_RATE_PARENT, 0),
 	MUX(CLK_MOUT_SCLK_AUDIO0, "mout_sclk_audio0", mout_sclk_audio0_p,
 			MUX_SEL_TOP_PERIC1, 0, 2),
 
@@ -524,12 +524,12 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 			DIV_TOP_PERIC2, 0, 4),
 
 	/* DIV_TOP_PERIC3 */
-	DIV(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
-			DIV_TOP_PERIC3, 16, 6),
+	DIV_F(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
+			DIV_TOP_PERIC3, 16, 6, CLK_SET_RATE_PARENT, 0),
 	DIV(CLK_DIV_SCLK_PCM1, "div_sclk_pcm1", "sclk_audio1",
 			DIV_TOP_PERIC3, 8, 8),
-	DIV(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
-			DIV_TOP_PERIC3, 4, 4),
+	DIV_F(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
+			DIV_TOP_PERIC3, 4, 4, CLK_SET_RATE_PARENT, 0),
 	DIV(CLK_DIV_SCLK_AUDIO0, "div_sclk_audio0", "mout_sclk_audio0",
 			DIV_TOP_PERIC3, 0, 4),
 
@@ -693,7 +693,7 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_SCLK_SLIMBUS, "sclk_slimbus", "mout_sclk_slimbus",
 			MUX_ENABLE_TOP_PERIC1, 16, 0, 0),
 	GATE(CLK_SCLK_AUDIO1, "sclk_audio1", "div_sclk_audio1",
-			MUX_ENABLE_TOP_PERIC1, 4, 0, 0),
+			MUX_ENABLE_TOP_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_AUDIO0, "sclk_audio0", "div_sclk_audio0",
 			MUX_ENABLE_TOP_PERIC1, 0, 0, 0),
 };
-- 
2.14.2
