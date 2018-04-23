Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755563AbeDWOeg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:34:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36835 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755428AbeDWOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:10 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180423143407euoutp02cd0971e907894b6c412597622168ae70~oF0JvRDqU2202422024euoutp02j
X-AuditID: cbfec7f5-f95739c0000028a9-5e-5addeedc05c1
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 6/6] regulator: core: Change voltage setting path
Date: Mon, 23 Apr 2018 16:33:42 +0200
Message-id: <1524494022-22260-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djP87p33t2NMvj/mcNi44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aC
        7h2sBfPDK15+vcnUwPjArYuRk0NCwESi48A51i5GLg4hgRWMEt1TTzJCOJ8ZJRbO+cfcxcgB
        VjXzWBVEfBmjxPW566A6/jNKbLi1mQWkiE1AS2JNezzIVBEBG4m3Nw6ADWIW6GeWmNzUygKS
        EBZwkTiwcAYjiM0ioCrx8scPMJsXKD65azo7xElyEjfPdTKD2JwCrhJLmh+wgwySENjBJrHi
        wh42iItcJPbftoWoF5Z4dXwLVK+MxOXJ3SwQdrXExa+72CDsGonG2xugaqwlPk/aAjafWYBP
        YtK26VBP8kp0tAlBlHhIbPx5jwUi7Cix5kgWxLszGCUWb2linMAotYCRYRWjeGppcW56arFx
        Xmq5XnFibnFpXrpecn7uJkZgVJ/+d/zrDsZ9f5IOMQpwMCrx8O7QvRslxJpYVlyZe4hRgoNZ
        SYT34RugEG9KYmVValF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwTB6dUA+Oi
        KRvDlNwmBsy15OsznVk8Ud7iXusXhd1JbDI+vZdkrbhcTPme2Wlq6063+9BePal1Wu6jRY1B
        f9X8tB1X5llcj2PQXvLmhatL7SN35nYxgXjn9sdfvxWoXj1nv7vBK7eNU1ft2VKdNI0nNTMC
        IndOUtzTd/6H07E3+lMlfymeenl4XfhHXiWW4oxEQy3mouJEADk17EzmAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t/xy7q33t2NMjh3w9hi44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aC
        7h2sBfPDK15+vcnUwPjArYuRg0NCwERi5rGqLkYuDiGBJYwS/Vd+sXQxcgI5jUwSb5szQWrY
        BLQk1rTHg4RFBGwk3t44wAhSzywwkVli4eIrrCAJYQEXiQMLZzCC2CwCqhIvf/wAs3mB4pO7
        prOD2BICchI3z3Uyg9icAq4SS5ofsEPscpHYt28X8wRGngWMDKsYRVJLi3PTc4uN9IoTc4tL
        89L1kvNzNzECQ2/bsZ9bdjB2vQs+xCjAwajEw7tD926UEGtiWXFl7iFGCQ5mJRHeh2+AQrwp
        iZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhiDztZe7jGIvncv
        bRN3ZFRz1vSs098/hx2N2zxP932cqFt85EzG2c9qszcu2+B1OsBrZsU5bTE+e6+qN2kHX7/9
        wq/AkR31Z4rvgdoZsfdO637vl1yceeJ5fqGQ6B0bJ3OFi6yJS5KPdGxxeZnXHc9yc2K09aKw
        h4c7ztw3N9NzZ1rVaXuc10WJpTgj0VCLuag4EQCZQ0/gOQIAAA==
X-CMS-MailID: 20180423143402eucas1p18a76b8d1cf6027af8ebfcd74b7650a1f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143402eucas1p18a76b8d1cf6027af8ebfcd74b7650a1f
X-RootMTR: 20180423143402eucas1p18a76b8d1cf6027af8ebfcd74b7650a1f
References: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
        <CGME20180423143402eucas1p18a76b8d1cf6027af8ebfcd74b7650a1f@eucas1p1.samsung.com>
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
 drivers/regulator/core.c | 159 +++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4f2e9cf..04a88c4 100644
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
 
@@ -2258,9 +2295,12 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2366,9 +2406,11 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2417,10 +2459,12 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2568,9 +2612,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_dependent(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -2979,8 +3023,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -3024,6 +3072,27 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -3035,13 +3104,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -3049,7 +3118,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3061,7 +3130,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3071,7 +3140,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3085,11 +3154,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 out:
 	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
 }
 
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
@@ -3262,17 +3326,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
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
@@ -3304,12 +3359,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
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
@@ -3387,12 +3442,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
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
@@ -3584,11 +3639,11 @@ int regulator_get_voltage(struct regulator *regulator)
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
