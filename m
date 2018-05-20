Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeETFS6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 01:18:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36709 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeETFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 01:18:52 -0400
X-Google-Smtp-Source: AB8JxZqzM9vhiTpqCYatQYAtN5y7QM83fnQ4J5xecLQTymSHlaBLH1wE0l9bZOUNwmn9Jn7e3KiMZQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
Date: Sun, 20 May 2018 10:47:32 +0530
Message-Id: <20180520051736.4842-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio bindings for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pinctrl/actions,s900-pinctrl.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
index fb87c7d74f2e..8fb5a53775e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -8,6 +8,17 @@ Required Properties:
 - reg:          Should contain the register base address and size of
                 the pin controller.
 - clocks:       phandle of the clock feeding the pin controller
+- gpio-controller: Marks the device node as a GPIO controller.
+- gpio-ranges: Specifies the mapping between gpio controller and
+               pin-controller pins.
+- #gpio-cells: Should be two. The first cell is the gpio pin number
+               and the second cell is used for optional parameters.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+                    interrupt.  Shall be set to 2.  The first cell
+                    defines the interrupt number, the second encodes
+                    the trigger flags described in
+                    bindings/interrupt-controller/interrupts.txt
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
@@ -164,6 +175,11 @@ Example:
                   compatible = "actions,s900-pinctrl";
                   reg = <0x0 0xe01b0000 0x0 0x1000>;
                   clocks = <&cmu CLK_GPIO>;
+                  gpio-controller;
+                  gpio-ranges = <&pinctrl 0 0 146>;
+                  #gpio-cells = <2>;
+                  interrupt-controller;
+                  #interrupt-cells = <2>;
 
                   uart2-default: uart2-default {
                           pinmux {
-- 
2.14.1
