Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeBSPpu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:45:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59827 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeBSPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180219154509euoutp02af9465570d7e804d4eda50c8bada2b0f~UxJLlVMUh1358313583euoutp02L
X-AuditID: cbfec7f4-b4fc79c0000043e4-71-5a8af1014c2f
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
Subject: [PATCH 8/8] [media] s5p-mfc: Use clk bulk API
Date: Mon, 19 Feb 2018 16:44:06 +0100
Message-id: <1519055046-2399-9-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRiGe7+z4uptWr5Z+GNUdEArC3mpSCuD74c/rB8hdrBVHyrNA/u0
        0qLsaE7zMC0PZEiFyUidc5kHrFy2maZjaFamqVjodGm6tDSxXLN/N/d9PffDAw9HSk20FxcV
        Ey8oY+QKGeNKVRtnzD5gQhW29cHAFtxd3k7j2+1vCFxoTaFwZX4FjTunxhn8PbsA4PHHKgar
        +7Io/OmplsK2b08I3FT2jsDDny0ULmhOoXHm4CiJzWYti9uu2lisG+yi8UT6Zxp31N1jcLr2
        KY3zzc8JbLjTAHCxtZvCZU29LC7RzRHY0nIAv7ItlMx3VVI4P8fKYPtLNRnozXd0WUh+/MMN
        ls/9XUnztYW9LK/TpDL8s+l+mu9LMxF81aPLvD5zwc/QawBv13nznU1X2BC3MNfdpwVF1FlB
        uWXPCdfIztlqMq5j1fmBwlaQDEY8VMCFQ3AH0pYVESrgyklhKUDFE+9pRyCFdoCakxX/oZme
        CsoJlQD0+LuadUJ/APplCVUBjmPgJvQkJdxhe0AjQPdrgx08CadZlDXbCByBO/RHg2NphENT
        cB1qGr7+r0cC96PZ0nzaucwbfWxPJR3aBQah/voGxlGEYDeLrr3QUU4oCLU8L10ccEcjJj3r
        1GtQR07aInMBWabqGKe+iK580i4yu5Bdrf+3gIRLkbo6j3QcgKAE3bopdSI8spuqFkf3ole5
        9azz+DyAyoc66SzgVQyWaICnkCBGRwiiX4xwzleUR4sJMRG+p2KjdWDhvVrnTT9qQN3cSQOA
        HJC5SWCvKkxKy8+KidEGgDhS5iEJ/rBgSU7LE5MEZWy4MkEhiAawmqNknpLjGy6FSWGEPF44
        IwhxgvJ/SnAuXsmguHv7mDg5f2S0P8t9erR1febYpFWTPrTEGBgSmVRjj8vsaQyOgK9ZaYkt
        Z6N/VOOXW7N7ht2U9Q9tLSvhvqJDFfqjfWXGqoZjms1a8917xnrDD132Tl21NGC4a+9B+9qA
        r223fRqXp2SMIEWqX6jfVA8hSH6usARN+h22vl12SUaJkfJtm0ilKP8LUAE1/loDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe89tR9niuCadDBYM/JChzoh8IYtApWP0obCg9iFbeVDJqe04
        SQmcZojHa2agK0hTLNZMnbesrFjzUivXnIqp041VbGpqlII6rA3p2+/5/Z/Lh4dExQ+wMDIj
        K5dVZykzZUQwZtkenoz8u8or5HOP5XD6+SgOK0c/IFDnLcVgZ307DsfXVgi4ercBwJUnPAFr
        52swONPTgcGlnwYEmtsmEOiZs2GwYaQUh9XuRRRarR0C+Ll4SQCN7kkc/qqYw6H95UMCVnT0
        4LDe+gaBpvsDADZ6pzHYZnYIYKvRh0Dbx0T4fsm/ZHuyE4P197wE/P2uFj0pZeyTNpRZmboj
        YOq2OnGmX+cQMEZ9GcH0rTtxZr58GGG6WgqZ7mq/r+rWA+a3UcqMm4sEZ4WK4LhUNjMjj1VH
        n7gSnD6+2Yvm2PfddOksQAsWJDwIImnqCL0x247xIJgUUy2AtjQ7kZ2iCKG/+Z7hPCBJgoqg
        DaUpAS+hhgDtmm3GA9Mo5RPQVdqcAO+hjtLu5XIkwBgVTps9JYIAi6h4evNpPb5zTUp/HS1D
        AxxEJdDOVwNEgMX+Huv8GFEDhI1glx5IWA2nSlNxh6M4pYrTZKVFXctWGYH/Zb1DG90vAL+c
        bAIUCWRCEeXgFWJcmcflq0yAJlGZRHRmyq9Eqcr8AladnaLWZLKcCewnMdlekVWerxBTacpc
        9jrL5rDq/ylCBoVpQcqf0LpV9lZc/OVTDf2fBr8s294SppLBwoRwOOOeWHSWn5cnxa0f2OIv
        wLZziQexdgfZOnx60eu74foea0xDJm67fDEzoV2HQkKSY481uWT6rb4FbWQSWeCpNKyRwuOz
        u6/aLRd5qNHhj8akl5oMSORIwWs2oliMF/+I9sgwLl0ZE4GqOeU/93h8mK4CAAA=
