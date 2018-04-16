Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeDPKRU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:17:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31951 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeDPKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:13:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180416101354epoutp035fc0ed6187574d839561ff54afa17a93~l4v864q6B1184411844epoutp03f
X-AuditID: b6c32a45-6d3ff70000000fe4-3a-5ad4776299b2
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 03/14] thermal: exynos: Read soc_type from match data
Date: Mon, 16 Apr 2018 12:11:54 +0200
Message-id: <1523873525-23718-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCmqW5S+ZUog4Nz2S02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WCl7dYLJ487GNz4PLYOesuu8fiPS+Z
        PDat6mTzuHNtD5tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZTTt+s9cMFWxYuXNiYwNjItl
        uhg5OSQETCRu9zUzdTFycQgJ7GCUeHVpMiuE851RYubMNWwwVTdWgdggiQ2MEj8XrGeHcH4x
        Sjz+fowdpIpNwEpiYvsqRhBbREBL4sSl7WBzmQV2MElMvDadGSQhLOAq0X/0NVgRi4CqRPf5
        FrA4r4CHxLT/X1kg1slJnDwGcgcnB6eAp0TTmmtgqyUEVrBJfDn7B6iBA8hxkeg7pApRLyzx
        6vgWdghbWuLZqo2MEPXNjBLfduxhhkhMYJTYs14IwraWOHz8ItgCZgE+iY7Df9khZvJKdLRB
        lXhI3DkzkRXCdpQ4v3AhC8THcxgl9q08xzaBUWoBI8MqRrHUguLc9NRiowJDveLE3OLSvHS9
        5PzcTYzg+NVy3cE445zPIUYBDkYlHt4dZy9HCbEmlhVX5h5ilOBgVhLhXZYIFOJNSaysSi3K
        jy8qzUktPsQozcGiJM7b4HsmSkggPbEkNTs1tSC1CCbLxMEp1cCotOQxH29m31WGukXaxRoX
        Bd+n7nfz/fm7WaieVWlJ+XbFMzbpviycFofWFc69PfVP9rYpYdNzFjUvVT2pfFOPqVx1X9wW
        l6rNcaGf5nFPE74h8Ge/3BG2Ewsdbs/deWu5glGdUNjiKUdkkxrK3fn2Ck6vL7/OsMPBXLdx
        V3/seo55lxpWvXyixFKckWioxVxUnAgAtIOlUtsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t9jQd3E8itRBt2nDSw2zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WCl7dYLJ487GNz4PLYOesuu8fiPS+Z
        PDat6mTzuHNtD5tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZTTt+s9cMFWxYuXNiYwNjItl
        uhg5OSQETCRurFrD1sXIxSEksI5RYtqqF+wgCSGBX4wSl7Y7gthsAlYSE9tXMYLYIgJaEicu
        bWcCaWAW2MEk8fL8HWaQhLCAq0T/0ddgRSwCqhLd51vA4rwCHhLT/n9lgdgmJ3Hy2GRWEJtT
        wFOiac01NohlHhKNE68yTmDkWcDIsIpRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzDY
        th3W6t/B+HhJ/CFGAQ5GJR7eHWcvRwmxJpYVV+YeYpTgYFYS4V2WCBTiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAKJnj6fiKU7ZXxcpS6dm7nRsnvJY/
        slneaNeyK9weVusErvTleb36V2T3sfxXykS1bP7+OZ/fhluvn39Il9v5d42Ssnvu6R/Xl5s8
        8r75eRl3nobRuiuTryyxnHXsZ9KCVdlvu67U3zlzaaLJg6S/2tnGxf5bl75O9ZD+cthfv2SG
        2ZrOv9liM5RYijMSDbWYi4oTAURSFM8yAgAA
