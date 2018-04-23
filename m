Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbeDWOel (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:34:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50128 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbeDWOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180423143406euoutp01a5170435da97cdb9f2c59af56aad1091~oF0Ir02Kp0294402944euoutp01U
X-AuditID: cbfec7f5-f95739c0000028a9-5c-5addeedb8a15
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 5/6] regulator: core: Add voltage balancing mechanism
Date: Mon, 23 Apr 2018 16:33:41 +0200
Message-id: <1524494022-22260-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7djPc7q3392NMljabGKxccZ6VoupD5+w
        Wcw/co7V4uyyg2wWD6/6W3y70sFkcXnXHDaLBS9vsVisPXKX3WLp9YtMFq17j7Bb7L/i5cDj
        sWbeGkaPb18nsXjMbrjI4rFz1l12j02rOtk8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+P1
        vplsBd9sKrbfOMTewPhDv4uRg0NCwESia75JFyMXh5DACkaJ119PMEM4nxklvu09yNLFyAlW
        9H9qMyNEYhmjxPONH6Cc/4wSG25tZgEZxSagJbGmPR6kQUTARuLtjQNgNcwC/cwSk5tawSYJ
        C3hIdMx/zwxiswioSsw5OJUNxOYVcJH4dug/E8Q2OYmb5zrBajgFXCWWND9gBxkkIbCDTeLh
        5U+MEEUuEr2L70HZwhKvjm9hh7BlJDo7DkINqpa4+HUXG4RdI9F4ewNUjbXE50lbwBYwC/BJ
        TNo2nRkSFrwSHW1CECUeEks3zIAa4yhx6HYbC8TDMxgl7lxrZJ3AKLWAkWEVo3hqaXFuemqx
        cV5quV5xYm5xaV66XnJ+7iZGYGSf/nf86w7GfX+SDjEKcDAq8fDu0L0bJcSaWFZcmXuIUYKD
        WUmE9+EboBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeOI26KCGB9MSS1OzU1ILUIpgsEwenVAPj
        DhY/nqVXr3WmH3TetaCM3efcxqSl98V3XU+b9P3SyyUzw36frJmjGP4qS1ruC88cnwjOaa77
        A9+vDP/IWGq+tuCkv8buDaaqXwtCujYvT2/4JbgqJKjr1Po/tk5i7LGejH81jk2OL7Zx/PUn
        8Oedl1f3dX8J35ssry24veCMCLeG3ddDH9cGK7EUZyQaajEXFScCABuHRhToAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xy7q33t2NMlj6TMhi44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8br
        fTPZCr7ZVGy/cYi9gfGHfhcjJ4eEgInE/6nNjF2MXBxCAksYJV61bGEHSQgJNDJJvG3O7GLk
        4GAT0JJY0x4PEhYRsJF4e+MAWD2zwERmiYWLr7CCJIQFPCQ65r9nBrFZBFQl5hycygZi8wq4
        SHw79J8JYpmcxM1znWA1nAKuEkuaH0DtcpHYt28X8wRGngWMDKsYRVJLi3PTc4sN9YoTc4tL
        89L1kvNzNzECg2/bsZ+bdzBe2hh8iFGAg1GJh3eH7t0oIdbEsuLK3EOMEhzMSiK8D98AhXhT
        EiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTDGLtHpEfrT++zv
        yU1bOP+cYv0xvXfRVr6Fnm2CdtKLPrwSre3cp7VvCSP/9ll9L+263ylznBSb2miWpXdzkeld
        vSvsdaFSl70e9s703/donv1Oje8a+5/G69b8rTwy4Y7jXicRYTPdc0ZbPzcVrAsPedO45lGI
        sosDS0Ot3N7Zd946BR82WrhKiaU4I9FQi7moOBEAa6+hjDoCAAA=
X-CMS-MailID: 20180423143402eucas1p1c8518c75a68eddaf06d8598e97c6a98f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143402eucas1p1c8518c75a68eddaf06d8598e97c6a98f
X-RootMTR: 20180423143402eucas1p1c8518c75a68eddaf06d8598e97c6a98f
References: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
        <CGME20180423143402eucas1p1c8518c75a68eddaf06d8598e97c6a98f@eucas1p1.samsung.com>
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

Introduce new function regulator_balance_voltage(), which
keeps max_spread constraint fulfilled between a group of coupled
regulators. It should be called if a regulator changes its
voltage or after disabling or enabling. Disabled regulators should
follow changes of the enabled ones, but their consumers' demands
shouldn't be taken into account while calculating voltage of other
coupled regulators.

Find voltages, which are closest to suiting all the consumers' demands,
while fulfilling max_spread constraint, keeping the following rules:
- if one regulator is about to rise its voltage, rise others
  voltages in order to keep the max_spread
- if a regulator, which has caused rising other regulators, is
  lowered, lower other regulators if possible
- if one regulator is about to lower its voltage, but it hasn't caused
  rising other regulators, don't change its voltage if it breaks the
  max_spread

Change regulators' voltages step by step, keeping max_spread constraint
fulfilled all the time. Function regulator_get_optimal_voltage()
should find the best possible change for the regulator, which doesn't
break max_spread constraint. In function regulator_balance_voltage()
optimize number of steps by finding highest voltage difference on
each iteration.

