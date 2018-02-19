Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeBSPpR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:45:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59796 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbeBSPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180219154503euoutp027caec951bbb542486dcc9b017d089762~UxJFsl3ba1439314393euoutp02Q
X-AuditID: cbfec7f2-5ffe19c000011644-47-5a8af0faefb5
From: Maciej Purski <m.purski@samsung.com>
To: linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kamil Debski <kamil@wypas.org>, Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thibault Saunier <thibault.saunier@osg.samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 1/8] clk: Add clk_bulk_alloc functions
Date: Mon, 19 Feb 2018 16:43:59 +0100
Message-id: <1519055046-2399-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe977zMXrtHrQWDIKupCmdHmgC4YGb2jghz6ExGzVi0lq452z
        VlFZ1Ny8X8pLVkKiMbTm2qxWRi1zpeXSyuwyFeyipWiZhVquzVe//c/5/875nw+HwWVOMphJ
        TkvnhTRVioLyIxpbJlxrJkeNCWsnWyLR+xvtJMptf4ahikE9gRrKbpLo9fgIhUYLywEaqTVS
        qKi3gEAfbGYCDQ3XYai5/g2GBno6CFT+VE+i/P7vOHK5zDR6cWaIRpb+LhL9yOkh0St7JYVy
        zDYSlbkeYMhxoQmgqsH3BKpvdtOoxvIXQx2t29HjIe+S6a4GApUVD1Jo7GERHiXnXnV14NxI
        9zmaK5lqILm7FW6as5gMFHf7dx/J9WY7Me5W9SnOmu/t51lNgBuzyLnXzZl0vH+C3+YDfEpy
        Bi+Eb93rdzDnvJlUZ68+Wun6g58GEwojkDCQXQcnHYWYEfgxMvY6gJ7KG0AsxgC0TbnJOUpv
        uEaIRg2At3PbaLHwAOguyfc6DEOxq2CdPtE3EMS2AHjlbpyPwdnfNCyYfAR8RiC7ATpsvTOa
        YJfDzuZPwDcrZaOhrT9WDJPDd+0G3KclbAzsu9dE+fZAtoeGLf+GMRGKgc88VkrUgfCb00qL
        egk0ZD2aZY7DjnH7LHMCZn4wzzKb4FiRdSYAZxfAosZS3HcDZKUw67xMRDiYl/uZEPU2WK6v
        nTlZxpYCeLk7ugAEV4F5JrCY12pSk3hNRBp/JEyjStVo05LC9h9OtQDve7VNO3/eAeOd+xyA
        ZYDCX8q6jQkyUpWh0aU6AGRwRZA0rtvbkh5Q6Y7xwuFEQZvCaxwghCEUi6XKFScTZGySKp0/
        xPNqXphzMUYSfBrMj9/t2PXx5craL1cLL1XZdc9/CU6TVh2wx7919P5lg7yteD3z4Kz2c8CK
        AaUyo29hdtVSt074qgvamVgXYXfcnJbsL0kUdigjFkUa48PzGrdUblR2RllNA1OtyWffTrvk
        oWRmdaDHv8Ju40zG1a4hj/LisuEnAaFNbVisOqRaQWgOqiJW4YJG9R+DFDWbWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xa7o/PnRFGTx+KGlxa905VovecyeZ
        LGa9bGex2DhjPavFla/v2Sw+TJzJaPF+eRebxaT7E1gsbm/dwGLx5u0aJosja68yWby4d5HF
        YuaJdlaL/sevmS3On9/AbnG26Q27xabH11gtPvbcY7W4vGsOm0XPhq2sFjPO72OyODR1L6PF
        gpe3WCzWHrnLbrFs0x8mi4unXC0OvwEa8u/aRhaLGZNfsll8PjCJ2UHO4/K1i8we72+0sntM
        +b2R1WPnrLvsHptWdbJ5bP/2gNXjfvdxJo/NS+o9tvQDxfu2rGL0+LxJzuPKkUb2AJ4oLpuU
        1JzMstQifbsEroyetg2sBd3aFXPOf2duYPyp1MXIySEhYCLR3rmYpYuRi0NIYAmjxM9rW5kg
        nEYmib6elaxdjBwcbAJaEmva40HiIgLHGCUe3lnMCtLNLPCHXaKvoQDEFhYwkzi09T4jiM0i
        oCpx6cgTRpBeXgFnia2PvSGWyUncPNfJDGJzCrhIPNi9lw3EFgIqOX//EtsERp4FjAyrGEVS
        S4tz03OLDfWKE3OLS/PS9ZLzczcxAmNs27Gfm3cwXtoYfIhRgINRiYdX4G5XlBBrYllxZe4h
        RgkOZiURXp8bQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTByc
        Ug2M7C3vfOZeD/yyesr21hWh/zdfWuAR3sJZ7WN4JFzD1zdFtl4n+6H/zeSdXFuXMwa5n3QN
        6yn5E1VXrViq9I0t0/fmpt/761V9ErS3cep8C3J42Kkr6qH/f7Wl0e2d+jr6jx+vsJ4asVcv
        NqlBNkk8SjjtjeXFdHPpKb5XOgQsCqcH2nybqKnEUpyRaKjFXFScCAAV15HkrQIAAA==
