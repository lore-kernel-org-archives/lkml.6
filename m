Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeBSPqP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:46:15 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57043 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBSPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:10 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154507euoutp019c84ca9ebf5a0f91e92bfdcf2fbc9d17~UxJJw-GOP0897708977euoutp01h
X-AuditID: cbfec7f4-b4fc79c0000043e4-67-5a8af0ff4669
From: Maciej Purski <m.purski@samsung.com>
To: linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kamil Debski <kamil@wypas.org>, Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thibault Saunier <thibault.saunier@osg.samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 6/8] drm/exynos/hdmi: Use clk bulk API
Date: Mon, 19 Feb 2018 16:44:04 +0100
Message-id: <1519055046-2399-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHPbtPzdVlGh00jYZCFNmDHgeKSjO4f0REfxQMSldeVHTLtuxl
        pBNsejO1lWlWzkAslpZO3XKl5XzMik2WtmxmFlFpKnP5oIdorqv/fc738fudA4fGJB1ECJ2s
        PM2plPJUKRmAmzp/O9bPjfOyjZ6xSOR+5CDQVcdLESob1uKorvQxgXqnPCQav3YLIM99nkS6
        wSIc9TfW4mh0rFqE2mveitDQRyeObnVpCVT4ZQRD3d21FLJnj1LI+MVFIG/+RwL1WO6QKL+2
        kUCl3S0iZC1uBqhi2I2jmvYBClUZZ0TI+WofahudHzLrqsNR6fVhEk280GF7wtkelxNjPX05
        FHvjbx3BNpUNUKzRkEey5ulPBDt4xSZi6ysz2YbCeb2gwQDYCWM429uuoQ4GygJ2JnCpyWc4
        1YZd8QFJ/MOveFpvxDmj4QOWBQbDeOBPQ2YLbHF5SR4E0BLmAYB6nR0IhwkAh7vbicWUu6MD
        E4wqAB3fNbjPkDBzANpmxTygaZJZC6u1cT45mOkEsLxpvy+PMdMULPrTCnxGELMNan9dE/kY
        ZyKh3eugfF0xsxdO3l0t7AqH7x15mI/9mVj46WkzKehuCnrNywSOhXypAQgcBH/YGiiBV8Ke
        61dwgTOgc8qy0L0INf21C5kdcELX8H8+xiyFOlMJ5rsCZMQw97JEiLDQYvEsVKPh7Yc3gfDa
        EgB72sKKQEgF8DOAFVy6WpHIqTcrubNRarlCna5MjDpxUmEE85/r9axt8gmwzBy3AoYG0kAx
        M8DLJIT8jPq8wgogjUmDxfv75iVxgvz8BU51Mk6VnsqprSCUxqUrxMfWXJJJmET5aS6F49I4
        1aIrov1DssC5ggNfj7zT9yXZlMdbTsW2ftDbJd5HCj0ovq+JHtpW8ianq7JF5n6VYU0ZEVfn
        xn8zmzfdC05e0gxXOU0HzCVBaYdMadsrV0YYXJU5z+vB+IA9xpj5ekvIzz5+qPHxs+XLp6az
        Q/22ZsdoPutryr1jnqShwx2b/UyxN7U5u4+uk+LqJPmmtZhKLf8HgfjhL1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xa7p/P3RFGezcq2xxa905VovecyeZ
        LGa9bGex2DhjPavFla/v2Sw+TJzJaPF+eRebxaT7E1gsbm/dwGLx5u0aJosja68yWby4d5HF
        YuaJdlaL/sevmS3On9/AbnG26Q27xabH11gtPvbcY7W4vGsOm0XPhq2sFjPO72OyODR1L6PF
        gpe3WCzWHrnLbrFs0x8mi4unXC0OvwEa8u/aRhaLGZNfsll8PjCJ2UHO4/K1i8we72+0sntM
        +b2R1WPnrLvsHptWdbJ5bP/2gNXjfvdxJo/NS+o9tvQDxfu2rGL0+LxJzuPKkUb2AJ4oLpuU
        1JzMstQifbsEroyu1U9ZCq6oVGxadYe5gfG+bBcjJ4eEgInEraNHmUFsIYEljBKXD/l1MXIB
        2Y1MErtX3GftYuTgYBPQkljTHg8SFxE4xijx8M5iVpAGZoE/7BJ9DQUgtrCAmUT7j4lMIDaL
        gKrE2Y/n2EF6eQWcJb7MVYTYJSdx81wn2C5OAReJB7v3skHsdZY4f/8S2wRGngWMDKsYRVJL
        i3PTc4uN9IoTc4tL89L1kvNzNzECI2zbsZ9bdjB2vQs+xCjAwajEwytwtytKiDWxrLgy9xCj
        BAezkgivzw2gEG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6p
        Bkav0h930i2dGLrm8mRtf/3w0ZPsJ9oJcTkTa3L87y6V1vf1sFQ/tXGjw0bL3pJfq9zbJi/h
        X/GlWUbEtndv2zXuUypzrae6xFrsZcpNiPjzg6fjSXGd+KLF1UETAwO79Q4cU9lS4MbErdXq
        8LJG6YmL0iJO6Ze3Kqe8ULNiPlP6Lqp80mErFiWW4oxEQy3mouJEAJBFq2ysAgAA
