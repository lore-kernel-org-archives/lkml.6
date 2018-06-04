Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeFDOAH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:00:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58844 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753188AbeFDN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180604135954euoutp0245e3cd02b22a8a48ff97da5f88f870e0~0_cQi0iTU0724607246euoutp02g
X-AuditID: cbfec7f5-f95739c0000028a9-b3-5b1545d93e5f
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 1/7] regulator: core: Add debug messages
Date: Mon, 04 Jun 2018 15:59:18 +0200
Message-id: <1528120764-14316-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7djP87o3XUWjDY5eZ7GY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8ayTXMYC06JVXQePcXSwHhCqIuRk0NCwERiyukv
        7F2MXBxCAisYJQ51PGCEcD4zSuyfvIINpurVyS6oxDJGiWvvVkC1/GeU2LG5Bcjh4GAT0JJY
        0x4P0iAi4CrxvecsC0gNs8ANRokrh84zgtQIC1hILGzRBqlhEVCVWP9jDwuIzSvgIjFx5x1m
        iGVyEjfPdYLZnEBz3s7eBLZYQmAKm8Sdaz+ZQOZIADUc21ULUS8s8er4FnYIW0bi8uRuFgg7
        X6L12WOoeIXEvt7TrBC2tcTh4xfBbGYBPolJ26YzQ4zklehog4aKh8Tcj0uYIF7cxyjxavl3
        5gmMkgsYGVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIERuPpf8e/7mDc9yfpEKMAB6MS
        D6+GlWi0EGtiWXFl7iFGCQ5mJRHe0xZAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLp
        iSWp2ampBalFMFkmDk6pBkbPiVuXZnonfDv/53TT/Ks6VevPxbx2MYl115+UfvnT/ntV55yU
        jt6TCYpxs9eRqWp8vVOwxDZsXv01leL9qy4qTv/71O0R4+83cddaSoysJ0hE/VmzPyWpbIu1
        yXHd6/3T399LkQ22Ozd7cclmzxs3pDL3PwloZ5NL2Pyqqo/jZqnghqiPHd+VWIozEg21mIuK
        EwG7USiMwgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd0brqLRBp1/JSymPnzCZrGv7zeb
        xabH11gtLu+aw2Yxe0k/i8WCl7dYLNYeuctusf+KlwOHx7evk1g8Nq3qZPPYvKTeo2/LKkaP
        4ze2M3l83iQXwBbFZZOSmpNZllqkb5fAlbFs0xzGglNiFZ1HT7E0MJ4Q6mLk5JAQMJF4dbKL
        sYuRi0NIYAmjxIaO+0wQTiOTxOWda1i6GDk42AS0JNa0x4M0iAi4SnzvOcsCUsMscItRYv2r
        o2A1wgIWEgtbtEFqWARUJdb/2MMCYvMKuEhM3HmHGWKZnMTNc51gNifQnLezNzGC2EICWRIL
        rixinsDIs4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgKG079nPLDsaud8GHGAU4GJV4
        eBtsRKOFWBPLiitzDzFKcDArifCetgAK8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCe
        WJKanZpakFoEk2Xi4JRqYDyqpi8oKv2nY+LOR5Pt5kx57P8wKsnQ2vWqVmosT/Qq3YucnXFH
        2jj+8XzIntW40LPlb3LA7J+eHY4MCo+X/IzbfPfHad8EpgbPRZG7nteel8pe8/XoY5W2wvr7
        GsfnMjB3Ju87FilfYLVhJTPjv0caPh9zz0lcrGqrPay75fS+hP9L2Q4ztiuxFGckGmoxFxUn
        AgACzuUgIQIAAA==
X-CMS-MailID: 20180604135952eucas1p2d76b6aa5d8fc9912113d519b48f7e99a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135952eucas1p2d76b6aa5d8fc9912113d519b48f7e99a
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135952eucas1p2d76b6aa5d8fc9912113d519b48f7e99a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug messages on voltage setting and enabling path in order
to debug the coupled regulators problem.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b..b740426 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1571,6 +1571,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	struct device *dev = rdev->dev.parent;
 	int ret;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	/* No supply to resovle? */
 	if (!rdev->supply_name)
 		return 0;
@@ -2211,6 +2212,7 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2259,6 +2261,7 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2275,6 +2278,7 @@ int regulator_enable(struct regulator *regulator)
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2373,6 +2377,7 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2383,6 +2388,7 @@ int regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -2858,6 +2864,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	const struct regulator_ops *ops = rdev->desc->ops;
 	int old_uV = _regulator_get_voltage(rdev);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
 	min_uV += rdev->constraints->uV_offset;
@@ -2992,6 +2999,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int best_supply_uV = 0;
 	int supply_change_uV = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3124,6 +3132,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	regulator_lock_supply(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4
