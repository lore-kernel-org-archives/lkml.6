Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeCLLI3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:08:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38691 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeCLLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:08:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180312110824euoutp02aa17c2fa087787264980017decf1fa38~bJ6ifGEeX1842118421euoutp02C
X-AuditID: cbfec7f4-b4fc79c0000043e4-e1-5aa65fa6bd1a
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <5df9b5b5-bb42-5e87-0bba-0ea11a9cb6b4@samsung.com>
Date: Mon, 12 Mar 2018 12:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180309125659.GE5252@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7rL4pdFGVzukLPYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvF2iN32S2WXr/IZNG69wi7xf4rXg7cHmvmrWH0
        +PZ1EovH7IaLLB47Z91l99i0qpPNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDK+7bvFXvBg
        ImPF2v0zWRsY35d1MXJySAiYSDw9e4uti5GLQ0hgBaPEkjkzGCGcz4wSm688Y+li5ICo2soN
        EV/GKLFn5UGoomeMElO2dTCCjBIWsJG483ILK4gtIqAscfX7XhaQImaBJmaJffMeMIFMYhPQ
        kljTHg9SwytgJ3HiXgM7iM0ioCpx4cllJhBbVCBCYuHUp4wQNYISPybfYwGxOQWMJOauOgcW
        ZxZwlHiwaCcrhC0u0dx6kwXClpfYvOYtM8heCYHvbBKPpx1lhPjTReL6oXvMELawxKvjW9gh
        bBmJy5O7WSDsaomLX3exQdg1Eo23N0DVWEt8nrSFGWIBn8SkbdOZIaHCK9HRJgRR4iFx68pa
        JgjbUeLqZ1gozmWS+Nozh3UCo9wsJP/MQvLDLCQ/zELywwJGllWM4qmlxbnpqcVGeanlesWJ
        ucWleel6yfm5mxiBCen0v+NfdjDu+pN0iFGAg1GJh5chclmUEGtiWXFl7iFGCQ5mJRHeO5pA
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBsZ1+dPvcuk1
        m24+s0KzPmCie9BZJoVTfxIbn7fdz5E6dP2y1c93V75wRt5XnFRr/Odv5eK6nZrfZqboW3gJ
        s1w1SJpRYMizzz2s3WndQW/Jd6scAyflGvErB6xyY1fi5Sr88mRh3SW7vLqkkIWzpV/v8v7e
        89zoDnc4c7+rrkqDppJ/98viU0osxRmJhlrMRcWJAPrB0b9EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Vd2l8cuiDLY+l7PYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvF2iN32S2WXr/IZNG69wi7xf4rXg7cHmvmrWH0
        +PZ1EovH7IaLLB47Z91l99i0qpPNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDK+7bvFXvBg
        ImPF2v0zWRsY35d1MXJwSAiYSDzdyt3FyMUhJLCEUWLFyYdsEM4zRon5v48xdjFycggL2Ejc
        ebmFFcQWEVCWuPp9LwtIEbNAC7PEoa0vWSA65jNJHN79hAVkLJuAlsSa9niQBl4BO4kT9xrY
        QWwWAVWJC08uM4HYogIREp0r57NA1AhK/Jh8D8zmFDCSmLvqHNhiZgFbiQXv17FA2OISza03
        oWx5ic1r3jJPYBSYhaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw
        brYd+7llB2PXu+BDjAIcjEo8vDM2LY0SYk0sK67MPcQowcGsJMJ7R3NZlBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGvNlmtZe9cydLnxM5GHrojcN/
        XYsjIjnRHfJ/mK3Z1pS2/pKZXH+4i7UsUdZ8QYJfYHLdmQIrQWYGi8mPnDnTzq/jsttStaf1
        vd6ZlENd5//2r1bYqKMc6MF40Squqo/1ZmHGx2eHYuP3sv+dyCefaH3617qv8W/uHHWJn/fW
        yWmnersjX6kSS3FGoqEWc1FxIgDRauqmlwIAAA==
