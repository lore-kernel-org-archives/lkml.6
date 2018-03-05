Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeCENEY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:04:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56903 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934919AbeCENEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:04:21 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180305130418euoutp01f3270afad3b23697e8f1b7e03cca1281~ZB_vOk4Uh1619416194euoutp016
X-AuditID: cbfec7f5-b5fff700000028a9-90-5a9d404dd90c
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH] regulator: core: Fix build errors
Date: Mon, 05 Mar 2018 14:03:59 +0100
Message-id: <1520255039-11136-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7djP87q+DnOjDKbcsbTYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjTvM5poIdkhX3b+s3MD4S
        6WLk4JAQMJH418DWxcjJISSwglHi3x7FLkYuIPszo0TrnReMIAmQmmOzj7FDJJYxSpx4f4IN
        wvnPKHHq4XVmkElsAloSa9rjQRpEBGwk3t44wAhSwyxwnEni+tSNTCAJYQEjiV2b74DZLAKq
        Ev39B1lBbF4BF4nZfy9BbZOTuHmukxmkWUKgh03i25fV7BAJF4ntq7qhioQlXh3fAhWXkbg8
        uZsFwq6WuPh1FxuEXSPReHsDVI21xOdJW5hBbGYBPolJ26YzQ7zPK9HRJgRR4iFx+/9WqDGO
        EvsXX2OEBEusxLVzq5kmMEouYGRYxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJERihp/8d
        /7qDcd+fpEOMAhyMSjy8AoVzooRYE8uKK3MPMUpwMCuJ8EpJzo0S4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzhunURclJJCeWJKanZpakFoEk2Xi4JRqYOx1OjZH75vbIdvpdzv/l+qx7OqSPyHk
        eqrI61jn5laRo4eflKqeU82p/MCw6guv17mao1zL1zBbbdnal5ajPnUxu9H+l/Nv/uMzm37i
        4QQmxYYy9oAjbzlUuS8dPKdnG/Hl7axZ16/mT03mObV2++xFnO+XrWSefe1hyW0nb5H4n1HL
        mv9U/atSYinOSDTUYi4qTgQA2GqBoMwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e/4VV0fh7lRBmt+qVtsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFtysdTBaXd81hs1jw8haLxdojd9ktll6/yGTRuvcIuwOXx5p5axg9Zjdc
        ZPHYOesuu8emVZ1sHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJUxp/kcU8EOyYr7t/UbGB+J
        dDFyckgImEgcm32MvYuRi0NIYAmjxKH28+wgCSGBRiaJMz0FXYwcHGwCWhJr2uNBwiICNhJv
        bxxgBKlnFjjJJPHn4jpGkISwgJHErs13mEBsFgFVif7+g6wgNq+Ai8Tsv5cYIZbJSdw818k8
        gZFrASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCA2Xbs55YdjF3vgg8xCnAwKvHwChTO
        iRJiTSwrrsw9xCjBwawkwislOTdKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU
        7NTUgtQimCwTB6dUA2PrZuaG01t4j4Zue3M26vvEcLUttskX4/7Elbz5H+pa9vD2EfGuL9u1
        tfneZYYwXxaLvSFtJJw4/0G4m6z4lhKP7a+cpqVPcE1/mtzS5PY9f+pxxR1+TXq7Ny9gtt3B
        fT5PMrcsc0mdY+GbvxvT2ieGuPcpsxj9sLN7NvmkuMlrzbeagoK7M5RYijMSDbWYi4oTASDa
        OnUUAgAA
X-CMS-MailID: 20180305130412eucas1p225fe12cfbdec20475a578a2b0463d0f5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180305130412eucas1p225fe12cfbdec20475a578a2b0463d0f5
X-RootMTR: 20180305130412eucas1p225fe12cfbdec20475a578a2b0463d0f5
References: <CGME20180305130412eucas1p225fe12cfbdec20475a578a2b0463d0f5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build errors detected by kbuild test robot occur on non-of
architectures.

This patch fixes this behavior as well as using plain integer instead
of NULL in of_count_phandle_with_args().

Fixes: 0c55103 ("regulator: core: Parse coupled regulators properties")
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/internal.h     | 34 ++++++++++++++++++++++++++--------
 drivers/regulator/of_regulator.c |  8 +++++---
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index f253a47..485db15 100644
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
@@ -83,11 +108,4 @@ enum regulator_get_type {
 
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
-
-struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
-						 int index);
-
-int of_get_n_coupled(struct regulator_dev *rdev);
-
-bool of_check_coupling_data(struct regulator_dev *rdev);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cf3210c..c6e61c7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -421,7 +421,8 @@ int of_get_n_coupled(struct regulator_dev *rdev)
 	int n_phandles;
 
 	n_phandles = of_count_phandle_with_args(node,
-						"regulator-coupled-with", 0);
+						"regulator-coupled-with",
+						NULL);
 
 	return (n_phandles > 0) ? n_phandles : 0;
 }
@@ -434,7 +435,8 @@ static bool of_coupling_find_node(struct device_node *src,
 	bool found = false;
 
 	n_phandles = of_count_phandle_with_args(src,
-						"regulator-coupled-with", 0);
+						"regulator-coupled-with",
+						NULL);
 
 	for (i = 0; i < n_phandles; i++) {
 		struct device_node *tmp = of_parse_phandle(src,
@@ -495,7 +497,7 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
 
 		c_n_phandles = of_count_phandle_with_args(c_node,
 							  "regulator-coupled-with",
-							  0);
+							  NULL);
 
 		if (c_n_phandles != n_phandles) {
 			dev_err(&rdev->dev, "number of couped reg phandles mismatch\n");
-- 
2.7.4
