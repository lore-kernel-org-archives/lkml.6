Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeBSPrH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:47:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57031 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeBSPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154506euoutp01975445ecd9b9ff9010bf02f17a1a5fef~UxJIVVaWE0858208582euoutp013
X-AuditID: cbfec7f2-5ffe19c000011644-56-5a8af0fe8a02
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
Subject: [PATCH 5/8] drm/exynos: mic: Use clk bulk API
Date: Mon, 19 Feb 2018 16:44:03 +0100
Message-id: <1519055046-2399-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe967w+nLNH2w8sMiCCNLiHqwCKMLLyFdoIsYpFNfNNJpm1pe
        smmkbVnqKrzQxUjNptM5nbdYF1vTFBVrmc3UQLqYlppoZaFtvvbtd875n//hHA6DS16QPswp
        eSKvkMtipZSIaLT+7t24MKUJ3axSr0b2mh4SXe15iaGSsRwC1RXVksg2O0mhqYJigCYfaCik
        Hckn0KDJQKCJb9UYsujfYOjLcB+BijtySJQ3Oo6j3l4DjbqzJmhkHO0n0XTuMIlet96iUK7B
        RKKi3scYartpBqh0zE4gvWWIRhXGvxjq69yLnk84TBb66whUdH2MQjNPtXiQL/e6vw/nJgcu
        0dyNP3Uk11IyRHNGnZrimuY+kNzIlXaMqy+7wDXkOfLXGnSAmzH6cjZLJn3INVS0I4qPPZXM
        KzbtDBfFaAzlZMJ7r3PZv21ABcolGsAwkN0Cr1iOa4CIkbCVAI6WmEgNcHEEMwCWmc462amZ
        y67EBFEFgHkdtuVgEcAW8yvc6USxfrA6J8zZ4MlaAbzTEuzU4OwcDfPnnwFnwYPdCtVWFeZk
        gl0H389/WmIxuxsO1ubjwjRf+K5HvcQu7B744ZGZchpBtp+GhiEjKYj2wI+Vv4DAHvBrewMt
        8GqovvwMEzgN9s22UgKnw8xBw7JmO5zRNiwNwFk3qG0sxIVTiOHl7OWrcLC2Zo2Au+C9t5HC
        uoUAXtTV0fnApxSs0AFvPkkZF80rA+T8WX+lLE6ZJI/2j4yPMwLHc3UttP9oBrOvItoAywCp
        q5gd0oRKSFmyMiWuDUAGl3qKgwccKXGULCWVV8SHKZJieWUbWMUQUm/xyfUZoRI2WpbIn+b5
        BF7xv4oxLj4qoLWHWY9mFZQfS8VuZykOyIdTpk0Xmt3GVzWK7j5kMzrN9xfT9EHwcFP68OKT
        bU+8PM0hZbaqwJ9n/FUnKuj6xye7utxXno7X2a1MCPnuoCx8XzdfOD+Ir30+EuFe+r0q28/+
        ed+G89r9IDrJZP/BWEIkVdz6ALQ7zStQX3bELCWUMbIAP1yhlP0Di6r/fVgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH+5+7Y6vDmnrS2MOkFykvYPIPQoSpnIeEQKj0xUaeVHJedtxo
        QTSLXB5NpyY6UxC8FMPLnJduGrFsZqXDqct0XkIoxYmWtNBktBm9ffj8+H6/Dz8KlTZjEVR+
        YSmnKVQVKAgR9tE/7j5zsCNkxbX6TsKF3ikcPpyaQGDzhhGD/U19OJz9tU3AnVozgNtPBALW
        rZgwuDhkxaB3qxuBYz1zCFxfnsag+b0RhzVrmyh0Oq0knLzrJaFtzY3DH1XLOJx52ULAKusQ
        DpucrxFobxgFsG1jAYM9Y0sk7LIdIHD6Qyp86w2U+N39GGyq3yDg7ps6NFnOzrinUXZ7/j7J
        PvrTj7MvmpdI1mapINhnvlWcXakcR9iBjjvsYE3AVw9aALtrk7OzY2XkRXGW6HwOV5Cv4zSx
        SVdFeYK1Ey/2hN0s35sFBtApFUAIxdAJjK/8KRJkKd0BGN9IrABEAS5DGKtpCBMARRF0NNNt
        zA56Ge0AzFdPOx4MoPQByVQbioN8nE5kKhyGwyKMPsV49r8dsoRWMot9JvTfmJz5MlVxyCF0
        CrP6apT4N6xknCsuwgTEbeCIBcg4La/OVfPxMbxKzWsLc2OuFaltIPCxYcfewHPg6s+wA5oC
        CrGEXhKypLhKx+vVdsBQqEImuTAfUJIclf4WpynK1mgLON4OIilMES5xxumzpHSuqpS7wXHF
        nOb/FaFCIgyAV3j25cLl78blnHvJau/6iN6VXqmzRMkyJJ/CM9fPhSpht2XiaOOM8sFkW8Sw
        kB6mOx2z63SqXdrS7KjPId60rk0wkOlvvV7va6iNqLmSNnos9Ky5No+sStn67X9XMiogj8Ut
        lxLJuQR0sNf483ZSapRjJ7LRnN8+QpwoUWB8nio+GtXwqr/GywcirQIAAA==
