Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B08C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD620872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUf8k6C1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCD620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391196AbeKLIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390707AbeKLIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:35 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1785222353;
        Sun, 11 Nov 2018 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975558;
        bh=oJMQcYpF8iZ+9Wyc4vikv9whq7hHEq0qenEuW5BdbBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUf8k6C1/8TMpHvbyU8u8gFKhK9krbZ10c0eIF6lY7NCVqHXC3T0MUEClZXTiGXsd
         /nUbAW6ZpJseZh/+riFL533PG8p4kY4Sy9gb6CS9iABflZRVXB74GOkUPgbapz6X3O
         gEheMP+AOw9+dmbkLzEaqC7w4kwEAMjvhn0ozEkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 114/222] ARM: dts: exynos: Convert exynos5250.dtsi to opp-v2 bindings
Date:   Sun, 11 Nov 2018 14:23:31 -0800
Message-Id: <20181111221657.956229413@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit eb9e16d8573e243f8175647f851eb5085dbe97a4 upstream.

Convert Exynos5250 to OPP-v2 bindings. This is a preparation to add proper
support for suspend operation point, which cannot be marked in opp-v1.

Cc: <stable@vger.kernel.org> # 4.3.x: cd6f55457eb4: ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
Cc: <stable@vger.kernel.org> # 4.3.x: 672f33198bee: arm: dts: exynos: Add missing cooling device properties for CPUs
Cc: <stable@vger.kernel.org> # 4.3.x
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5250.dtsi |  130 +++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 42 deletions(-)

--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -57,62 +57,108 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
-			clock-frequency = <1700000000>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
-			clock-latency = <140000>;
-
-			operating-points = <
-				1700000 1300000
-				1600000 1250000
-				1500000 1225000
-				1400000 1200000
-				1300000 1150000
-				1200000 1125000
-				1100000 1100000
-				1000000 1075000
-				 900000 1050000
-				 800000 1025000
-				 700000 1012500
-				 600000 1000000
-				 500000  975000
-				 400000  950000
-				 300000  937500
-				 200000  925000
-			>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
-			clock-frequency = <1700000000>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
-			clock-latency = <140000>;
-
-			operating-points = <
-				1700000 1300000
-				1600000 1250000
-				1500000 1225000
-				1400000 1200000
-				1300000 1150000
-				1200000 1125000
-				1100000 1100000
-				1000000 1075000
-				 900000 1050000
-				 800000 1025000
-				 700000 1012500
-				 600000 1000000
-				 500000  975000
-				 400000  950000
-				 300000  937500
-				 200000  925000
-			>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1050000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1075000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1125000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1150000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1225000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1300000>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
 	soc: soc {
 		sysram@02020000 {
 			compatible = "mmio-sram";