X-CMS-MailID: 20180312110821eucas1p296a5dcd95ebe4dabb4352f41d9650fda
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
X-RootMTR: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
        <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <20180309124234.GC5252@sirena.org.uk>
        <5cf960c5-73ab-fd53-fb68-b6f7f92ca3e7@samsung.com>
        <20180309125659.GE5252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 01:56 PM, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 01:50:20PM +0100, Maciej Purski wrote:
>> On 03/09/2018 01:42 PM, Mark Brown wrote:
> 
>>> Is it possible to respin this in terms of the test/coupled branch in my
>>> git tree?  There were a bunch of build fixes that got sent and I don't
>>> want to loose any of those.
> 
>> I have included those build fixes in my new patchset. I can extract the
>> newest changes and rebase them against your test/coupled branch, if that's
>> what you're asking for.
> 
> That was what I was asking for, yeah (though it can wait till people
> manage to test).  It would also be helpful from a review point of view
> to see what the fix is.
>

Hi,
this is the patch containing all the new changes applied to coupled regulators.


 From 3b073fa86bd55feda7d3855c0c776aad6b659f67 Mon Sep 17 00:00:00 2001
From: Maciej Purski <m.purski@samsung.com>
Date: Fri, 9 Mar 2018 14:02:03 +0100
Subject: [PATCH] regulator: core: Make locks re-entrant

Setting voltage, enabling/disabling regulators requires operations on
all regulators related with the regulator being changed. Therefore,
all of them should be locked for the whole operation. With the current
locking implementation, adding additional dependency (regulators
coupling) causes deadlocks in some cases.

Introduce a possibility to attempt to lock a mutex multiple times
by the same task without waiting on a mutex. This should handle all
reasonable coupling-supplying combinations, especially when two coupled
regulators share common supplies. The only situation that should be
forbidden is simultaneous coupling and supplying between a pair of
regulators.

The idea is based on clk core.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
  drivers/regulator/core.c         | 214 ++++++++++++++++++++-------------------
  include/linux/regulator/driver.h |   2 +
  2 files changed, 113 insertions(+), 103 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e685f8b..1999290 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -96,6 +96,7 @@ struct regulator_supply_alias {
  	const char *alias_supply;
  };

+
  static int _regulator_is_enabled(struct regulator_dev *rdev);
  static int _regulator_disable(struct regulator_dev *rdev);
  static int _regulator_get_voltage(struct regulator_dev *rdev);
@@ -151,65 +152,81 @@ static inline struct regulator_dev *rdev_get_supply(struct 
regulator_dev *rdev)
  	return NULL;
  }

-/**
- * regulator_lock_supply - lock a regulator and its supplies
- * @rdev:         regulator source
- */
-static void regulator_lock_supply(struct regulator_dev *rdev)
+static void regulator_lock_nested(struct regulator_dev *rdev,
+				  unsigned int subclass)
  {
-	int i;
+	if (!mutex_trylock(&rdev->mutex)) {
+		if (rdev->mutex_owner == current) {
+			rdev->ref_cnt++;
+			return;
+		}
+		mutex_lock_nested(&rdev->mutex, subclass);
+	}

-	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
-		mutex_lock_nested(&rdev->mutex, i);
+	rdev->ref_cnt = 1;
+	rdev->mutex_owner = current;
  }

-/**
- * regulator_unlock_supply - unlock a regulator and its supplies
- * @rdev:         regulator source
- */
-static void regulator_unlock_supply(struct regulator_dev *rdev)
+static void regulator_unlock(struct regulator_dev *rdev)
  {
-	struct regulator *supply;
+	if (rdev->ref_cnt != 0) {
+		rdev->ref_cnt--;

-	while (1) {
-		mutex_unlock(&rdev->mutex);
-		supply = rdev->supply;
+		if (!rdev->ref_cnt) {
+			rdev->mutex_owner = NULL;
+			mutex_unlock(&rdev->mutex);
+		}
+	}
+}

-		if (!rdev->supply)
-			return;
+static int regulator_lock_recursive(struct regulator_dev *rdev,
+				    unsigned int subclass)
+{
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock_nested(c_rdev, subclass++);

-		rdev = supply->rdev;
+		if (c_rdev->supply)
+			subclass = regulator_lock_recursive(c_rdev->supply->rdev,
+							    subclass);
  	}
+
+	return subclass;
  }

