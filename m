Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCNPmy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:42:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeCNPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:42:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 16/47] video/logo: remove obsolete logo files
Date: Wed, 14 Mar 2018 16:35:29 +0100
Message-Id: <20180314153603.3127932-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:jssXw5a3nFNRXCFdU9U3uowOLqHVPmqkbgFtUx3BLEgH0+tO4NA
 MYELjc4Tkkx9u11ch97OmEFlW3fAZO5EATMkhPV/QGgXscNcGKrMAoG/PrXMblmvmhmEvHA
 T0Jf2sbAhV6wMWCGRrsNgiyaQw8vEGQyQch7uARpgUN7sjs8YCIR4M9Rpa05G0ig1rLZc//
 CVRtjx8mqCPKQkEyXcU5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vQullhtKXs8=:X3LkPBtTqHvFacAin0cB0Q
 4BKGHz6PlbZTHYLO0lVzMSNxistJhujGtxDN+vDpb/1pE0JBtGgjVsOuCUdZ/3JXjZTdxt9f9
 cWVZlMqy2wa0gByhYRQoFp70eSxoatPdl05BdGJKNfHksK0FaimF+MFcaAudnhtIO/wKyWII9
 O4XBiBDgpB0KtqUft9c1byeuXRFcrHtgzIu4nKiGdikffAW6+OHm27KzRLlTRuafypTa2sHVL
 6HRiRgAMvgN7N0Do05e6xINcy+Gp4AAykEqza4mi03UOMnoMUVfJ9ApmDA0dk6vxFgPCZR5Uh
 SRcVJnIV8V+m+WsC+yabmasEnVS0g2TRl5NEBeuDZEHIw6LQF3ffGfE0uWU719LLYT1BlVOhn
 i2uq0V28QlwHHtNoihJJw6NQU1X/QWqf8w8quX7DOm4G8N0TFTP4HFFFBAuEVzw2v4k0AYgyv
 nSADx2ELZAHHUMMk07yb6zLIW8vsgIM02r/KjsxMpFFI/YfyTuyOy30MzajuJkqV/VxuhAHyY
 8Lrwa7ozMjZQrykSVWDj+aQT3fvdRIYd4VJBLGoLrzrVbxcfIdRL+xrXGCi8sil7QeTccPKQr
 tpiIc4x8sFucvaUllQ76dR2dj88Oi+shJFlsMdz6EGavNyK+bocfAPZOeBhXHvKQg0zeGXhod
 pKTALg6g8o8DydLXXYYfHL3L1NU8PZnoSB+5TXJN5P9zFQdsGK8WKd0iHeWQ26RNboB+NiI2l
 CnTCLc2gHwzRbyJsLiQIciV3B+oJh4rTHx3Mgg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin and m32r architectures are getting removed, so it's
time to clean up the logos as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/logo/Kconfig                   |   15 -
 drivers/video/logo/Makefile                  |    3 -
 drivers/video/logo/logo.c                    |   12 -
 drivers/video/logo/logo_blackfin_clut224.ppm | 1127 ----------------------
 drivers/video/logo/logo_blackfin_vga16.ppm   | 1127 ----------------------
 drivers/video/logo/logo_m32r_clut224.ppm     | 1292 --------------------------
 include/linux/linux_logo.h                   |    3 -
 7 files changed, 3579 deletions(-)
 delete mode 100644 drivers/video/logo/logo_blackfin_clut224.ppm
 delete mode 100644 drivers/video/logo/logo_blackfin_vga16.ppm
 delete mode 100644 drivers/video/logo/logo_m32r_clut224.ppm

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 0037104d66ac..d1f6196c8b9a 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -27,16 +27,6 @@ config LOGO_LINUX_CLUT224
 	bool "Standard 224-color Linux logo"
 	default y
 
-config LOGO_BLACKFIN_VGA16
-	bool "16-colour Blackfin Processor Linux logo"
-	depends on BLACKFIN
-	default y
-
-config LOGO_BLACKFIN_CLUT224
-	bool "224-colour Blackfin Processor Linux logo"
-	depends on BLACKFIN
-	default y
-
 config LOGO_DEC_CLUT224
 	bool "224-color Digital Equipment Corporation Linux logo"
 	depends on MACH_DECSTATION || ALPHA
@@ -77,9 +67,4 @@ config LOGO_SUPERH_CLUT224
 	depends on SUPERH
 	default y
 
