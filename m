Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeCIEjv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 23:39:51 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.228]:11203 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750898AbeCIEju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 23:39:50 -0500
From: Matheus Castello <matheus@castello.eng.br>
To: stefan.wahren@i2se.com, eric@anholt.net
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 3/3] pinctrl: bcm2835: Update docs about generic pinctrl bindings support
Date: Fri,  9 Mar 2018 00:16:14 -0400
Message-Id: <1520568974-15547-4-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520568974-15547-1-git-send-email-matheus@castello.eng.br>
References: <5b3419be-12ca-75d7-6f5e-d3338ddd7f14@castello.eng.br>
 <1520568974-15547-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1eu9Sj-003CXR-NE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:8442
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 26
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have generic pin configuration and multiplexing support,
ahd shoud be preferred than brcm legacy one.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
index 2569866..58b4720 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
@@ -36,6 +36,25 @@ listed. In other words, a subnode that lists only a mux function implies no
 information about any pull configuration. Similarly, a subnode that lists only
 a pul parameter implies no information about the mux function.
 
+This driver supports the generic pin multiplexing and configuration
+bindings. For details on each properties, you can refer to
+./pinctrl-bindings.txt.
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
