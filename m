Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966876AbeEYPv1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:51:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:33007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965666AbeEYPvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:25 -0400
MIME-Version: 1.0
Message-ID: <trinity-b1da805c-c37c-4bf8-9384-b923a3919016-1527263483541@3c-app-gmx-bs69>
From: "Frank Wunderlich" <FrankWu@gmx.de>
To: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Fw: fix green/blue pio-led on bpi-r2
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 May 2018 17:51:23 +0200
Importance: normal
Sensitivity: Normal
References: <trinity-63c216a4-492c-4250-934a-37dc10d0cb56-1527263229587@3c-app-gmx-bs69>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ujMcxgrbcYS8v3JkO7UbYwkqT20JWAJov4Q+k4Q9AHN
 AIVoDlABgAcXnGAXZOIbL4f6ExEd8JX6hLCBmKUbEnvf0lduxX
 7rAd0xV+uzI1bhAcHOjznGhn9SUa0lcuNZrdrNRFFdbuFWJA/U
 m+1C14pX7sfi1iWwRVtxQ5p1TOo5FY8M7NdXa5BOtkMQr2aT5y
 BcajfXQ3qnY15B/ToZe6KFkkybymQT5kzN9TD0iYg1bJGNfHwZ
 bqrBuDa1zAyd2twZqxKjFz4pNkG3iZmhO8POAaTTO30HlRDsY1 +vdNxs=
X-UI-Out-Filterresults: notjunk:1;V01:K0:qUQ+y0dipAM=:B2BscbwnCjYx2FPQ7xj0Vj
 /RNrmv90BGANDWybcSWrCblPBlw8nIWWfb8C5BsWvGLX+geTLH6RD5c50v65B0ChUZ/8n4n2P
 YxkD9D3Lgc0fLCbIHPfxySmT9gJzear9zjIyC6IPz74whzZBXAMxWv30CtiIEDa4YJE8eau47
 E/L9+IvrByQFgCFJtU8ypK8F6NEBb4TDMVdCra0xU585RS7Am3d0rWbcaOvmeelnj7mqV/xF3
 jpdWtHVRruK4HX/wOuVjEt0CehdOLd0CUNtrplEukP6KFfJqfboFtiFBJvxSd5YnIKf3lBFNp
 Zsbjo4+s/7iv1FkTxatlZaZA9oYfHG20Uz4gDAKBtfFrYtWRQFisSUhAkFztmLA+WPbS9DFXq
 Fl+d+//grfae7JDHN932puG9qpAQUoArEoY0SvBEHnG+nDCdRDgWpgKSxP6qSUPLt17mGyg4M
 KjHB7Jz3PoNyc+2RXQzJUzVU0HW0Sc4wasYNdiHgUcrtts/dxliq
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend to Mailinglist because of previous blocked  cause of html-format

Gesendet: Freitag, 25. Mai 2018 um 17:47 Uhr
Von: "Frank Wunderlich" <FrankWu@gmx.de>
An: "Matthias Brugger" <matthias.bgg@gmail.com>, "Rob Herring" <robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Betreff: fix green/blue pio-led on bpi-r2

Hi,
 
i've tested LEDs on bananapi-r2 and see that they stay on at boot-time and can be switched off by "echo 0", as this behaviour is not logical i changed that. Also green and blue are swapped by access their names in sysfs.
 
http://forum.banana-pi.org/t/control-on-board-leds/4287/33
 
hoping everything is alright with the patch (it's my first on here)
 
to test it:
 
[16:08] root@bpi-r2:~# L=/sys/class/leds/bpi-r2\:isink
[17:41] root@bpi-r2:~# L2=/sys/class/leds/bpi-r2\:pio
[17:42] root@bpi-r2:~# echo 1 > $L2:green/brightness
[17:42] root@bpi-r2:~# echo 1 > $L2:blue/brightness
[17:42] root@bpi-r2:~# echo 0 > $L2:green/brightness
[17:42] root@bpi-r2:~# echo 0 > $L2:blue/brightness
 
at least options needed:
CONFIG_SYSFS=y
CONFIG_GPIO_SYSFS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_GPIO=y
 
regards Frank
 
>From 850977bdb8cf05b1212c69232f03fd55293fe21a Mon Sep 17 00:00:00 2001
From: Frank Wunderlich <frank-w@public-files.de>
Date: Mon, 21 May 2018 21:38:53 +0200
Subject: [PATCH] [DTS] fix green/blue pio-led on bpi-r2
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 024bdb7d6cca5..6fa37a2764110 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -80,21 +80,21 @@
         pinctrl-names = "default";
         pinctrl-0 = <&led_pins_a>;
 
-        blue {
-            label = "bpi-r2:pio:blue";
-            gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
+        green {
+            label = "bpi-r2:pio:green";
+            gpios = <&pio 241 GPIO_ACTIVE_LOW>;
             default-state = "off";
         };
 
-        green {
-            label = "bpi-r2:pio:green";
-            gpios = <&pio 240 GPIO_ACTIVE_HIGH>;
+        blue {
+            label = "bpi-r2:pio:blue";
+            gpios = <&pio 240 GPIO_ACTIVE_LOW>;
             default-state = "off";
         };
 
         red {
             label = "bpi-r2:pio:red";
-            gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
+            gpios = <&pio 239 GPIO_ACTIVE_LOW>;
             default-state = "off";
         };
     };
