Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED49BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCEA20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oNIg+4MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCEA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJHWwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:52:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58713 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJHWwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:52:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008154003euoutp02f0eaea919e3847a657c431d5cb0ac9cb~brFrWTfit2002920029euoutp02P
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 15:40:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008154003euoutp02f0eaea919e3847a657c431d5cb0ac9cb~brFrWTfit2002920029euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539013203;
        bh=DT1f/QDVxhmUm0Wlj5PqeIgi9RBkmw2l+DpmzalnCj4=;
        h=To:Cc:From:Subject:Date:References:From;
        b=oNIg+4MYWf4RtW49cVdoUU5jg09ZLL2lJ2kzlfaRQmzfeg1CIiNgVao+Rug836G+P
         wWcO/S5mVpbCG8UClCYUYzZB6mGGurHTOpXcY28kkvwqcHGZOWEzIDMMBoqTelWDJv
         EEkULX391X39N5fEfZluOs8HPExklOcFYSnbENN8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008154003eucas1p12486a86489fe1bd061eb51b82306d329~brFq9HTnf1356813568eucas1p1e;
        Mon,  8 Oct 2018 15:40:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.DC.04441.35A7BBB5; Mon,  8
        Oct 2018 16:40:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O;
        Mon,  8 Oct 2018 15:40:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008154002eusmtrp196e22714549efe1dc5972863a2bf81cf~brFqLKkKa1091910919eusmtrp1v;
        Mon,  8 Oct 2018 15:40:02 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-2a-5bbb7a532ae9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.23.04284.25A7BBB5; Mon,  8
        Oct 2018 16:40:02 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008154002eusmtip28f9fa3bce4994adf1d12cb56b53ed759~brFp7N_Pu0400304003eusmtip2e;
        Mon,  8 Oct 2018 15:40:02 +0000 (GMT)
To:     linux-fbdev@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: remove redundant 'default n' from Kconfig-s
Date:   Mon, 8 Oct 2018 17:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djPc7rBVbujDQ78YbK48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujN8vb7EXLAqr+Huvk7WBcY5TFyMn
        h4SAicTdbZ1MXYxcHEICKxglVux6ygzhfGGUuP3lEBuE85lR4mXzfiaYltNLZkMlljNK9J3b
        xg7hvGeU+Pj1HSNIlYiAvMSe/nawDmYBR4m//VuZQWw2ASuJie2rwGqEBbwkmh8+YQOxWQRU
        JN4u28jaxcjBISoQIdF/Rh0kzCsgKHFy5hMWiDHyEtvfzgE7T0LgOpvEi/PXWSGKyiROnXzG
        DHGdi8TBXzOgLhWWeHV8CzuELSNxenIPC0TzdEaJN7+WQjnrGSXWnDkG1WEtcfj4RbArmAU0
        Jdbv0ocIO0rcuTGZCSQsIcAnceOtIMRBfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt186VUKd5
        SPQ96gaLCwnESmy+380+gVFhFpI3ZyF5cxbCDQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXr
        JefnbmIEponT/45/2sH49VLSIUYBDkYlHt4ZebujhVgTy4orcw8xSnAwK4nwim7fFS3Em5JY
        WZValB9fVJqTWnyIUZqDRUmcd9m8jdFCAumJJanZqakFqUUwWSYOTqkGRpX/yssfuD5KNDH1
        OZJTevy4m1EHJ/+8drO08u0HeFKZXH0fXHJsq2Lpuuix6cwynqbzuYcVeiXYgkqjT4h+ydzD
        Pn+THOPtgsLNcrXrq6/OqTkTL7Zad9Ku6LpvM05JeqxSEXqZaX73b3r/0dbfr1QUNlhIMMeX
        3W9zWbVOM+finO++3JMXK7EUZyQaajEXFScCAB507WwPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xe7pBVbujDRYdlbO48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jN8vb7EXLAqr+Huvk7WBcY5TFyMnh4SAicTpJbPZuhi5OIQEljJK
        rHs3jbWLkQMoISNxfH0ZRI2wxJ9rXVA1bxkl/q3axwqSEBGQl9jT384EYjMLOEr87d/KDGKz
        CVhJTGxfxQhiCwt4STQ/fMIGYvMK2EmsOfSYBcRmEVCReLtsI9gcUYEIiVsPO1ggagQlTs58
        wgIxU13iz7xLzBC2vMT2t3OYJzDyz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIEBvO2Yz8372C8tDH4EKMAB6MSD++MvN3RQqyJZcWVuYcYJTiYlUR4RbfvihbiTUms
        rEotyo8vKs1JLT7EaAp0+ERmKdHkfGCk5ZXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnN
        Tk0tSC2C6WPi4JRqYIw6KX6uPeMhq6nkMwYeq+Xh7rIzcwzj5Kom/FOQEV6YoTL1kWZ0xNv9
        doGpdw+tvjD9i8DDifP2cgZdTszr3bWmuUaHYXftgfvFMdsYfzu89pd7421/g0NxOreAZYXS
        78kWX6eeqUtLiFtcrC7EnXPt1rYjLxT2Js4TF1iQOMtt286Ypby7JZVYijMSDbWYi4oTASvj
        qvZ8AgAA
