Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA194ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E62083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr0LVjLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8E62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeJVFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41536 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeJVFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so35084164lja.8;
        Sun, 21 Oct 2018 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvXilCKoG7Om0U54BXuHpSWpsgo6GxzP/ylvX2mhmdo=;
        b=Yr0LVjLQISIRtWyrIZMlk0S+pteqPJKNyNmXQaZnCZtPPBPSAGkIFSZODTMQ3yIPG3
         v76ioNFDxLOHB5d/5i8VacG6UvbhoqpWGSUrqV6kxCA/w0wX2mHg54cdKHT22KlP27cg
         ScOAqcnzg0YhLVTtlxqbhZslwQ7j9NB1c0ADCg89ytpb2xjoTptHgcaAC5Hc3lhw+Eve
         Ljip9RIszy8vSPwMTpUkfN0YY7jEfVHzY+X92nJXwLCzK6Ra1Mp8wssoJT+fNAhgBkUJ
         CHLdO2StVqKpsxIPQsMkpnr8u/qQFtwCfyRBO3YWR4C5M6NMFQq+iZbC3hCvUirvHfWO
         dPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvXilCKoG7Om0U54BXuHpSWpsgo6GxzP/ylvX2mhmdo=;
        b=ENKn8oBWQVbv2xgmg06P5w3Iu2zZBg3q8rksu6VSOSTq4KZ+YcZJmDKIO4iPtJvlpf
         5lUlruu86R6PDxdWuj2DDCUo6EuBmCy1jKrq6XJLrIgB7DRBq6AWB3PnU7ju8WMKYmDi
         MMScU1fnkAuwwmSYeX4KSbQkPIWiX7Ubq1XMeRfsSo0/n55doeHjaxKwitDeKAlvovEx
         Iy1seK4GmoOIkFFBVGfhW1KddoEiSXyOWEiBAVsAHSBHE7RqIWMQEqdsQ/yAlS9YbnIV
         jWNrfxV0RM9iM+rsf/ttNMNGPa1WMoC9VU+DDnSX/1gGz40Iwln0+xI63umQHXegJOEn
         PlUQ==
X-Gm-Message-State: AGRZ1gJYNHHNSHXdTUTQ8D1pwuQ2qDCT8p+KZGjux8Jm6cF64ayLIH9p
        HjLvvO9ad2KJGdTodVzt1nM=
X-Google-Smtp-Source: AJdET5esKiGu8kBPREV6pfoUjej/APKwYyQM0eZVtLN9MJtzFEgSkmpdA9tsvphUESMEIWG8Dk54cA==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr9303228ljg.25.1540155490399;
        Sun, 21 Oct 2018 13:58:10 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 06/17] ARM: dts: tegra20: Add CPU Operating Performance Points
Date:   Sun, 21 Oct 2018 23:54:50 +0300
Message-Id: <20181021205501.23943-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/arm/boot/dts/tegra20.dtsi | 277 +++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 185cd074eeff..51ffb5d2b974 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -859,6 +859,271 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@216000000_750 {
+			clock-latency-ns = <2000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0xFF 0xFFFF>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-suspend;
+		};
+
+		opp@314000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <314000000>;
+		};
+
+		opp@380000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <380000000>;
+		};
+
+		opp@389000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <389000000>;
+		};
+
+		opp@456000000_825 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@494000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <494000000>;
+		};
+
+		opp@503000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <503000000>;
+		};
+
+		opp@598000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <598000000>;
+		};
+
+		opp@608000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@618000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <618000000>;
+		};
+
+		opp@655000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <655000000>;
+		};
+
+		opp@675000000_825 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <675000000>;
+		};
+
+		opp@730000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <730000000>;
+		};
+
+		opp@750000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <750000000>;
+		};
+
+		opp@760000000_775 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <775000 775000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@770000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <770000000>;
+		};
+
+		opp@798000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <798000000>;
+		};
+
+		opp@817000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@817000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@827000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <827000000>;
+		};
+
+		opp@845000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <845000000>;
+		};
+
+		opp@893000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <893000000>;
+		};
+
+		opp@902000000_950 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <950000 950000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <902000000>;
+		};
+
+		opp@912000000_1050 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1050000 1050000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@922000000_925 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <925000 925000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <922000000>;
+		};
+
+		opp@922000000_1050 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1050000 1050000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <922000000>;
+		};
+
+		opp@940000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <940000000>;
+		};
+
+		opp@950000000_950 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <950000 950000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <950000000>;
+		};
+
+		opp@960000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <960000000>;
+		};
+
+		opp@1000000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1025 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1025000 1025000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1100 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1100000 1100000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -867,12 +1132,24 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "intermediate", "cclk";
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
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.19.0

