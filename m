Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDKFU4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:20:56 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.228]:30131 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751729AbeDKFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:20:55 -0400
From: Matheus Castello <matheus@castello.eng.br>
To: robh@kernel.org, stefan.wahren@i2se.com, eric@anholt.net
Cc: linus.walleij@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic pinctrl support
Date: Wed, 11 Apr 2018 00:58:44 -0400
Message-Id: <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523422726-7910-1-git-send-email-matheus@castello.eng.br>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
 <1523422726-7910-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1f67qU-002CSG-W1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:21541
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 23
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added generic pin configuration and multiplexing support,
and should be preferred than brcm legacy one.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
index 2569866..51fe305 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
@@ -36,6 +36,24 @@ listed. In other words, a subnode that lists only a mux function implies no
 information about any pull configuration. Similarly, a subnode that lists only
 a pul parameter implies no information about the mux function.

+The BCM2835 pin configuration and multiplexing supports the generic bindings.
+For details on each properties, you can refer to ./pinctrl-bindings.txt.
+
+Required sub-node properties:
+  - pins
+  - function
+
+Optional sub-node properties:
+  - bias-disable
+  - bias-pull-up
+  - bias-pull-down
+  - output-high
+  - output-low
+
+Legacy pin configuration and multiplexing binding:
+*** (Its use is deprecated, use generic multiplexing and configuration
+bindings instead)
+
 Required subnode-properties:
 - brcm,pins: An array of cells. Each cell contains the ID of a pin. Valid IDs
   are the integer GPIO IDs; 0==GPIO0, 1==GPIO1, ... 53==GPIO53.
--
2.7.4
