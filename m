Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E751F206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gVzjfoO/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QF2llGUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E751F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeLBDz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:55:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLBDz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:55:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBFBF60C1C; Sun,  2 Dec 2018 03:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722922;
        bh=6rUwJ1D7cTf+leH7yTrKIXIajNsiIaqFAQ9MUaAFuQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVzjfoO/nuuj/MxuFInjoQbPv4SEYfe0iXXRbC6rbw2SdxGAZTyYPVEha/aNGvfrD
         B1yYiLNoM5rrysOIa56IXcycGZrbSefXoWYR9ehbRibWhh6rwGkQo/5pUoTEojkIpC
         LlROJ1xl2K8duTpRW7izc2M9u6u0forbaTjZwTpw=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B862360A34;
        Sun,  2 Dec 2018 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722921;
        bh=6rUwJ1D7cTf+leH7yTrKIXIajNsiIaqFAQ9MUaAFuQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QF2llGUJgrIU6VlBZJkKNrA6IK3HXNN57AAEEgceIgB0oOr+JdOhVekV6jPoMoaZL
         QNg36a4B9+0VDkErKpczsmocSmVU4FUcFiLp3faQ7yg+Ytr9fJAl8jRpu/lDXuXDk5
         NcQo5M5WwCjxeQ3A74+n5hFFTsBLlsR93DsZB0oM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B862360A34
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
Date:   Sun,  2 Dec 2018 09:25:02 +0530
Message-Id: <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
SoCs. This is required for managing the cpu frequency transitions which are
controlled by the hardware engine.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
new file mode 100644
index 0000000..2b82965
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
@@ -0,0 +1,172 @@
+Qualcomm Technologies, Inc. CPUFREQ Bindings
+
+CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+SoCs to manage frequency in hardware. It is capable of controlling frequency
+for multiple clusters.
+
+Properties:
+- compatible
+	Usage:		required
+	Value type:	<string>
+	Definition:	must be "qcom,cpufreq-hw".
+
+- clocks
+	Usage:		required
+	Value type:	<phandle> From common clock binding.
+	Definition:	clock handle for XO clock and GPLL0 clock.
+
+- clock-names
+	Usage:		required
+	Value type:	<string> From common clock binding.
+	Definition:	must be "xo", "alternate".
+
+- reg
+	Usage:		required
+	Value type:	<prop-encoded-array>
+	Definition:	Addresses and sizes for the memory of the HW bases in
+			each frequency domain.
+- reg-names
+	Usage:		Optional
+	Value type:	<string>
+	Definition:	Frequency domain name i.e.
+			"freq-domain0", "freq-domain1".
+
+- freq-domain-cells:
+	Usage:		required.
+	Definition:	Number of cells in a freqency domain specifier.
+
+* Property qcom,freq-domain
+Devices supporting freq-domain must set their "qcom,freq-domain" property with
+phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
+
+
+Example:
+
+Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
+DCVS state together.
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+				L3_0: l3-cache {
+				      compatible = "cache";
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			L2_100: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			L2_200: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			L2_300: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			L2_400: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			L2_500: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			L2_600: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "qcom,kryo385";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			L2_700: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+	};
+
+ soc {
+	cpufreq_hw: cpufreq@17d43000 {
+		compatible = "qcom,cpufreq-hw";
+		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+		reg-names = "freq-domain0", "freq-domain1";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+		clock-names = "xo", "alternate";
+
+		#freq-domain-cells = <1>;
+	};
+}
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

