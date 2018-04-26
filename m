Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756467AbeDZLyx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:54:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21400 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755410AbeDZLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426115239epoutp03f81e4533d3da0175ec2dc3f22c65d63f~o_jBqQ2WD2115421154epoutp03B
X-AuditID: b6c32a48-c49ff70000000fef-23-5ae1bd87229c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 16/18] thermal: exynos: cleanup code for enabling threshold
 interrupts
Date: Thu, 26 Apr 2018 13:51:31 +0200
Message-id: <1524743493-28113-17-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmhW773odRBr1TlC02zljPajH/yjVW
        i8u75rBZfO49wmgx4/w+JosnD/vYHNg8ds66y+6xeM9LJo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DK+DnrPVvBf72KtnOHWBoYd6p1MXJySAiYSEw4c4qli5GLQ0hgB6PE0R032CGc74wS
        07/fYOti5ACr2n8pACK+gVGif/9BqKJfjBIr2mezgoxiE7CSmNi+ihHEFhHQkjhxaTsTSBGz
        wBxGiVkNu1lAJgkLREh0HY0AqWERUJX48f0EM4jNK+ApcfD3PVaIk+QkTh6bDGZzAsUvHGkC
        O09CoJFNYmZ/P1SRi8Sbd2eZIWxhiVfHt7BD2NISz1ZtZIRoaGaU+LZjD1TRBEaJPeuFIGxr
        icPHL4INYhbgk+g4/Jcd4k1eiY42qBIPib2f50PtcpTovzyXCeJjoGd+Xr7BOIFRagEjwypG
        sdSC4tz01GKjAhO94sTc4tK8dL3k/NxNjOAY1PLYwXjgnM8hRgEORiUe3oCFD6KEWBPLiitz
        DzFKcDArifDGtz6MEuJNSaysSi3Kjy8qzUktPsQozcGiJM7b4HsmSkggPbEkNTs1tSC1CCbL
        xMEp1cDIoXfvj9L3Ga4ygbVuZuu/ZDfuDlS1T2HYsV3i9gwdhnidPctYlJ2eTLeUU6i+78Jz
        dW9OksutlcEbg4vLfW6cTuo0XXjbXHmJ8esHyhmLXVILSl/oeH3UfKQ7cdHuJRzXpthoPz+e
        81bg9fSp6gtO1j28LCxu+HzZhJdz9tvsYrug+OtK7mxvJZbijERDLeai4kQAGlHRYL0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42I5/e+xoG773odRBo/+cFlsnLGe1WL+lWus
        Fpd3zWGz+Nx7hNFixvl9TBZPHvaxObB57Jx1l91j8Z6XTB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CV8XPWe7aC/3oVbecOsTQw7lTrYuTgkBAwkdh/KaCLkZNDSGAdo0TTC5MuRi4g+xej
        xONJy1hAEmwCVhIT21cxgtgiAloSJy5tZwIpYhaYwyjxfMUcJpBBwgIREl1HI0BqWARUJX58
        P8EMYvMKeEoc/H2PFcSWEJCTOHlsMpjNCRS/cKSJBWKxh8T9vvdsExh5FjAyrGKUTC0ozk3P
        LTYqMMpLLdcrTswtLs1L10vOz93ECAyXbYe1+ncwPl4Sf4hRgINRiYc3YOGDKCHWxLLiytxD
        jBIczEoivPGtD6OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJx
        cEo1MHIvZc2xuzrbXSd1xf7P9asD16Wsdrm249F9Q+/eTpXES7busVtNZpiJVsxtSvT1XbKR
        5/WKpwcf1jfden5hTc36T994BHfHHt41xyIl7fosy5qmxWe8V/akcsfL+FZdSEgMCih4qTfx
        huQp5tPmqy8s21S3lM3DwXrZ/FLvhmVXjb4yRToJXlZiKc5INNRiLipOBAAMagPAEwIAAA==
X-CMS-MailID: 20180426115239epcas2p2dc72353efa8375b7f70a41c570fba789
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115239epcas2p2dc72353efa8375b7f70a41c570fba789
X-RootMTR: 20180426115239epcas2p2dc72353efa8375b7f70a41c570fba789
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115239epcas2p2dc72353efa8375b7f70a41c570fba789@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup code for enabling threshold interrupts in ->tmu_control
method implementations.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 101 ++++++++++++-----------------------
 1 file changed, 34 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index abe0737..9639acf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -76,9 +76,6 @@
 #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
 
 #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
-#define EXYNOS_TMU_INTEN_RISE2_SHIFT	8
-#define EXYNOS_TMU_INTEN_RISE3_SHIFT	12
 #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
 
 #define EXYNOS_EMUL_TIME	0x57F0
@@ -136,13 +133,6 @@
 #define EXYNOS7_TMU_TEMP_MASK			0x1ff
 #define EXYNOS7_PD_DET_EN_SHIFT			23
 #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
-#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
-#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
-#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
-#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
-#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
-#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
-#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
@@ -615,29 +605,27 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
+	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 3)
-			 << EXYNOS_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			 << EXYNOS_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			 << EXYNOS_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			 << EXYNOS_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
+		}
 
 		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-	} else {
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+	} else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
+
 	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
@@ -646,36 +634,25 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en, pd_det_en;
+	unsigned int con, interrupt_en = 0, pd_det_en, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 7)
-			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 6)
-			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 5)
-			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 4)
-			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 3)
-			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-	} else {
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+	} else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
@@ -688,37 +665,27 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
+	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 7)
-			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 6)
-			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 5)
-			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 4)
-			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 3)
-			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
 	}
 
 	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
-- 
1.9.1