Message-Id: <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
X-CMS-MailID: 20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449
References: <CGME20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig                  |   28 ---------------------------
 drivers/video/fbdev/mmp/hw/Kconfig           |    1 
 drivers/video/fbdev/mmp/panel/Kconfig        |    1 
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig |    7 ------
 4 files changed, 37 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2018-10-08 16:33:37.571968486 +0200
+++ b/drivers/video/fbdev/Kconfig	2018-10-08 17:21:23.632040663 +0200
@@ -47,7 +47,6 @@ menuconfig FB
 config FIRMWARE_EDID
        bool "Enable firmware EDID"
        depends on FB
-       default n
        ---help---
          This enables access to the EDID transferred from the firmware.
 	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
@@ -65,12 +64,10 @@ config FB_DDC
        depends on FB
        select I2C_ALGOBIT
        select I2C
-       default n
 
 config FB_BOOT_VESA_SUPPORT
 	bool
 	depends on FB
-	default n
 	---help---
 	  If true, at least one selected framebuffer driver can take advantage
 	  of VESA video modes set at an early boot stage via the vga= parameter.
@@ -78,7 +75,6 @@ config FB_BOOT_VESA_SUPPORT
 config FB_CFB_FILLRECT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -87,7 +83,6 @@ config FB_CFB_FILLRECT
 config FB_CFB_COPYAREA
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -96,7 +91,6 @@ config FB_CFB_COPYAREA
 config FB_CFB_IMAGEBLIT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -105,7 +99,6 @@ config FB_CFB_IMAGEBLIT
 config FB_CFB_REV_PIXELS_IN_BYTE
 	bool
 	depends on FB
-	default n
 	---help---
 	  Allow generic frame-buffer functions to work on displays with 1, 2
 	  and 4 bits per pixel depths which has opposite order of pixels in
@@ -114,7 +107,6 @@ config FB_CFB_REV_PIXELS_IN_BYTE
 config FB_SYS_FILLRECT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -123,7 +115,6 @@ config FB_SYS_FILLRECT
 config FB_SYS_COPYAREA
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -132,7 +123,6 @@ config FB_SYS_COPYAREA
 config FB_SYS_IMAGEBLIT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -141,7 +131,6 @@ config FB_SYS_IMAGEBLIT
 config FB_PROVIDE_GET_FB_UNMAPPED_AREA
 	bool
 	depends on FB
-	default n
 	---help---
 	  Allow generic frame-buffer to provide get_fb_unmapped_area
 	  function.
@@ -173,7 +162,6 @@ endchoice
 config FB_SYS_FOPS
        tristate
        depends on FB
-       default n
 
 config FB_DEFERRED_IO
 	bool
@@ -187,7 +175,6 @@ config FB_HECUBA
 config FB_SVGALIB
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Common utility functions useful to fbdev drivers of VGA-based
 	  cards.
@@ -195,19 +182,16 @@ config FB_SVGALIB
 config FB_MACMODES
        tristate
        depends on FB
-       default n
 
 config FB_BACKLIGHT
 	bool
 	depends on FB
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
-	default n
 
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
-	default n
 	---help---
 	  This enables functions for handling video modes using the
 	  Generalized Timing Formula and the EDID parser. A few drivers rely
@@ -218,7 +202,6 @@ config FB_MODE_HELPERS
 config FB_TILEBLITTING
        bool "Enable Tile Blitting Support"
        depends on FB
-       default n
        ---help---
          This enables tile blitting.  Tile blitting is a drawing technique
 	 where the screen is divided into rectangular sections (tiles), whereas
@@ -929,7 +912,6 @@ config FB_NVIDIA_I2C
 config FB_NVIDIA_DEBUG
 	bool "Lots of debug output"
 	depends on FB_NVIDIA
-	default n
 	help
 	  Say Y here if you want the nVidia driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -976,7 +958,6 @@ config FB_RIVA_I2C
 config FB_RIVA_DEBUG
 	bool "Lots of debug output"
 	depends on FB_RIVA
-	default n
 	help
 	  Say Y here if you want the Riva driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -1259,7 +1240,6 @@ config FB_RADEON_BACKLIGHT
 config FB_RADEON_DEBUG
 	bool "Lots of debug output from Radeon driver"
 	depends on FB_RADEON
-	default n
 	help
 	  Say Y here if you want the Radeon driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -1392,7 +1372,6 @@ config FB_SAVAGE_I2C
 config FB_SAVAGE_ACCEL
        bool "Enable Console Acceleration"
        depends on FB_SAVAGE
-       default n
        help
           This option will compile in console acceleration support. If
           the resulting framebuffer console has bothersome glitches, then
