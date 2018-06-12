Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C1AA0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6CD208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QWXlfiv5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="omwck2US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6CD208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeFLLCz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:02:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933295AbeFLLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:02:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82299606DB; Tue, 12 Jun 2018 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801370;
        bh=nS/EvWej8YdR5bI3gWtIx6sPrqHWhvpXYE7WZFg9lYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWXlfiv5ZO2Hfp18lRpreAxUe3gypbBMmc4+wjd+PnhrZif0k0eHLy+SwLEjhnvkc
         XuiX4v+CemD6nDft9QWTCw2CK1sZiMa0o/NZyhxJJppIrluteMXlPWGcMEFTE8ZRrL
         ic7rWGjJkrJiteCsnGEg54lWjH3VKVUCrX8IQOsg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3F6E606DB;
        Tue, 12 Jun 2018 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801369;
        bh=nS/EvWej8YdR5bI3gWtIx6sPrqHWhvpXYE7WZFg9lYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omwck2USmFfLxmDOvwb1h9770vjjQJJoSXfGxCsN3a/cELJM7li8o3dOsT2DHFo5v
         GnKsW3F0ELg0DsAIPwdHTld2tCts4C71WurjTRPMtTHFKO8BKX2XmZx5H43Qzu4oWi
         tqi1VKerGTaeI2gdqwJiOV6ik6DRXRCZC9fYW4Mg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3F6E606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date:   Tue, 12 Jun 2018 16:32:34 +0530
Message-Id: <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
SoCs. This is required for managing the cpu frequency transitions which are
controlled by firmware.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
new file mode 100644
index 0000000..e3087ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
@@ -0,0 +1,173 @@
+Qualcomm Technologies, Inc. CPUFREQ Bindings
+
+CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+SoCs to manage frequency in hardware. It is capable of controlling frequency
+for multiple clusters.
+
+Properties:
+- compatible
+	Usage:		required
+	Value type:	<string>
+	Definition:	must be "qcom,cpufreq-fw".
+
+* Property qcom,freq-domain
+Devices supporting freq-domain must set their "qcom,freq-domain" property with
+phandle to a freq_domain_table in their DT node.
+
+* Frequency Domain Table Node
+
+This describes the frequency domain belonging to a device.
+This node can have following properties:
+
+- reg
+	Usage:		required
+	Value type:	<prop-encoded-array>
+	Definition:	Addresses and sizes for the memory of the perf
+			, lut and enable bases.
+			perf - indicates the base address for the desired
+			performance state to be set.
+			lut - indicates the look up table base address for the
+			cpufreq	driver to read frequencies.
+			enable - indicates the enable register for firmware.
+- reg-names
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Address names. Must be "perf", "lut", "enable".
+			Must be specified in the same order as the reg property.
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
+			qcom,freq-domain = <&freq_domain_table0>;
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
+			qcom,freq-domain = <&freq_domain_table0>;
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
+			qcom,freq-domain = <&freq_domain_table0>;
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
+			qcom,freq-domain = <&freq_domain_table0>;
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
+			qcom,freq-domain = <&freq_domain_table1>;
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
+			qcom,freq-domain = <&freq_domain_table1>;
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
+			qcom,freq-domain = <&freq_domain_table1>;
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
+			qcom,freq-domain = <&freq_domain_table1>;
+			L2_700: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+	};
+
+	qcom,cpufreq-fw {
+		compatible = "qcom,cpufreq-fw";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		freq_domain_table0 : freq_table0 {
+			reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
+				 <0x17d41000 0x4>;
+			reg-names = "perf", "lut", "enable";
+		};
+
+		freq_domain_table1 : freq_table1 {
+			reg = <0x17d46120 0x4>, <0x17d45910 0x500>,
+				<0x17d45800 0x4> ;
+			reg-names = "perf", "lut", "enable";
+		};
+	};
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