X-CMS-MailID: 20180416101353epcas2p1793d6079b1a1fbb8b4841ee562b22155
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101353epcas2p1793d6079b1a1fbb8b4841ee562b22155
X-RootMTR: 20180416101353epcas2p1793d6079b1a1fbb8b4841ee562b22155
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101353epcas2p1793d6079b1a1fbb8b4841ee562b22155@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Purski <m.purski@samsung.com>

Device context's field data->soc is currently obtained by comparing
of_compatible's. Provide soc_type as .data field in device's match
table, as it is done in most drivers.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 74 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ac83f72..d7a3c3c 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -29,7 +29,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -1105,47 +1105,41 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
-	{ .compatible = "samsung,exynos3250-tmu", },
-	{ .compatible = "samsung,exynos4210-tmu", },
-	{ .compatible = "samsung,exynos4412-tmu", },
-	{ .compatible = "samsung,exynos5250-tmu", },
-	{ .compatible = "samsung,exynos5260-tmu", },
-	{ .compatible = "samsung,exynos5420-tmu", },
-	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
-	{ .compatible = "samsung,exynos5433-tmu", },
-	{ .compatible = "samsung,exynos5440-tmu", },
-	{ .compatible = "samsung,exynos7-tmu", },
-	{ /* sentinel */ },
+	{
+		.compatible = "samsung,exynos3250-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS3250,
+	}, {
+		.compatible = "samsung,exynos4210-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS4210,
+	}, {
+		.compatible = "samsung,exynos4412-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS4412,
+	}, {
+		.compatible = "samsung,exynos5250-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5250,
+	}, {
+		.compatible = "samsung,exynos5260-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5260,
+	}, {
+		.compatible = "samsung,exynos5420-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5420,
+	}, {
+		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
+		.data = (const void *)SOC_ARCH_EXYNOS5420_TRIMINFO,
+	}, {
+		.compatible = "samsung,exynos5433-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5433,
+	}, {
+		.compatible = "samsung,exynos5440-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5440,
+	}, {
+		.compatible = "samsung,exynos7-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS7,
+	},
+	{ },
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
 
-static int exynos_of_get_soc_type(struct device_node *np)
-{
-	if (of_device_is_compatible(np, "samsung,exynos3250-tmu"))
-		return SOC_ARCH_EXYNOS3250;
-	else if (of_device_is_compatible(np, "samsung,exynos4210-tmu"))
-		return SOC_ARCH_EXYNOS4210;
-	else if (of_device_is_compatible(np, "samsung,exynos4412-tmu"))
-		return SOC_ARCH_EXYNOS4412;
-	else if (of_device_is_compatible(np, "samsung,exynos5250-tmu"))
-		return SOC_ARCH_EXYNOS5250;
-	else if (of_device_is_compatible(np, "samsung,exynos5260-tmu"))
-		return SOC_ARCH_EXYNOS5260;
-	else if (of_device_is_compatible(np, "samsung,exynos5420-tmu"))
-		return SOC_ARCH_EXYNOS5420;
-	else if (of_device_is_compatible(np,
-					 "samsung,exynos5420-tmu-ext-triminfo"))
-		return SOC_ARCH_EXYNOS5420_TRIMINFO;
-	else if (of_device_is_compatible(np, "samsung,exynos5433-tmu"))
-		return SOC_ARCH_EXYNOS5433;
-	else if (of_device_is_compatible(np, "samsung,exynos5440-tmu"))
-		return SOC_ARCH_EXYNOS5440;
-	else if (of_device_is_compatible(np, "samsung,exynos7-tmu"))
-		return SOC_ARCH_EXYNOS7;
-
-	return -EINVAL;
-}
-
 static int exynos_of_sensor_conf(struct device_node *np,
 				 struct exynos_tmu_platform_data *pdata)
 {
@@ -1219,7 +1213,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
 	data->pdata = pdata;
-	data->soc = exynos_of_get_soc_type(pdev->dev.of_node);
+	data->soc = (enum soc_type)of_device_get_match_data(&pdev->dev);
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
-- 
1.9.1
