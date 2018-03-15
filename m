Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCOLlm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:41:42 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59338 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbeCOLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:40 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm/sun4i: Add DT binding for Detail Enhancement Unit in Allwinner A80 SoC
Date: Thu, 15 Mar 2018 19:41:30 +0800
Message-Id: <20180315114136.24747-3-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display pipeline on the A80 SoC has what is called the Detail
Enhancement Unit, or DEU for short, block in between the display
frontend and backend. This unit can sharpen images in both luma
and chroma channels. It seems to also do colorspace conversion.

This patch adds the device tree binding for this hardware block.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/display/sunxi/sun4i-drm.txt           | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index c05cbcdde4d7..671d75c76ad0 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -248,6 +248,28 @@ On the A33, some additional properties are required:
   - resets and reset-names need to have a phandle to the SAT bus
     resets, whose name will be "sat"
 
+DEU
+---
+
+The DEU (Detail Enhancement Unit), found in the Allwinner A80 SoC,
+can sharpen the display content in both luma and chroma channels.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun9i-a80-deu
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the DEU
+    * ahb: the DEU interface clock
+    * mod: the DEU module clock
+    * ram: the DEU DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset line driving the DEU
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the outputs
+
 Display Engine Frontend
 -----------------------
 
-- 
2.16.2
