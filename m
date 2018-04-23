Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeDWOeW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:34:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36813 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755460AbeDWOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180423143405euoutp027b112f5b943d4d6f9b8a48223de68cb5~oF0HLA9j02196021960euoutp026
X-AuditID: cbfec7f4-b4fc79c0000043e4-dd-5addeedacfe2
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 3/6] regulator: core: Parse coupled regulators properties
Date: Mon, 23 Apr 2018 16:33:39 +0200
Message-id: <1524494022-22260-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7djPc7q33t2NMui9JmWxccZ6VoupD5+w
        Wcw/co7V4uyyg2wWD6/6W3y70sFkcXnXHDaLBS9vsVisPXKX3WLp9YtMFq17j7Bb7L/i5cDj
        sWbeGkaPb18nsXjMbrjI4rFz1l12j02rOtk8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+Ny
        6yXmggXuFV2TVjI3MJ607GLk5JAQMJHoXfqOsYuRi0NIYAWjxMzrD5ghnM+MEls33mOFqVoz
        fSsrRGIZo0THxctsEM5/RonXUw+wdzFycLAJaEmsaY8HaRARsJF4e+MA2FhmgX5miclNrSwg
        NcICPhL71yeA1LAIqEpsn7cObAGvgIvEgzeHmSGWyUncPNcJZnMKuEosaX7ADjJHQmAPm8Sc
        Y8cZIYpcJB5tOAplC0u8Or6FHcKWkejsOMgEYVdLXPy6iw3CrpFovL0BqsZa4vOkLWALmAX4
        JCZtm84McpuEAK9ER5sQRImHxLW3b6Ced5T49KyHCeLfGYwSl3fcY5nAKLWAkWEVo3hqaXFu
        emqxUV5quV5xYm5xaV66XnJ+7iZGYGSf/nf8yw7GXX+SDjEKcDAq8fDu0L0bJcSaWFZcmXuI
        UYKDWUmE9+EboBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeOI26KCGB9MSS1OzU1ILUIpgsEwen
        VAOj6/0fDtJPk1sUnedrt7vFlXSqBLg4nayvObqtk3EO55sNol9E7ml8MuRbN5szJzXA9Yi6
        4Xw7g2+v46Mjlss+t9CcNeHgwUV5Igc2zWnj9rjC+sxDIozBvq29K8HSU2XdpM/rJs/Zqq0w
        3eLN/mxuDtGpNz8c97uwLcKf68raM7xzZrZYd71XYinOSDTUYi4qTgQAADGay+gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xy7o3392NMvh2nM9i44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bl
        1kvMBQvcK7omrWRuYDxp2cXIySEhYCKxZvpW1i5GLg4hgSWMErf/PWOBcBqZJJadXcfWxcjB
        wSagJbGmPR6kQUTARuLtjQOMIDXMAhOZJRYuvsIKUiMs4COxf30CSA2LgKrE9nnrWEFsXgEX
        iQdvDjNDLJOTuHmuE8zmFHCVWNL8gB3EFgKq2bdvF/MERp4FjAyrGEVSS4tz03OLDfWKE3OL
        S/PS9ZLzczcxAoNv27Gfm3cwXtoYfIhRgINRiYd3h+7dKCHWxLLiytxDjBIczEoivA/fAIV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUwJm+OvOysnx+5
        d9drf5W9OvzF+n/Ecx975KWGv759Jn16xbtbh59Mqwx7LPJn5oSVK5kP/Jm+/3v6iYSMaeVs
        txqUFT+GL9lbkLd08Za9hywTb375efZGTnH9xDm3v9zh2hPMtFnm5eW7B4t9y/83CRSdXr5G
        fcGK0vUd+YnN188a8qed7O8uSVFiKc5INNRiLipOBADVifikOgIAAA==
X-CMS-MailID: 20180423143401eucas1p1c80bce784a76eca5c86c2e73c53b34df
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143401eucas1p1c80bce784a76eca5c86c2e73c53b34df
X-RootMTR: 20180423143401eucas1p1c80bce784a76eca5c86c2e73c53b34df
References: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
        <CGME20180423143401eucas1p1c80bce784a76eca5c86c2e73c53b34df@eucas1p1.samsung.com>
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
index 0d3f73e..6b09c70 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -139,6 +139,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
+	if (!of_property_read_u32(np, "regulator-coupled-max-spread",
+				  &pval))
+		constraints->max_spread = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
@@ -408,3 +412,150 @@ struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 
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
index 659a031..dae6106 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
+#define MAX_COUPLED		4
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
