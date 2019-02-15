Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4657721A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYtk3b6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfBONuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:50:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46349 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBONt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so4857413pfh.13;
        Fri, 15 Feb 2019 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
        b=rYtk3b6yXh3QjciyPCKhT/XhQJlnGpaykwgjpFwiLRAYm40PsxbBKy0yPYVhoJ2bje
         7GXwcjQLLkCQ6xmOyo823Getk6KGWMEsFdBE8K9PuRj3XwqJQJOZgHlByl4hm/Ze8lC8
         AKGs9/78KhWgyiSTtzR/UsSOWgSXcVqVRNsgvlmnbwE+X8HLMzD7ZEFi0GrR3UXVFlmf
         9d/mImnSXYvaplQkTOO6/LpWiNZunpkVBb6Ts7yuv/bBhYUvClnSKG3K/3w/ox1XuVFn
         lGjQlQqlrFgOn91Cy20zuqBIHaGE1DFyfZNmHrVn/izVOI4LguqHAli95oe7EyUB69rB
         aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
        b=hZtfo1f7WjdD3DzZEjbaA789hduaIEdqLycGzVENCe9ei6++7Lxe9ephW7GaLxdQDS
         nh89Ai2KjghoKIma+YDtNcFZ1Ouu169wD0ScN94p2Gbyg4hkhFXI34iGw0f7DW0yn1v6
         BF3Q1oj0AdW2/dJP5uit6iJ4MOGqrN+igqAZy+nbSw0zNmTj4KHTkem5BT5zSKc+qGKa
         WnMk7ANUm4TJ6+BEJBCnJ2B1oWkzgtq0ixCu/2LlKTjMBT9VPPXnXxXfd7/v3KVw0xdR
         +DFY4ykj9bqe5zj4PvA+wiu6SlyCmh/i4ztaQeQocBMFnvi/NHVTDeftO/Ppmd/lrV8N
         E82Q==
X-Gm-Message-State: AHQUAuZFWf4mQwWEZhHmxQajS7Nrqhl4MfTllt7NtSh3R1bEm8DsexPp
        K+GbPLMIw1HU8TiQaChXgZ6eBpELa4k=
X-Google-Smtp-Source: AHgI3IbNk3I5+OCPsiR4MT7lg4rskqavJlLuodBpXsexgfJQ+vhB2leyMMcL5uSa/a769rP32BGtkg==
X-Received: by 2002:a65:490e:: with SMTP id p14mr5464986pgs.373.1550238596863;
        Fri, 15 Feb 2019 05:49:56 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j5sm6871172pfe.84.2019.02.15.05.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:49:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATVH v2 4/4] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Fri, 15 Feb 2019 08:49:37 -0500
Message-Id: <20190215134937.10259-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OPP (Operating Performance Points) table for the CPU cores to
enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
information comes from github.

When the four CPUs are running at 1.8 GHz, 100% busy, it is easy to heat
up and make the system restart. And currently H6 does not support the
thermal driver, can not get the temperature information of the cpu to
control the highest frequency. So temporarily remove the opp of 1.8GHz.

When the four CPUs operate at 1.4 GHz, 100% busy, the temperature is
stable at about 90 degrees, and the system can still operate normally.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 723f5d991a74..84fb47062fe6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -28,6 +28,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -37,6 +39,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -46,6 +50,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -55,6 +61,55 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@888000000 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <800000 800000 940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1080000000 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <840000 840000 1060000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <900000 900000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <960000 960000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0

