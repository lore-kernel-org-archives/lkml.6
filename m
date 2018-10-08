Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A921C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23584204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OogA4+Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23584204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHVvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:51:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33001 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:51:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008143947euoutp01682ab969ae761dc80cd39c8f42d542cf~bqRDR9rCO1456614566euoutp013
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 14:39:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008143947euoutp01682ab969ae761dc80cd39c8f42d542cf~bqRDR9rCO1456614566euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539009587;
        bh=2hXhJG9nR52KD384ib1IoKm1nUJipcNM/OvD9VOonFg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=OogA4+NhPo1ipiXoWsaqZCyWKCwTeIo0+acDbAXynipcl66qaN1gycsnyA/hat1CX
         uUCkyUvbVYmY4bwTJwYuY+tpKLxUw8jihdr9IgqSjAfb+88pA/gJw+YPMKwCV7pqz2
         fwlVN/5MSrpDpvTmrB3ieN1Bwjw8BWI1f8Y6xRzo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008143946eucas1p2bf5474a6d386e530239b62b37f19d451~bqRC0JFab2389523895eucas1p2s;
        Mon,  8 Oct 2018 14:39:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.45.04441.23C6BBB5; Mon,  8
        Oct 2018 15:39:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb~bqRCEWq7m0204102041eucas1p1z;
        Mon,  8 Oct 2018 14:39:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181008143946eusmtrp250211e7a1d9a10361aaa0f3bb313e92d~bqRCDfveK1149411494eusmtrp2k;
        Mon,  8 Oct 2018 14:39:46 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-cc-5bbb6c32ddfd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.4B.04128.13C6BBB5; Mon,  8
        Oct 2018 15:39:45 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008143945eusmtip1328143a07412bb6292ec0bd079c4cf5e~bqRBtM_G62463924639eusmtip1R;
        Mon,  8 Oct 2018 14:39:45 +0000 (GMT)
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: remove dead old CLPS711x LCD support driver
Date:   Mon, 8 Oct 2018 16:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzneV2jnN3RBk8PqFhc+fqezWLT42us
        Fif6PrBaXN41h81i0g4pB1aP+93HmTw2L6n3mDL3CKvH501yASxRXDYpqTmZZalF+nYJXBkb
        D/oXfA6peNN5ir2B8aNzFyMnh4SAiUTz+vdsXYxcHEICKxglFr0+zgrhfGGU2P2nhR3C+cwo
        sWXWNSaYlsPNi5kgEssZJdY2zIJqec8osXTPRBaQKhEBdYlFD7ezgCSYBdoYJRbsuQHWziZg
        JTGxfRUjiC0s4CWxpfstWAOLgIrEgd8bgWwODlGBCIn+M+ogYV4BQYmTM5+AlTALyEtsfzuH
        GWSmhMB7NokDN9cwQRSVSbydso4Z4jwXif89b6FsYYlXx7ewQ9gyEv93zmeCaJ7OKPHm11IW
        CGc9o8SaM8egnrOWOHz8IivIFcwCmhLrd+lDhB0lWhe+AgtLCPBJ3HgrCHEQn8SkbdOZIcK8
        Eh1tQhDVahIblm1gg1nbtXMl1DkeEs1XH7KC2EICsRJXPnxmncCoMAvJm7OQvDkL4YYFjMyr
        GMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPJ6X/HP+1g/Hop6RCjAAejEg/vyoBd0UKs
        iWXFlbmHGCU4mJVEeEW3A4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUg
        tQgmy8TBKdXA2CTgqiB9Vyw30zYzJ0pvAeOfvls5NRxezFOmsZ5jMbo5/xZvq/CJpNmpyj9l
        819wBBs55JzZtXdtlf6ek2eV4tUfpkUs43R+ryHG6+P3VWLbjDJ+w3N1Zsd/PTvxLda2xNv4
        xKdnEus6nk3k2cR08oDP9BnGBh+8dm7aqqv8dm3EyRs3L9sbKLEUZyQaajEXFScCANVAQZAh
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xu7qGObujDfb0Wltc+fqezWLT42us
        Fif6PrBaXN41h81i0g4pB1aP+93HmTw2L6n3mDL3CKvH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkbD/oXfA6peNN5ir2B8aNzFyMn
        h4SAicTh5sVMXYxcHEICSxklVh+Yz97FyAGUkJE4vr4MokZY4s+1LjaImreMEjtutrODJEQE
        1CUWPdzOApJgFmhjlJjU0AWWYBOwkpjYvooRxBYW8JLY0v2WBcTmFbCT+L/xBRuIzSKgInHg
        90awuKhAhMSthx1QNYISJ2c+AbOZgRb8mXeJGcKWl9j+dg7zBEb+WUjKZiEpm4WkbAEj8ypG
        kdTS4tz03GIjveLE3OLSvHS95PzcTYzAgN927OeWHYxd74IPMQpwMCrx8K4I2BUtxJpYVlyZ
        e4hRgoNZSYRXdDtQiDclsbIqtSg/vqg0J7X4EKMp0OETmaVEk/OB0ZhXEm9oamhuYWlobmxu
        bGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHRcNmu5z4LTc5Uvth+fotozZaHU/VOr330
        iOXRB0exCM+jvVbHdQ1rP6bvumv987910/M3pdZmKj+a6/+8lGNLSbk/eVusevUXrT8J2o4u
        olu/+NySWMfYfEIiV375FdU/Lzbdli5v5T72a/OLnI3/GZ8sYAgxqWR/4MX/Zg+v9uK4pP7U
        Oqs8JZbijERDLeai4kQAtkWYu44CAAA=
