Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeEEJfy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:35:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeEEJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:35:03 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/5] dt-bindings: clock: add rk3399 DDR3 standard speed bins.
Date: Sat,  5 May 2018 11:34:47 +0200
Message-Id: <20180505093450.17327-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180505093450.17327-1-enric.balletbo@collabora.com>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDR3 SDRAM Standard (JESD79-3F) defines some standard speed bins for
DDR3 memories. The rk3399_dmc driver allows you to pass these values via
the device tree. For that purpose the devfreq/rk3399_dmc.txt binding
refers to a ddr.h file which does not exist. This patch adds the missing
defines in a include file called rk3399-ddr.h with the definition of
standard speed bins according to the ARM Trusted Firmware (ATF).

Fixes: c1ceb8f7c167 (Documentation: bindings: add dt documentation for rk3399 dmc)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2:
- [2/6] Improved commit message.
- [2/6] Rename ddr.h to rk3399-ddr.h because is SoC specific.

 .../bindings/devfreq/rk3399_dmc.txt           |  2 +-
 include/dt-bindings/clock/rk3399-ddr.h        | 56 +++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/rk3399-ddr.h

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index d83ef821d282..834637c7bae7 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -19,7 +19,7 @@ Required properties:
 
 Following properties relate to DDR timing:
 
-- rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/ddr.h,
+- rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/rk3399-ddr.h,
 				  it selects the DDR3 cl-trp-trcd type. It must be
 				  set according to "Speed Bin" in DDR3 datasheet,
 				  DO NOT use a smaller "Speed Bin" than specified
diff --git a/include/dt-bindings/clock/rk3399-ddr.h b/include/dt-bindings/clock/rk3399-ddr.h
new file mode 100644
index 000000000000..ed2280844963
--- /dev/null
+++ b/include/dt-bindings/clock/rk3399-ddr.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+#ifndef DT_BINDINGS_DDR_H
+#define DT_BINDINGS_DDR_H
+
+/*
+ * DDR3 SDRAM Standard Speed Bins include tCK, tRCD, tRP, tRAS and tRC for
+ * each corresponding bin.
+ */
+
+/* DDR3-800 (5-5-5) */
+#define DDR3_800D	0
+/* DDR3-800 (6-6-6) */
+#define DDR3_800E	1
+/* DDR3-1066 (6-6-6) */
+#define DDR3_1066E	2
+/* DDR3-1066 (7-7-7) */
+#define DDR3_1066F	3
+/* DDR3-1066 (8-8-8) */
+#define DDR3_1066G	4
+/* DDR3-1333 (7-7-7) */
+#define DDR3_1333F	5
+/* DDR3-1333 (8-8-8) */
+#define DDR3_1333G	6
+/* DDR3-1333 (9-9-9) */
+#define DDR3_1333H	7
+/* DDR3-1333 (10-10-10) */
+#define DDR3_1333J 	8
+/* DDR3-1600 (8-8-8) */
+#define DDR3_1600G	9
+/* DDR3-1600 (9-9-9) */
+#define DDR3_1600H	10
+/* DDR3-1600 (10-10-10) */
+#define DDR3_1600J	11
+/* DDR3-1600 (11-11-11) */
+#define DDR3_1600K	12
+/* DDR3-1600 (10-10-10) */
+#define DDR3_1866J	13
+/* DDR3-1866 (11-11-11) */
+#define DDR3_1866K	14
+/* DDR3-1866 (12-12-12) */
+#define DDR3_1866L	15
+/* DDR3-1866 (13-13-13) */
+#define DDR3_1866M	16
+/* DDR3-2133 (11-11-11) */
+#define DDR3_2133K	17
+/* DDR3-2133 (12-12-12) */
+#define DDR3_2133L	18
+/* DDR3-2133 (13-13-13) */
+#define DDR3_2133M	19
+/* DDR3-2133 (14-14-14) */
+#define DDR3_2133N	20
+/* DDR3 ATF default */
+#define DDR3_DEFAULT	21
+
+#endif
-- 
2.17.0
