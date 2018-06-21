Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E620BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fv9nq6EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFUKfn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:35:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37263 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeFUKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:35:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180621103533euoutp027bcb22c3898c0e55b141d9fba7162a73~6Jnsss8uX0072200722euoutp02Y;
        Thu, 21 Jun 2018 10:35:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180621103533euoutp027bcb22c3898c0e55b141d9fba7162a73~6Jnsss8uX0072200722euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529577333;
        bh=jrVVyH0zfivUqR6ZU74Ue3Bw8+4wiggPuR0tXjDf+UI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fv9nq6EZ9H6RwUJyRtvm48VeXKVR+CsdUo9njKKvrXff+V6z78szsancxs33NJ+ck
         g308YVXMj9K6yErvWS873zor9y0kfT/d1fbiUM1rMPIzbj20o1+T+To9SciQAJ5949
         idgYU+dBCYCHqSc76QZjN+Xf+A9PSOPHJlm4CSG0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180621103532eucas1p2c929d2d95b47af2d65efbdbca0a709b4~6Jnrmtvtv1182111821eucas1p2a;
        Thu, 21 Jun 2018 10:35:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.C4.10409.47F7B2B5; Thu, 21
        Jun 2018 11:35:32 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93~6JnqbJLh71576515765eucas1p1H;
        Thu, 21 Jun 2018 10:35:31 +0000 (GMT)
X-AuditID: cbfec7f5-f95739c0000028a9-78-5b2b7f749b80
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.15.04183.37F7B2B5; Thu, 21
        Jun 2018 11:35:31 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAO0008H5F77Y30@eusync1.samsung.com>; Thu, 21 Jun
        2018 11:35:31 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date:   Thu, 21 Jun 2018 12:35:30 +0200
Message-id: <8551504.8D13YNfR1X@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7ol9drRBpP/s1tsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkzth5nLnhtUXFwwUTmBsa5+l2MnBwS
        AiYSt362s4DYQgIrGCXu/8zqYuQCsj8zSuzdOokVpuje60NMEIlljBJ/li1jhnB+M0oc+niP
        DaSKTcBKYmL7KkYQW0RAU+L63++sIEXMAhOZJG5sbGQHSQgLREnM2PATrIhFQFVi1uF+oCIO
        Dl6ghrX9EiBhUQEviS372plAbF4BQYkfk++BnccsIC+xb/9UVghbR+LssXWMIPMlBHawSXz9
        0c8IcaqLxPOr/9khbGGJV8e3QNkyEpcnd7NANExnlHjzaymUs55RYs2ZY0wQVdYSh49fhFrB
        JzFp23RmkOskBHglOtqEIEwPiWXTXEBMIYFYid3rWSYwSs9CcuosJKfOQnLqAkbmVYziqaXF
        uempxcZ5qeV6xYm5xaV56XrJ+bmbGIEJ4fS/4193MO77k3SIUYCDUYmH90aYVrQQa2JZcWXu
        IUYJDmYlEd5zJtrRQrwpiZVVqUX58UWlOanFhxilOViUxHnjNOqihATSE0tSs1NTC1KLYLJM
        HJxSDYwimZWL0gxbg57nyk2cZBv57qKYukTItcabexebvNbb82fxW+2Y1yt6rkg4TNu5YbXe
        4+tTWqpWLN8e/HN3orrgdi7nfasij33LehjolrH3DEueOceDlNpj/4OLTpxMl/XYemL7z/WS
        WQ+77p+bsdBTzFDo3SR3/8oPh3kn7V102eNIwJ39eawrlViKMxINtZiLihMBvBYIDAQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xy7rF9drRBs+fSlhsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkzth5nLnhtUXFwwUTmBsa5+l2MnBwS
        AiYS914fYgKxhQSWMEpM/S/UxcgFZP9llPj37TQLSIJNwEpiYvsqRhBbREBT4vrf76wgRcwC
        E5kkmrqmMncxcnAIC0RJ3J6gCFLDIqAqMetwPytImBeofm2/BEhYVMBLYsu+drBdvAKCEj8m
        3wMbzywgL7Fv/1RWCFtLYv3O40wTGHlnISmbhaRsFpKyBYzMqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQKDdtuxn1t2MHa9Cz7EKMDBqMTDeyNMK1qINbGsuDL3EKMEB7OSCO85E+1oId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYwcfFuUei4nqm3l
        38uhubA2L9J6YaDcx34dpklKzF8e1a8S9Vjn8nHpw+M7+Bd/ubJDyWVehsSHV0JZkyb9/sC4
        yP9/R2ra2kfK6c7lnf6hswvWMeU5SLbdEvu19dABzmmpH16/3DC7bV2K9rHOyIT/CfvOe9kU
        77eruLz0eO+nYq1jB5osZL8psRRnJBpqMRcVJwIADGFqNVYCAAA=
X-CMS-MailID: 20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93
References: <CGME20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- rebased against current -next kernel

 arch/arm/boot/dts/exynos3250.dtsi                 |    2 +-
 arch/arm/boot/dts/exynos4.dtsi                    |    2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |   20 --------------------
 arch/arm/boot/dts/exynos5250.dtsi                 |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi                 |    8 ++++----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi |   21 ---------------------
 arch/arm/boot/dts/exynos5420.dtsi                 |   10 +++++-----
 7 files changed, 12 insertions(+), 53 deletions(-)

Index: b/arch/arm/boot/dts/exynos3250.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos3250.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos3250.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -242,7 +242,7 @@
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
Index: b/arch/arm/boot/dts/exynos4.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos4.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -735,7 +735,7 @@
 			reg = <0x100C0000 0x100>;
 			interrupts = <2 4>;
 			status = "disabled";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		jpeg_codec: jpeg-codec@11840000 {
Index: b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos4412 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
Index: b/arch/arm/boot/dts/exynos5250.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5250.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5250.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -301,7 +301,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata: sata@122f0000 {
Index: b/arch/arm/boot/dts/exynos5410.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5410.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5410.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -93,7 +93,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -102,7 +102,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -111,7 +111,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -120,7 +120,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		mmc_0: mmc@12200000 {
Index: b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5420 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <0>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
Index: b/arch/arm/boot/dts/exynos5420.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5420.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5420.dtsi	2018-06-21 12:17:32.095322153 +0200
@@ -738,7 +738,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -747,7 +747,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -756,7 +756,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -765,7 +765,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -774,7 +774,7 @@
 			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sysmmu_g2dr: sysmmu@10a60000 {

