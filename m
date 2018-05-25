Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966211AbeEYKcj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:32:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33976 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966151AbeEYKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:33 -0400
X-Google-Smtp-Source: AB8JxZqdumhz0j9ld4lKHnGMYAS2tszvv3kIe/vdc0tkURiIwSdPNHgtHFl9W5N/TyYg+DBM8SU9Fw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] arm: dts: uniphier: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:51 +0530
Message-Id: <51ac4a5f0466aeed3f223663d9c34d6345b2a1f2.1527244201.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index debcbd15c24b..40ed15465095 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -36,6 +36,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -46,6 +47,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -56,6 +58,7 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu_opp>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
