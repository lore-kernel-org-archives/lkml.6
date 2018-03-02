Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427177AbeCBLYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:24:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32809 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422736AbeCBIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180302085130euoutp01d0d7b347e74db5f0729ab291173b436d~YDmKPWNPL2795527955euoutp01A
X-AuditID: cbfec7f5-b5fff700000028a9-4e-5a9910914568
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 5/5] regulator: core: Change voltage setting path
Date: Fri, 02 Mar 2018 09:42:49 +0100
Message-id: <1519980169-8491-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7djP87oTBWZGGWx5rWqxccZ6VoupD5+w
        Wcw/co7V4uyyg2wW3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7A5cHmvmrWH0mN1w
        kcVj56y77B6bVnWyefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGxUU7GAuW2VX823yOrYHx
        rFEXIyeHhICJxORLO1lAbCGBFYwSi+eGQtifGSXOH9eFqTmz5wN7FyMXUHwZo8SyB1vZIJz/
        QM63mUAOBwebgJbEmvZ4kAYRARuJtzcOMILUMAscZ5K4PnUjE0hCWMBF4nHHIlYQm0VAVaJv
        8lYwm1fAWWL28idsENvkJG6e62QGsTmB6n8+WAW2TEJgCZvEm6sfGSGKXCTmX97KBGELS7w6
        voUdwpaR6Ow4CBWvlrj4dRfU0BqJxtsboGqsJT5P2gK2gFmAT2LStunMIA9ICPBKdLQJQZR4
        SDyd0Q81xlHiwdsFTBAPT2eUePBrE+MERqkFjAyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLz
        czcxAqP39L/jX3cw7vuTdIhRgINRiYd3J+eMKCHWxLLiytxDjBIczEoivC0fgEK8KYmVValF
        +fFFpTmpxYcYpTlYlMR54zTqooQE0hNLUrNTUwtSi2CyTBycUg2Muv0T5P6HSxxWXvf5q77D
        O32p+aE8JZvmTa3v7l668a35/op9x319/hgkKPhPX62uy5Vz78ZuaeuQF8evNOpNSlTmKtr2
        x2fajqfbf7/3rC0KD76hGl8z4UAk+3EJAS7+yGkcD87xHSrVsrvMXvrcSS2keLb8lVfxnqZS
        e48J3l+e2rPu/dptSizFGYmGWsxFxYkAxde1jdoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t/xy7oTBWZGGbyZw2GxccZ6VoupD5+w
        Wcw/co7V4uyyg2wW3650MFlc3jWHzWLBy1ssFmuP3GW3WHr9IpNF694j7A5cHmvmrWH0mN1w
        kcVj56y77B6bVnWyefRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGxUU7GAuW2VX823yOrYHx
        rFEXIyeHhICJxJk9H9i7GLk4hASWMErc+L2RGcJpZJK4dug2UIaDg01AS2JNezxIg4iAjcTb
        GwcYQWqYBU4ySfy5uI4RJCEs4CLxuGMRK4jNIqAq0Td5K5jNK+AsMXv5EzaIbXISN891MoPY
        nED1Px+sAosLAdU0Hl3HPoGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAINt27Ofm
        HYyXNgYfYhTgYFTi4T3wcUaUEGtiWXFl7iFGCQ5mJRHelg9AId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYz1sRIzkz+oPnh97ZJUVnXijK1W+9j8b9l0
        rnbYvvOYi9CXDZ+CUndqin9oPGLgpfOE69mTpH8L9vAmt043f673UDc0dJfVUeZpWy7nzl/r
        m7NR0vfk6wVnuPYJ/1n4sv3lqdQr7gel5ldVJCtkn930UEHZwYK9UOby4vAOyenB9SqbZr7X
        XBGlxFKckWioxVxUnAgAQlNOvy4CAAA=
X-CMS-MailID: 20180302085129eucas1p165d7e94517ca9c6fee534f53a88125a9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085129eucas1p165d7e94517ca9c6fee534f53a88125a9
X-RootMTR: 20180302085129eucas1p165d7e94517ca9c6fee534f53a88125a9
References: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CGME20180302085129eucas1p165d7e94517ca9c6fee534f53a88125a9@eucas1p1.samsung.com>
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

Add function for locking coupled regulators. Extract a new function
regulator_set_voltage_rdev() from regulator_set_voltage_unlocked(),
which is called when setting voltage of a single regulator.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 101 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b24a987..dedf737 100644
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
@@ -180,6 +183,36 @@ static void regulator_unlock_supply(struct regulator_dev *rdev)
 }
 
 /**
+ * regulator_lock_coupled - lock a group of coupled regulators
+ * @rdev:      regulator source
+ */
+static void regulator_lock_coupled(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled = c_desc->n_coupled;
+	int i;
+
+	for (i = 0; i < n_coupled; i++)
+		if (c_desc->coupled_rdevs[i])
+			mutex_lock_nested(&c_desc->coupled_rdevs[i]->mutex, i);
+}
+
+/**
+ * regulator_unlock_coupled - unlock a group of coupled regulators
+ * @rdev:      regulator source
+ */
+static void regulator_unlock_coupled(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled = c_desc->n_coupled;
+	int i;
+
+	for (i = 0; i < n_coupled; i++)
+		if (c_desc->coupled_rdevs[i])
+			mutex_unlock(&c_desc->coupled_rdevs[i]->mutex);
+}
+
+/**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
  * @supply: regulator supply name
@@ -2199,6 +2232,11 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2208,9 +2246,10 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_coupled(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_coupled(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2316,9 +2355,10 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_coupled(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_coupled(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2367,10 +2407,11 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_coupled(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_coupled(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2929,8 +2970,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -2974,6 +3019,27 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -2985,13 +3051,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -2999,7 +3065,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3011,7 +3077,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3021,7 +3087,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3035,11 +3101,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 out:
 	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
 }
 
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
@@ -3254,12 +3315,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_coupled(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_coupled(regulator->rdev);
 
 	return ret;
 }
-- 
2.7.4
