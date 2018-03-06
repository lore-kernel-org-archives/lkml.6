Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbeCFOou (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:44:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63080 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180306144441epoutp0421b06723c1523e4e2cb62a51895bebdb~ZW-q9Eler1173611736epoutp04Q
X-AuditID: b6c32a45-3ebff70000001023-da-5a9ea959e3dc
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 03/12] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
Date: Tue, 06 Mar 2018 15:43:46 +0100
Message-id: <1520347435-22970-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmuW7kynlRBrfms1tsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZXzYt52l4KZUxasLC1gaGLeKdTFyckgImEjM2jmHtYuRi0NIYAejxLqda5lBEkIC
        3xkllvSqwBS9WLONBSK+m1FiRWcCRMMvRomPH9YzgSTYBKwkJravYgSxRQRKJKat6mUEKWIW
        OMsksWP7O7BuYYEciemz2tlBbBYBVYkd7zvA4rwCHhIrrk9ggtgmJ3Hy2GRWEJtTwFPiRMc5
        NpBBEgIn2CQuf9zNDlHkInGmfzILhC0s8er4Fqi4tMSzVRsZIRqaGSW+7djDDJGYwCixZ70Q
        hG0tcfj4RbANzAJ8Eh2H/wI1cwDFeSU62qBKPCRmXmphhLAdJTonn2KGeHkOo8Sl+R+YJjBK
        LWBkWMUollpQnJueWmxUYKhXnJhbXJqXrpecn7uJERzvWq47GGec8znEKMDBqMTDu8FjbpQQ
        a2JZcWXuIUYJDmYlEd4I/XlRQrwpiZVVqUX58UWlOanFhxilOViUxHnbAlyihATSE0tSs1NT
        C1KLYLJMHJxSDYx1np2ppy3E28r8Vl6RLrWe7uV5Qlnk04b5N0IPuqjwG5vfcp1xh38O4/9N
        1RtDmxqvl67SbPhjtcTr0vXai/OMbk8wyC/eah7yYfnrheo/2BSzr834MdPZQPzJzNLtE1wn
        JXVLdU57Nkv4dcm9d+m7p+Z0rOVdPedZzb+SCCuDp5U63WWTtt1VYinOSDTUYi4qTgQAc5ky
        6vMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAd2IlfOiDM4sVrDYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyviwbztLwU2pilcXFrA0MG4V62Lk5JAQMJF4sWYbSxcjF4eQwE5Gif8nTjNDOL8Y
        JW40rWQDqWITsJKY2L6KEcQWESiR6Jz2mhnEZhY4yyRx8D8HiC0skCMxfVY7O4jNIqAqseN9
        BwuIzSvgIbHi+gQmiG1yEiePTWYFsTkFPCVOdJwDmy8EVLO4+zfbBEaeBYwMqxglUwuKc9Nz
        i40KjPJSy/WKE3OLS/PS9ZLzczcxAsNz22Gt/h2Mj5fEH2IU4GBU4uHd4DE3Sog1say4MvcQ
        owQHs5IIb4T+vCgh3pTEyqrUovz4otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwc
        nFINjIqcVlVTfboPz3vDFsKkU/PrdbKWd/Dd4leGvl8jEu/kF0VVPNmym8siZpK+9AXrwzKC
        a4Vb3l3izpk9RfJciUnOmcdTs0MO5ew7v1N457Nb0v7ML/PZX1olnGaU/2dzXjhuZ0uAqUX1
        07pVMxw7dSYz9TcKB5+xmzbb4L/pAbmd8Q4ciXWrlViKMxINtZiLihMBUvrv1EsCAAA=
X-CMS-MailID: 20180306144440epcas2p30fd2531c12454051bfe6ae0cf0d35b2e
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144440epcas2p30fd2531c12454051bfe6ae0cf0d35b2e
X-RootMTR: 20180306144440epcas2p30fd2531c12454051bfe6ae0cf0d35b2e
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144440epcas2p30fd2531c12454051bfe6ae0cf0d35b2e@epcas2p3.samsung.com>
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
index e42a08b..5877dd4 100644
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
@@ -251,13 +254,13 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
-		temp_code = (temp - pdata->first_point_trim) *
+		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
 			(data->temp_error2 - data->temp_error1) /
-			(pdata->second_point_trim - pdata->first_point_trim) +
+			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
 			data->temp_error1;
 		break;
 	case TYPE_ONE_POINT_TRIMMING:
-		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
+		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 		break;
 	default:
 		WARN_ON(1);
@@ -279,12 +282,12 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp = (temp_code - data->temp_error1) *
-			(pdata->second_point_trim - pdata->first_point_trim) /
+			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
 			(data->temp_error2 - data->temp_error1) +
-			pdata->first_point_trim;
+			EXYNOS_FIRST_POINT_TRIM;
 		break;
 	case TYPE_ONE_POINT_TRIMMING:
-		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
+		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 		break;
 	default:
 		WARN_ON(1);
@@ -1160,11 +1163,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
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
