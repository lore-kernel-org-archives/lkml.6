Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCNJMe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:12:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33419 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeCNJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:12:32 -0400
X-Google-Smtp-Source: AG47ELs9og7rF7VLZlriAKyAehh9ObC853nTj704QDGVNzPl1h/69qgDGyjrvwgzOtAOkMmXX7LhhQ==
From: Lin Huang <hl@rock-chips.com>
To: thierry.reding@gmail.com
Cc: emil.l.velikov@gmail.com, briannorris@chromium.org, robh+dt@kernel.org,
        seanpaul@chromium.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 3/3] dt-bindings: Add INNOLUX P097PFG panel bindings
Date: Wed, 14 Mar 2018 17:12:16 +0800
Message-Id: <1521018736-20980-3-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huang lin <hl@rock-chips.com>

The Innolux P097PFG panel is 9.7" panel with 1536X2048
resolution, it reuse P079ZCA panel driver, so improve
p079ZCA dt-binding to support P097PFG.

Change-Id: I8704914898fe53b734d31fbe646df8aa5fd8b30d
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None

 .../devicetree/bindings/display/panel/innolux,p079zca.txt     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
index d0f5516..8cadd8c 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
@@ -1,13 +1,18 @@
 Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
+Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
 
 Required properties:
-- compatible: should be "innolux,p079zca"
+- compatible: should be should be one of the following.
+    -"innolux,p079zca" for Innolux 7.9" P079ZCA 768*1024 panel
+    -"innolux,p097pfg" for Innolux 9.7" P097PFG 1536*2048 panel
 - reg: DSI virtual channel of the peripheral
-- power-supply: phandle of the regulator that provides the supply voltage
 - enable-gpios: panel enable gpio
 
 Optional properties:
 - backlight: phandle of the backlight device attached to the panel
+- power-supply: phandle of the regulator that provides the supply voltage
+- avdd-supply: phandle of the regulator that provides positive voltage
+- avee-supply: phandle of the regulator that provides negative voltage
 
 Example:
 
@@ -16,6 +21,8 @@ Example:
 			compatible = "innolux,p079zca";
 			reg = <0>;
 			power-supply = <...>;
+			avdd-supply = <...>;
+			avee-supply = <...>;
 			backlight = <&backlight>;
 			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.7.4
