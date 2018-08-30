Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2154EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAC20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVHxGQvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAAC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeH3Xup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46334 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeH3Xuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so8209901ljj.13;
        Thu, 30 Aug 2018 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oAdTGbI6yFO7xBr8XZdwHyZzxbUESQyzxbd3CtAslzU=;
        b=mVHxGQvBpMQlTgZHlFAb0FzCSiJFunZqJAaqzNKxB6cfHqP948zdBJass9AjZSjMmn
         mgFNm+Q/KbQ+glkmwIX3B3I+rcC39zRwb56Wag49TAplhzYl98XnEU8hbjuab0N9C9kX
         Dliy3g867yMeBBTqLjnsCNwDUdSirQXezGfZPcxPK4WdEzJwF1miQFUKgXhoxkUfjNYv
         SRbw3ZuQp+WJb62uXiHZyuQb8FQwNdKXBcsmwRNmTc74ZsrSgnR/ZwCs1p0uSvCEzJSZ
         BED+jREWgP6O7e+el+Ji2IQoCVQF5IhSJ5I2PE9VxxZcH9FcOIz2r9tmH6M7NxFIupAS
         uNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oAdTGbI6yFO7xBr8XZdwHyZzxbUESQyzxbd3CtAslzU=;
        b=RMbO7Bawo2zqRKriWxytsOV2rLa6gh2YZITlUJXqXd2bLcuIz2vIIsJplkvqSqKK6C
         HVJddShhcWkxDDcxK45Ro2dfoyyEA64Xfw0Fo6m/xAcKLSjMf+NaeOTJZNCD8kV0UeHj
         p+XdU0UKOWI4VfGS9cPGqErPueiqGbRqAZJNfZzMyeqnxCjFWwxEBlVzi5YpXnZTQ+mL
         C29CIQCztqOrCMlKbGwOpSXasz+SI58qZumj5Sggo+xnKUo6KmeZ4UKDVzcI5S7UAhs/
         62lho5uXn8qkwq8UXeqvYb5KNVs3i2Jq1GFubUTkZdDWmVT8pMthvHjtPSpsSVi8CR8X
         VZCQ==
X-Gm-Message-State: APzg51D+c+UiD2Z9NWJGE3hlnvLPEFRX3Hpk+57700gbS97WGnrIMj+U
        dSKIdFmDJMKSYMTw1UNptkI=
X-Google-Smtp-Source: ANB0VdbcbEmQf1ZNr2wuO7hnLxghrf1wwzyZcvjziDf1OTBU8Whsr2d8SC8pTX4Vga42KK8sQfAiRg==
X-Received: by 2002:a2e:752:: with SMTP id i18-v6mr8121452ljd.118.1535658415356;
        Thu, 30 Aug 2018 12:46:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] ARM: dts: tegra20: Add CPU Operating Performance Points
Date:   Thu, 30 Aug 2018 22:43:55 +0300
Message-Id: <20180830194356.14059-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU's Operating Performance Points to the device tree, they are used
by the CPUFreq driver and allow to setup thermal throttling for the boards
by linking the cooling device (CPU) with thermal sensors via thermal-zones
description.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 01398db0c9c7..4415de0f7c65 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -859,6 +859,52 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@216000000 {
+			clock-latency-ns = <2000>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-suspend;
+		};
+
+		opp@312000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <312000000>;
+		};
+
+		opp@456000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@608000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@760000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@912000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@1000000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -867,12 +913,24 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.18.0

