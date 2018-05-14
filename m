Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeENLn1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:60256 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeENLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180514114319epoutp031c7a8e124f9a215cd3ce325c9f5d9441~ugCBNIUyo1742717427epoutp03W
X-AuditID: b6c32a39-8bdff70000000fed-c1-5af976572f43
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 04/14] thermal: ti-soc-thermal: cleanup COUNTER feature
 handling for OMAP5
Date: Mon, 14 May 2018 13:42:11 +0200
Message-id: <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmvm542c8ogzOXNCw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroy+tWeZC14LV7Reu8/SwLhYsIuRk0NCwETixMOX7F2MXBxCAjsY
        JZauPs0C4XxnlOj5f5O1i5EDrOrbTj+I+G5Gif53K9kgnF+MEtfunmYHGcUmYCUxsX0VI4gt
        IuAmMWvJHzCbWWAqo8SmCfUgtrBAjMTMK0/ZQGwWAVWJNWemg/XyCnhIvJ3eywpxkpzEyWOT
        wWxOAU+JDe0vwZZJCExgk5i79gsjRJGLxMJNn5kgbGGJV8e3sENcKi1x6agtRH0zo8S3HXuY
        IWomMErsWS8EYVtLHD5+kRXiOD6Jd197oL7klehogyrxkHh/upMNwnaUeH5mG9TDcxgljtw9
        zTSBUWoBI8MqRrHUguLc9NRiwwJTveLE3OLSvHS95PzcTYzgqNSy3MF47JzPIUYBDkYlHt6A
        5T+ihFgTy4orcw8xSnAwK4nw7jb6GSXEm5JYWZValB9fVJqTWnyIUZqDRUmcd47S1yghgfTE
        ktTs1NSC1CKYLBMHp1QDY9r7aAHmrB1J51+42s54sfb0JY8/d/XZXe4+CP8mrrOowS63xveb
        r4P11akHS2fIzVW+zOF23phptlUPz+Rrf1at39WctWdFAWt5bOTn2VZOTp9v3FWWeB8st4ut
        Pddm05cdmVGLJm/85bJ875b7RV7ee54GvfZ9P3FiTtOyy60/ed9+UG7wT1BiKc5INNRiLipO
        BABgLWecxgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xgG542c8og+2bpCw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroy+tWeZC14LV7Reu8/SwLhYsIuRg0NCwETi206/LkYuDiGBnYwS
        u78fZoNwfjFKdLbsYu9i5ORgE7CSmNi+ihHEFhFwk5i15A8jSBGzwFRGicmfTrGBJIQFYiRm
        XnkKZrMIqEqsOTMdrJlXwEPi7fReVhBbQkBO4uSxyWA2p4CnxIb2l2D1QkA1t3+3sE1g5FnA
        yLCKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwjLYd1urbwXh/SfwhRgEORiUe3hUr
        f0QJsSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGyAnLAl4XvFsQuj/+xQcnD/YTrDv77wWZhgl8kTrc8NhS5sf/CeE6
        e+bc2/Rux47Lkul7f09qXF9YNWf9tt+7nKc67+r4tk2ocrPt21zTeU33Lq5fr61xVXDhlpev
        XRx11zn9k5pwzOix5/qS1C3tsnGuOWuzMrIf8ThO8zaUFzm8+JaYxVujBCWW4oxEQy3mouJE
        AOuUJB4fAgAA
X-CMS-MailID: 20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5
X-RootMTR: 20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP5 sensors don't claim COUNTER feature support (they use
COUNTER_DELAY feature instead) so there is no need to set fields
of struct temp_sensor_registers which are only used for COUNTER
feature.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c | 9 ---------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 8191bae..e384be1 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -41,9 +41,6 @@
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
 
-	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
-	.counter_mask = OMAP5430_COUNTER_MASK,
-
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
 	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
 	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
@@ -77,9 +74,6 @@
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
 
-	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
-	.counter_mask = OMAP5430_COUNTER_MASK,
-
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
 	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
 	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
@@ -114,9 +108,6 @@
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
 
-	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
-	.counter_mask = OMAP5430_COUNTER_MASK,
-
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
 	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
 	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index dcbf903..223c7a8 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -93,9 +93,6 @@
 #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
 #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
 
-/* OMAP5430.BANDGAP_COUNTER */
-#define OMAP5430_COUNTER_MASK				(0xffffff << 0)
-
 /* OMAP5430.BANDGAP_THRESHOLD */
 #define OMAP5430_T_HOT_MASK				(0x3ff << 16)
 #define OMAP5430_T_COLD_MASK				(0x3ff << 0)
-- 
1.9.1