-/**
- * regulator_lock_coupled - lock a group of coupled regulators
- * @rdev:      regulator source
- */
-static void regulator_lock_coupled(struct regulator_dev *rdev)
+static void regulator_unlock_dependent(struct regulator_dev *rdev)
  {
-	struct coupling_desc *c_desc = &rdev->coupling_desc;
-	int n_coupled = c_desc->n_coupled;
+	struct regulator_dev *c_rdev;
  	int i;

-	for (i = 0; i < n_coupled; i++)
-		if (c_desc->coupled_rdevs[i])
-			mutex_lock_nested(&c_desc->coupled_rdevs[i]->mutex, i);
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_unlock(c_rdev);
+
+		if (c_rdev->supply)
+			regulator_unlock_dependent(c_rdev->supply->rdev);
+	}
  }

-/**
- * regulator_unlock_coupled - unlock a group of coupled regulators
- * @rdev:      regulator source
- */
-static void regulator_unlock_coupled(struct regulator_dev *rdev)
+static inline void regulator_lock(struct regulator_dev *rdev)
  {
-	struct coupling_desc *c_desc = &rdev->coupling_desc;
-	int n_coupled = c_desc->n_coupled;
-	int i;
+	regulator_lock_nested(rdev, 0);
+}

-	for (i = 0; i < n_coupled; i++)
-		if (c_desc->coupled_rdevs[i])
-			mutex_unlock(&c_desc->coupled_rdevs[i]->mutex);
+static inline void regulator_lock_dependent(struct regulator_dev *rdev)
+{
+	regulator_lock_recursive(rdev, 0);
  }

  /**
@@ -385,9 +402,9 @@ static ssize_t regulator_uV_show(struct device *dev,
  	struct regulator_dev *rdev = dev_get_drvdata(dev);
  	ssize_t ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	ret = sprintf(buf, "%d\n", _regulator_get_voltage(rdev));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -451,9 +468,9 @@ static ssize_t regulator_state_show(struct device *dev,
  	struct regulator_dev *rdev = dev_get_drvdata(dev);
  	ssize_t ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	ret = regulator_print_state(buf, _regulator_is_enabled(rdev));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -561,10 +578,10 @@ static ssize_t regulator_total_uA_show(struct device *dev,
  	struct regulator *regulator;
  	int uA = 0;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	list_for_each_entry(regulator, &rdev->consumer_list, list)
  		uA += regulator->uA_load;
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return sprintf(buf, "%d\n", uA);
  }
  static DEVICE_ATTR(requested_microamps, 0444, regulator_total_uA_show, NULL);
@@ -1356,7 +1373,7 @@ static struct regulator *create_regulator(struct 
regulator_dev *rdev,
  	if (regulator == NULL)
  		return NULL;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	regulator->rdev = rdev;
  	list_add(&regulator->list, &rdev->consumer_list);

@@ -1411,12 +1428,12 @@ static struct regulator *create_regulator(struct 
regulator_dev *rdev,
  	    _regulator_is_enabled(rdev))
  		regulator->always_on = true;

-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return regulator;
  overflow_err:
  	list_del(&regulator->list);
  	kfree(regulator);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return NULL;
  }

@@ -1805,13 +1822,13 @@ static void _regulator_put(struct regulator *regulator)
  	/* remove any sysfs entries */
  	if (regulator->dev)
  		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	list_del(&regulator->list);

  	rdev->open_count--;
  	rdev->exclusive = 0;
  	put_device(&rdev->dev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	kfree_const(regulator->supply_name);
  	kfree(regulator);
@@ -2240,10 +2257,10 @@ int regulator_enable(struct regulator *regulator)
  			return ret;
  	}

-	regulator_lock_coupled(rdev);
+	regulator_lock_dependent(rdev);
  	ret = _regulator_enable(rdev);
  	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_coupled(rdev);
+	regulator_unlock_dependent(rdev);

  	if (ret != 0 && rdev->supply)
  		regulator_disable(rdev->supply);
@@ -2349,10 +2366,10 @@ int regulator_disable(struct regulator *regulator)
  	if (regulator->always_on)
  		return 0;

