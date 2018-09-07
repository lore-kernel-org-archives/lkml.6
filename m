Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033D92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033D92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeIHCft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:35:49 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:52781 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeIHCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:35:48 -0400
Received: from sed.home (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8B2232003B4;
        Fri,  7 Sep 2018 23:52:29 +0200 (CEST)
From:   Cedric Roux <sed@free.fr>
To:     kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cedric Roux <sed@free.fr>
Subject: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in mach-mini2440.c
Date:   Fri,  7 Sep 2018 23:54:45 +0200
Message-Id: <20180907215446.15160-1-sed@free.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running:
    scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
revealed several errors and warnings.

They were all removed, except one which is an #if 0 around the declaration
of a gpio pin. This needs some more investigation and I prefer to let it
here. This is not some dead code.

'printk' was replaced by 'pr_info'.

Signed-off-by: Cedric Roux <sed@free.fr>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 80 ++++++++++++++-------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index f9fc1f8d2b28..4a0bf6abba8c 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -64,8 +64,8 @@ static struct map_desc mini2440_iodesc[] __initdata = {
 };
 
 #define UCON S3C2410_UCON_DEFAULT
-#define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
-#define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
+#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
+#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
 
 
 static struct s3c2410_uartcfg mini2440_uartcfgs[] __initdata = {
@@ -104,8 +104,8 @@ static struct s3c2410_udc_mach_info mini2440_udc_cfg __initdata = {
 /*
  * This macro simplifies the table bellow
  */
-#define _LCD_DECLARE(_clock,_xres,margin_left,margin_right,hsync, \
-			_yres,margin_top,margin_bottom,vsync, refresh) \
+#define _LCD_DECLARE(_clock, _xres, margin_left, margin_right, hsync, \
+			_yres, margin_top, margin_bottom, vsync, refresh) \
 	.width = _xres, \
 	.xres = _xres, \
 	.height = _yres, \
@@ -128,7 +128,7 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 	[0] = {	/* mini2440 + 3.5" TFT + touchscreen */
 		_LCD_DECLARE(
 			7,			/* The 3.5 is quite fast */
-			240, 21, 38, 6, 	/* x timing */
+			240, 21, 38, 6,		/* x timing */
 			320, 4, 4, 2,		/* y timing */
 			60),			/* refresh rate */
 		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
@@ -140,7 +140,7 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 	[1] = { /* mini2440 + 7" TFT + touchscreen */
 		_LCD_DECLARE(
 			10,			/* the 7" runs slower */
-			800, 40, 40, 48, 	/* x timing */
+			800, 40, 40, 48,	/* x timing */
 			480, 29, 3, 3,		/* y timing */
 			50),			/* refresh rate */
 		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
@@ -148,7 +148,7 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 				   S3C2410_LCDCON5_INVVFRAME |
 				   S3C2410_LCDCON5_PWREN),
 	},
-	/* The VGA shield can outout at several resolutions. All share 
+	/* The VGA shield can outout at several resolutions. All share
 	 * the same timings, however, anything smaller than 1024x768
 	 * will only be displayed in the top left corner of a 1024x768
 	 * XGA output unless you add optional dip switches to the shield.
@@ -158,9 +158,10 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 		_LCD_DECLARE(
 			10,
 			1024, 1, 2, 2,		/* y timing */
-			768, 200, 16, 16, 	/* x timing */
+			768, 200, 16, 16,	/* x timing */
 			24),	/* refresh rate, maximum stable,
-				 tested with the FPGA shield */
+				 * tested with the FPGA shield
+				 */
 		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
 				   S3C2410_LCDCON5_HWSWP),
 	},
@@ -196,7 +197,8 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 
 	/* Enable VD[2..7], VD[10..15], VD[18..23] and VCLK, syncs, VDEN
 	 * and disable the pull down resistors on pins we are using for LCD
-	 * data. */
+	 * data.
+	 */
 
 	.gpcup		= (0xf << 1) | (0x3f << 10),
 
@@ -232,10 +234,10 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 /* MMC/SD  */
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
-   .gpio_detect   = S3C2410_GPG(8),
-   .gpio_wprotect = S3C2410_GPH(8),
-   .set_power     = NULL,
-   .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_detect   = S3C2410_GPG(8),
+	.gpio_wprotect = S3C2410_GPH(8),
+	.set_power     = NULL,
+	.ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
 /* NAND Flash on MINI2440 board */
@@ -254,7 +256,8 @@ static struct mtd_partition mini2440_default_nand_part[] __initdata = {
 	[2] = {
 		.name	= "kernel",
 		/* 5 megabytes, for a kernel with no modules
-		 * or a uImage with a ramdisk attached */
+		 * or a uImage with a ramdisk attached
+		 */
 		.size	= 0x00500000,
 		.offset	= SZ_256K + SZ_128K,
 	},
@@ -271,7 +274,7 @@ static struct s3c2410_nand_set mini2440_nand_sets[] __initdata = {
 		.nr_chips	= 1,
 		.nr_partitions	= ARRAY_SIZE(mini2440_default_nand_part),
 		.partitions	= mini2440_default_nand_part,
-		.flash_bbt 	= 1, /* we use u-boot to create a BBT */
+		.flash_bbt	= 1, /* we use u-boot to create a BBT */
 	},
 };
 
