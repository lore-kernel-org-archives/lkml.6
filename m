Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeCIMXI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:23:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56014 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeCIMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:22:39 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180309122236euoutp023467b6fd8b1ac3ab0dfcc1b8c8b17475~aP-ef-sy_2958129581euoutp02-
X-AuditID: cbfec7f2-5ffe19c000011644-ba-5aa27c8bf23a
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 6/6] regulator: core: Change voltage setting path
Date: Fri, 09 Mar 2018 13:22:08 +0100
Message-id: <1520598128-11768-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7djPc7rdNYuiDC40qlpsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFw6v+Ft+udDBZXN41h81iwctbLBZrj9xlt1h6/SKTReveI+wW+694OfB4
        rJm3htHj29dJLB6zGy6yeOycdZfdY9OqTjaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyphy
        7wB7wcvQiqcvtzI2MJ5y7WLk5JAQMJFomX6HsYuRi0NIYAWjRGfDBiYI5zOjRMOCVpYuRg6w
        qkt7lSDiyxglvi3tgir6zyhxeNItsCI2AS2JNe3xIFNFBGwk3t44ADaVWaCfWWJyE8ggTg5h
        AReJ6WAJTg4WAVWJG+efg9m8QPF1Gz4yQ5wkJ3HzXCeYzSngKnHu+huwQRICW9gkvt87yQhR
        5CLR+vU7E4QtLPHq+BZ2CFtG4vLkbhYIu1ri4tddbBB2jUTj7Q1QNdYSnydtAVvALMAnMWnb
        dGaIL3klOtqEIEo8JO5+384KYTtKfFn1mAXi4RmMEpNarrFPYJRawMiwilE8tbQ4Nz212DAv
        tVyvODG3uDQvXS85P3cTIzCyT/87/mkH49dLSYcYBTgYlXh4HzgujBJiTSwrrsw9xCjBwawk
        wltVsShKiDclsbIqtSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgbHn
        H8PCTP0bDvOX7ir7XTdPrWOh0ybr3Vq6L8+6/JlkY+T9Wk18o2aW61+1oCqd2byBQZUvylRC
        WfY+F9H+/q6+eNP2hvqQduWlPmz/+Jf+0fjzLHpKoK1ayoFgt188mXtWtP3Wip5w+qfKhxJh
        m+hDjvcPeSz0iP9471Go5MMDTJfi+k+GxyuxFGckGmoxFxUnAgBRmrMe6AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t/xy7rdNYuiDK7PZbHYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlTHl
        3gH2gpehFU9fbmVsYDzl2sXIwSEhYCJxaa9SFyMnh5DAEkaJSZ2yXYxcQHYjk8T33uXMIDVs
        AloSa9rjQWpEBGwk3t44wAhSwywwkVli4eIrrCAJYQEXielgCU4OFgFViRvnn4PZvEDxdRs+
        MoPYEgJyEjfPdYLZnAKuEueuv2GEWOwi0THjOfsERp4FjAyrGEVSS4tz03OLjfSKE3OLS/PS
        9ZLzczcxAkNv27GfW3Ywdr0LPsQowMGoxMP7wHFhlBBrYllxZe4hRgkOZiUR3qqKRVFCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGC1nrwp89/2VELP2
        sX37zNoMd+zdu23Gb/WYhde6ONLakibOa0wWK3h1dJvO1Lf3dm5hNq16fUS+Tsv5DXuSlERu
        tLvpK/H7+uoXQi0/zBK9vc5t6qukdC6fDsMV4pHRn6xrra33cHF+0ltmvXO5httjyfRZFxwP
        fONy/Gus1cb9RbtSNeVkmBJLcUaioRZzUXEiAJLJnIc5AgAA
X-CMS-MailID: 20180309122235eucas1p1342d196d86555bd469cde651fa011999
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122235eucas1p1342d196d86555bd469cde651fa011999
X-RootMTR: 20180309122235eucas1p1342d196d86555bd469cde651fa011999
References: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <CGME20180309122235eucas1p1342d196d86555bd469cde651fa011999@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Uncoupled regulators should be a special case of coupled regulators, so
they should share a common voltage setting path. When enabling,
disabling or setting voltage of a coupled regulator, all coupled
regulators should be locked. Regulator's supplies should be locked, when
setting voltage of a single regulator. Enabling a coupled regulator or
setting its voltage should not be possible if some of its coupled
regulators, has not been registered.

