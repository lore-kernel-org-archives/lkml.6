Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeFBQ40 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:56:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47045 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeFBQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:56:23 -0400
X-Google-Smtp-Source: ADUXVKKUQ3LFEFlT2MTGxcpmGV1iKm2QgmX8KR0xkzNyXRwheIUSf0aBRFlJNccZO/Yubc5pOXEiRw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: pinctrl: Add gpio interrupt bindings for Actions S900 SoC
Date: Sat,  2 Jun 2018 22:24:13 +0530
Message-Id: <20180602165415.30956-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio interrupt bindings for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pinctrl/actions,s900-pinctrl.txt          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
index 8fb5a53775e8..81b58dddd3ed 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -19,6 +19,10 @@ Required Properties:
                     defines the interrupt number, the second encodes
                     the trigger flags described in
                     bindings/interrupt-controller/interrupts.txt
+- interrupts: The interrupt outputs from the controller. There is one GPIO
+              interrupt per GPIO bank. The number of interrupts listed depends
+              on the number of GPIO banks on the SoC. The interrupts must be
+              ordered by bank, starting with bank 0.
 
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
@@ -180,6 +184,12 @@ Example:
                   #gpio-cells = <2>;
                   interrupt-controller;
                   #interrupt-cells = <2>;
+                  interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                               <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
                   uart2-default: uart2-default {
                           pinmux {
-- 
2.17.0
