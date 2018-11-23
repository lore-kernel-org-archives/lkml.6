Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA44C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6172020685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJ9MEyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6172020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502981AbeKWU2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:28:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43479 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394486AbeKWU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:28:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so2850132pgk.10;
        Fri, 23 Nov 2018 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJ515zLevEUeccqRDVYn+tVCB8I11XduuAr4ftmENcA=;
        b=gsJ9MEyt5SZ8UhTserpQJms67J8YRuw6hkwQgzVLa3aQ9tqxm9htONtqwzyJETpubT
         VRkSCoT+6yGT9JLyCjgIF5wmPAPxJCHZEcWB3gOFL4gs/0bHJ+H+hEDa02l3RshTGSyW
         v+jpBnV7GMr3t2gjU5r2ABG1Aykwoh6MaFiATzShTdhtPvkZ8yzx935lByvpm13iJ5zr
         HlZgXj/t8Eu1fW5CBk/KlVj8xn4+07C7lgifw7cgo4DBoaI4R8A8yPfcj2IAfd6/lW3Y
         VOU1kWtmilI7kRmYK9YzqYEDv8s5sD4NRpeifp6vjmjplCtAdgNrTLnLvXr2In5qQ0gX
         +mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJ515zLevEUeccqRDVYn+tVCB8I11XduuAr4ftmENcA=;
        b=FHnNfXBPZIyBY503hjvH5SvB/6iHIgiiDe3lEEsXkmkcPLI9762iOSdcGKMDkvVAA1
         Qlvie0HsbI02xL+g56/2xhjKX9NTdEBU/pKe7MdwM+Xlc36Ep9/TNqR9DWFo6C5LSVSA
         JZ7NboNapAEC+k6XUq0MiL/ECO7KS3pobpt1NH2mj0pDlK1fZiNsKevkc7Wt8TO2pfXV
         ELsfgwYWTZn59KRz3V9jNfBf9BdgXwmp6SWrYZYC+QyDAQKW1dUTvNIbAZwHnushn55D
         nm2eEWG54ahmG+q0ElEvp0MSpboZW2SWKNSsBYspX9mGx0w/We/MjysNxjYrC3LnalGf
         9ZhQ==
X-Gm-Message-State: AA+aEWY64tgoAxZMQZZvVtuWxGKDVflnZEvHXe0NBZLY8d3t+ZHBiR3z
        XYq6q8T8ZnlphDdnLGI2tG8=
X-Google-Smtp-Source: AFSGD/UWORZqnu9QvgGPoE/ZLVAiuY72CZc648nY9Vd5KZcLcMjT8gss2D4urNlNU6C5XXbsv71Q+A==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr13511440pgd.344.1542966285933;
        Fri, 23 Nov 2018 01:44:45 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.164])
        by smtp.gmail.com with ESMTPSA id o189sm34059848pfg.117.2018.11.23.01.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:44:45 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/3] ARM: dts: Add g3d bus nodes using VDD_INT for Exynos542x SoC
Date:   Fri, 23 Nov 2018 09:44:13 +0000
Message-Id: <20181123094413.1108-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123094413.1108-1-linux.amoon@gmail.com>
References: <20181123094413.1108-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing Netwwork on chip for g3d bus node using VDD_INI
for Exynos542x SoC.

- CLK_DOUT_ACLK_G3D for G3D's AXI

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 57 +++++++++++++++++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  5 ++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff15880761..bc7203bb1282 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1047,6 +1047,14 @@
 			status = "disabled";
 		};
 
+		bus_g3d: bus_g3d {
+			compatible = "samsung,exynos-bus";
+			clocks = <&clock CLK_DOUT_ACLK_G3D>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_g3d_opp_table>;
+			status = "disabled";
+		};
+
 		bus_jpeg: bus_jpeg {
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
@@ -1245,7 +1253,44 @@
 			};
 		};
 
-		bus_jpeg_opp_table: opp_table11 {
+		bus_g3d_opp_table: opp_table11 {
+			compatible = "operating-points-v2";
+
+			opp@600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp@543000000 {
+				opp-hz = /bits/ 64 <543000000>;
+				opp-microvolt = <987500>;
+			};
+			opp@480000000 {
+				opp-hz = /bits/ 64 <480000000>;
+				opp-microvolt = <950000>;
+			};
+			opp@420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <937500>;
+			};
+			opp@350000000 {
+				opp-hz = /bits/ 64 <350000000>;
+				opp-microvolt = <900000>;
+			};
+			opp@266000000 {
+				opp-hz = /bits/ 64 <266000000>;
+				opp-microvolt = <862500>;
+			};
+			opp@177000000 {
+				opp-hz = /bits/ 64 <177000000>;
+				opp-microvolt = <862500>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <862500>;
+			};
+		};
+
+		bus_jpeg_opp_table: opp_table12 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1262,7 +1307,7 @@
 			};
 		};
 
-		bus_jpeg_apb_opp_table: opp_table12 {
+		bus_jpeg_apb_opp_table: opp_table13 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1279,7 +1324,7 @@
 			};
 		};
 
-		bus_disp1_fimd_opp_table: opp_table13 {
+		bus_disp1_fimd_opp_table: opp_table14 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1290,7 +1335,7 @@
 			};
 		};
 
-		bus_disp1_opp_table: opp_table14 {
+		bus_disp1_opp_table: opp_table15 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1304,7 +1349,7 @@
 			};
 		};
 
-		bus_gscl_opp_table: opp_table15 {
+		bus_gscl_opp_table: opp_table16 {
 			compatible = "operating-points-v2";
 
 			opp00 {
@@ -1318,7 +1363,7 @@
 			};
 		};
 
-		bus_mscl_opp_table: opp_table16 {
+		bus_mscl_opp_table: opp_table17 {
 			compatible = "operating-points-v2";
 
 			opp00 {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2fac4baf1eb4..6e39e4594502 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -89,6 +89,11 @@
 	status = "okay";
 };
 
+&bus_g3d {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
 &bus_jpeg {
 	devfreq = <&bus_wcore>;
 	status = "okay";
-- 
2.17.1

