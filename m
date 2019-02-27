Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F2C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205A620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfB0Re4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:34:56 -0500
Received: from smtp8.web4u.cz ([81.91.87.88]:60809 "EHLO mx-8.mail.web4u.cz"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbfB0Rew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:34:52 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 12:34:50 EST
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
        by mx-8.mail.web4u.cz (Postfix) with ESMTP id D3E63200A11;
        Wed, 27 Feb 2019 18:28:21 +0100 (CET)
Received: from baree.pikron.com (unknown [89.102.8.6])
        (Authenticated sender: ppisa@pikron.com)
        by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 895022009ED;
        Wed, 27 Feb 2019 18:28:21 +0100 (CET)
From:   pisa@cmp.felk.cvut.cz
To:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com,
        ondrej.ille@gmail.com, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v2 2/2] dt-bindings: net: can: binding for CTU CAN FD open-source IP core.
Date:   Wed, 27 Feb 2019 18:26:29 +0100
Message-Id: <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
X-W4U-Auth: 3e517bd4b824ea18c93c24dd8ab580d48cb0aa53
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
new file mode 100644
index 000000000000..fea9c08b79ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
@@ -0,0 +1,108 @@
+Memory mapped CTU CAN FD open-source IP core
+
+The core sources and documentation on project page
+
+  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
+  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
+
+Integration in Xilinx Zynq SoC based system together with
+OpenCores SJA1000 compatible controllers
+
+  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
+
+Martin Jerabek's dimploma thesis with integration and testing
+framework description
+
+ https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
+
+Required properties:
+
+- compatible : should be one of "ctu,ctucanfd", "ctu,canfd-2".
+      The "canfd-2" has been reserved for older revision of the IP core.
+      The revision can be read from the IP core register as well.
+
+- reg = <(baseaddr) (size)> : specify mapping into physical address
+      space of the processor system.
+
+- interrupts : property with a value describing the interrupt source
+      required for the CTU CAN FD. For Zynq SoC system format is
+      <(is_spi) (number) (type)> where is_spi defines if it is SPI
+      (shared peripheral) interrupt, the second number is translated
+      to the vector by addition of 32 on Zynq-7000 systems and type
+      is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.
+
+- interrupt-parent = <&interrupt-controller-phandle> :
+      is required for Zynq SoC to find map interrupt
+      to the correct controller
+
+- clocks: phandle of reference clock (100 MHz is appropriate
+      for FPGA implementation on Zynq-7000 system).
+
+Optional properties:
+
+- clock-names: not used in actual design but if more clocks are used
+      by cores then "can_clk" would be clock source name for the clocks
+      used to define CAN time-quanta.
+
+Example when integrated to Zynq-7000 system DTS:
+
+        / {
+            /* ... */
+            amba: amba {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                compatible = "simple-bus";
+
+                ctu_can_fd_0: ctu_can_fd@43c30000 {
+                    compatible = "ctu,ctucanfd";
+                    interrupt-parent = <&intc>;
+                    interrupts = <0 30 4>;
+                    clocks = <&clkc 15>;
+                    reg = <0x43c30000 0x10000>;
+                };
+            };
+        };
+
+
+Example when used as DTS overlay on Zynq-7000 system:
+
+
+// Device Tree Example: Full Reconfiguration without Bridges
+/dts-v1/;
+/plugin/;
+
+/ {
+    fragment@0 {
+        target-path = "/fpga-full";
+
+        __overlay__ {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            firmware-name = "system.bit.bin";
+        };
+    };
+
+    fragment@1 {
+        target-path = "/amba";
+        __overlay__ {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            ctu_can_fd_0: ctu_can_fd@43c30000 {
+                compatible = "ctu,ctucanfd";
+                interrupt-parent = <&intc>;
+                interrupts = <0 30 4>;
+                clocks = <&clkc 15>;
+                reg = <0x43c30000 0x10000>;
+            };
+            ctu_can_fd_1: ctu_can_fd@43c70000 {
+                compatible = "ctu,ctucanfd";
+                interrupt-parent = <&intc>;
+                interrupts = <0 31 4>;
+                clocks = <&clkc 15>;
+                reg = <0x43c70000 0x10000>;
+            };
+        };
+    };
+};
-- 
2.11.0

