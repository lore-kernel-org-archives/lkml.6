Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeDPKOJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14169 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeDPKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180416101404epoutp046abe507d098dd08ff12f17a9e68d1b0c~l4wFqzjXE0715307153epoutp04V
X-AuditID: b6c32a45-6d3ff70000000fe4-66-5ad4776bdb19
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 06/14] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
Date: Mon, 16 Apr 2018 12:11:57 +0200
Message-id: <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmmW52+ZUog0sLTSw2zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsErowNXRoFl6Uq2q4vZWpgPCPWxcjJISFg
        InFi4Td2EFtIYAejxN5+my5GLiD7O6PEvOW/mWGKjrVcYIRIbGCUOPrxBDOE84tR4t2KdjaQ
        KjYBK4mJ7asYQWwRAS2JE5e2M4EUMQtMYJJ4+momWJGwQI7EspcLwIpYBFQlLrR/YAGxeQU8
        JGbcvccCsU5O4uSxyawgNqeAp0TTmmtsIIMkBBawSdw5/50NoshFon11L9R9whKvjm9hh7Cl
        JZ6t2sgI0dDMKPFtxx6oogmMEnvWC0HY1hKHj18E28AswCfRcfgvUDMHUJxXoqMNqsRD4sTb
        78wQYUeJW290ID6ewyixeWkzywRGqQWMDKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3MYIj
        Vst1B+OMcz6HGAU4GJV4eHecvRwlxJpYVlyZe4hRgoNZSYR3WSJQiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG+D75koIYH0xJLU7NTUgtQimCwTB6dUA2PepDcfQ9n3Xtbs1CiQ1+H4dSjvyxxx
        7aDPzBmLdNRquaXamuOWl69fuWEej4LYIe8bJWcMvywQeFzAGOT3fd2LNoM5l/eujol8eGHb
        PHtxDZtt0QL/P/HJreiqtcnfyPq57+HtX5HzjO53GZ3037qEfZHooo0p73b4ti6X/s/X/qaA
        VVe3/JoSS3FGoqEWc1FxIgAguRfS1AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd3s8itRBivu8VpsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkbujQKLktVtF1fytTAeEasi5GTQ0LA
        ROJYywXGLkYuDiGBdYwSb2eeYYFwfjFKPN66hBWkik3ASmJi+ypGEFtEQEvixKXtTCBFzAIT
        mCSWrF3EDpIQFsiRWPZyAVgRi4CqxIX2DywgNq+Ah8SMu/dYINbJSZw8NhlsKKeAp0TTmmts
        ILYQUE3jxKuMExh5FjAyrGKUTC0ozk3PLTYqMMpLLdcrTswtLs1L10vOz93ECAyxbYe1+ncw
        Pl4Sf4hRgINRiYd3x9nLUUKsiWXFlbmHGCU4mJVEeJclAoV4UxIrq1KL8uOLSnNSiw8xSnOw
        KInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwzmnQ2Onj9rl23p37yupS1u6Ksw4ZFzNHO8T5
        pim8WcMe8/L06xhDi4PhBQZVcgGHdPknbHTIUttb+XtFaOWble+Wp2/cK7pvR9DLL61r9y6f
        sChywpI70zvfqRoUXd3YOiNJUWUTR37seeH5Dwq+a5WGBp41anzPcScuc7e44quSFb5B/wPT
        lFiKMxINtZiLihMBYJX9Ri0CAAA=
X-CMS-MailID: 20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937
X-RootMTR: 20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SoCs use the same values (25, 85) for trim points (except
Exynos5440 which currently specifices value 70 for the second trim
point -> it seems to be a mistake because documentation uses value
85 and two points based trimming has never been used by the driver
for this SoC anyway) so just make it explicit and remove parsing of
samsung,tmu_[first,second]_point_trim properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 20 +++++++++-----------
 drivers/thermal/samsung/exynos_tmu.h |  2 --
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 958a7c4..7ec8061 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -165,6 +165,9 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+#define EXYNOS_FIRST_POINT_TRIM			25
+#define EXYNOS_SECOND_POINT_TRIM		85
+
 #define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
@@ -251,11 +254,11 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 
 	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
-		return temp + data->temp_error1 - pdata->first_point_trim;
+		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 
-	return (temp - pdata->first_point_trim) *
+	return (temp - EXYNOS_FIRST_POINT_TRIM) *
 		(data->temp_error2 - data->temp_error1) /
-		(pdata->second_point_trim - pdata->first_point_trim) +
+		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
 		data->temp_error1;
 }
 
@@ -268,12 +271,12 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 
 	if (pdata->cal_type == TYPE_ONE_POINT_TRIMMING)
-		return temp_code - data->temp_error1 + pdata->first_point_trim;
+		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 
 	return (temp_code - data->temp_error1) *
-		(pdata->second_point_trim - pdata->first_point_trim) /
+		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
 		(data->temp_error2 - data->temp_error1) +
-		pdata->first_point_trim;
+		EXYNOS_FIRST_POINT_TRIM;
 }
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
@@ -1142,11 +1145,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	of_property_read_u32(np, "samsung,tmu_max_efuse_value",
 			     &pdata->max_efuse_value);
 
-	of_property_read_u32(np, "samsung,tmu_first_point_trim", &value);
-	pdata->first_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
-	pdata->second_point_trim = (u8)value;
-
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
 	of_node_put(np);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index a7e81b4..a5d8c9c 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -62,8 +62,6 @@ struct exynos_tmu_platform_data {
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
-	u8 first_point_trim;
-	u8 second_point_trim;
 
 	u32 cal_type;
 };
-- 
1.9.1
