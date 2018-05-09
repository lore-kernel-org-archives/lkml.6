Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964885AbeEIRbl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:31:41 -0400
Received: from vern.gendns.com ([206.190.152.46]:51997 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965796AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 03/27] clk: davinci: psc: allow for dev == NULL
Date: Wed,  9 May 2018 12:25:42 -0500
Message-Id: <20180509172606.29387-4-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some davinci SoCs, we need to register the PSC clocks during early
boot because they are needed for clocksource/clockevent. These changes
allow for dev == NULL because in this case, we won't have a platform
device for the clocks.

Some function declarations are moved to a public header files so that they can
be called from mach init code.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- dropped helper functions that conditionally called devm_ versions of functions

v9 changes:
- new patch in v9


 drivers/clk/davinci/psc-dm355.c  |  2 +-
 drivers/clk/davinci/psc-dm365.c  |  2 +-
 drivers/clk/davinci/psc-dm644x.c |  2 +-
 drivers/clk/davinci/psc-dm646x.c |  2 +-
 drivers/clk/davinci/psc.c        | 27 ++++++++++++++++++++-------
 include/linux/clk/davinci.h      |  5 +++++
 6 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
index 6995ecea2677..001288dfdfb1 100644
--- a/drivers/clk/davinci/psc-dm355.c
+++ b/drivers/clk/davinci/psc-dm355.c
@@ -68,7 +68,7 @@ static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
 	{ }
 };
 
-static int dm355_psc_init(struct device *dev, void __iomem *base)
+int dm355_psc_init(struct device *dev, void __iomem *base)
 {
 	return davinci_psc_register_clocks(dev, dm355_psc_info, 42, base);
 }
diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
index 3ad915f37376..5b5b55b0b59a 100644
--- a/drivers/clk/davinci/psc-dm365.c
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -73,7 +73,7 @@ static const struct davinci_lpsc_clk_info dm365_psc_info[] = {
 	{ }
 };
 
-static int dm365_psc_init(struct device *dev, void __iomem *base)
+int dm365_psc_init(struct device *dev, void __iomem *base)
 {
 	return davinci_psc_register_clocks(dev, dm365_psc_info, 52, base);
 }
diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
index c22367baa46f..74668931be48 100644
--- a/drivers/clk/davinci/psc-dm644x.c
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -63,7 +63,7 @@ static const struct davinci_lpsc_clk_info dm644x_psc_info[] = {
 	{ }
 };
 
-static int dm644x_psc_init(struct device *dev, void __iomem *base)
+int dm644x_psc_init(struct device *dev, void __iomem *base)
 {
 	return davinci_psc_register_clocks(dev, dm644x_psc_info, 41, base);
 }
diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
index 468ef86ea40b..22473affa7cf 100644
--- a/drivers/clk/davinci/psc-dm646x.c
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -58,7 +58,7 @@ static const struct davinci_lpsc_clk_info dm646x_psc_info[] = {
 	{ }
 };
 
-static int dm646x_psc_init(struct device *dev, void __iomem *base)
+int dm646x_psc_init(struct device *dev, void __iomem *base)
 {
 	return davinci_psc_register_clocks(dev, dm646x_psc_info, 46, base);
 }
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index ce170e600f09..421f9f7906f4 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -15,6 +15,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/of_address.h>
@@ -63,7 +64,7 @@ struct davinci_psc_data {
 
 /**
  * struct davinci_lpsc_clk - LPSC clock structure
- * @dev: the device that provides this LPSC
+ * @dev: the device that provides this LPSC or NULL
  * @hw: clk_hw for the LPSC
  * @pm_domain: power domain for the LPSC
  * @genpd_clk: clock reference owned by @pm_domain
@@ -221,6 +222,7 @@ static void davinci_psc_genpd_detach_dev(struct generic_pm_domain *pm_domain,
 
 /**
  * davinci_lpsc_clk_register - register LPSC clock
+ * @dev: the clocks's device or NULL
  * @name: name of this clock
  * @parent_name: name of clock's parent
  * @regmap: PSC MMIO region
@@ -238,7 +240,7 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 	int ret;
 	bool is_on;
 
-	lpsc = devm_kzalloc(dev, sizeof(*lpsc), GFP_KERNEL);
+	lpsc = kzalloc(sizeof(*lpsc), GFP_KERNEL);
 	if (!lpsc)
 		return ERR_PTR(-ENOMEM);
 
@@ -261,10 +263,14 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 	lpsc->pd = pd;
 	lpsc->flags = flags;
 
-	ret = devm_clk_hw_register(dev, &lpsc->hw);
+	ret = clk_hw_register(dev, &lpsc->hw);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	/* for now, genpd is only registered when using device-tree */
+	if (!dev || !dev->of_node)
+		return lpsc;
+
 	/* genpd attach needs a way to look up this clock */
 	ret = clk_hw_register_clkdev(&lpsc->hw, name, best_dev_name(dev));
 
@@ -378,11 +384,11 @@ __davinci_psc_register_clocks(struct device *dev,
 	struct regmap *regmap;
 	int i, ret;
 
-	psc = devm_kzalloc(dev, sizeof(*psc), GFP_KERNEL);
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
 	if (!psc)
 		return ERR_PTR(-ENOMEM);
 
-	clks = devm_kmalloc_array(dev, num_clks, sizeof(*clks), GFP_KERNEL);
+	clks = kmalloc_array(num_clks, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		return ERR_PTR(-ENOMEM);
 
@@ -396,14 +402,14 @@ __davinci_psc_register_clocks(struct device *dev,
 	for (i = 0; i < num_clks; i++)
 		clks[i] = ERR_PTR(-ENOENT);
 
-	pm_domains = devm_kcalloc(dev, num_clks, sizeof(*pm_domains), GFP_KERNEL);
+	pm_domains = kcalloc(num_clks, sizeof(*pm_domains), GFP_KERNEL);
 	if (!pm_domains)
 		return ERR_PTR(-ENOMEM);
 
 	psc->pm_data.domains = pm_domains;
 	psc->pm_data.num_domains = num_clks;
 
-	regmap = devm_regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
+	regmap = regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
 	if (IS_ERR(regmap))
 		return ERR_CAST(regmap);
 
@@ -423,6 +429,13 @@ __davinci_psc_register_clocks(struct device *dev,
 		pm_domains[info->md] = &lpsc->pm_domain;
 	}
 
+	/*
+	 * for now, a reset controller is only registered when there is a device
+	 * to associate it with.
+	 */
+	if (!dev)
+		return psc;
+
 	psc->rcdev.ops = &davinci_psc_reset_ops;
 	psc->rcdev.owner = THIS_MODULE;
 	psc->rcdev.dev = dev;
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index ebdd9df1c0ef..62764c5cc86e 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -21,4 +21,9 @@ int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgch
 int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
+int dm355_psc_init(struct device *dev, void __iomem *base);
+int dm365_psc_init(struct device *dev, void __iomem *base);
+int dm644x_psc_init(struct device *dev, void __iomem *base);
+int dm646x_psc_init(struct device *dev, void __iomem *base);
+
 #endif /* __LINUX_CLK_DAVINCI_PLL_H___ */
-- 
2.17.0