X-CMS-MailID: 20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c
X-RootMTR: 20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a driver is going to use clk_bulk_get() function, it has to
initialize an array of clk_bulk_data, by filling its id fields.

Add a new function to the core, which dynamically allocates
clk_bulk_data array and fills its id fields. Add clk_bulk_free()
function, which frees the array allocated by clk_bulk_alloc() function.
Add a managed version of clk_bulk_alloc().

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/clk/clk-bulk.c   | 16 ++++++++++++
 drivers/clk/clk-devres.c | 37 +++++++++++++++++++++++++---
 include/linux/clk.h      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4c10456..2f16941 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,22 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/slab.h>
+
+struct clk_bulk_data *clk_bulk_alloc(int num_clocks, const char *const *clk_ids)
+{
+	struct clk_bulk_data *ptr;
+	int i;
+
+	ptr = kcalloc(num_clocks, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num_clocks; i++)
+		ptr[i].id = clk_ids[i];
+
+	return ptr;
+}
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..2115b97 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -9,6 +9,39 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
+struct clk_bulk_devres {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static void devm_clk_alloc_release(struct device *dev, void *res)
+{
+	struct clk_bulk_devres *devres = res;
+
+	clk_bulk_free(devres->clks);
+}
+
+struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev, int num_clks,
+					  const char *const *clk_ids)
+{
+	struct clk_bulk_data **ptr, *clk_bulk;
+
+	ptr = devres_alloc(devm_clk_alloc_release,
+			   num_clks * sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	clk_bulk = clk_bulk_alloc(num_clks, clk_ids);
+	if (clk_bulk) {
+		*ptr = clk_bulk;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return clk_bulk;
+}
+
 static void devm_clk_release(struct device *dev, void *res)
 {
 	clk_put(*(struct clk **)res);
@@ -34,10 +67,6 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
-struct clk_bulk_devres {
-	struct clk_bulk_data *clks;
-	int num_clks;
-};
 
 static void devm_clk_bulk_release(struct device *dev, void *res)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4c4ef9f..7d66f41 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
+#include <linux/slab.h>
 
 struct device;
 struct clk;
@@ -240,6 +241,52 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 #endif
 
 #ifdef CONFIG_HAVE_CLK
+
+/**
+ * clk_bulk_alloc - allocates an array of clk_bulk_data and fills their
+ *		    id field
+ * @num_clks: number of clk_bulk_data
+ * @clk_ids: array of clock consumer ID's
+ *
+ * This function allows drivers to dynamically create an array of clk_bulk_data
+ * and fill their id field in one operation. If successful, it allows calling
+ * clk_bulk_get on the pointer returned by this function.
+ *
+ * Returns a pointer to a clk_bulk_data array, or valid IS_ERR() condition
+ * containing errno.
+ */
+struct clk_bulk_data *clk_bulk_alloc(int num_clks, const char *const *clk_ids);
+
+/**
+ * devm_clk_bulk_alloc - allocates an array of clk_bulk_data and fills their
+ *			 id field
+ * @dev: device for clock "consumer"
+ * @num_clks: number of clk_bulk_data
+ * @clk_ids: array of clock consumer ID's
+ *
+ * This function allows drivers to dynamically create an array of clk_bulk_data
+ * and fill their id field in one operation with management, the array will
+ * automatically be freed when the device is unbound. If successful, it allows
+ * calling clk_bulk_get on the pointer returned by this function.
+ *
+ * Returns a pointer to a clk_bulk_data array, or valid IS_ERR() condition
+ * containing errno.
+ */
+struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev, int num_clks,
+					  const char * const *clk_ids);
+
+/**
+ * clk_bulk_free - frees the array of clk_bulk_data
+ * @clks: pointer to clk_bulk_data array
+ *
+ * This function frees the array allocated by clk_bulk_data. It must be called
+ * when all clks are freed.
+ */
+static inline void clk_bulk_free(struct clk_bulk_data *clks)
+{
+	kfree(clks);
+}
+
 /**
  * clk_get - lookup and obtain a reference to a clock producer.
  * @dev: device for clock "consumer"
@@ -598,6 +645,23 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
 #else /* !CONFIG_HAVE_CLK */
 
+static inline struct clk_bulk_data *clk_bulk_alloc(int num_clks,
+						   const char **clk_ids)
+{
+	return NULL;
+}
+
+static inline struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev,
+							int num_clks,
+							const char **clk_ids)
+{
+	return NULL;
+}
+
+static inline void clk_bulk_free(struct clk_bulk_data *clks)
+{
+}
+
 static inline struct clk *clk_get(struct device *dev, const char *id)
 {
 	return NULL;
-- 
2.7.4
