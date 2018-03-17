Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeCQPGx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 11:06:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:59911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbeCQPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 11:06:51 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org
Subject: [PATCH] powerpc: wii.dts: Add drive slot LED
Date: Sat, 17 Mar 2018 16:06:17 +0100
Message-Id: <20180317150617.26913-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o+6YQhA/50aNuR5eNm1MmkCZy4j1HQoztX/9HUQTrja/RNtE/Nd
 N6oWT3NAA3JY9aY3Lt8UHDXgCmVktF8V7IY2ZO25jqQUKvblixLNFZwz5mDj+RBCCMW3Xyq
 WaloGP7Xpith6VOt0wxHwYszuanjCtYSmM5DCm66TubCoYcRcKLDdE9JzZwxMePJhDtnHS+
 QFMxetrMgGHy8D+UEycTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6hCM+DjODo0=:ujkA2MUv07BHoo6++uijfB
 bJ4Tz2UuOd74SNLEu7XinRsaDzvbVsZVEnZKeOV0qGTCGfwH1B5JJrcPoRTSrjmDqwyq/PPCW
 v/VVyFvTTXZmhA0x4FYtt9GUbQgCbHcFf6GKYDZgvYabOzxUHkprWfQQu7yJvqf735PLyIo0p
 SDjBoDpKBBQRiNmou1osD431Bb9h6f+0FWx1MwcAg1iggu1AHGrpM+XEpK74Fou6/hKHSEHO5
 yWU+pgR5sU5TaLRt6DBqK1yJxme2jmtzJ5+H/nLp0sapQeMvaez9RJC+pQwqBXrls9+/hZwkK
 sNG7eJNwfMUyTEzFkGyT4jTGAlheX0ZPsFqChXsTr9pAaoUxdAH56cfNEsOOXbbGmVBzNzCu6
 XEGAf7kMSJs0KF3kDPIvwMfODUGQjF06J5oO01OjSD2LA+h6JmwRDIaUmrumeyuWWswJeNQrn
 NzqOXr1WQZRG8SodT4vBfYdr+l1P/bpegkfyK+ysRscbEHmDZWQDwTEJgnpSkSwsDRsjWNG9k
 2/oRjXosnXxbCXOg8vx3V6Y4miJ8YtXFjuwJ7L35FiTxIs1kdO0YhIvde7ChSRMSc1/2EQtWk
 xsXymkRsF6b7Wvbtvqr0RZtAuLpvFLV98Z1iipCRh7LrJ5N8JfCQ9DPX7MGY2dJU8YqAPg1NZ
 HwqUgXSebk13dMcqticFXZCB8czzDOsR6d+Gd9WnbJP1WsgSiY+KIUTct1LPtjvH/dOC/BKjW
 0CjwMTaEvr3fTlM9m8Q9c7NQbdGfuRsC//hwPdLRzfqV3ExWpao2VSLeeo6hik2eZFXZAU9iD
 wOf+Hd9RayXAoiXPTzZe12tFv39v4JCJEzd7U9M4GL6dxu1ZMg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wii has a blue LED in the disk drive slot, which is controlled via a
GPIO line. Add this LED to wii.dts, and mark it as a panic-indicator.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/boot/dts/wii.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index d697f706fc22..a946a8f4bee3 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -13,6 +13,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 
 /*
  * This is commented-out for now.
@@ -228,5 +229,16 @@
 			interrupts = <2>;
 		};
 	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		/* This is the blue LED in the disk drive slot */
+		drive-slot {
+			label = "wii:blue:drive_slot";
+			gpios = <&GPIO 5 GPIO_ACTIVE_HIGH>;
+			panic-indicator;
+		};
+	};
 };
 
-- 
2.16.2
