Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeBSPrZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:47:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57002 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeBSPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154504euoutp012720e71d1f9aa9ee36fb560ea2648f14~UxJGgtwJU0897708977euoutp01e
X-AuditID: cbfec7f2-5ffe19c000011644-4b-5a8af0fcb8d6
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
Subject: [PATCH 3/8] drm/exynos/decon: Use clk bulk API
Date: Mon, 19 Feb 2018 16:44:01 +0100
Message-id: <1519055046-2399-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+8591uIwo32Z+ccgMiFrEPRBF7Iyzh8SJUSxrqc8aeRW7Khl
        SU5JzVmps9LsZhZapqVzLi+si60spcnUtCwvuCCX1qylmJm1Ofvv4Xl+3/O+L3wMLrOSAcxh
        TZyg1fCxCsqPML/81bpsckSvWqErl6DuBzYSnbe9xlChM4NAVQUPSdQx6qLQSO4VgFylegoZ
        +nII9KGmkkDDX8sxZK14i6HBXjuBrrzKIFG2YwhHra2VNHqTOkwjo6OTRN/P9ZKovf4ahc5V
        1pCooPUxhhovWQAqcnYTqMLaQ6MS4ySG7M3h6Pmwp2Sqs4pABXlOCrmfGvD1QVx7px3nXO/S
        aO7i7yqSqyvsoTljWSbFPRrrJ7m+rCaMq76TzJmyPf4FUxng3MYgrsOaQm+do/JbEyXEHk4Q
        tMvX7feLcUwOgmOOwBPVXUodaJHrgYSB7EpYXNpFebWMvQtgXjWuB34e7QbQZhmg/0Nt6bnA
        F5QAOH79GuZ78RfAlu4IPWAYig2B5Rn7vPY89iWAN+oivDzOjtEwZ+IZ8Ab+7Cr4wmKYLiXY
        xbD0fvu0L2U3woZJHe4bFgTf2zKntYTdBPsbLJS3CLLdNKz9Yad80Cb49nYH5tP+8EuTaWbT
        QNiel0X49CloH62f4ZNgyofKGWY1dBtM0wNwdi40mPNx7wGQlcKz6TIfwkFz2o0ZOwz+/ET7
        zs0HsHQoIgcEFIFZZUAuxIvqaEFUaoTjoSKvFuM10aEHj6qNwPO3WqaaftSC0bYDjYBlgGKO
        lO3Rq2QknyAmqhsBZHDFPGnEO48ljeITTwrao/u08bGC2AgWMoRCLt0bfFolY6P5OOGIIBwT
        tP9TjJEE6AC4Rzo2b3OG7BmPusx37dqt7KwO2+MIT1bXujIHzHGHKlRrG4q2BEcWnDGk7Fzg
        CujIz4z5U5dqKVv27fOdqAd5kim1Oalhx6gpeUlaiJt3bm/eMDB/f7FOYeuxPrPKNUXvleLV
        m9G09qM8YVh9qzB84u+TgcgjiYsMqUtnp+euUhBiDK8MwbUi/w8pgevYVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcQDF/d/de3e3NrhMwauGD6PClMxF1P9hmWXBfRAK7Gkv65I3Pzd1
        VyWFagppLvMrB84irEzBstzULM2y+VmiUzfnR80pK9ScqZmCNaxN6e3HOYdzHg7BkxjQYCJZ
        ncVq1EyaFBeiQzsD9iO/13SKqEcfhHDmxQgG7458RGDNUhEKjdUvMWjbXMXhWoUBwNUGHQ4r
        neUo/NzWjEL3ynME9jZNIHBxdgyFhsEiDJa5lnnQYmnmw+ECNx+aXHYMrpfMYtDa8QCHJc1t
        GKy2vEOgWd8FYO3SDAqbeh18WG/yIHDs03nY4/aW7NiNKKy+t4TDje5KXkwobbWP8ejVqVt8
        uuqPEaPf1Dj4tKmxGKfbt+Yw2nlnAKFb6m7SrWVevbS1EdAbplDa1pvPvyhSCOUJbFpyDqs5
        Gn1ZmOTyLIIM1/5rLZMyLRgK1AEBQZHHqfHCCqADQkJC1gGqsMCM+QwJmY9Q24NKHSAInAyn
        nhcpfZkAsh9Q81+e7GZ4pIdPlWozfOxPnqT6uir5PkbJg1TDMyvwsZiMpTo9Wt7eWCg1PVK8
        ywLyHDXX2YXvbcVSFuc4Xg5EtcCvEQSw2ZwqUcUdi+QYFZetToy8kq4yAe9hr/q3W18D3Y94
        MyAJIBWJSYdOIcGYHC5XZQYUwZMGiOOmvJI4gcnNYzXpSk12GsuZQQiBSgPFlqhchYRMZLLY
        VJbNYDX/XYQQBGtBlprNG+2rCnFQowbhQNipsyvy0W8iy0LmzxiZX1tcxL68S2eU9+2H41n2
        tm1+hT3wtiOlJHozwn/SIghb/6qf6KDlw6cdW91W48R1Y9NCee3V9ijB08fvpzPrY1KCJLJh
        +ZrEmXoIRy602Mr0y1M9c/rv7sHwG39PMA+D6F9SlEtiZOE8Dcf8A+1cCC6sAgAA
