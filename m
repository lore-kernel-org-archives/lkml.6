Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeFDOAF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:00:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58848 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeFDN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180604135954euoutp02a8cc6db6fc37384148e56f44fe787de8~0_cQyPHrz0724607246euoutp02h
X-AuditID: cbfec7f4-b4fc79c0000043e4-80-5b1545d9591c
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 2/7] regulator: core: Add regulator_set_voltage_rdev()
Date: Mon, 04 Jun 2018 15:59:19 +0200
Message-id: <1528120764-14316-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7djP87o3XUWjDTY0KlpMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+P6xUnsBY0yFUsn/WNqYFwk1sXIwSEhYCIx9VV+
        FyMXh5DACkaJNYv/s0I4nxkl9jxtZeti5AQrWjh3AQtEYhmjxPx3d9ghnP+MEjs2t7CDjGIT
        0JJY0x4P0iAi4CrxvecsWAOzwA1GiSuHzjOCJIQF3CQu3N7CClLPIqAq8bjJBCTMK+AicbXx
        OdQyOYmb5zqZQWxOoDlvZ29iBJkjITCFTeL9nG4WiLNdJD7s8oCoF5Z4dXwLO4QtI9HZcZAJ
        ws6XaH32GCpeIbGv9zQrhG0tcfj4RTCbWYBPYtK26cwQI3klOtqEIEo8JLYfecQI8eI+Rolj
        e/YxTWCUXMDIsIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwFk//O/5lB+OuP0mHGAU4
        GJV4eDWsRKOFWBPLiitzDzFKcDArifCetgAK8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsS
        EkhPLEnNTk0tSC2CyTJxcEo1MC5JLfSbssdDwtvwWmdVV/ajSZovu5WfCu20uy7OdO77rfN/
        ws+vieboc5521Nu8tHb33HxrxZsVvP+lej8dWvsygO1q1IkJuu3RIscWVMmJS0Yt+3GdY86i
        9ev0yi9w9L/S6NxiNy8iitPfrOirpg5T04bmBwLPw/1SZF9ODDU/c8ReO+53uxJLcUaioRZz
        UXEiAC/ZQj/BAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd0brqLRBrOvGFhMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+P6xUnsBY0yFUsn/WNqYFwk1sXIySEhYCKxcO4C
        li5GLg4hgSWMEmtenWGGcBqZJC7vXAOU4eBgE9CSWNMeD9IgIuAq8b3nLFgDs8AtRon1r46y
        gCSEBdwkLtzewgpSzyKgKvG4yQQkzCvgInG18TkbxDI5iZvnOplBbE6gOW9nb2IEsYUEsiQW
        XFnEPIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAUNp27OfmHYyXNgYfYhTgYFTi
        4dWwEo0WYk0sK67MPcQowcGsJMJ72gIoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
        YklqdmpqQWoRTJaJg1OqgVEtO/zdZD7Rc8wXgm7ovyg/9fHSt/2N++bLa2yyk3hiGiHSt3xa
        ks+Znbv4Pkkub9myPezot1VHZ8+ZLWmwd96iTOdFL5cu/Fcd/8PF6uq2zwcSq9vFDx9PvbBp
        RnDVzu8KTFJTLSffc57hxrvF1bMs/tVH7hb2BUUzy37F93q8mmn1/M2iuFXHlViKMxINtZiL
        ihMBg8pERSECAAA=
X-CMS-MailID: 20180604135952eucas1p2e3fdb68bf31e32b7c9557051671885a9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135952eucas1p2e3fdb68bf31e32b7c9557051671885a9
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135952eucas1p2e3fdb68bf31e32b7c9557051671885a9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor regulator_set_voltage_unlocked() by taking code related to
regulator_dev and creating a new function regulator_set_voltage_rdev(),
which operates only on struct regulator_dev.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b740426..413a824 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,9 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+				      int min_uV, int max_uV,
+				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -2996,8 +2999,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
 
 	pr_err("%s: %d\n", __func__, __LINE__);
 	/* If we're setting the same range as last time the change
@@ -3042,6 +3043,26 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
+	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
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
@@ -3053,13 +3074,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -3067,7 +3088,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3079,7 +3100,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3089,7 +3110,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3103,11 +3124,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 out:
 	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
 }
 
 /**
-- 
2.7.4
