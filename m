Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeERCcW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:32:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46496 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeERCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:32:17 -0400
X-Google-Smtp-Source: AB8JxZpQELmzyR/5JRgpBgErp9sKt3IDkFYDJ7PUIE+B9sCqQwq7qbSP3rl7xlXzxajwbGTW8qoxcw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
Date: Fri, 18 May 2018 08:00:52 +0530
Message-Id: <20180518023056.7869-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio bindings for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pinctrl/actions,s900-pinctrl.txt    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
index fb87c7d74f2e..300a50783aab 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -8,6 +8,15 @@ Required Properties:
 - reg:          Should contain the register base address and size of
                 the pin controller.
 - clocks:       phandle of the clock feeding the pin controller
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells:     Should be two. The first cell is the gpio pin number
+                   and the second cell is used for optional parameters.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:      Specifies the number of cells needed to encode an
+                        interrupt.  Shall be set to 2.  The first cell
+                        defines the interrupt number, the second encodes
+                        the trigger flags described in
+                        bindings/interrupt-controller/interrupts.txt
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
@@ -164,6 +173,10 @@ Example:
                   compatible = "actions,s900-pinctrl";
                   reg = <0x0 0xe01b0000 0x0 0x1000>;
                   clocks = <&cmu CLK_GPIO>;
+                  gpio-controller;
+                  #gpio-cells = <2>;
+                  interrupt-controller;
+                  #interrupt-cells = <2>;
 
                   uart2-default: uart2-default {
                           pinmux {
-- 
2.14.1