Message-Id: <20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb~bqRCEWq7m0204102041eucas1p1z@eucas1p1.samsung.com>
X-CMS-MailID: 20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb
References: <CGME20181008143946eucas1p1c0180243a556c88a3a2186ebc17737cb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c86f51737f8d ("ARM: clps711x: Switch to MULTIPLATFORM")
ARCH_CLPS711X depends on ARCH_MULTIPLATFORM to be enabled so the old
CLPS711x LCD support driver (enabled by the FB_CLPS711X_OLD config
option) can't be selected any longer. Remove all FB_CLPS711XX_OLD
code as it has been dead for over 2 years now. Please note that the
new CLPS711x LCD support driver (enabled by the FB_CLPS711X config
option) is still available in the kernel tree.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig      |    7 
 drivers/video/fbdev/Makefile     |    1 
 drivers/video/fbdev/clps711xfb.c |  314 ---------------------------------------
 3 files changed, 322 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2018-10-08 12:57:36.743642088 +0200
+++ b/drivers/video/fbdev/Kconfig	2018-10-08 16:05:55.075926618 +0200
@@ -8,12 +8,6 @@ config FB_CMDLINE
 config FB_NOTIFY
 	bool
 
-config FB_CLPS711X_OLD
-	tristate
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-
 menuconfig FB
 	tristate "Support for frame buffer devices"
 	select FB_CMDLINE
@@ -338,7 +332,6 @@ config FB_ACORN
 config FB_CLPS711X
 	tristate "CLPS711X LCD support"
 	depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
-	select FB_CLPS711X_OLD if ARCH_CLPS711X && !ARCH_MULTIPLATFORM
 	select BACKLIGHT_LCD_SUPPORT
 	select FB_MODE_HELPERS
 	select FB_SYS_FILLRECT
Index: b/drivers/video/fbdev/Makefile
===================================================================
--- a/drivers/video/fbdev/Makefile	2018-09-03 18:11:52.693791712 +0200
+++ b/drivers/video/fbdev/Makefile	2018-10-08 16:05:33.391926072 +0200
@@ -14,7 +14,6 @@ obj-$(CONFIG_FB_WMT_GE_ROPS)   += wmt_ge
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
 obj-$(CONFIG_FB_ARC)              += arcfb.o
 obj-$(CONFIG_FB_CLPS711X)	  += clps711x-fb.o
-obj-$(CONFIG_FB_CLPS711X_OLD)	  += clps711xfb.o
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
 obj-$(CONFIG_FB_GRVGA)            += grvga.o
 obj-$(CONFIG_FB_PM2)              += pm2fb.o