-	regulator_lock_coupled(rdev);
+	regulator_lock_dependent(rdev);
  	ret = _regulator_disable(rdev);
  	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_coupled(rdev);
+	regulator_unlock_dependent(rdev);

  	if (ret == 0 && rdev->supply)
  		regulator_disable(rdev->supply);
@@ -2401,11 +2418,11 @@ int regulator_force_disable(struct regulator *regulator)
  	struct regulator_dev *rdev = regulator->rdev;
  	int ret;

-	regulator_lock_coupled(rdev);
+	regulator_lock_dependent(rdev);
  	regulator->uA_load = 0;
  	ret = _regulator_force_disable(regulator->rdev);
  	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_coupled(rdev);
+	regulator_unlock_dependent(rdev);

  	if (rdev->supply)
  		while (rdev->open_count--)
@@ -2421,7 +2438,7 @@ static void regulator_disable_work(struct work_struct *work)
  						  disable_work.work);
  	int count, i, ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	BUG_ON(!rdev->deferred_disables);

@@ -2442,7 +2459,7 @@ static void regulator_disable_work(struct work_struct *work)
  			rdev_err(rdev, "Deferred disable failed: %d\n", ret);
  	}

-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	if (rdev->supply) {
  		for (i = 0; i < count; i++) {
@@ -2477,11 +2494,11 @@ int regulator_disable_deferred(struct regulator 
*regulator, int ms)
  	if (!ms)
  		return regulator_disable(regulator);

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	rdev->deferred_disables++;
  	mod_delayed_work(system_power_efficient_wq, &rdev->disable_work,
  			 msecs_to_jiffies(ms));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return 0;
  }
@@ -2513,10 +2530,10 @@ static int _regulator_list_voltage(struct regulator_dev 
*rdev,
  		if (selector >= rdev->desc->n_voltages)
  			return -EINVAL;
  		if (lock)
-			mutex_lock(&rdev->mutex);
+			regulator_lock(rdev);
  		ret = ops->list_voltage(rdev, selector);
  		if (lock)
-			mutex_unlock(&rdev->mutex);
+			regulator_unlock(rdev);
  	} else if (rdev->is_switch && rdev->supply) {
  		ret = _regulator_list_voltage(rdev->supply->rdev,
  					      selector, lock);
@@ -2553,9 +2570,9 @@ int regulator_is_enabled(struct regulator *regulator)
  	if (regulator->always_on)
  		return 1;

-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_dependent(regulator->rdev);
  	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_dependent(regulator->rdev);

  	return ret;
  }
@@ -3267,17 +3284,8 @@ static int regulator_balance_voltage(struct regulator_dev 
*rdev,
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
@@ -3309,12 +3317,12 @@ int regulator_set_voltage(struct regulator *regulator, 
int min_uV, int max_uV)
  {
  	int ret = 0;

-	regulator_lock_coupled(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);

  	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
  					     PM_SUSPEND_ON);

-	regulator_unlock_coupled(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);

  	return ret;
  }
@@ -3392,12 +3400,12 @@ int regulator_set_suspend_voltage(struct regulator 
*regulator, int min_uV,
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
@@ -3499,7 +3507,7 @@ int regulator_sync_voltage(struct regulator *regulator)
  	struct regulator_voltage *voltage = &regulator->voltage[PM_SUSPEND_ON];
  	int ret, min_uV, max_uV;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	if (!rdev->desc->ops->set_voltage &&
  	    !rdev->desc->ops->set_voltage_sel) {
@@ -3528,7 +3536,7 @@ int regulator_sync_voltage(struct regulator *regulator)
  	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);

  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }
  EXPORT_SYMBOL_GPL(regulator_sync_voltage);
@@ -3589,11 +3597,11 @@ int regulator_get_voltage(struct regulator *regulator)
  {
  	int ret;

-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);

  	ret = _regulator_get_voltage(regulator->rdev);

-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);

  	return ret;
  }
