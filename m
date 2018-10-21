Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3490CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41C2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1lFZOh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJVFNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33239 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so35130781ljz.0;
        Sun, 21 Oct 2018 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5nLsZqyhHcgyJIEH7t62KCL1JMNL5JZ/y2YC9VXvUuI=;
        b=T1lFZOh4TRVdynOXKoQSbHTUJTynY7zpKMOfqYxUSi5xWo9+iiY4YarpVntsbwLl/e
         1bY19g+PDW94/S/3F5j1MOWafG00EGQ2FI0HpEcm0nzVqDJc36vrDOj3ljwCXlyFuuta
         3fcOjfC4upmbSd5Z3JwLZQq8Aj9l5Vgsi9bgnno/bxpqKht9T+/Dj8EerJNiRLuqUE3t
         fH99LCNKPIEozCg2xeAE4zZcsyb6VO/WyIilU3lGhyh+LDsL/RQBH/pxUDPWW44rLxFq
         wYHberQiRG2abpdedOTX3xW0RIFaqQJUNvcS7iyFuj5BvGPqoVi3UbjFNpbEMGDGI4f1
         erCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5nLsZqyhHcgyJIEH7t62KCL1JMNL5JZ/y2YC9VXvUuI=;
        b=FscftJR9SH7vw7BzsFA/43+t/zGaOThXfF1U3Ia3T6eZNVrI4Yf4lE66KRXRikLb+q
         Fmmwf/QLx5gjbKRCDrBSgB9I1RFhmpTBZkugSjoCQfRF6v5GJci2Ixt+ZvmpZ207Asys
         uuL/VtLtOV9WYNrfjlYHupZWHEBrS2sk+RuybpKu2zAzGa9W+69GpUQ9orK1+Ge08rQK
         td3bwPMgBzoW4XZtaiGR7exv3VQ+0IEqnMZSSZNmgp53lZl0QsqMSeM5yewkYp9WQlaf
         vO/aSK0kRIUf8aueBOwOdcpCeJND1ELIVgOzPAZOG4UdPcyyNR3p40VqenPr5PIIfby0
         oMLg==
X-Gm-Message-State: ABuFfohigP+mlWgUfLe2WWCWFjefOekinkX7f55bHfnxs+ikWPExYxP/
        gDqfNMQXJ8GYvSOXVCAhxt0=
X-Google-Smtp-Source: ACcGV60EYidnyzxsqvbhYK59uRgBQPBE+HwsMNENgcxFaJM7iDWFerBF3A7oPFTOUArhppSwq9YEDQ==
X-Received: by 2002:a2e:2205:: with SMTP id i5-v6mr24166652lji.15.1540155487006;
        Sun, 21 Oct 2018 13:58:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/17] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Sun, 21 Oct 2018 23:54:47 +0300
Message-Id: <20181021205501.23943-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoC's.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../cpufreq/nvidia,tegra20-cpufreq.txt        | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
new file mode 100644
index 000000000000..a8023ea7a99f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
@@ -0,0 +1,96 @@
+Binding for NVIDIA Tegra20 CPUFreq
+==================================
+
+Required properties:
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - pll_x: main-parent for CPU clock, must be the first entry
+  - intermediate: intermediate-parent for CPU clock
+  - cclk: the CPU clock
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitfields indicating:
+	On Tegra20:
+	1. CPU process ID mask
+	2. SoC speedo ID mask
+
+	On Tegra30:
+	1. CPU process ID mask
+	2. CPU speedo ID mask
+
+	A bitwise AND is performed against these values and if any bit
+	matches, the OPP gets enabled.
+
+- opp-microvolt: CPU voltage triplet.
+
+Optional properties:
+- cpu-supply: Phandle to the CPU power supply.
+- core-supply: Phandle to the CORE power supply.
+- rtc-supply: Phandle to the RTC power supply, required only for Tegra20.
+
+Voltage supply requirements:
+- Tegra20:
+	CORE and RTC regulators must be coupled using the regulator-coupled-with
+	property and regulator-coupled-max-spread property must be set to no
+	more than 170mV.
+
+	See ../regulator/regulator.txt for more detail about the properties.
+
+- Tegra30:
+	CORE and CPU regulators must be coupled using the regulator-coupled-with
+	property and regulator-coupled-max-spread property must be set to no
+	more than 300mV. Each of CORE and CPU regulators must set
+	regulator-max-step-microvolt property to no more than 100mV.
+
+	See ../regulator/regulator.txt for more detail about the properties.
+
+
+Example:
+	regulators {
+		cpu_reg: regulator0 {
+			regulator-name = "vdd_cpu";
+		};
+
+		core_reg: regulator1 {
+			regulator-name = "vdd_core";
+			regulator-coupled-with = <&rtc_reg>;
+			regulator-coupled-max-spread = <170000>;
+		};
+
+		rtc_reg: regulator2 {
+			regulator-name = "vdd_rtc";
+			regulator-coupled-with = <&core_reg>;
+			regulator-coupled-max-spread = <170000>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@456000000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		...
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-supply = <&cpu_reg>;
+			core-supply = <&core_reg>;
+			rtc-supply = <&rtc_reg>;
+			#cooling-cells = <2>;
+		};
+	};
-- 
2.19.0

