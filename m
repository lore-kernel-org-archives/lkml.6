Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B233BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C42177E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158821;
	bh=r1zfajbQFwlOPesYRLlGOdQnXCOUyoCVvZj3f5ZvSew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xhlbaa1dkOjN+gW4Cb9O4h9NyGMC4bA5u/94/SwPg3Pgamj7/UNY+dkoCy9CyyYbL
	 RJxI8eDs64BEvesEU8OXeSS+zLRSPHbT6zivf1eTZYwGuMWbJOlMKJvqvL3hBtHwHl
	 m93q2Yd3J/BTp4bj39vpK3ogeA45YxHixyXoRXwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfAJWUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:20:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40085 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfAJWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:20:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so11411825oth.7;
        Thu, 10 Jan 2019 14:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stIqPQDH9x652/G5j/8eauLkKtitzkd2koQud573cqI=;
        b=KO4XWI8GZa/XhSrK12xbdFyWk78QBsuAFosBMQxw6D3iWImbEeJdL2MDHl2ip8iU/m
         HUUXDZbzoyLeCEip+yZBYFdFWgfqfeL/6yczsKb31OE2FbsekEvYT0fjDOVA42ny+L2b
         kJaakhzS232g1DSY5pJ7qjDVQkhigZvhtCCGgpR7Fkv4TVgEQjOiWZzzK17ZJXfJT74L
         LeGuyvI8bLzJFJ/AEkBtGkekRaKZ3ZdaPV+CKLwBiOWneSZwjt+iFXsfWkfgNux7HhC3
         5ZwNj8dEanV5oTGVLzT1BSshEB3vfwgtwb8fZ66bFU5Kp9rtT9ENm87Td5DqGyQwqwnF
         N6zA==
X-Gm-Message-State: AJcUukcVrVzakGHI1pAM9pi5EkXOFrYdGhQpdYBpGIdoxWgf2xwb3aeR
        lk07od4XkZ0RaC1Nwy3I6mZkCko=
X-Google-Smtp-Source: ALg8bN5ZKJrWzX1L/6F2lK4ZWvO4i2QoB/xyIvPTY46lcvVH9TBi/VIE7AWOtwJCth5iGwP/u5v1Eg==
X-Received: by 2002:a9d:c6a:: with SMTP id 97mr7814598otr.163.1547158818563;
        Thu, 10 Jan 2019 14:20:18 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r9sm41471303otq.81.2019.01.10.14.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:20:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
Date:   Thu, 10 Jan 2019 16:20:16 -0600
Message-Id: <20190110222017.6390-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the snps,dw-apb-uart binding to DT schema using json-schema.

The Rockchip and Broadcom compatible strings were not documented,
so add them here.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/serial/snps-dw-apb-uart.txt      |  76 ----------
 .../bindings/serial/snps-dw-apb-uart.yaml     | 140 ++++++++++++++++++
 2 files changed, 140 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
deleted file mode 100644
index 12bbe9f22560..000000000000
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-* Synopsys DesignWare ABP UART
-
-Required properties:
-- compatible : "snps,dw-apb-uart"
-- reg : offset and length of the register set for the device.
-- interrupts : should contain uart interrupt.
-
-Clock handling:
-The clock rate of the input clock needs to be supplied by one of
-- clock-frequency : the input clock frequency for the UART.
-- clocks : phandle to the input clock
-
-The supplying peripheral clock can also be handled, needing a second property
-- clock-names: tuple listing input clock names.
-	Required elements: "baudclk", "apb_pclk"
-
-Optional properties:
-- snps,uart-16550-compatible : reflects the value of UART_16550_COMPATIBLE
-  configuration parameter. Define this if your UART does not implement the busy
-  functionality.
-- resets : phandle to the parent reset controller.
-- reg-shift : quantity to shift the register offsets by.  If this property is
-  not present then the register offsets are not shifted.
-- reg-io-width : the size (in bytes) of the IO accesses that should be
-  performed on the device.  If this property is not present then single byte
-  accesses are used.
-- dcd-override : Override the DCD modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- dsr-override : Override the DTS modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- cts-override : Override the CTS modem status signal. This signal will always
-  be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin.
-- ri-override : Override the RI modem status signal. This signal will always be
-  reported as inactive instead of being obtained from the modem status register.
-  Define this if your serial port does not use this pin.
-
-Example:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clock-frequency = <3686400>;
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		dcd-override;
-		dsr-override;
-		cts-override;
-		ri-override;
-	};
-
-Example with one clock:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clocks = <&baudclk>;
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
-
-Example with two clocks:
-
-	uart@80230000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x80230000 0x100>;
-		clocks = <&baudclk>, <&apb_pclk>;
-		clock-names = "baudclk", "apb_pclk";
-		interrupts = <10>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
new file mode 100644
index 000000000000..b42002542690
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/snps-dw-apb-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare ABP UART
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-uart
+              - renesas,r9a06g033-uart
+          - const: renesas,rzn1-uart
+      - items:
+          - enum:
+              - rockchip,px30-uart
+              - rockchip,rk3036-uart
+              - rockchip,rk3066-uart
+              - rockchip,rk3188-uart
+              - rockchip,rk3288-uart
+              - rockchip,rk3328-uart
+              - rockchip,rk3368-uart
+              - rockchip,rk3399-uart
+              - rockchip,rv1108-uart
+          - const: snps,dw-apb-uart
+      - items:
+          - enum:
+              - brcm,bcm11351-dw-apb-uart
+              - brcm,bcm21664-dw-apb-uart
+          - const: snps,dw-apb-uart
+      - const: snps,dw-apb-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: baudclk
+      - const: apb_pclk
+
+  snps,uart-16550-compatible:
+    description: reflects the value of UART_16550_COMPATIBLE configuration
+      parameter. Define this if your UART does not implement the busy functionality.
+    type: boolean
+
+  resets:
+    maxItems: 1
+
+  reg-shift: true
+
+  reg-io-width: true
+
+  dcd-override:
+    description: Override the DCD modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  dsr-override:
+    description: Override the DTS modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  cts-override:
+    description: Override the CTS modem status signal. This signal will
+      always be reported as active instead of being obtained from the modem
+      status register. Define this if your serial port does not use this
+      pin.
+    type: boolean
+
+  ri-override:
+    description: Override the RI modem status signal. This signal will always
+      be reported as inactive instead of being obtained from the modem status
+      register. Define this if your serial port does not use this pin.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clock-frequency = <3686400>;
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+      dcd-override;
+      dsr-override;
+      cts-override;
+      ri-override;
+    };
+
+  - |
+    // Example with one clock:
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clocks = <&baudclk>;
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+    };
+
+  - |
+    // Example with two clocks:
+    serial@80230000 {
+      compatible = "snps,dw-apb-uart";
+      reg = <0x80230000 0x100>;
+      clocks = <&baudclk>, <&apb_pclk>;
+      clock-names = "baudclk", "apb_pclk";
+      interrupts = <10>;
+      reg-shift = <2>;
+      reg-io-width = <4>;
+    };
+...
-- 
2.19.1

