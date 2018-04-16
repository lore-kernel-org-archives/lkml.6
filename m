Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeDPKRB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:17:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61744 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753823AbeDPKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180416101400epoutp01ef6aa6ace837884ef9abaac3c9cb5384~l4wCs8UUt2798927989epoutp014
X-AuditID: b6c32a36-f6fff70000000fc2-a3-5ad47768eb13
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 05/14] thermal: exynos: remove parsing of
 samsung,tmu_default_temp_offset property
Date: Mon, 16 Apr 2018 12:11:56 +0200
Message-id: <1523873525-23718-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCmgW5G+ZUogw9/BC02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroz2byfYCl7LVzQ2RTYwvpfqYuTkkBAw
        kVh36zpzFyMXh5DADkaJFxcWM0E43xkl5h4+wwxT9eNoDztEYgOjxOVzEAkhgV+MEltfFIHY
        bAJWEhPbVzGC2CICWhInLm0Hm8QsMIFJ4umrmWwgCWGBFIkv23tZQWwWAVWJdY0PWEBsXgEP
        id4P7WwQ2+QkTh6bDFbDKeAp0bTmGhvIIAmBBWwS7RNOAzkcQI6LxO8tURD1whKvjm9hhwhL
        S1w6agtR3swo8W3HHqgPJjBK7FkvBGFbSxw+fhFsPrMAn8S7rz2sEL28Eh1tQhCmh8TfPZEQ
        1Y4Sy/buZ4X4fQ6jxLzD7cwTGKUWMDKsYhRLLSjOTU8tNiww0itOzC0uzUvXS87P3cQIjlYt
        sx2Mi875HGIU4GBU4uHdcfZylBBrYllxZe4hRgkOZiUR3mWJQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8T33ORAkJpCeWpGanphakFsFkmTg4pRoYtVwUdfYVu/073fPw8H6zab55XufvP/kW
        8Y6BqV78g6W96o4WP/25J7Pk91xfe69p9nensm01wZ/mxa/V3PxhusPH97NrjIQlg0NtFELe
        PfR6usZ72uMnb79bHiozqBGVtYlWznb7y2Iy4Rurlv5Dril5xnstOqPUvVpOB5mv+70z63bx
        f4spSizFGYmGWsxFxYkAnP9k1dICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd2M8itRBtdesFpsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBnt306wFbyWr2hsimxgfC/VxcjJISFg
        IvHjaA97FyMXh5DAOkaJs+sWQzm/GCUWzu1hA6liE7CSmNi+ihHEFhHQkjhxaTsTSBGzwAQm
        iSVrF7GDJIQFUiS+bO9lBbFZBFQl1jU+YAGxeQU8JHo/tLNBrJOTOHlsMlgNp4CnRNOaa2Bx
        IaCaxolXGScw8ixgZFjFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYYtsOa/XtYLy/
        JP4QowAHoxIP746zl6OEWBPLiitzDzFKcDArifAuSwQK8aYkVlalFuXHF5XmpBYfYpTmYFES
        572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDj9ulXk48V5L/OFxY94rXebsnDT4yrZX40PlIuK
        bWRFdyUcveyll5vcfuId051Y3VMTCibomV7aHZt3rI7/hO32Mz9Ps6Suef/vM7fUhmMcG5W2
        V/bzr/wXv+yzuCu/sHZG6Ww/01dten/1xN5enTp9I7NRc4DdnPZu4xsPRXQk8nrfGX4NjlRi
        Kc5INNRiLipOBACqAvH4LQIAAA==
X-CMS-MailID: 20180416101400epcas1p45e65b37b922a5d0265de7879eeb1df87
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101400epcas1p45e65b37b922a5d0265de7879eeb1df87
X-RootMTR: 20180416101400epcas1p45e65b37b922a5d0265de7879eeb1df87
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101400epcas1p45e65b37b922a5d0265de7879eeb1df87@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming (one point based or two points based) is always used for
the temperature calibration and the default non-trimming code is
never reached. Remove it and then remove no longer needed parsing
of samsung,tmu_default_temp_offset property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 48 ++++++++++--------------------------
 drivers/thermal/samsung/exynos_tmu.h |  2 --
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d7a3c3c..958a7c4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -249,24 +249,14 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
-	int temp_code;
-
-	switch (pdata->cal_type) {
-	case TYPE_TWO_POINT_TRIMMING:
-		temp_code = (temp - pdata->first_point_trim) *
-			(data->temp_error2 - data->temp_error1) /
-			(pdata->second_point_trim - pdata->first_point_trim) +
-			data->temp_error1;
-		break;
-	case TYPE_ONE_POINT_TRIMMING:
-		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
-		break;
-	default:
-		temp_code = temp + pdata->default_temp_offset;
-		break;
-	}
 
-	return temp_code;
+	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+		return temp + data->temp_error1 - pdata->first_point_trim;
+
+	return (temp - pdata->first_point_trim) *
+		(data->temp_error2 - data->temp_error1) /
+		(pdata->second_point_trim - pdata->first_point_trim) +
+		data->temp_error1;
 }
 
 /*
@@ -276,24 +266,14 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
-	int temp;
 
-	switch (pdata->cal_type) {
-	case TYPE_TWO_POINT_TRIMMING:
-		temp = (temp_code - data->temp_error1) *
-			(pdata->second_point_trim - pdata->first_point_trim) /
-			(data->temp_error2 - data->temp_error1) +
-			pdata->first_point_trim;
-		break;
-	case TYPE_ONE_POINT_TRIMMING:
-		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
-		break;
-	default:
-		temp = temp_code - pdata->default_temp_offset;
-		break;
-	}
+	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
+		return temp_code - data->temp_error1 + pdata->first_point_trim;
 
-	return temp;
+	return (temp_code - data->temp_error1) *
+		(pdata->second_point_trim - pdata->first_point_trim) /
+		(data->temp_error2 - data->temp_error1) +
+		pdata->first_point_trim;
 }
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
@@ -1166,8 +1146,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->first_point_trim = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
 	pdata->second_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_default_temp_offset", &value);
-	pdata->default_temp_offset = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 8c468b6..a7e81b4 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -50,7 +50,6 @@ enum soc_type {
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
- * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
@@ -65,7 +64,6 @@ struct exynos_tmu_platform_data {
 	u32 max_efuse_value;
 	u8 first_point_trim;
 	u8 second_point_trim;
-	u8 default_temp_offset;
 
 	u32 cal_type;
 };
-- 
1.9.1
