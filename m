Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCIMYB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:24:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46451 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCIMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:22:36 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309122235euoutp0148f6d7ff07b388a32c8e1d6c81926c78~aP-cyugma1639716397euoutp01-
X-AuditID: cbfec7f4-713ff700000043e4-35-5aa27c89496f
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 3/6] regulator: core: Parse coupled regulators properties
Date: Fri, 09 Mar 2018 13:22:05 +0100
Message-id: <1520598128-11768-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7djPc7pdNYuiDD5FW2ycsZ7VYurDJ2wW
        84+cY7U4u+wgm8XDq/4W3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7Bb7r3g58His
        mbeG0ePb10ksHrMbLrJ47Jx1l91j06pONo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKWHSh
        n6lgoXvFoknLGRsYT1l2MXJwSAiYSEz/V9vFyMUhJLCCUeL1tEVsXYycQM5nRomN0/RAbJCa
        R60zWSGKljFKfFy1gQmi6D+jxLaDciCD2AS0JNa0x4OERQRsJN7eOMAIUs8s0M8sMbmplQUk
        ISzgI9F/8wMriM0ioCpxqHMPO0gvr4CLxIl/LhC75CRunutkBrE5BVwlzl1/AzZHQmAHm8Si
        FecZIYpcJN5M+M8CYQtLvDq+hR3ClpHo7DjIBGFXS1z8uosNwq6RaLy9AarGWuLzpC1gC5gF
        +CQmbZvODAkIXomONiGIEg+JST8+M0PYjhLrGu9C/T6DUeLesp0sExilFjAyrGIUTy0tzk1P
        LTbKSy3XK07MLS7NS9dLzs/dxAiM6NP/jn/ZwbjrT9IhRgEORiUe3geOC6OEWBPLiitzDzFK
        cDArifBWVSyKEuJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCU
        amB0PjhFnedU2bufb5gEr73tPvVDItz/R23AxkOmBve3FGzZ8pZ91e0JP+3fHJz4vd4mSevn
        h5ztK1as0dk/NVfxcYJJnHatz+mt352fbfsd+1dNXmFB+5+e/3+S91v5plrpvTZj2s8Y+Niw
        76UW10PdgD2H/88O5Ai/JyL+7rXhTdvPfxd8ENl+XYmlOCPRUIu5qDgRAPliN7XkAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xy7qdNYuiDG5ckrHYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlbHo
        Qj9TwUL3ikWTljM2MJ6y7GLk5JAQMJF41DqTtYuRi0NIYAmjxN7FHxghnEYmiR3b97B3MXJw
        sAloSaxpjwdpEBGwkXh74wBYDbPARGaJhYuvsIIkhAV8JPpvfgCzWQRUJQ51QvTyCrhInPjn
        ArFMTuLmuU5mEJtTwFXi3PU3jCC2EFBJx4zn7BMYeRYwMqxiFEktLc5Nzy021CtOzC0uzUvX
        S87P3cQIDL5tx35u3sF4aWPwIUYBDkYlHt4HjgujhFgTy4orcw8xSnAwK4nwVlUsihLiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXAOGXPQuVXTL8v/vml
        n156y5Uj5Nam+3wz1uxcW2rDwf6N847SAfPYc8VTOqatTJo988G6uaErE80yTjG2J/PLOCZY
        zN9enPZm5YH9oqcMl5j1vPbRPruzomu94wPmnPluBulv9lbf3XVp5o9GEWWFeQ3TpaZpce9K
        6mG4NN/wwytDX+YT37pvNyixFGckGmoxFxUnAgAbwvjeOgIAAA==
X-CMS-MailID: 20180309122233eucas1p2c64ed26c56a0c5f4ef1c268ae381743f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122233eucas1p2c64ed26c56a0c5f4ef1c268ae381743f
X-RootMTR: 20180309122233eucas1p2c64ed26c56a0c5f4ef1c268ae381743f
References: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <CGME20180309122233eucas1p2c64ed26c56a0c5f4ef1c268ae381743f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Add new structure "coupling_desc" to regulator_dev, which contains
pointers to all coupled regulators including the owner of the structure,
number of coupled regulators and counter of currently resolved
regulators.

Add of_functions to parse all data needed in regulator coupling.
Provide method to check DTS data consistency. Check if each coupled
regulator's max_spread is equal and if their lists of regulators match.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/internal.h      |  28 ++++++-
 drivers/regulator/of_regulator.c  | 151 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h  |  18 +++++
 include/linux/regulator/machine.h |   4 +
 4 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e..485db15 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -63,6 +63,14 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