-config LOGO_M32R_CLUT224
-	bool "224-color M32R Linux logo"
-	depends on M32R
-	default y
-
 endif # LOGO
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 6194373ee424..228a89b9bdd1 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -5,8 +5,6 @@ obj-$(CONFIG_LOGO)			+= logo.o
 obj-$(CONFIG_LOGO_LINUX_MONO)		+= logo_linux_mono.o
 obj-$(CONFIG_LOGO_LINUX_VGA16)		+= logo_linux_vga16.o
 obj-$(CONFIG_LOGO_LINUX_CLUT224)	+= logo_linux_clut224.o
-obj-$(CONFIG_LOGO_BLACKFIN_CLUT224)	+= logo_blackfin_clut224.o
-obj-$(CONFIG_LOGO_BLACKFIN_VGA16)	+= logo_blackfin_vga16.o
 obj-$(CONFIG_LOGO_DEC_CLUT224)		+= logo_dec_clut224.o
 obj-$(CONFIG_LOGO_MAC_CLUT224)		+= logo_mac_clut224.o
 obj-$(CONFIG_LOGO_PARISC_CLUT224)	+= logo_parisc_clut224.o
@@ -15,7 +13,6 @@ obj-$(CONFIG_LOGO_SUN_CLUT224)		+= logo_sun_clut224.o
 obj-$(CONFIG_LOGO_SUPERH_MONO)		+= logo_superh_mono.o
 obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
 obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
-obj-$(CONFIG_LOGO_M32R_CLUT224)		+= logo_m32r_clut224.o
 
 obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 4d50bfd13e7c..36aa050f9a21 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -63,10 +63,6 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 		/* Generic Linux logo */
 		logo = &logo_linux_vga16;
 #endif
-#ifdef CONFIG_LOGO_BLACKFIN_VGA16
-		/* Blackfin processor logo */
-		logo = &logo_blackfin_vga16;
-#endif
 #ifdef CONFIG_LOGO_SUPERH_VGA16
 		/* SuperH Linux logo */
 		logo = &logo_superh_vga16;
@@ -78,10 +74,6 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 		/* Generic Linux logo */
 		logo = &logo_linux_clut224;
 #endif
-#ifdef CONFIG_LOGO_BLACKFIN_CLUT224
-		/* Blackfin Linux logo */
-		logo = &logo_blackfin_clut224;
-#endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
 		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
 		logo = &logo_dec_clut224;
@@ -107,10 +99,6 @@ const struct linux_logo * __ref fb_find_logo(int depth)
 		/* SuperH Linux logo */
 		logo = &logo_superh_clut224;
 #endif
-#ifdef CONFIG_LOGO_M32R_CLUT224
-		/* M32R Linux logo */
-		logo = &logo_m32r_clut224;
-#endif
 	}
 	return logo;
 }
diff --git a/drivers/video/logo/logo_blackfin_clut224.ppm b/drivers/video/logo/logo_blackfin_clut224.ppm
deleted file mode 100644
index dc9a50a14477..000000000000
diff --git a/drivers/video/logo/logo_blackfin_vga16.ppm b/drivers/video/logo/logo_blackfin_vga16.ppm
deleted file mode 100644
index 1352b02a9d93..000000000000
diff --git a/drivers/video/logo/logo_m32r_clut224.ppm b/drivers/video/logo/logo_m32r_clut224.ppm
deleted file mode 100644
index 8b2983c5a0bd..000000000000
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index 5e3581d76c7f..d4d5b93efe84 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -36,8 +36,6 @@ struct linux_logo {
 extern const struct linux_logo logo_linux_mono;
 extern const struct linux_logo logo_linux_vga16;
 extern const struct linux_logo logo_linux_clut224;
-extern const struct linux_logo logo_blackfin_vga16;
-extern const struct linux_logo logo_blackfin_clut224;
 extern const struct linux_logo logo_dec_clut224;
 extern const struct linux_logo logo_mac_clut224;
 extern const struct linux_logo logo_parisc_clut224;
@@ -46,7 +44,6 @@ extern const struct linux_logo logo_sun_clut224;
 extern const struct linux_logo logo_superh_mono;
 extern const struct linux_logo logo_superh_vga16;
 extern const struct linux_logo logo_superh_clut224;
-extern const struct linux_logo logo_m32r_clut224;
 extern const struct linux_logo logo_spe_clut224;
 
 extern const struct linux_logo *fb_find_logo(int depth);
-- 
2.9.0
