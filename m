Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A767ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13E2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DhuyhWYt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KDSHcwjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeGRGNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:13:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeGRGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:13:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B1DC460B72; Wed, 18 Jul 2018 05:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892238;
        bh=mMTn+rGHJd8L/DNYEy3zuBfhTpzgywiMQT8HOJ5DR28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhuyhWYtp9KLPcD0GQ9XiyUcPDOjRt7mPNw1MnonGef/gpgVVULXmToqUVoG4jUEm
         9hUX8W8yQ2/a0jZclNSzAsOdfGAs2/Y242D6GdwZVtKG833vvomc2hwFjlFSgFJegp
         eLgmxDQRbkBO1TZHry10H7hALU5C1SRBricKEjcY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 206EE607EB;
        Wed, 18 Jul 2018 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892237;
        bh=mMTn+rGHJd8L/DNYEy3zuBfhTpzgywiMQT8HOJ5DR28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDSHcwjOGVcE3eBFYyel8wTjLqwp63MeU7kn9IwvXcso6MvwUkikcWkzYrsPistqD
         n0LQ51C8CVd9ugYH23sbpP74a7T+rJh9i+x/0yjC3dzJoYNBVpggI5CTLtVj7aQsQz
         65/oiGLUyQ718nAHGuDYeUCUtbgO0m93J9g+METI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 206EE607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v6 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
Date:   Wed, 18 Jul 2018 11:06:59 +0530
Message-Id: <1531892220-2046-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
References: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
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
index 0000000..22d4355
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
+	Definition:	clock handle for XO clock.
+
+- clock-names
+	Usage:		required
+	Value type:	<string> From common clock binding.
+	Definition:	must be "xo".
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
+	Definition:	Addresses and sizes for the memory of the HW bases.
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
+	qcom,cpufreq-hw {
+		compatible = "qcom,cpufreq-hw";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		freq_domain_table0: freq_table0 {
+			reg = <0 0x17d43000 0 0x1400>;
+		};
+
+		freq_domain_table1: freq_table1 {
+			reg = <0 0x17d45800 0 0x1400>;
+		};
+	};
+};
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

