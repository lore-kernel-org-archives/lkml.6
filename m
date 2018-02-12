Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964895AbeBLQQy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:16:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12865 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935579AbeBLQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:16:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180212161643epoutp03f6cafd19aa60617339901205bcc4307e~SoDvU5asx2297922979epoutp03B
X-AuditID: b6c32a35-891ff70000001031-2b-5a81bdea614b
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/7] ASoC: samsung: i2s: Ensure names of supplied clocks
 are unique
Date: Mon, 12 Feb 2018 17:15:33 +0100
Message-id: <20180212161538.22669-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCmvu6rvY1RBn+fyFlcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGT27L7AV
        TJasOHb0L3MD432RLkZODgkBE4lPs+awdjFycQgJ7GCUuDntNROE851RonnFaXaYqr9rlkFV
        7WaU+HnkPTNIQkjgF6PE9VWpIDabgKFE79E+RhBbREBM4vacTmaQBmaBM0wS0/etYQJJCAtE
        SHx4dgjMZhFQlVj8vQuoiIODV8BaYmeXKMQyeYn3C+6DzeEUsJGYdHk52EUSAjvYJO6f7mGG
        KHKR+NP2kRHCFpZ4dXwLO8gcCQFpiUtHbSHq+xklPh7fzwLhrGaUeP1tFytEg7XE4eMXwWxm
        AT6Jd197WCGaeSU62oQgSjwk+r7fYYQIO0pMvmMG8TzQzNMPN7JMYJRawMiwilEstaA4Nz21
        2LDAUK84Mbe4NC9dLzk/dxMjOKK1THcwTjnnc4hRgINRiYe3Y3ZjlBBrYllxZe4hRgkOZiUR
        3j/NQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8AQEuUUIC6YklqdmpqQWpRTBZJg5OqQbGS9mS
        m5mXmp/f9rpfWFUqb670i5W/RAyOPYuSviB/2+CAltH5qys0/qfGrL3hp917vyso0KTyoJri
        7AX/3/zY+jhSuj3z58bVmXeP73v+rSr6oOxmm44ALvFkJ+Edx6rfFq8RLv5o8NLPQPXHsW1J
        k98+Pvnp0pUV86KelE3g6chfX2B2dVvaLyWW4oxEQy3mouJEAL3EfBzkAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAd2XexujDKbcMbe4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaLt/u7mS3On9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovWvUfYLQ6/aWe1
        uLjiC5MDr8eGz01sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mnp2X2Ar
        mCxZcezoX+YGxvsiXYycHBICJhJ/1yxj7WLk4hAS2MkocWLtfTYI5xejxNfF7SwgVWwChhK9
        R/sYQWwRATGJ23M6mUGKmAXOMEl8mXiJHSQhLBAhsenyJyYQm0VAVWLx9y6gIg4OXgFriZ1d
        ohDb5CXeL7gPNodTwEZi0uXlYOVCQCVHlq9nnsDIs4CRYRWjZGpBcW56brFRgWFearlecWJu
        cWleul5yfu4mRmAIbjus1beD8f6S+EOMAhyMSjy8HbMbo4RYE8uKK3MPMUpwMCuJ8P5pBgrx
        piRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TBKdXAGBu9Rq2dIb0k
        stpcwG/io5emp7eUJ1w8+HHFJ72ZzmwKz7Zyc346pF3xrUR69nGxe/NU1hasfyJSfr2im7uj
        MtbylZfTeeZZfP2vK6devSH5luHjN0Hr/19FWTzXpm1kevV0V9tmuZzu94+qGZMFf19Nczz9
        svLWMrZtzPX/F1ucY9NRjxH4rMRSnJFoqMVcVJwIAAEM24k9AgAA
X-CMS-MailID: 20180212161641epcas1p2418c2323e5eb99a37a89b42c246f23dd
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212161641epcas1p2418c2323e5eb99a37a89b42c246f23dd
X-RootMTR: 20180212161641epcas1p2418c2323e5eb99a37a89b42c246f23dd
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161641epcas1p2418c2323e5eb99a37a89b42c246f23dd@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple instances of the I2S IP block the platform
device name is prepended to each clock registered by the driver.
The clock-output-names property is now not used, this should not cause
any issues as, for example, CDCLK clock is referenced through DT 'clocks'
property, not by name.

This change allows to have both I2S0 and I2S1 enabled simultaneously
on exynos5433 and working properly when #clock-cells property is specified
in respective DT nodes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - added devm_kasprintf() error handling.
---
 sound/soc/samsung/i2s.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index aeba0ae890ea..5088d12faeda 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1193,11 +1193,13 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
 
 static int i2s_register_clock_provider(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
+	struct device *dev = &pdev->dev;
+	struct i2s_dai *i2s = dev_get_drvdata(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
 	int ret, i;
 
@@ -1214,30 +1216,38 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 		clk_put(rclksrc);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(i2s_clk_desc); i++) {
+		i2s_clk_name[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
+						dev_name(dev), i2s_clk_desc[i]);
+		if (!i2s_clk_name[i])
+			return -ENOMEM;
+	}
+
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
 		u32 val = readl(i2s->addr + I2SPSR);
 		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
 
 		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
-				"i2s_rclksrc", p_names, ARRAY_SIZE(p_names),
+				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
+				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
 		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
-				"i2s_presc", "i2s_rclksrc",
+				i2s_clk_name[CLK_I2S_RCLK_PSR],
+				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
-		p_names[0] = "i2s_presc";
+		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
 		i2s->clk_data.clk_num = 2;
 	}
-	of_property_read_string_index(dev->of_node,
-				"clock-output-names", 0, &clk_name[0]);
 
-	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev, clk_name[0],
-				p_names[0], CLK_SET_RATE_PARENT,
+	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
+				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
+				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
-- 
2.14.2