@@ -3621,7 +3629,7 @@ int regulator_set_current_limit(struct regulator *regulator,
  	struct regulator_dev *rdev = regulator->rdev;
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	/* sanity check */
  	if (!rdev->desc->ops->set_current_limit) {
@@ -3636,7 +3644,7 @@ int regulator_set_current_limit(struct regulator *regulator,

  	ret = rdev->desc->ops->set_current_limit(rdev, min_uA, max_uA);
  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }
  EXPORT_SYMBOL_GPL(regulator_set_current_limit);
@@ -3645,7 +3653,7 @@ static int _regulator_get_current_limit(struct 
regulator_dev *rdev)
  {
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	/* sanity check */
  	if (!rdev->desc->ops->get_current_limit) {
@@ -3655,7 +3663,7 @@ static int _regulator_get_current_limit(struct 
regulator_dev *rdev)

  	ret = rdev->desc->ops->get_current_limit(rdev);
  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }

@@ -3691,7 +3699,7 @@ int regulator_set_mode(struct regulator *regulator, 
unsigned int mode)
  	int ret;
  	int regulator_curr_mode;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	/* sanity check */
  	if (!rdev->desc->ops->set_mode) {
@@ -3715,7 +3723,7 @@ int regulator_set_mode(struct regulator *regulator, 
unsigned int mode)

  	ret = rdev->desc->ops->set_mode(rdev, mode);
  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }
  EXPORT_SYMBOL_GPL(regulator_set_mode);
@@ -3724,7 +3732,7 @@ static unsigned int _regulator_get_mode(struct 
regulator_dev *rdev)
  {
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	/* sanity check */
  	if (!rdev->desc->ops->get_mode) {
@@ -3734,7 +3742,7 @@ static unsigned int _regulator_get_mode(struct 
regulator_dev *rdev)

  	ret = rdev->desc->ops->get_mode(rdev);
  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }

@@ -3755,7 +3763,7 @@ static int _regulator_get_error_flags(struct regulator_dev 
*rdev,
  {
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	/* sanity check */
  	if (!rdev->desc->ops->get_error_flags) {
@@ -3765,7 +3773,7 @@ static int _regulator_get_error_flags(struct regulator_dev 
*rdev,

  	ret = rdev->desc->ops->get_error_flags(rdev, flags);
  out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
  	return ret;
  }

@@ -3814,10 +3822,10 @@ int regulator_set_load(struct regulator *regulator, int 
uA_load)
  	struct regulator_dev *rdev = regulator->rdev;
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	regulator->uA_load = uA_load;
  	ret = drms_uA_update(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -3845,7 +3853,7 @@ int regulator_allow_bypass(struct regulator *regulator, 
bool enable)
  	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_BYPASS))
  		return 0;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	if (enable && !regulator->bypass) {
  		rdev->bypass_count++;
@@ -3869,7 +3877,7 @@ int regulator_allow_bypass(struct regulator *regulator, 
bool enable)
  	if (ret == 0)
  		regulator->bypass = enable;

-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -4631,9 +4639,9 @@ static int _regulator_suspend_late(struct device *dev, 
void *data)
  	suspend_state_t *state = data;
  	int ret;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
  	ret = suspend_set_state(rdev, *state);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -4662,14 +4670,14 @@ static int _regulator_resume_early(struct device *dev, 
void *data)
  	if (rstate == NULL)
  		return -EINVAL;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	if (rdev->desc->ops->resume_early &&
  	    (rstate->enabled == ENABLE_IN_SUSPEND ||
  	     rstate->enabled == DISABLE_IN_SUSPEND))
  		ret = rdev->desc->ops->resume_early(rdev);

-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return ret;
  }
@@ -4971,7 +4979,7 @@ static int __init regulator_late_cleanup(struct device 
*dev, void *data)
  	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
  		return 0;

-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);

  	if (rdev->use_count)
  		goto unlock;
@@ -5002,7 +5010,7 @@ static int __init regulator_late_cleanup(struct device 
*dev, void *data)
  	}

  unlock:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);

  	return 0;
  }
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 85452bb..505bc60 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -446,6 +446,8 @@ struct regulator_dev {

  	struct blocking_notifier_head notifier;
  	struct mutex mutex; /* consumer lock */
+	struct task_struct *mutex_owner;
+	int ref_cnt;
  	struct module *owner;
  	struct device dev;
  	struct regulation_constraints *constraints;
-- 
2.7.4