X-CMS-MailID: 20180219154501eucas1p1e16a883d2eb0c8a99bafce5d71656066
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154501eucas1p1e16a883d2eb0c8a99bafce5d71656066
X-RootMTR: 20180219154501eucas1p1e16a883d2eb0c8a99bafce5d71656066
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154501eucas1p1e16a883d2eb0c8a99bafce5d71656066@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 97 ++++++++++--------------------------
 1 file changed, 27 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index a4b75a4..6c208f7 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -136,8 +136,8 @@ struct hdmi_context {
 	int				irq;
 	struct regmap			*pmureg;
 	struct regmap			*sysreg;
-	struct clk			**clk_gates;
-	struct clk			**clk_muxes;
+	struct clk_bulk_data		*clk_gates;
+	struct clk_bulk_data		*clk_muxes;
 	struct regulator_bulk_data	regul_bulk[ARRAY_SIZE(supply)];
 	struct regulator		*reg_hdmi_en;
 	struct exynos_drm_clk		phy_clk;
@@ -739,43 +739,16 @@ static int hdmiphy_reg_write_buf(struct hdmi_context *hdata,
 	}
 }
 
-static int hdmi_clk_enable_gates(struct hdmi_context *hdata)
-{
-	int i, ret;
-
-	for (i = 0; i < hdata->drv_data->clk_gates.count; ++i) {
-		ret = clk_prepare_enable(hdata->clk_gates[i]);
-		if (!ret)
-			continue;
-
-		dev_err(hdata->dev, "Cannot enable clock '%s', %d\n",
-			hdata->drv_data->clk_gates.data[i], ret);
-		while (i--)
-			clk_disable_unprepare(hdata->clk_gates[i]);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void hdmi_clk_disable_gates(struct hdmi_context *hdata)
-{
-	int i = hdata->drv_data->clk_gates.count;
-
-	while (i--)
-		clk_disable_unprepare(hdata->clk_gates[i]);
-}
-
 static int hdmi_clk_set_parents(struct hdmi_context *hdata, bool to_phy)
 {
 	struct device *dev = hdata->dev;
 	int ret = 0;
+	struct clk_bulk_data *clk_muxes = hdata->clk_muxes;
 	int i;
 
 	for (i = 0; i < hdata->drv_data->clk_muxes.count; i += 3) {
-		struct clk **c = &hdata->clk_muxes[i];
-
-		ret = clk_set_parent(c[2], c[to_phy]);
+		ret = clk_set_parent(clk_muxes[i + 2].clk,
+				     clk_muxes[i + to_phy].clk);
 		if (!ret)
 			continue;
 
@@ -1655,54 +1628,36 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int hdmi_clks_get(struct hdmi_context *hdata,
-			 const struct string_array_spec *names,
-			 struct clk **clks)
+static struct clk_bulk_data *hdmi_clks_alloc_get(struct hdmi_context *hdata,
+					const struct string_array_spec *names)
 {
-	struct device *dev = hdata->dev;
-	int i;
-
-	for (i = 0; i < names->count; ++i) {
-		struct clk *clk = devm_clk_get(dev, names->data[i]);
-
-		if (IS_ERR(clk)) {
-			int ret = PTR_ERR(clk);
+	struct clk_bulk_data *ptr;
+	int ret;
 
-			dev_err(dev, "Cannot get clock %s, %d\n",
-				names->data[i], ret);
+	ptr = devm_clk_bulk_alloc(hdata->dev, names->count, names->data);
+	if (IS_ERR(ptr))
+		return ptr;
 
-			return ret;
-		}
-
-		clks[i] = clk;
-	}
+	ret = devm_clk_bulk_get(hdata->dev, names->count, ptr);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
-	return 0;
+	return ptr;
 }
 
 static int hdmi_clk_init(struct hdmi_context *hdata)
 {
 	const struct hdmi_driver_data *drv_data = hdata->drv_data;
-	int count = drv_data->clk_gates.count + drv_data->clk_muxes.count;
-	struct device *dev = hdata->dev;
-	struct clk **clks;
-	int ret;
 
-	if (!count)
-		return 0;
-
-	clks = devm_kzalloc(dev, sizeof(*clks) * count, GFP_KERNEL);
-	if (!clks)
-		return -ENOMEM;
+	hdata->clk_muxes = hdmi_clks_alloc_get(hdata, &drv_data->clk_muxes);
+	if (IS_ERR(hdata->clk_muxes))
+		return PTR_ERR(hdata->clk_muxes);
 
-	hdata->clk_gates = clks;
-	hdata->clk_muxes = clks + drv_data->clk_gates.count;
+	hdata->clk_gates = hdmi_clks_alloc_get(hdata, &drv_data->clk_gates);
+	if (IS_ERR(hdata->clk_gates))
+		return PTR_ERR(hdata->clk_gates);
 
-	ret = hdmi_clks_get(hdata, &drv_data->clk_gates, hdata->clk_gates);
-	if (ret)
-		return ret;
-
-	return hdmi_clks_get(hdata, &drv_data->clk_muxes, hdata->clk_muxes);
+	return 0;
 }
 
 
@@ -2073,7 +2028,8 @@ static int __maybe_unused exynos_hdmi_suspend(struct device *dev)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 
-	hdmi_clk_disable_gates(hdata);
+	clk_bulk_disable_unprepare(hdata->drv_data->clk_gates.count,
+				   hdata->clk_gates);
 
 	return 0;
 }
@@ -2083,7 +2039,8 @@ static int __maybe_unused exynos_hdmi_resume(struct device *dev)
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	int ret;
 
-	ret = hdmi_clk_enable_gates(hdata);
+	ret = clk_bulk_prepare_enable(hdata->drv_data->clk_gates.count,
+				      hdata->clk_gates);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4