X-CMS-MailID: 20180219154458eucas1p1b4e728757e78f3d5dde5c9aa565a5d20
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154458eucas1p1b4e728757e78f3d5dde5c9aa565a5d20
X-RootMTR: 20180219154458eucas1p1b4e728757e78f3d5dde5c9aa565a5d20
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154458eucas1p1b4e728757e78f3d5dde5c9aa565a5d20@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 50 ++++++++-------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 1c330f2..1760fcb 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -55,7 +55,7 @@ struct decon_context {
 	struct exynos_drm_plane_config	configs[WINDOWS_NR];
 	void __iomem			*addr;
 	struct regmap			*sysreg;
-	struct clk			*clks[ARRAY_SIZE(decon_clks_name)];
+	struct clk_bulk_data		*clks;
 	unsigned int			irq;
 	unsigned int			irq_vsync;
 	unsigned int			irq_lcd_sys;
@@ -485,15 +485,13 @@ static irqreturn_t decon_te_irq_handler(int irq, void *dev_id)
 static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
-	int win, i, ret;
+	int win, ret;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		ret = clk_prepare_enable(ctx->clks[i]);
-		if (ret < 0)
-			goto err;
-	}
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(decon_clks_name), ctx->clks);
+	if (ret < 0)
+		return;
 
 	decon_shadow_protect(ctx, true);
 	for (win = 0; win < WINDOWS_NR; win++)
@@ -504,10 +502,6 @@ static void decon_clear_channels(struct exynos_drm_crtc *crtc)
 
 	/* TODO: wait for possible vsync */
 	msleep(50);
-
-err:
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
 }
 
 static enum drm_mode_status decon_mode_valid(struct exynos_drm_crtc *crtc,
@@ -638,10 +632,8 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 static int exynos5433_decon_suspend(struct device *dev)
 {
 	struct decon_context *ctx = dev_get_drvdata(dev);
-	int i = ARRAY_SIZE(decon_clks_name);
 
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(decon_clks_name), ctx->clks);
 
 	return 0;
 }
@@ -649,19 +641,9 @@ static int exynos5433_decon_suspend(struct device *dev)
 static int exynos5433_decon_resume(struct device *dev)
 {
 	struct decon_context *ctx = dev_get_drvdata(dev);
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		ret = clk_prepare_enable(ctx->clks[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	return 0;
+	int ret;
 
-err:
-	while (--i >= 0)
-		clk_disable_unprepare(ctx->clks[i]);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(decon_clks_name), ctx->clks);
 
 	return ret;
 }
@@ -719,7 +701,6 @@ static int exynos5433_decon_probe(struct platform_device *pdev)
 	struct decon_context *ctx;
 	struct resource *res;
 	int ret;
-	int i;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -732,15 +713,14 @@ static int exynos5433_decon_probe(struct platform_device *pdev)
 	if (ctx->out_type & IFTYPE_HDMI)
 		ctx->first_win = 1;
 
-	for (i = 0; i < ARRAY_SIZE(decon_clks_name); i++) {
-		struct clk *clk;
-
-		clk = devm_clk_get(ctx->dev, decon_clks_name[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+	ctx->clks = devm_clk_bulk_alloc(dev, ARRAY_SIZE(decon_clks_name),
+					decon_clks_name);
+	if (IS_ERR(ctx->clks))
+		return PTR_ERR(ctx->clks);
 
-		ctx->clks[i] = clk;
-	}
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(decon_clks_name), ctx->clks);
+	if (ret < 0)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->addr = devm_ioremap_resource(dev, res);
-- 
2.7.4
