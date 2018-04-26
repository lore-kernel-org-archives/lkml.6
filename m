Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeDZLwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21334 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbeDZLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426115224epoutp03564791e933951cfe799516979ba316e2~o_izpHeC02115921159epoutp03-
X-AuditID: b6c32a36-b6dff70000001027-22-5ae1bd787411
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 10/18] thermal: exynos: move IRQs clearing to
 exynos_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:25 +0200
Message-id: <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCmrm7F3odRBmd2CFpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsfX/NqaCpwIVDevPsjQw9vB1MXJwSAiYSFxbFtXFyMkhJLCDUeLyTakuRi4g+zuj
        xMTZ/xhBEiA1lx5PY4VIbGCUeHn+DxuE84tR4tGXa2wgVWwCVhIT21eBdYgIaEmcuLSdCaSI
        WWAOo8Ssht0sIAlhgXCJO4f3s4PYLAKqEk1H74M18Ap4SuydsJgdYp2cxMljk1lBbE6g+IUj
        TSwggyQE/rJKbGp/zwRR5CLRPH8vlC0s8er4FnaIf6QlLh21hahvZpT4tmMPM0TNBEaJPeuF
        IGxricPHL4ItYBbgk3j3tYcVopdXoqMNqsRD4mrLNWaIsKPE3vW8EA8D/dJ+9wXbBEapBYwM
        qxjFUguKc9NTiw0LjPSKE3OLS/PS9ZLzczcxguNPy2wH46JzPocYBTgYlXh4AxY+iBJiTSwr
        rsw9xCjBwawkwhvf+jBKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9TnzNRQgLpiSWp2ampBalF
        MFkmDk6pBsaolHsFQqbb2d7fexEpvzlmho/X1BtzVBrCJOY7ZLtE2P9h89aZtjPq/d/pZxfd
        2vajc/FajchN95Zrndomn8HM+9b9bbfd9uDyV46f5FmlJpWa/b/rLKLju6UogsdjYyYb8/en
        Mwy/L0jaLtdjd1dwusqx6LQSqcDTC79sK1n2U91INspJ85MSS3FGoqEWc1FxIgDIdvcUuwIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xoG7F3odRBtc9LTbOWM9qMf/KNVaL
        y7vmsFl87j3CaDHj/D4miycP+9gc2Dx2zrrL7rF4z0smj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4MrY+n8bU8FTgYqG9WdZGhh7+LoYOTkkBEwkLj2exgpiCwmsY5S48kehi5ELyP7FKLGs
        dw8zSIJNwEpiYvsqRhBbREBL4sSl7UwgRcwCcxglnq+YwwSSEBYIl7hzeD87iM0ioCrRdPQ+
        WAOvgKfE3gmL2SG2yUmcPDYZbBsnUPzCkSYWiM0eEvf73rNNYORZwMiwilEytaA4Nz232KjA
        MC+1XK84Mbe4NC9dLzk/dxMjMGC2Hdbq28F4f0n8IUYBDkYlHt6AhQ+ihFgTy4orcw8xSnAw
        K4nwxrc+jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB
        sZ9Jvy+z5lzu7DmTLM68i+96W/ZtuyDH75cbOxfXTZ1ws/3a93a9g9Ptr6yVKmYQn8HmduDb
        4gZuD86j03LWLzW8mWDYdXzHKcvjUa2+M1oU2v7oXuLzmbDDffNdYa6XNys37+13ivz2ZuF+
        OSkO7w1awq+POO5c7LTikqLTtC9Vz3IXv3v++YASS3FGoqEWc1FxIgDfndeHFAIAAA==
X-CMS-MailID: 20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552
X-RootMTR: 20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ->tmu_clear_irqs call from ->tmu_initialize method to
exynos_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1664d37..82484c5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -368,8 +368,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status)
 		ret = -EBUSY;
-	else
+	else {
 		data->tmu_initialize(pdev);
+		data->tmu_clear_irqs(data);
+	}
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
@@ -430,8 +432,6 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 		writeb(temp - reference, data->base +
 		       EXYNOS4210_TMU_REG_TRIG_LEVEL0 + i * 4);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
@@ -486,8 +486,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -571,8 +569,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 		falling_threshold |= (threshold_code << j * 8);
 		writel(falling_threshold, data->base + falling_reg_offset);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -635,8 +631,6 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 		writel(falling_threshold,
 		       data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
-- 
1.9.1