X-CMS-MailID: 20180219154503eucas1p1c8893411994bd1152d0ce5b386118416
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154503eucas1p1c8893411994bd1152d0ce5b386118416
X-RootMTR: 20180219154503eucas1p1c8893411994bd1152d0ce5b386118416
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154503eucas1p1c8893411994bd1152d0ce5b386118416@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  6 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c     | 41 +++++++++----------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index 76119a8..da3f0b3 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -192,9 +192,9 @@ struct s5p_mfc_buf {
  * struct s5p_mfc_pm - power management data structure
  */
 struct s5p_mfc_pm {
-	struct clk	*clock_gate;
-	const char * const *clk_names;
-	struct clk	*clocks[MFC_MAX_CLOCKS];
+	struct clk		*clock_gate;
+	const char * const	*clk_names;
+	struct clk_bulk_data	*clocks;
 	int		num_clocks;
 	bool		use_clock_gating;
 
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index eb85ced..857f6ea 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -24,7 +24,7 @@ static atomic_t clk_ref;
 
 int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 {
-	int i;
+	int ret;
 
 	pm = &dev->pm;
 	p_dev = dev;
@@ -35,17 +35,17 @@ int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 	pm->clock_gate = NULL;
 
 	/* clock control */
-	for (i = 0; i < pm->num_clocks; i++) {
-		pm->clocks[i] = devm_clk_get(pm->device, pm->clk_names[i]);
-		if (IS_ERR(pm->clocks[i])) {
-			mfc_err("Failed to get clock: %s\n",
-				pm->clk_names[i]);
-			return PTR_ERR(pm->clocks[i]);
-		}
-	}
+	pm->clocks = devm_clk_bulk_alloc(pm->device, pm->num_clocks,
+					 pm->clk_names);
+	if (IS_ERR(pm->clocks))
+		return PTR_ERR(pm->clocks);
+
+	ret = devm_clk_bulk_get(pm->device, pm->num_clocks, pm->clocks);
+	if (ret < 0)
+		return ret;
 
 	if (dev->variant->use_clock_gating)
-		pm->clock_gate = pm->clocks[0];
+		pm->clock_gate = pm->clocks[0].clk;
 
 	pm_runtime_enable(pm->device);
 	atomic_set(&clk_ref, 0);
@@ -75,43 +75,32 @@ void s5p_mfc_clock_off(void)
 
 int s5p_mfc_power_on(void)
 {
-	int i, ret = 0;
+	int ret = 0;
 
 	ret = pm_runtime_get_sync(pm->device);
 	if (ret < 0)
 		return ret;
 
 	/* clock control */
-	for (i = 0; i < pm->num_clocks; i++) {
-		ret = clk_prepare_enable(pm->clocks[i]);
-		if (ret < 0) {
-			mfc_err("clock prepare failed for clock: %s\n",
-				pm->clk_names[i]);
-			i++;
-			goto err;
-		}
-	}
+	ret = clk_bulk_prepare_enable(pm->num_clocks, pm->clocks);
+	if (ret < 0)
+		goto err;
 
 	/* prepare for software clock gating */
 	clk_disable(pm->clock_gate);
 
 	return 0;
 err:
-	while (--i > 0)
-		clk_disable_unprepare(pm->clocks[i]);
 	pm_runtime_put(pm->device);
 	return ret;
 }
 
 int s5p_mfc_power_off(void)
 {
-	int i;
-
 	/* finish software clock gating */
 	clk_enable(pm->clock_gate);
 
-	for (i = 0; i < pm->num_clocks; i++)
-		clk_disable_unprepare(pm->clocks[i]);
+	clk_bulk_disable_unprepare(pm->num_clocks, pm->clocks);
 
 	return pm_runtime_put_sync(pm->device);
 }
-- 
2.7.4
