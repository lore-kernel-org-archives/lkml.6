Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423181AbeCBIvg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:51:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37890 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165051AbeCBIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180302085128euoutp020e63e6b4bb6a43a6d12a55fc5eb864a0~YDmILt09T0345303453euoutp02P
X-AuditID: cbfec7f4-713ff700000043e4-ae-5a99108f51e0
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 2/5] regulator: core: Parse coupled regulators properties
Date: Fri, 02 Mar 2018 09:42:46 +0100
Message-id: <1519980169-8491-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7djP87r9AjOjDNZu1LTYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj8UeFgmUOFUuOdTM2MHaa
        dDFyckgImEhM3vCABcQWEljBKHFosmIXIxeQ/ZlRYtainSwwRb17GpghipYxSsxr1oIo+s8o
        sebwf8YuRg4ONgEtiTXt8SA1IgI2Em9vHGAEqWEWOM4kcX3qRiaQhLCAj8TK/SvYQWwWAVWJ
        VysngsV5BZwl/kxdzAqxTE7i5rlOsGWcAi4SPx+sYgMZJCGwhE3i7/57TBBFLhJzZh1mh7CF
        JV4d3wJly0hcntwNdXW1xMWvu9gg7BqJxtsboGqsJT5P2gK2gFmAT2LStunMIA9ICPBKdLQJ
        QZR4SPRdXgJV7ihx+M5cRoiHpzNKXDr0l2kCo9QCRoZVjOKppcW56anFRnmp5XrFibnFpXnp
        esn5uZsYgbF7+t/xLzsYd/1JOsQowMGoxMOb8X5GlBBrYllxZe4hRgkOZiUR3pYPQCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQZGxcuxpU6lyhcLCw+t
        qbYv+tgXoHGM6aKSmMiBk5wHKj/dNWXoLj7R/T4zSKdspZ6duHkZg2XPXvffQQ37aqRik2Mc
        1q3gFopTKA9tSdr1cWf9CVEXhsU2ocsU7m7m/bR0u5Xz8j9T727+3RHRude/k6f5wuriE5ue
        7Qi7nqYmyKD1Vji9xk2JpTgj0VCLuag4EQD4IR7A2QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t/xy7r9AjOjDHbu5rPYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj8UeFgmUOFUuOdTM2MHaa
        dDFyckgImEj07mlg7mLk4hASWMIo8fV0GyNIQkigkUni+dz8LkYODjYBLYk17fEgYREBG4m3
        Nw4wgtQzC5xkkvhzcR1YvbCAj8TK/SvYQWwWAVWJVysnMoHYvALOEn+mLmaFWCYncfNcJzOI
        zSngIvHzwSo2iF3OEo1H17FPYORZwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDAth37
        uWUHY9e74EOMAhyMSjy8Bz7OiBJiTSwrrsw9xCjBwawkwtvyASjEm5JYWZValB9fVJqTWnyI
        UZqDRUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qBMX/+1Yepc/17TxpvX/GjviDiyhMzXief
        4wqBzWbzvn55re3u96zdLy9g8TsV0anHLqx98L4q+X7bsYXyy1Jlp79O13tnEFoY2jVZ9Jig
        nfLqfdkpwRPdufzsJNat9WEV6+h8fV665Ejliby5uirv2eZwT4g8+DX94z+eQ6eNLm1j3+GS
        3X57hxJLcUaioRZzUXEiAMvd5TcsAgAA
X-CMS-MailID: 20180302085127eucas1p11acd79e50c5042b6b9f61c8a8a18011e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085127eucas1p11acd79e50c5042b6b9f61c8a8a18011e
X-RootMTR: 20180302085127eucas1p11acd79e50c5042b6b9f61c8a8a18011e
References: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CGME20180302085127eucas1p11acd79e50c5042b6b9f61c8a8a18011e@eucas1p1.samsung.com>
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
 drivers/regulator/internal.h      |   6 ++
 drivers/regulator/of_regulator.c  | 149 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h  |  18 +++++
 include/linux/regulator/machine.h |   4 +
 4 files changed, 177 insertions(+)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e..f253a47 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -84,4 +84,10 @@ enum regulator_get_type {
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
 
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index);
+
+int of_get_n_coupled(struct regulator_dev *rdev);
+
+bool of_check_coupling_data(struct regulator_dev *rdev);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index f47264f..cf3210c 100644
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
 
@@ -407,3 +411,148 @@ struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 
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
+						"regulator-coupled-with", 0);
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
+						"regulator-coupled-with", 0);
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
+							  0);
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
index 4fc96cb..e0f5d4c 100644
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
 	struct module *owner;
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