@@ -1449,7 +1428,6 @@ if FB_VIA
 
 config FB_VIA_DIRECT_PROCFS
 	bool "direct hardware access via procfs (DEPRECATED)(DANGEROUS)"
-	default n
 	help
 	  Allow direct hardware access to some output registers via procfs.
 	  This is dangerous but may provide the only chance to get the
@@ -1458,7 +1436,6 @@ config FB_VIA_DIRECT_PROCFS
 
 config FB_VIA_X_COMPATIBILITY
 	bool "X server compatibility"
-	default n
 	help
 	  This option reduces the functionality (power saving, ...) of the
 	  framebuffer to avoid negative impact on the OpenChrome X server.
@@ -1683,7 +1660,6 @@ config FB_WM8505
 config FB_WMT_GE_ROPS
 	bool "VT8500/WM8xxx accelerated raster ops support"
 	depends on (FB = y) && (FB_VT8500 || FB_WM8505)
-	default n
 	help
 	  This adds support for accelerated raster operations on the
 	  VIA VT8500 and Wondermedia 85xx series SoCs.
@@ -1793,17 +1769,14 @@ config FB_PXA
 
 config FB_PXA_OVERLAY
 	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
-	default n
 	depends on FB_PXA && (PXA27x || PXA3xx)
 
 config FB_PXA_SMARTPANEL
 	bool "PXA Smartpanel LCD support"
-	default n
 	depends on FB_PXA
 
 config FB_PXA_PARAMETERS
 	bool "PXA LCD command line parameters"
-	default n
 	depends on FB_PXA
 	---help---
 	  Enable the use of kernel command line or module parameters
@@ -1841,7 +1814,6 @@ config FB_MBX
 config FB_MBX_DEBUG
        bool "Enable debugging info via debugfs"
        depends on FB_MBX && DEBUG_FS
-       default n
        ---help---
          Enable this if you want debugging information using the debug
          filesystem (debugfs)
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/hw/Kconfig	2018-09-03 18:11:52.745791712 +0200
+++ b/drivers/video/fbdev/mmp/hw/Kconfig	2018-10-08 17:21:32.772040893 +0200
@@ -3,7 +3,6 @@ if MMP_DISP
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
 	depends on CPU_PXA910 || CPU_MMP2
-	default n
 	help
 		Marvell MMP display hw controller support
 		this controller is used on Marvell PXA910 and
Index: b/drivers/video/fbdev/mmp/panel/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/panel/Kconfig	2018-09-03 18:11:52.745791712 +0200
+++ b/drivers/video/fbdev/mmp/panel/Kconfig	2018-10-08 17:21:39.280041057 +0200
@@ -2,6 +2,5 @@
 config MMP_PANEL_TPOHVGA
 	bool "tpohvga panel TJ032MD01BW support"
 	depends on SPI_MASTER
-	default n
 	help
 		tpohvga panel support
Index: b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
===================================================================
--- a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig	2018-09-03 18:11:52.749791711 +0200
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig	2018-10-08 17:22:02.768041649 +0200
@@ -10,7 +10,6 @@ config FB_OMAP2_DSS
 
 config FB_OMAP2_DSS_DEBUG
 	bool "Debug support"
-	default n
 	help
 	  This enables printing of debug messages. Alternatively, debug messages
 	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
@@ -19,7 +18,6 @@ config FB_OMAP2_DSS_DEBUG
 config FB_OMAP2_DSS_DEBUGFS
 	bool "Debugfs filesystem support"
 	depends on DEBUG_FS
-	default n
 	help
 	  This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
 	  querying about clock configuration and register configuration of dss,
@@ -28,7 +26,6 @@ config FB_OMAP2_DSS_DEBUGFS
 config FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	bool "Collect DSS IRQ statistics"
 	depends on FB_OMAP2_DSS_DEBUGFS
-	default n
 	help
 	  Collect DSS IRQ statistics, printable via debugfs.
 
@@ -45,7 +42,6 @@ config FB_OMAP2_DSS_DPI
 config FB_OMAP2_DSS_RFBI
 	bool "RFBI support"
 	depends on BROKEN
-        default n
 	help
 	  MIPI DBI support (RFBI, Remote Framebuffer Interface, in Texas
 	  Instrument's terminology).
@@ -73,7 +69,6 @@ config FB_OMAP4_DSS_HDMI
 
 config FB_OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-	default n
 	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI Interface for OMAP5 and similar cores. This adds the High
@@ -82,7 +77,6 @@ config FB_OMAP5_DSS_HDMI
 
 config FB_OMAP2_DSS_SDI
 	bool "SDI support"
-        default n
 	help
 	  SDI (Serial Display Interface) support.
 
@@ -91,7 +85,6 @@ config FB_OMAP2_DSS_SDI
 
 config FB_OMAP2_DSS_DSI
 	bool "DSI support"
-        default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
 