+
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index);
+
+int of_get_n_coupled(struct regulator_dev *rdev);
+
+bool of_check_coupling_data(struct regulator_dev *rdev);
+
 #else
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
@@ -72,8 +80,25 @@ regulator_of_get_init_data(struct device *dev,
 {
 	return NULL;
 }
-#endif
 
+static inline struct regulator_dev *
+of_parse_coupled_regulator(struct regulator_dev *rdev,
+			   int index)
+{
+	return NULL;
+}
+
+static inline int of_get_n_coupled(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline bool of_check_coupling_data(struct regulator_dev *rdev)
+{
+	return false;
+}
+
+#endif
 enum regulator_get_type {
 	NORMAL_GET,
 	EXCLUSIVE_GET,
@@ -83,5 +108,4 @@ enum regulator_get_type {
 
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
-
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index f47264f..c6e61c7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -138,6 +138,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
+	if (!of_property_read_u32(np, "regulator-coupled-max-spread",
+				  &pval))
+		constraints->max_spread = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
@@ -407,3 +411,150 @@ struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }
+
+/*
+ * Returns number of regulators coupled with rdev.
+ */
+int of_get_n_coupled(struct regulator_dev *rdev)
+{
+	struct device_node *node = rdev->dev.of_node;
+	int n_phandles;
+
+	n_phandles = of_count_phandle_with_args(node,
+						"regulator-coupled-with",
+						NULL);
+
+	return (n_phandles > 0) ? n_phandles : 0;
+}
+
+/* Looks for "to_find" device_node in src's "regulator-coupled-with" property */
+static bool of_coupling_find_node(struct device_node *src,
+				  struct device_node *to_find)
+{
+	int n_phandles, i;
+	bool found = false;
+
+	n_phandles = of_count_phandle_with_args(src,
+						"regulator-coupled-with",
+						NULL);
+
+	for (i = 0; i < n_phandles; i++) {
+		struct device_node *tmp = of_parse_phandle(src,
+					   "regulator-coupled-with", i);
+
+		if (!tmp)
+			break;
+
+		/* found */
+		if (tmp == to_find)
+			found = true;
+
+		of_node_put(tmp);
+
+		if (found)
+			break;
+	}
+
+	return found;
+}
+
+/**
+ * of_check_coupling_data - Parse rdev's coupling properties and check data
+ *			    consistency
+ * @rdev - pointer to regulator_dev whose data is checked
+ *
+ * Function checks if all the following conditions are met:
+ * - rdev's max_spread is greater than 0
+ * - all coupled regulators have the same max_spread
+ * - all coupled regulators have the same number of regulator_dev phandles
+ * - all regulators are linked to each other
+ *
+ * Returns true if all conditions are met.
+ */
+bool of_check_coupling_data(struct regulator_dev *rdev)
+{
+	int max_spread = rdev->constraints->max_spread;
+	struct device_node *node = rdev->dev.of_node;
+	int n_phandles = of_get_n_coupled(rdev);
+	struct device_node *c_node;
+	int i;
+	bool ret = true;
+
+	if (max_spread <= 0) {
+		dev_err(&rdev->dev, "max_spread value invalid\n");
+		return false;
+	}
+
+	/* iterate over rdev's phandles */
+	for (i = 0; i < n_phandles; i++) {
+		int c_max_spread, c_n_phandles;
+
+		c_node = of_parse_phandle(node,
+					  "regulator-coupled-with", i);
+
+		if (!c_node)
+			ret = false;
+
+		c_n_phandles = of_count_phandle_with_args(c_node,
+							  "regulator-coupled-with",
+							  NULL);
+
+		if (c_n_phandles != n_phandles) {
+			dev_err(&rdev->dev, "number of couped reg phandles mismatch\n");
+			ret = false;
+			goto clean;
+		}
+
+		if (of_property_read_u32(c_node, "regulator-coupled-max-spread",
+					 &c_max_spread)) {
+			ret = false;
+			goto clean;
+		}
+
+		if (c_max_spread != max_spread) {
+			dev_err(&rdev->dev,
+				"coupled regulators max_spread mismatch\n");
+			ret = false;
+			goto clean;
+		}
+
+		if (!of_coupling_find_node(c_node, node)) {
+			dev_err(&rdev->dev, "missing 2-way linking for coupled regulators\n");
+			ret = false;
+		}
+
+clean:
+		of_node_put(c_node);
+		if (!ret)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * of_parse_coupled regulator - Get regulator_dev pointer from rdev's property
+ * @rdev: Pointer to regulator_dev, whose DTS is used as a source to parse
+ *	  "regulator-coupled-with" property
+ * @index: Index in phandles array
+ *
+ * Returns the regulator_dev pointer parsed from DTS. If it has not been yet
+ * registered, returns NULL
+ */
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index)
+{
+	struct device_node *node = rdev->dev.of_node;
+	struct device_node *c_node;
+	struct regulator_dev *c_rdev;
+
+	c_node = of_parse_phandle(node, "regulator-coupled-with", index);
+	if (!c_node)
+		return NULL;
+
+	c_rdev = of_find_regulator_by_node(c_node);
+
+	of_node_put(c_node);
+
+	return c_rdev;
+}
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 659a031..8928fd6 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
+#define MAX_COUPLED		10
+
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
@@ -407,6 +409,20 @@ struct regulator_config {
 };
 
 /*
+ * struct coupling_desc
+ *
+ * Describes coupling of regulators. Each regulator should have
+ * at least a pointer to itself in coupled_rdevs array.
+ * When a new coupled regulator is resolved, n_resolved is
+ * incremented.
+ */
+struct coupling_desc {
+	struct regulator_dev *coupled_rdevs[MAX_COUPLED];
+	int n_resolved;
+	int n_coupled;
+};
+
+/*
  * struct regulator_dev
  *
  * Voltage / Current regulator class device. One for each
@@ -429,6 +445,8 @@ struct regulator_dev {
 	/* lists we own */
 	struct list_head consumer_list; /* consumers we supply */
 
+	struct coupling_desc coupling_desc;
+
 	struct blocking_notifier_head notifier;
 	struct mutex mutex; /* consumer lock */
 	struct task_struct *mutex_owner;
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 93a0489..3468703 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -103,6 +103,7 @@ struct regulator_state {
  * @ilim_uA: Maximum input current.
  * @system_load: Load that isn't captured by any consumer requests.
  *
+ * @max_spread: Max possible spread between coupled regulators
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
  * @valid_ops_mask: Operations which may be performed by consumers.
  *
@@ -154,6 +155,9 @@ struct regulation_constraints {
 
 	int system_load;
 
+	/* used for coupled regulators */
+	int max_spread;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
2.7.4
