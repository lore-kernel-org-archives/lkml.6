Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDPCky (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:40:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36144 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeDPCkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:40:52 -0400
X-Google-Smtp-Source: AIpwx4+ObrYvYSJHze8IGL62QiX8wPD7RlBXN6jFgzuqHmI0Twfh5lG/b/zEfTL323v9kluE04Qlhw==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc: devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/2] arm64: dts: Add the rtc enable clock for watchdog
Date: Mon, 16 Apr 2018 10:40:04 +0800
Message-Id: <bc450ea82fe7fbec7e7f74c5cdc8a37d202fe526.1523846102.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
In-Reply-To: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rtc enable clock for watchdog controller to make it work well.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index bf7e70c..e9db910 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -214,8 +214,9 @@
 				reg = <0 0x40310000 0 0x1000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-sec = <12>;
-				clock-names = "enable";
-				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
+				clock-names = "enable", "rtc_enable";
+				clocks = <&aon_gate CLK_APCPU_WDG_EB>,
+				       <&aon_gate CLK_AP_WDG_RTC_EB>;
 			};
 		};
 
-- 
1.7.9.5
