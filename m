Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71545C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6D220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wB8x+wrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6D220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbeKLIug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390716AbeKLIWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A9D223C8;
        Sun, 11 Nov 2018 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975557;
        bh=2ADCds6qfVboEURMrkIITdavTm6wfJ0GE+8TuSa9mFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wB8x+wrqhf44cCzY2eDiFL8eDq3IZ9GpvSKwqPzO1yncc0AtG61gg3CwOo75LaspJ
         lmXxAutgL9UQjE0+uLNCbXMifKo2og4YWxrlyYBjGQBXkv1lxRJdENn71ajs9CJPEa
         yEUNMWlUrmA83sFHJIhPpDhSZUZwQBQl7sbco5WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 112/222] ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
Date:   Sun, 11 Nov 2018 14:23:29 -0800
Message-Id: <20181111221657.808638635@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit cd6f55457eb449a388e793abd676e3a5b73510bc upstream.

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused properties from the CPU nodes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos4210.dtsi      |    2 --
 arch/arm/boot/dts/exynos4412.dtsi      |    2 --
 arch/arm/boot/dts/exynos5250.dtsi      |    2 --
 arch/arm/boot/dts/exynos5420-cpus.dtsi |   16 ----------------
 arch/arm/boot/dts/exynos5422-cpus.dtsi |   16 ----------------
 5 files changed, 38 deletions(-)

--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -52,8 +52,6 @@
 				400000	975000
 				200000	950000
 			>;
-			cooling-min-level = <4>;
-			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -45,8 +45,6 @@
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
-			cooling-min-level = <13>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -80,8 +80,6 @@
 				 300000  937500
 				 200000  925000
 			>;
-			cooling-min-level = <15>;
-			cooling-max-level = <9>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -33,8 +33,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -45,8 +43,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -57,8 +53,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -69,8 +63,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -82,8 +74,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -94,8 +84,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -106,8 +94,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -118,8 +104,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -32,8 +32,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -44,8 +42,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -56,8 +52,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -68,8 +62,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -81,8 +73,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -93,8 +83,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -105,8 +93,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
@@ -117,8 +103,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 	};


