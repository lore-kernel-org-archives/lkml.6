Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB696C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849BF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547486975;
	bh=FkYiSK5Pe0mp1U2VAHnxJBZ83gkFJp7mXB70qmO7MmU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KmsIP8XCoPbqbJznGbzE88H0zwb5vmbHS0UO84WfUHj5RAtDP78HaAIL2R1yZC98r
	 CnbyVuACfh5J2qF4zZBz8KHD6epJeUZqLo8mNniroEiGH4ToLO+CH7++4qTQ9JJH+p
	 efkZyJEui0sHeg3Pagy4pVf0utm2fQ7jDrrn37iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANR3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:29:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39599 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANR3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:29:33 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so20027454otl.6;
        Mon, 14 Jan 2019 09:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=neOaH11nZPsGZausKZVZiY+iEnZ3JNrWmaaX56gICco=;
        b=Als9asC7zqBOpNy/49Pde1KRBG3xMYCceeQlQ3ylLGGHaVQcOiK2Oehp4/zoNnWTFR
         y0/pGdARpv6A92XpIQJRd1FwXg0va/+84xRYY8Fl2IzT1RRdlThqYNDXb7euedGxa5q5
         3ESeUVDFaytg5BTl8T93/Up6CK7SSGLYZjzL1enx0LYaxY6qwg89Nwm0Ndbisiv550OO
         WlomOJNeodkgPSSixygI+LSm20HEYuRh8VYQiFCeOg2T2r+dAeUa1nM95RR9c7xofB45
         7SZqAVYB1IWufebX8xslYKRKOldIyHc4CDh6i0jio5glqcUmeqmMmSBzeaHpN18YeK+6
         HbCA==
X-Gm-Message-State: AJcUukfpmfitRQ1cJdRc4fYJS5JVInJMZr6DNrgS1fQDhuBZ52osFuzI
        d69r5E6kW+4y9T1O0AGK/OymWx0=
X-Google-Smtp-Source: ALg8bN4Ql/kICw6k14OM5NPntDLebbEGR45xfxO2/jeKYy8LrPC/GXZaa8TkoXkDRuJQHTIoR0URHA==
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr18437427otq.3.1547486971979;
        Mon, 14 Jan 2019 09:29:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 31sm943609otw.55.2019.01.14.09.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 09:29:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to json-schema
Date:   Mon, 14 Jan 2019 11:29:29 -0600
Message-Id: <20190114172930.7508-1-robh@kernel.org>
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
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Move Renesas compatible strings to patch 2

 .../bindings/serial/snps-dw-apb-uart.txt      |  76 ----------
 .../bindings/serial/snps-dw-apb-uart.yaml     | 135 ++++++++++++++++++
 2 files changed, 135 insertions(+), 76 deletions(-)
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
index 000000000000..3e90c790d720
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -0,0 +1,135 @@
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