Add function for locking coupled regulators and supplies. Extract
a new function regulator_set_voltage_rdev() from
regulator_set_voltage_unlocked(), which is called when setting
voltage of a single regulator.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 155 +++++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1b1e0375..0e80ba5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -107,6 +107,9 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
 static int regulator_balance_voltage(struct regulator_dev *rdev,
 				     suspend_state_t state);
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+				      int min_uV, int max_uV,
+				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -198,38 +201,67 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	}
 }
 
-/**
- * regulator_lock_supply - lock a regulator and its supplies
- * @rdev:         regulator source
- */
-static void regulator_lock_supply(struct regulator_dev *rdev)
+static int regulator_lock_recursive(struct regulator_dev *rdev,
+				    unsigned int subclass)
 {
+	struct regulator_dev *c_rdev;
 	int i;
 
-	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
-		regulator_lock_nested(rdev, i);
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock_nested(c_rdev, subclass++);
+
+		if (c_rdev->supply)
+			subclass =
+				regulator_lock_recursive(c_rdev->supply->rdev,
+							 subclass);
+	}
+
+	return subclass;
 }
 
 /**
- * regulator_unlock_supply - unlock a regulator and its supplies
- * @rdev:         regulator source
+ * regulator_unlock_dependent - unlock regulator's suppliers and coupled
+ *				regulators
+ * @rdev:			regulator source
+ *
+ * Unlock all regulators related with rdev by coupling or suppling.
  */
-static void regulator_unlock_supply(struct regulator_dev *rdev)
+static void regulator_unlock_dependent(struct regulator_dev *rdev)
 {
-	struct regulator *supply;
+	struct regulator_dev *c_rdev;
+	int i;
 
-	while (1) {
-		regulator_unlock(rdev);
-		supply = rdev->supply;
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
 
-		if (!rdev->supply)
-			return;
+		if (!c_rdev)
+			continue;
+
+		regulator_unlock(c_rdev);
 
-		rdev = supply->rdev;
+		if (c_rdev->supply)
+			regulator_unlock_dependent(c_rdev->supply->rdev);
 	}
 }
 
 /**
+ * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
+ * @rdev:			regulator source
+ *
+ * This function as a wrapper on regulator_lock_recursive(), which locks
+ * all regulators related with rdev by coupling or suppling.
+ */
+static inline void regulator_lock_dependent(struct regulator_dev *rdev)
+{
+	regulator_lock_recursive(rdev, 0);
+}
+
+/**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
  * @supply: regulator supply name
@@ -2249,6 +2281,11 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2258,9 +2295,10 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2366,9 +2404,10 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2417,10 +2456,11 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2568,9 +2608,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_dependent(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -2979,8 +3019,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
+
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -3024,6 +3068,27 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
+	if (ret < 0)
+		goto out2;
+
+out:
+	return 0;
+out2:
+	voltage->min_uV = old_min_uV;
+	voltage->max_uV = old_max_uV;
+
+	return ret;
+}
+
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+				      int max_uV, suspend_state_t state)
+{
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
+	int ret;
+
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3035,13 +3100,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		selector = regulator_map_voltage(rdev, min_uV, max_uV);
 		if (selector < 0) {
 			ret = selector;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV = _regulator_list_voltage(rdev, selector, 0);
 		if (best_supply_uV < 0) {
 			ret = best_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
@@ -3049,7 +3114,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3061,7 +3126,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3071,7 +3136,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3085,11 +3150,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 out:
 	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
 }
 
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
@@ -3262,17 +3322,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			goto out;
 		}
 
-		/*
-		 * Lock just the supply regulators, as the regulator itself
-		 * is already locked by regulator_lock_coupled().
-		 */
-		if (best_rdev->supply)
-			regulator_lock_supply(best_rdev->supply->rdev);
-
 		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
 						 best_uV, state);
-		if (best_rdev->supply)
-			regulator_unlock_supply(best_rdev->supply->rdev);
 
 		if (ret < 0)
 			goto out;
@@ -3304,12 +3355,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3387,12 +3438,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_set_suspend_voltage(regulator, min_uV,
 					     max_uV, state);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3584,11 +3635,11 @@ int regulator_get_voltage(struct regulator *regulator)
 {
 	int ret;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_get_voltage(regulator->rdev);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
-- 
2.7.4