@@ -290,7 +293,7 @@ static struct s3c2410_platform_nand mini2440_nand_info __initdata = {
 static struct resource mini2440_dm9k_resource[] = {
 	[0] = DEFINE_RES_MEM(MACH_MINI2440_DM9K_BASE, 4),
 	[1] = DEFINE_RES_MEM(MACH_MINI2440_DM9K_BASE + 4, 4),
-	[2] = DEFINE_RES_NAMED(IRQ_EINT7, 1, NULL, IORESOURCE_IRQ \
+	[2] = DEFINE_RES_NAMED(IRQ_EINT7, 1, NULL, IORESOURCE_IRQ
 						| IORESOURCE_IRQ_HIGHEDGE),
 };
 
@@ -362,7 +365,8 @@ static struct gpio_keys_button mini2440_buttons[] = {
 	},
 #if 0
 	/* this pin is also known as TCLK1 and seems to already
-	 * marked as "in use" somehow in the kernel -- possibly wrongly */
+	 * marked as "in use" somehow in the kernel -- possibly wrongly
+	 */
 	{
 		.gpio		= S3C2410_GPG(11),	/* K6 */
 		.code		= KEY_F6,
@@ -564,7 +568,8 @@ static char mini2440_features_str[12] __initdata = "0tb";
 static int __init mini2440_features_setup(char *str)
 {
 	if (str)
-		strlcpy(mini2440_features_str, str, sizeof(mini2440_features_str));
+		strlcpy(mini2440_features_str, str,
+			sizeof(mini2440_features_str));
 	return 1;
 }
 
@@ -583,10 +588,10 @@ struct mini2440_features_t {
 };
 
 static void __init mini2440_parse_features(
-		struct mini2440_features_t * features,
-		const char * features_str )
+		struct mini2440_features_t *features,
+		const char *features_str)
 {
-	const char * fp = features_str;
+	const char *fp = features_str;
 
 	features->count = 0;
 	features->done = 0;
@@ -598,13 +603,14 @@ static void __init mini2440_parse_features(
 		switch (f) {
 		case '0'...'9':	/* tft screen */
 			if (features->done & FEATURE_SCREEN) {
-				printk(KERN_INFO "MINI2440: '%c' ignored, "
-					"screen type already set\n", f);
+				pr_info("MINI2440: '%c' ignored, screen type already set\n",
+					f);
 			} else {
 				int li = f - '0';
+
 				if (li >= ARRAY_SIZE(mini2440_lcd_cfg))
-					printk(KERN_INFO "MINI2440: "
-						"'%c' out of range LCD mode\n", f);
+					pr_info("MINI2440: '%c' out of range LCD mode\n",
+						f);
 				else {
 					features->optional[features->count++] =
 							&s3c_device_lcd;
@@ -615,8 +621,8 @@ static void __init mini2440_parse_features(
 			break;
 		case 'b':
 			if (features->done & FEATURE_BACKLIGHT)
-				printk(KERN_INFO "MINI2440: '%c' ignored, "
-					"backlight already set\n", f);
+				pr_info("MINI2440: '%c' ignored, backlight already set\n",
+					f);
 			else {
 				features->optional[features->count++] =
 						&mini2440_led_backlight;
@@ -624,13 +630,13 @@ static void __init mini2440_parse_features(
 			features->done |= FEATURE_BACKLIGHT;
 			break;
 		case 't':
-			printk(KERN_INFO "MINI2440: '%c' ignored, "
-				"touchscreen not compiled in\n", f);
+			pr_info("MINI2440: '%c' ignored, touchscreen not compiled in\n",
+				f);
 			break;
 		case 'c':
 			if (features->done & FEATURE_CAMERA)
-				printk(KERN_INFO "MINI2440: '%c' ignored, "
-					"camera already registered\n", f);
+				pr_info("MINI2440: '%c' ignored, camera already registered\n",
+					f);
 			else
 				features->optional[features->count++] =
 					&s3c_device_camif;
@@ -645,7 +651,7 @@ static void __init mini2440_init(void)
 	struct mini2440_features_t features = { 0 };
 	int i;
 
-	printk(KERN_INFO "MINI2440: Option string mini2440=%s\n",
+	pr_info("MINI2440: Option string mini2440=%s\n",
 			mini2440_features_str);
 
 	/* Parse the feature string */
@@ -674,17 +680,17 @@ static void __init mini2440_init(void)
 		mini2440_fb_info.displays =
 			&mini2440_lcd_cfg[features.lcd_index];
 
-		printk(KERN_INFO "MINI2440: LCD");
+		pr_info("MINI2440: LCD");
 		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
 			if (li == features.lcd_index)
-				printk(" [%d:%dx%d]", li,
+				pr_info(" [%d:%dx%d]", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
 			else
-				printk(" %d:%dx%d", li,
+				pr_info(" %d:%dx%d", li,
 					mini2440_lcd_cfg[li].width,
 					mini2440_lcd_cfg[li].height);
-		printk("\n");
+		pr_info("\n");
 		s3c24xx_fb_set_platdata(&mini2440_fb_info);
 	}
 
-- 
2.18.0

