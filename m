Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966161AbeEYKcd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:32:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41918 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966081AbeEYKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:31 -0400
X-Google-Smtp-Source: AB8JxZq55/Mqyx5HS1byzPrAO1vGgmaZmJyK2VB30Vswg5LTbA3/fi9td7MDpdcO7iODBHBSF9tavg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] arm: dts: rk322x: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:50 +0530
Message-Id: <406021e33d541ca0318a6b15687084ca19fdd943.1527244201.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/rk322x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index be80e9a2c9af..ef414e39bf3a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -80,6 +80,7 @@
 			reg = <0xf01>;
 			resets = <&cru SRST_CORE1>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 
@@ -89,6 +90,7 @@
 			reg = <0xf02>;
 			resets = <&cru SRST_CORE2>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 
@@ -98,6 +100,7 @@
 			reg = <0xf03>;
 			resets = <&cru SRST_CORE3>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 	};
-- 
2.15.0.194.g9af6a3dea062