Index: b/drivers/video/fbdev/clps711xfb.c
===================================================================
--- a/drivers/video/fbdev/clps711xfb.c	2018-09-03 18:11:52.705791712 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,314 +0,0 @@
-/*
- *  linux/drivers/video/clps711xfb.c
- *
- *  Copyright (C) 2000-2001 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *  Framebuffer driver for the CLPS7111 and EP7212 processors.
- */
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <linux/uaccess.h>
-
-struct fb_info	*cfb;
-
-#define CMAP_MAX_SIZE	16
-
-/*
- * LCD AC Prescale.  This comes from the LCD panel manufacturers specifications.
- * This determines how many clocks + 1 of CL1 before the M signal toggles.
- * The number of lines on the display must not be divisible by this number.
- */
-static unsigned int lcd_ac_prescale = 13;
-
-/*
- *    Set a single color register. Return != 0 for invalid regno.
- */
-static int
-clps7111fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-		     u_int transp, struct fb_info *info)
-{
-	unsigned int level, mask, shift, pal;
-
-	if (regno >= (1 << info->var.bits_per_pixel))
-		return 1;
-
-	/* gray = 0.30*R + 0.58*G + 0.11*B */
-	level = (red * 77 + green * 151 + blue * 28) >> 20;
-
-	/*
-	 * On an LCD, a high value is dark, while a low value is light. 
-	 * So we invert the level.
-	 *
-	 * This isn't true on all machines, so we only do it on EDB7211.
-	 *  --rmk
-	 */
-	if (machine_is_edb7211()) {
-		level = 15 - level;
-	}
-
-	shift = 4 * (regno & 7);
-	level <<= shift;
-	mask  = 15 << shift;
-	level &= mask;
-
-	regno = regno < 8 ? PALLSW : PALMSW;
-
-	pal = clps_readl(regno);
-	pal = (pal & ~mask) | level;
-	clps_writel(pal, regno);
-
-	return 0;
-}
-
-/*
- * Validate the purposed mode.
- */	
-static int
-clps7111fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	var->transp.msb_right	= 0;
-	var->transp.offset	= 0;
-	var->transp.length	= 0;
-	var->red.msb_right	= 0;
-	var->red.offset		= 0;
-	var->red.length		= var->bits_per_pixel;
-	var->green		= var->red;
-	var->blue		= var->red;
-
-	if (var->bits_per_pixel > 4) 
-		return -EINVAL;
-
-	return 0;
-}
-
-/*
- * Set the hardware state.
- */ 
-static int 
-clps7111fb_set_par(struct fb_info *info)
-{
-	unsigned int lcdcon, syscon, pixclock;
-
-	switch (info->var.bits_per_pixel) {
-	case 1:
-		info->fix.visual = FB_VISUAL_MONO01;
-		break;
-	case 2:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 4:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	}
-
-	info->fix.line_length = info->var.xres_virtual * info->var.bits_per_pixel / 8;
-
-	lcdcon = (info->var.xres_virtual * info->var.yres_virtual * info->var.bits_per_pixel) / 128 - 1;
-	lcdcon |= ((info->var.xres_virtual / 16) - 1) << 13;
-	lcdcon |= lcd_ac_prescale << 25;
-
-	/*
-	 * Calculate pixel prescale value from the pixclock.  This is:
-	 *  36.864MHz / pixclock_mhz - 1.
-	 * However, pixclock is in picoseconds, so this ends up being:
-	 *  36864000 * pixclock_ps / 10^12 - 1
-	 * and this will overflow the 32-bit math.  We perform this as
-	 * (9 * 4096000 == 36864000):
-	 *  pixclock_ps * 9 * (4096000 / 10^12) - 1
-	 */
-	pixclock = 9 * info->var.pixclock / 244140 - 1;
-	lcdcon |= pixclock << 19;
-
-	if (info->var.bits_per_pixel == 4)
-		lcdcon |= LCDCON_GSMD;
-	if (info->var.bits_per_pixel >= 2)
-		lcdcon |= LCDCON_GSEN;
-
-	/*
-	 * LCDCON must only be changed while the LCD is disabled
-	 */
-	syscon = clps_readl(SYSCON1);
-	clps_writel(syscon & ~SYSCON1_LCDEN, SYSCON1);
-	clps_writel(lcdcon, LCDCON);
-	clps_writel(syscon | SYSCON1_LCDEN, SYSCON1);
-	return 0;
-}
-
-static int clps7111fb_blank(int blank, struct fb_info *info)
-{
-	/* Enable/Disable LCD controller. */
-	if (blank)
-		clps_writel(clps_readl(SYSCON1) & ~SYSCON1_LCDEN, SYSCON1);
-	else
-		clps_writel(clps_readl(SYSCON1) | SYSCON1_LCDEN, SYSCON1);
-
-	return 0;
-}
-
-static struct fb_ops clps7111fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_check_var	= clps7111fb_check_var,
-	.fb_set_par	= clps7111fb_set_par,
-	.fb_setcolreg	= clps7111fb_setcolreg,
-	.fb_blank	= clps7111fb_blank,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
-
-static void clps711x_guess_lcd_params(struct fb_info *info)
-{
-	unsigned int lcdcon, syscon, size;
-	unsigned long phys_base = PAGE_OFFSET;
-	void *virt_base = (void *)PAGE_OFFSET;
-
-	info->var.xres_virtual	 = 640;
-	info->var.yres_virtual	 = 240;
-	info->var.bits_per_pixel = 4;
-	info->var.activate	 = FB_ACTIVATE_NOW;
-	info->var.height	 = -1;
-	info->var.width		 = -1;
-	info->var.pixclock	 = 93006; /* 10.752MHz pixel clock */
-
-	/*
-	 * If the LCD controller is already running, decode the values
-	 * in LCDCON to xres/yres/bpp/pixclock/acprescale
-	 */
-	syscon = clps_readl(SYSCON1);
-	if (syscon & SYSCON1_LCDEN) {
-		lcdcon = clps_readl(LCDCON);
-
-		/*
-		 * Decode GSMD and GSEN bits to bits per pixel
-		 */
-		switch (lcdcon & (LCDCON_GSMD | LCDCON_GSEN)) {
-		case LCDCON_GSMD | LCDCON_GSEN:
-			info->var.bits_per_pixel = 4;
-			break;
-
-		case LCDCON_GSEN:
-			info->var.bits_per_pixel = 2;
-			break;
-
-		default:
-			info->var.bits_per_pixel = 1;
-			break;
-		}
-
-		/*
-		 * Decode xres/yres
-		 */
-		info->var.xres_virtual = (((lcdcon >> 13) & 0x3f) + 1) * 16;
-		info->var.yres_virtual = (((lcdcon & 0x1fff) + 1) * 128) /
-					  (info->var.xres_virtual *
-					   info->var.bits_per_pixel);
-
-		/*
-		 * Calculate pixclock
-		 */
-		info->var.pixclock = (((lcdcon >> 19) & 0x3f) + 1) * 244140 / 9;
-
-		/*
-		 * Grab AC prescale
-		 */
-		lcd_ac_prescale = (lcdcon >> 25) & 0x1f;
-	}
-
-	info->var.xres = info->var.xres_virtual;
-	info->var.yres = info->var.yres_virtual;
-	info->var.grayscale = info->var.bits_per_pixel > 1;
-
-	size = info->var.xres * info->var.yres * info->var.bits_per_pixel / 8;
-
-	/*
-	 * Might be worth checking to see if we can use the on-board
-	 * RAM if size here...
-	 * CLPS7110 - no on-board SRAM
-	 * EP7212   - 38400 bytes
-	 */
-	if (size <= 38400) {
-		printk(KERN_INFO "CLPS711xFB: could use on-board SRAM?\n");
-	}
-
-	if ((syscon & SYSCON1_LCDEN) == 0) {
-		/*
-		 * The display isn't running.  Ensure that
-		 * the display memory is empty.
-		 */
-		memset(virt_base, 0, size);
-	}
-
-	info->screen_base    = virt_base;
-	info->fix.smem_start = phys_base;
-	info->fix.smem_len   = PAGE_ALIGN(size);
-	info->fix.type       = FB_TYPE_PACKED_PIXELS;
-}
-
-static int clps711x_fb_probe(struct platform_device *pdev)
-{
-	int err = -ENOMEM;
-
-	if (fb_get_options("clps711xfb", NULL))
-		return -ENODEV;
-
-	cfb = kzalloc(sizeof(*cfb), GFP_KERNEL);
-	if (!cfb)
-		goto out;
-
-	strcpy(cfb->fix.id, "clps711x");
-
-	cfb->fbops		= &clps7111fb_ops;
-	cfb->flags		= FBINFO_DEFAULT;
-
-	clps711x_guess_lcd_params(cfb);
-
-	fb_alloc_cmap(&cfb->cmap, CMAP_MAX_SIZE, 0);
-
-	err = register_framebuffer(cfb);
-
-out:	return err;
-}
-
-static int clps711x_fb_remove(struct platform_device *pdev)
-{
-	unregister_framebuffer(cfb);
-	kfree(cfb);
-
-	return 0;
-}
-
-static struct platform_driver clps711x_fb_driver = {
-	.driver	= {
-		.name	= "video-clps711x",
-	},
-	.probe	= clps711x_fb_probe,
-	.remove	= clps711x_fb_remove,
-};
-module_platform_driver(clps711x_fb_driver);
-
-MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
-MODULE_DESCRIPTION("CLPS711X framebuffer driver");
-MODULE_LICENSE("GPL");