X-CMS-MailID: 20180219154500eucas1p25e9f3bf44901cb2bbe9720cdc5bdd855
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154500eucas1p25e9f3bf44901cb2bbe9720cdc5bdd855
X-RootMTR: 20180219154500eucas1p25e9f3bf44901cb2bbe9720cdc5bdd855
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154500eucas1p25e9f3bf44901cb2bbe9720cdc5bdd855@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 41 +++++++++++----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 2174814..276558a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -88,7 +88,7 @@
 
 #define MIC_BS_SIZE_2D(x)	((x) & 0x3fff)
 
-static char *clk_names[] = { "pclk_mic0", "sclk_rgb_vclk_to_mic0" };
+static const char *const clk_names[] = { "pclk_mic0", "sclk_rgb_vclk_to_mic0" };
 #define NUM_CLKS		ARRAY_SIZE(clk_names)
 static DEFINE_MUTEX(mic_mutex);
 
@@ -96,7 +96,7 @@ struct exynos_mic {
 	struct device *dev;
 	void __iomem *reg;
 	struct regmap *sysreg;
-	struct clk *clks[NUM_CLKS];
+	struct clk_bulk_data *clks;
 
 	bool i80_mode;
 	struct videomode vm;
@@ -338,10 +338,8 @@ static const struct component_ops exynos_mic_component_ops = {
 static int exynos_mic_suspend(struct device *dev)
 {
 	struct exynos_mic *mic = dev_get_drvdata(dev);
-	int i;
 
-	for (i = NUM_CLKS - 1; i > -1; i--)
-		clk_disable_unprepare(mic->clks[i]);
+	clk_bulk_disable_unprepare(NUM_CLKS, mic->clks);
 
 	return 0;
 }
@@ -349,19 +347,8 @@ static int exynos_mic_suspend(struct device *dev)
 static int exynos_mic_resume(struct device *dev)
 {
 	struct exynos_mic *mic = dev_get_drvdata(dev);
-	int ret, i;
-
-	for (i = 0; i < NUM_CLKS; i++) {
-		ret = clk_prepare_enable(mic->clks[i]);
-		if (ret < 0) {
-			DRM_ERROR("Failed to enable clock (%s)\n",
-							clk_names[i]);
-			while (--i > -1)
-				clk_disable_unprepare(mic->clks[i]);
-			return ret;
-		}
-	}
-	return 0;
+
+	return clk_bulk_prepare_enable(NUM_CLKS, mic->clks);
 }
 #endif
 
@@ -374,7 +361,7 @@ static int exynos_mic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct exynos_mic *mic;
 	struct resource res;
-	int ret, i;
+	int ret;
 
 	mic = devm_kzalloc(dev, sizeof(*mic), GFP_KERNEL);
 	if (!mic) {
@@ -405,16 +392,16 @@ static int exynos_mic_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	for (i = 0; i < NUM_CLKS; i++) {
-		mic->clks[i] = devm_clk_get(dev, clk_names[i]);
-		if (IS_ERR(mic->clks[i])) {
-			DRM_ERROR("mic: Failed to get clock (%s)\n",
-								clk_names[i]);
-			ret = PTR_ERR(mic->clks[i]);
-			goto err;
-		}
+	mic->clks = devm_clk_bulk_alloc(dev, NUM_CLKS, clk_names);
+	if (IS_ERR(mic->clks)) {
+		ret = PTR_ERR(mic->clks);
+		goto err;
 	}
 
+	ret = devm_clk_bulk_get(dev, NUM_CLKS, mic->clks);
+	if (ret < 0)
+		goto err;
+
 	platform_set_drvdata(pdev, mic);
 
 	mic->bridge.funcs = &mic_bridge_funcs;
-- 
2.7.4