If a regulator, which is about to change its voltage, is not coupled,
method regulator_get_optimal_voltage() should simply return the lowest
voltage fulfilling consumers' demands.

Coupling should be checked only if the system is in PM_SUSPEND_ON state.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 82b002e..4f2e9cf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,8 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -3090,6 +3092,196 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	return ret;
 }
 
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
+	int max_spread = rdev->constraints->max_spread;
+	int n_coupled = c_desc->n_coupled;
+	int desired_min_uV, desired_max_uV, min_current_uV = INT_MAX;
+	int max_current_uV = 0, highest_min_uV = 0, target_uV, possible_uV;
+	int i, ret;
+
+	/* If consumers don't provide any demands, set voltage to min_uV */
+	desired_min_uV = rdev->constraints->min_uV;
+	desired_max_uV = rdev->constraints->max_uV;
+	ret = regulator_check_consumers(rdev,
+					&desired_min_uV,
+					&desired_max_uV, PM_SUSPEND_ON);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If there are no coupled regulators, simply set the voltage demanded
+	 * by consumers.
+	 */
+	if (n_coupled == 1) {
+		ret = desired_min_uV;
+		goto out;
+	}
+
+	/* Find highest min desired voltage */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_min = 0;
+		int tmp_max = INT_MAX;
+
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		ret = regulator_check_consumers(c_rdevs[i],
+						&tmp_min,
+						&tmp_max, PM_SUSPEND_ON);
+		if (ret < 0)
+			goto out;
+
+		if (tmp_min > highest_min_uV)
+			highest_min_uV = tmp_min;
+	}
+
+	/*
+	 * Let target_uV be equal to the desired one if possible.
+	 * If not, set it to minimum voltage, allowed by other coupled
+	 * regulators.
+	 */
+	target_uV = max(desired_min_uV,  highest_min_uV - max_spread);
+
+	/*
+	 * Find min and max voltages, which currently aren't
+	 * violating max_spread
+	 */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_act;
+
+		/*
+		 * Don't check the regulator, which is about
+		 * to change voltage
+		 */
+		if (c_rdevs[i] == rdev)
+			continue;
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		if (tmp_act < 0) {
+			ret = tmp_act;
+			goto out;
+		}
+
+		if (tmp_act < min_current_uV)
+			min_current_uV = tmp_act;
+
+		if (tmp_act > max_current_uV)
+			max_current_uV = tmp_act;
+	}
+
+	/* There aren't any other regulators enabled */
+	if (max_current_uV == 0) {
+		possible_uV = target_uV;
+	} else {
+		/*
+		 * Correct target voltage, so as it currently isn't
+		 * violating max_spread
+		 */
+		possible_uV = max(target_uV, max_current_uV - max_spread);
+		possible_uV = min(possible_uV, min_current_uV + max_spread);
+	}
+
+	if (possible_uV > desired_max_uV) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = possible_uV;
+
+out:
+	return ret;
+}
+
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state)
+{
+	struct regulator_dev **c_rdevs;
+	struct regulator_dev *best_rdev;
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled;
+	int i, best_delta, best_uV, ret = 1;
+
+	c_rdevs = c_desc->coupled_rdevs;
+	n_coupled = c_desc->n_coupled;
+
+	/*
+	 * if system is in a state other than PM_SUSPEND_ON, don't check
+	 * other coupled regulators
+	 */
+	if (state != PM_SUSPEND_ON)
+		n_coupled = 1;
+
+	/*
+	 * Find the best possible voltage change on each loop. Leave the loop
+	 * if there isn't any possible change.
+	 */
+	while (1) {
+		best_delta = 0;
+		best_uV = 0;
+		best_rdev = NULL;
+
+		/*
+		 * Find highest difference between optimal voltage
+		 * and current voltage.
+		 */
+		for (i = 0; i < n_coupled; i++) {
+			/*
+			 * optimal_uV is the best voltage that can be set for
+			 * i-th regulator at the moment without violating
+			 * max_spread constraint in order to balance
+			 * the coupled voltages.
+			 */
+			int optimal_uV, current_uV;
+
+			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
+			if (optimal_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			current_uV = _regulator_get_voltage(c_rdevs[i]);
+			if (current_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
+				best_delta = optimal_uV - current_uV;
+				best_rdev = c_rdevs[i];
+				best_uV = optimal_uV;
+			}
+		}
+
+		/* Nothing to change, return successfully */
+		if (!best_rdev) {
+			ret = 0;
+			goto out;
+		}
+
+		/*
+		 * Lock just the supply regulators, as the regulator itself
+		 * is already locked by regulator_lock_coupled().
+		 */
+		if (best_rdev->supply)
+			regulator_lock_supply(best_rdev->supply->rdev);
+
+		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
+						 best_uV, state);
+		if (best_rdev->supply)
+			regulator_unlock_supply(best_rdev->supply->rdev);
+
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 /**
  * regulator_set_voltage - set regulator output voltage
  * @regulator: regulator source
-- 
2.7.4
