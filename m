Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEBLE0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:04:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44433 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEBLEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:04:21 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502110418euoutp02540c5883c74b0bd09fab07edb83f4c8a~qzwhoPz432683926839euoutp02U
X-AuditID: cbfec7f4-6f9ff700000043e4-47-5ae99b312e4a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/18] thermal: exynos: cleanup code for enabling
 threshold interrupts
Date: Wed, 02 May 2018 13:04:16 +0200
Message-id: <3056898.TmvD5ep5ug@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <17338828.V5XOYeIB5l@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87qGs19GGXR021jM+yxrMf/KNVaL
        y7vmsFl87j3CaDHj/D4miycP+9gc2Dx2zrrL7rF4z0smjzvX9rB5fN4kF8ASxWWTkpqTWZZa
        pG+XwJXReEKmoM2j4vakDcwNjHusuhg5OSQETCSWP+9m72Lk4hASWMEo8bfxIhOE85lR4vex
        dewwVfcfnYSqWsYo8X3xV0YI5zejxNH5D1hBqtgErCQmtq9iBLFFBPQkGt+3gY1iFljFKNH/
        6R0TSEJYIEbiyNV3QEUcHCwCqhLr9xWBhHkFNCVWTZ3EAmKLCnhJbNnXDlbOKaAtMfXFLiaI
        GkGJH5PvgdUwC8hL7Ns/lRXC1pE4e2wdI8Sla9gkpuyoBhkvIeAicf2sM0RYWOLV8S1Qz8hI
        XJ7czQJymoRAM6PEtx17mCESExgl9qwXgrCtJQ4fvwg1n09i0rbpzBAzeSU62qBKPCTuvT4O
        1eoo8fDzSzZImNxilHh44zrTBEbZWUjOnoXk7FlIzl7AyLyKUTy1tDg3PbXYKC+1XK84Mbe4
        NC9dLzk/dxMjMB2c/nf8yw7GXX+SDjEKcDAq8fAa5L2IEmJNLCuuzD3EKMHBrCTCu7LjWZQQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3jiNuighgfTEktTs1NSC1CKYLBMHp1QDY6vqkjW3guft
        vZJtvqTNY/aT9R4Myx+IJ+RuEY52Dw50Li77VZjW+5yx+ceaX5NK2rxdtqQFbEm4KOeUNU8j
        R2pTEEPur07mn2erbPbNkP0bzfhTeFp79hrmWunZJtc6InayrJyxtX3O7+ezXEK//UoQ8Q+w
        d2Nrufx/zuuks8p9vvwaUzP9lViKMxINtZiLihMBqWArrAMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xy7qGs19GGczfJ2cx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAldG4wmZgjaPituTNjA3MO6x6mLk5JAQMJG4/+gkexcjF4eQwBJGiZtTj7NAOH8ZJfb0
        dbGCVLEJWElMbF/FCGKLCOhJNL5vYwIpYhZYxSixsrWXGSQhLBAjcXXyHKAiDg4WAVWJ9fuK
        QMK8ApoSq6ZOYgGxRQW8JLbsa2cCsTkFtCWmvtjFBLGsjVHiV/8xNogGQYkfk++BNTALyEvs
        2z+VFcLWkli/8zjTBEb+WUjKZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA
        sN127OeWHYxd74IPMQpwMCrx8BrkvYgSYk0sK67MPcQowcGsJMK7suNZlBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGzjC/WGbJ1/L3StmND+T9KXcK
        V/VutSlxSTvVOvFih3uzxf6e9V77zvz7E3nmTfEM1SNn1K6wXhEwSDj1T6LAcE1YQa33scoZ
        BW/sHFUsRdaFZV88Is6yMj1/noOkz+HU9Wkl/+PKw0uM32zYfvbhBdFO/fnlV7VcF3JPf7eu
        vUor1LnvmoESS3FGoqEWc1FxIgD8hq+xVwIAAA==
X-CMS-MailID: 20180502110417eucas1p172aa0b68b5719dbebd2ed02baaf6a10a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502110417eucas1p172aa0b68b5719dbebd2ed02baaf6a10a
X-RootMTR: 20180502110417eucas1p172aa0b68b5719dbebd2ed02baaf6a10a
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <20180501110239.GM27619@mai> <17338828.V5XOYeIB5l@amdc3058>
        <CGME20180502110417eucas1p172aa0b68b5719dbebd2ed02baaf6a10a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 02, 2018 12:03:44 PM Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, May 01, 2018 01:02:39 PM Daniel Lezcano wrote:
