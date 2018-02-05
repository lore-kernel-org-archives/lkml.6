Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeBEPpD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:45:03 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:14988 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:44:56 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180205154454epoutp0389fafd63e83d3c966a764e25ff67b305~QeG9boVkh3105131051epoutp03w
X-AuditID: b6c32a39-467ff70000000fc5-2d-5a787bf5e3aa
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/8] ASoC: samsung: i2s: Ensure the RCLK rate is properly
 determined
Date: Mon, 05 Feb 2018 16:43:56 +0100
Message-id: <20180205154403.13520-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCmge7X6ooog5OntCyuXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujOl/nrIU
        rOatWLqzj6mB8RFXFyMnh4SAiUTXxTfMXYxcHEICOxglzn+5zAbhfGeUmHW/lx2masLaqYwQ
        id2MEvPffmCHcH4xSrQeXs4CUsUmYCjRe7SPEcQWERCTuD2nE2wus8AZJonp+9YwgSSEBcIk
        Fi8/ygxiswioSjx79YEVxOYVsJbYc+kMK8Q6eYn3C+6DDeIUsJHYc28Z2GoJgT1sEifvvmaD
        KHKR6Lm7iwnCFpZ4dXwL0EkcQLa0xKWjthD1/YwSJ9Y0QzXPYJS40z4BqsFa4vDxi2DbmAX4
        JN597WGFaOaV6GgTgijxkJgycwoLhO0osf/aJrC9QiBDfz6TnMAotYCRYRWjWGpBcW56arFh
        galecWJucWleul5yfu4mRnBUa1nuYDx2zucQowAHoxIPr0BGRZQQa2JZcWXuIUYJDmYlEV6n
        6+VRQrwpiZVVqUX58UWlOanFhxilOViUxHkDAlyihATSE0tSs1NTC1KLYLJMHJxSDYz5uq+S
        WV0n6u/9Ia4oapS3s6QqXPS59j95Sd65HVP3c2kJuD2z65oYf/rufFe3+cayX/vXnQrP9T8+
        ZUt8VdBfJkXbi10fKroXrP7xNHDd3sZ5vDdizonrHbkoUby1Uc1NZl2AiU5k9rJVgqs+bfP6
        /fXK9tKYXpk/ToxSHxbZlMbs9TJV8VdiKc5INNRiLipOBACCyOCZ5gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAd2v1RVRBs86mC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujOl/nrIU
        rOatWLqzj6mB8RFXFyMnh4SAicSEtVMZuxi5OIQEdjJK9M7uZoJwfjFKTDr4iQ2kik3AUKL3
        aB8jiC0iICZxe04nM0gRs8AZJokvEy+xgySEBcIkFi8/ygxiswioSjx79YEVxOYVsJbYc+kM
        K8Q6eYn3C+6DDeIUsJHYc28ZkM0BtM1aoummwARGngWMDKsYJVMLinPTc4uNCgzzUsv1ihNz
        i0vz0vWS83M3MQJDcNthrb4djPeXxB9iFOBgVOLhzciqiBJiTSwrrsw9xCjBwawkwut0vTxK
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsalUZqzqt4Y
        rp/2QF7mx5Ppl1/dKJrtOtXoiP2xqdJmU2Q0eW/LTVN1U5Ze0bJfq/G5zIyKqSwnZ//gn854
        2WdVHoPn6lNvzT8vkHXM1G+1OHJy9bVz768c5mrk7bkTYtyi/n6N850YAfZ5fdUm1/JmrUj5
        ZOLy4qP5j1eq+xLCvGW+sFeHsjxXYinOSDTUYi4qTgQARxnJpz0CAAA=
X-CMS-MailID: 20180205154453epcas1p10046e1103497692c86c0899a5ef11781
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154453epcas1p10046e1103497692c86c0899a5ef11781
X-RootMTR: 20180205154453epcas1p10046e1103497692c86c0899a5ef11781
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154453epcas1p10046e1103497692c86c0899a5ef11781@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the RCLK mux clock configuration is specified in DT and no set_sysclk()
callback is used in the sound card driver the sclk_srcrate field will remain
set to 0, leading to an incorrect PSR divider setting.
To fix this the frequency value is retrieved from the CLK_I2S_RCLK_SRC clock,
so the actual RCLK mux selection is taken into account.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 233f1c9a4b6c..aeba0ae890ea 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -656,8 +656,12 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		tmp |= mod_slave;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		/* Set default source clock in Master mode */
-		if (i2s->rclk_srcrate == 0)
+		/*
+		 * Set default source clock in Master mode, only when the
+		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
+		 * clock configuration assigned in DT is not overwritten.
+		 */
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -881,6 +885,11 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+
+		if (i2s->rclk_srcrate == 0 && rclksrc && !IS_ERR(rclksrc))
+			i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
-- 
2.14.2
