Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbeDZLwS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48290 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755522AbeDZLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:10 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426115208epoutp019758419aa89013bf9015d5478ccf9895~o_ikWA0Js0232602326epoutp01Q
X-AuditID: b6c32a38-6f7ff7000000105c-88-5ae1bd66c927
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Thu, 26 Apr 2018 13:51:18 +0200
Message-id: <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmrm7a3odRBkem2VhsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWtjD0vBUYGK793VDYw7eLsYOTkkBEwk5tz6ztbFyMUhJLCDUaLz9wdmCOc7o0T3
        xQ8sMFW/TzZBVW1glFj/v4cJwvnFKDH5fTcrSBWbgJXExPZVjCC2iICWxIlL28GKmAXmMErM
        atgNNkpYIFLiwOb7YEUsAqoSd269BLN5BTwk5rf+ZYZYJydx8thksKGcAp4SF440sYAMkhD4
        ySpxt+sIUAMHkOMicfmTGkS9sMSr41vYIcLSEpeO2kKUNzNKfNuxB2rmBEaJPeuFIGxricPH
        L4LNZxbgk3j3tYcVopdXoqMNqsRD4sS1bWwQtqPEgVczGCEeBvrlxIpJrBMYpRYwMqxiFEst
        KM5NTy02LDDRK07MLS7NS9dLzs/dxAiOQC2LHYx7zvkcYhTgYFTi4Q1Y+CBKiDWxrLgy9xCj
        BAezkghvfOvDKCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T33ORAkJpCeWpGanphakFsFkmTg4
        pRoYS5bHP9hz4MGMLXWOUw/96VP8kSouO0/iVuCMWSWyv5x4tx2V7Y14LW0l9PHNMjlzV9Vt
        sUk8cg8Z3/IIV1f7brg0wXZ1eFxJSstz3gffb/uIFVerf/6x7clN0azGL7/PmESu3HKwxmLu
        C+ULP6ZcuLeYi7eq9+Lu3KleuyqSW49LPt3dwvV+sxJLcUaioRZzUXEiAGEOfJK8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoG7a3odRBq9+qFpsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVcWtjD0vBUYGK793VDYw7eLsYOTkkBEwkfp9sYuti5OIQEljHKNHQfw3K+cUosfDK
        CUaQKjYBK4mJ7avAbBEBLYkTl7YzgRQxC8xhlHi+Yg4TSEJYIFJiw/V7YDaLgKrEnVsvwRp4
        BTwk5rf+ZYZYJydx8thkVhCbU8BT4sKRJhYQWwio5n7fe7YJjDwLGBlWMUqmFhTnpucWGxUY
        5qWW6xUn5haX5qXrJefnbmIEhsy2w1p9OxjvL4k/xCjAwajEwxuw8EGUEGtiWXFl7iFGCQ5m
        JRHe+NaHUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUw
        Llp1VVZW+YPdREfJUC3NrM41Wbu4xdTXL3z+YsuHd7eV1G6aFmilLlaM+nlC3++B2F6t25HL
        crRiWX1k0t3eKr5N433nFhr4vdzm7cs/1S/O8i7aZ8c5d7vmups3zdfpfjObrnJCLkfLtMva
        P2OTfVjMz+3Zs7PuTZ87Ty/p37OZUWHvCxa8V2Ipzkg01GIuKk4EAKMaNR4VAgAA
X-CMS-MailID: 20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d
X-RootMTR: 20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Check for critical trip point existence in exynos_tmu_initialize()
  so it is checked on all SoCs (except Exynos5433 for now).

* Use dev_err() instead of pr_err().

* Fix dev_err() to reference "device tree" not "of-thermal.c".

* Remove no longer needed check from exynos4412_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9e040eb..a0c1604 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -331,7 +331,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	struct thermal_zone_device *tzd = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tzd);
-	int ret;
+	int ret = 0, temp;
 
 	if (!trips) {
 		dev_err(&pdev->dev,
@@ -339,6 +339,14 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
+		ret = tzd->ops->get_crit_temp(tzd, &temp);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"No CRITICAL trip point defined in device tree!\n");
+		goto out;
+	}
+
 	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
@@ -356,7 +364,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
-
+out:
 	return ret;
 }
 
@@ -480,13 +488,6 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 		}
 	}
 
-	if (i == of_thermal_get_ntrips(data->tzd)) {
-		pr_err("%s: No CRITICAL trip point defined at of-thermal.c!\n",
-		       __func__);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
 	/* 1-4 level to be assigned in th0 reg */
 	rising_threshold &= ~(0xff << 8 * i);
-- 
1.9.1