> > On Thu, Apr 26, 2018 at 01:51:31PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Cleanup code for enabling threshold interrupts in ->tmu_control
> > > method implementations.
> > > 
> > > There should be no functional changes caused by this patch.
> > > 
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > ---
> > >  drivers/thermal/samsung/exynos_tmu.c | 101 ++++++++++++-----------------------
> > >  1 file changed, 34 insertions(+), 67 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > > index abe0737..9639acf 100644
> > > --- a/drivers/thermal/samsung/exynos_tmu.c
> > > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > > @@ -76,9 +76,6 @@
> > >  #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
> > >  
> > >  #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
> > > -#define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
> > > -#define EXYNOS_TMU_INTEN_RISE2_SHIFT	8
> > > -#define EXYNOS_TMU_INTEN_RISE3_SHIFT	12
> > >  #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
> > >  
> > >  #define EXYNOS_EMUL_TIME	0x57F0
> > > @@ -136,13 +133,6 @@
> > >  #define EXYNOS7_TMU_TEMP_MASK			0x1ff
> > >  #define EXYNOS7_PD_DET_EN_SHIFT			23
> > >  #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
> > > -#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
> > > -#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
> > > -#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
> > > -#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
> > > -#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
> > > -#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
> > > -#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
> > >  #define EXYNOS7_EMUL_DATA_SHIFT			7
> > >  #define EXYNOS7_EMUL_DATA_MASK			0x1ff
> > >  
> > > @@ -615,29 +605,27 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
> > >  {
> > >  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> > >  	struct thermal_zone_device *tz = data->tzd;
> > > -	unsigned int con, interrupt_en;
> > > +	unsigned int con, interrupt_en = 0, i;
> > >  
> > >  	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
> > >  
> > >  	if (on) {
> > > -		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > > -		interrupt_en =
> > > -			(of_thermal_is_trip_valid(tz, 3)
> > > -			 << EXYNOS_TMU_INTEN_RISE3_SHIFT) |
> > > -			(of_thermal_is_trip_valid(tz, 2)
> > > -			 << EXYNOS_TMU_INTEN_RISE2_SHIFT) |
> > > -			(of_thermal_is_trip_valid(tz, 1)
> > > -			 << EXYNOS_TMU_INTEN_RISE1_SHIFT) |
> > > -			(of_thermal_is_trip_valid(tz, 0)
> > > -			 << EXYNOS_TMU_INTEN_RISE0_SHIFT);
> > > +		for (i = 0; i < data->ntrip; i++) {
> > > +			if (!of_thermal_is_trip_valid(tz, i))
> > > +				continue;
> > > +
> > > +			interrupt_en |=
> > > +				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
> > > +		}
> > 
> > As EXYNOS_TMU_INTEN_RISE0_SHIFT is equal to zero, may be you can replace this
> > by BITS(i * 4) ?
> > 
> > Same comments for exynos5433 and exynos7 below.
> 
> Good point, I will replace it by using BIT() macro.

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: exynos: cleanup code for enabling threshold interrupts

Cleanup code for enabling threshold interrupts in ->tmu_control
method implementations.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c |  100 ++++++++++-------------------------
 1 file changed, 31 insertions(+), 69 deletions(-)

Index: b/drivers/thermal/samsung/exynos_tmu.c
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.c	2018-05-02 12:25:14.393266604 +0200
+++ b/drivers/thermal/samsung/exynos_tmu.c	2018-05-02 12:28:23.545271367 +0200
@@ -75,10 +75,6 @@
 #define EXYNOS_TMU_TRIP_MODE_MASK	0x7
 #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
 
-#define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
-#define EXYNOS_TMU_INTEN_RISE2_SHIFT	8
-#define EXYNOS_TMU_INTEN_RISE3_SHIFT	12
 #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
 
 #define EXYNOS_EMUL_TIME	0x57F0
@@ -135,14 +131,6 @@
 
 #define EXYNOS7_TMU_TEMP_MASK			0x1ff
 #define EXYNOS7_PD_DET_EN_SHIFT			23
-#define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
-#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
-#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
-#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
-#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
-#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
-#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
-#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
@@ -615,29 +603,26 @@ static void exynos4210_tmu_control(struc
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
+			interrupt_en |= BIT(i * 4);
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
@@ -646,36 +631,24 @@ static void exynos5433_tmu_control(struc
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
+			interrupt_en |= BIT(i);
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
 
@@ -688,37 +661,26 @@ static void exynos7_tmu_control(struct p
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
+			interrupt_en |= BIT(i);
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
