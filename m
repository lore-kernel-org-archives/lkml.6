Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeDZV1s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:27:48 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43195 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDZV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:27:47 -0400
X-Google-Smtp-Source: AB8JxZoD6FOyJhNr8KVvzJ9NYb8xRQfypaYEODV4YS5Sqxaq3tIgVViZdUe+/QHx/3Z6VVEaC1JDHg==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/4] dt-bindings: move various timer bindings to timer/ directory
Date: Thu, 26 Apr 2018 16:27:41 -0500
Message-Id: <20180426212744.28688-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings are supposed to be organized by device class/function. Move
bindings for various timers to timer/ binding directory.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ux500/boards.txt                  | 2 +-
 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt              | 2 +-
 .../devicetree/bindings/{nios2/timer.txt => timer/altr,timer-1.0.txt}   | 0
 .../bindings/{arm/arch_timer.txt => timer/arm,arch_timer.txt}           | 0
 .../bindings/{arm/armv7m_systick.txt => timer/arm,armv7m-systick.txt}   | 0
 .../bindings/{arm/global_timer.txt => timer/arm,global_timer.txt}       | 0
 Documentation/devicetree/bindings/{arm/twd.txt => timer/arm,twd.txt}    | 0
 .../devicetree/bindings/{powerpc/fsl/gtm.txt => timer/fsl,gtm.txt}      | 0
 .../bindings/{arm/mrvl/timer.txt => timer/mrvl,mmp-timer.txt}           | 0
 .../devicetree/bindings/{arm/msm/timer.txt => timer/qcom,msm-timer.txt} | 0
 .../bindings/{arm/spear-timer.txt => timer/st,spear-timer.txt}          | 0
 .../devicetree/bindings/{c6x/timer64.txt => timer/ti,c64x+timer64.txt}  | 0
 .../devicetree/bindings/{arm/omap/timer.txt => timer/ti,timer.txt}      | 0
 .../devicetree/bindings/{arm/vt8500 => timer}/via,vt8500-timer.txt      | 0
 14 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{nios2/timer.txt => timer/altr,timer-1.0.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/arch_timer.txt => timer/arm,arch_timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/armv7m_systick.txt => timer/arm,armv7m-systick.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/global_timer.txt => timer/arm,global_timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/twd.txt => timer/arm,twd.txt} (100%)
 rename Documentation/devicetree/bindings/{powerpc/fsl/gtm.txt => timer/fsl,gtm.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/mrvl/timer.txt => timer/mrvl,mmp-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/msm/timer.txt => timer/qcom,msm-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/spear-timer.txt => timer/st,spear-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{c6x/timer64.txt => timer/ti,c64x+timer64.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/omap/timer.txt => timer/ti,timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/vt8500 => timer}/via,vt8500-timer.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/ux500/boards.txt b/Documentation/devicetree/bindings/arm/ux500/boards.txt
index 7334c24625fc..0fa429534f49 100644
--- a/Documentation/devicetree/bindings/arm/ux500/boards.txt
+++ b/Documentation/devicetree/bindings/arm/ux500/boards.txt
@@ -26,7 +26,7 @@ interrupt-controller:
 	see binding for interrupt-controller/arm,gic.txt
 
 timer:
-	see binding for arm/twd.txt
+	see binding for timer/arm,twd.txt
 
 clocks:
 	see binding for clocks/ux500.txt
diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
index 2e53324fb720..5ccfcc82da08 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 - compatible: Shall contain "ti,omap-dmtimer-pwm".
-- ti,timers: phandle to PWM capable OMAP timer. See arm/omap/timer.txt for info
+- ti,timers: phandle to PWM capable OMAP timer. See timer/ti,timer.txt for info
   about these timers.
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
diff --git a/Documentation/devicetree/bindings/nios2/timer.txt b/Documentation/devicetree/bindings/timer/altr,timer-1.0.txt
similarity index 100%
rename from Documentation/devicetree/bindings/nios2/timer.txt
rename to Documentation/devicetree/bindings/timer/altr,timer-1.0.txt
diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/timer/arm,arch_timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/arch_timer.txt
rename to Documentation/devicetree/bindings/timer/arm,arch_timer.txt
diff --git a/Documentation/devicetree/bindings/arm/armv7m_systick.txt b/Documentation/devicetree/bindings/timer/arm,armv7m-systick.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armv7m_systick.txt
rename to Documentation/devicetree/bindings/timer/arm,armv7m-systick.txt
diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/timer/arm,global_timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/global_timer.txt
rename to Documentation/devicetree/bindings/timer/arm,global_timer.txt
diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/timer/arm,twd.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/twd.txt
rename to Documentation/devicetree/bindings/timer/arm,twd.txt
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/gtm.txt b/Documentation/devicetree/bindings/timer/fsl,gtm.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/gtm.txt
rename to Documentation/devicetree/bindings/timer/fsl,gtm.txt
diff --git a/Documentation/devicetree/bindings/arm/mrvl/timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mrvl/timer.txt
rename to Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
diff --git a/Documentation/devicetree/bindings/arm/msm/timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/msm/timer.txt
rename to Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
diff --git a/Documentation/devicetree/bindings/arm/spear-timer.txt b/Documentation/devicetree/bindings/timer/st,spear-timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/spear-timer.txt
rename to Documentation/devicetree/bindings/timer/st,spear-timer.txt
diff --git a/Documentation/devicetree/bindings/c6x/timer64.txt b/Documentation/devicetree/bindings/timer/ti,c64x+timer64.txt
similarity index 100%
rename from Documentation/devicetree/bindings/c6x/timer64.txt
rename to Documentation/devicetree/bindings/timer/ti,c64x+timer64.txt
diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/omap/timer.txt
rename to Documentation/devicetree/bindings/timer/ti,timer.txt
diff --git a/Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt b/Documentation/devicetree/bindings/timer/via,vt8500-timer.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
rename to Documentation/devicetree/bindings/timer/via,vt8500-timer.txt
-- 
2.14.1
