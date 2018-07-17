Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C39ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE820C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMYdSpfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE820C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeGQKpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:45:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43576 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:45:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so256278plk.10;
        Tue, 17 Jul 2018 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hkjzRXrjle2f9IC9CpSfEJ5rNupqERiOiluf/+qp5A=;
        b=fMYdSpfc81c/XHqMgtqO2I2YPqEEtizXdaz5jSlcy7xoruCkdDv+hDz4ATCJ9z9jjL
         JZhKuQkw1iYUiMygWl9vS6hSv5s92H+6rBoNf6khaqwp/egLfY7MDyRkJXwpxJ6n3ry2
         lvBx1Wxw2iFIKx1dfbsWHDoG6h2bys/9WMcShYeispHi/pvbnFSgUBSlNr4TaE/YSYfj
         anUQhbVE/RxF691Zue1UqoLjGhZf7ctqOMHFTVrVXbPmZNtgujRE0gak6nH7EjTsFdW1
         7obht1mRdN6DvKTLSnQ5SgxiARcHUksztMgzwnfuhF0xwmnlkCidxZ/9sUPDLZaY8dN0
         Di6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8hkjzRXrjle2f9IC9CpSfEJ5rNupqERiOiluf/+qp5A=;
        b=uKX3JRqn4aK1RrmyvlqiEa2FWmB3bFawNkUL1fQJN8CgUzG5BMSwOGo7nqNxGNYqoX
         6zrFL0UNfo/7VHFUA1u5TEGUITCqwUoES2jNg73ls0YcDH/qWtXrj7X6zFaVrv7KoR3a
         g1532k39/5vKdnnei+7MRRJP/fYXmvnL9Grq5UhF/HYLFABsSRYKPVI5omXcy4gYYpVX
         kiy/+Bm0UoBIsLH3+gZCVC0TSPxc7kAVvJg+p/0U+kuGt8MyIIICWBW261CmCzxEbxVO
         rujNZokRXIN/DPNgpWifn5ElbPLLzLUCgv1qSkEIcXBH1vnsEpAI7qbvX8NERl+sfqX+
         36hQ==
X-Gm-Message-State: AOUpUlGIcD9rw+v5bG1T4iiBaWfDZy2D793g8nXDG1s9hCcWaS2k4br2
        +OH1NyrlzQDLxq+RE3WrSV0=
X-Google-Smtp-Source: AAOMgpeotuapBhqNPpP/R/3NdhjVQ/3kLk99WGj1EJ1UKwLwGZNAep2ru2uM6naFZ+XA+Fowq9lSLw==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr1021954pld.294.1531822392552;
        Tue, 17 Jul 2018 03:13:12 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.210])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2809963pgb.14.2018.07.17.03.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:13:12 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
Date:   Tue, 17 Jul 2018 10:12:22 +0000
Message-Id: <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add tmuctrl aliases node for exynos542x

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
 6 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 57c2332..ff79f0b 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1061,19 +1061,19 @@
 	status = "okay";
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f4e8c58..c0441ca 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -35,6 +35,10 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		tmuctrl0 = &tmu_cpu_0;
+		tmuctrl1 = &tmu_cpu_1;
+		tmuctrl2 = &tmu_cpu_2;
+		tmuctrl3 = &tmu_cpu_3;
 	};
 
 	/*
@@ -732,7 +736,7 @@
 			interrupt-parent = <&gic>;
 		};
 
-		tmu_cpu0: tmu@10060000 {
+		tmu_cpu_0: tmu@10060000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10060000 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -741,7 +745,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu1: tmu@10064000 {
+		tmu_cpu_1: tmu@10064000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10064000 0x100>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
@@ -750,7 +754,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu2: tmu@10068000 {
+		tmu_cpu_2: tmu@10068000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x10068000 0x100>, <0x1006c000 0x4>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
@@ -759,7 +763,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu3: tmu@1006c000 {
+		tmu_cpu_3: tmu@1006c000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
@@ -1341,19 +1345,19 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0>;
+			thermal-sensors = <&tmu_cpu_0>;
 			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu1_thermal: cpu1-thermal {
-		       thermal-sensors = <&tmu_cpu1>;
+		       thermal-sensors = <&tmu_cpu_1>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		cpu2_thermal: cpu2-thermal {
-		       thermal-sensors = <&tmu_cpu2>;
+		       thermal-sensors = <&tmu_cpu_2>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		cpu3_thermal: cpu3-thermal {
-		       thermal-sensors = <&tmu_cpu3>;
+		       thermal-sensors = <&tmu_cpu_3>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		gpu_thermal: gpu-thermal {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f408..e28091f 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -397,19 +397,19 @@
 	};
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index 8f332be..310222f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -29,7 +29,7 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
+			thermal-sensors = <&tmu_cpu_0 0>;
 			trips {
 				cpu0_alert0: cpu-alert-0 {
 					temperature = <70000>; /* millicelsius */
@@ -78,7 +78,7 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu_1 0>;
 			trips {
 				cpu1_alert0: cpu-alert-0 {
 					temperature = <70000>;
@@ -116,7 +116,7 @@
 			};
 		};
 		cpu2_thermal: cpu2-thermal {
-			thermal-sensors = <&tmu_cpu2 0>;
+			thermal-sensors = <&tmu_cpu_2 0>;
 			trips {
 				cpu2_alert0: cpu-alert-0 {
 					temperature = <70000>;
@@ -154,7 +154,7 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu_3 0>;
 			trips {
 				cpu3_alert0: cpu-alert-0 {
 					temperature = <70000>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c..36af2ea 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -52,7 +52,7 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
+			thermal-sensors = <&tmu_cpu_0 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -135,7 +135,7 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu_1 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -202,7 +202,7 @@
 			};
 		};
 		cpu2_thermal: cpu2-thermal {
-			thermal-sensors = <&tmu_cpu2 0>;
+			thermal-sensors = <&tmu_cpu_2 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -269,7 +269,7 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu_3 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index d80ab90..c976d02 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -1030,19 +1030,19 @@
 	status = "okay";
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-- 
2.7.4

