Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966481AbeEJPqf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:46:35 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:46027 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966458AbeEJPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:29 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:541:800:857:960:968:973:988:989:1260:1345:1359:1437:1534:1544:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3867:3871:4419:4605:5007:6261:8603:10004:10848:11026:11658:11914:12043:12291:12296:12438:12555:12683:12895:13972:14093:14110:14181:14394:14721:21080:21433:21451:21627:21773:30054:30075,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: twist27_1b3d16fd5a32c
X-Filterd-Recvd-Size: 4892
From: Joe Perches <joe@perches.com>
To: Peter Jones <pjones@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] efifb: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:36 -0700
Message-Id: <b424c8d20ebdfe54adca5ceee86fd21e8a144f6e.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/efifb.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484e3da7..3a11174f194b 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -250,13 +250,13 @@ static int efifb_probe(struct platform_device *dev)
 	} else {
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
-		pr_warn("efifb: cannot reserve video memory at 0x%lx\n",
+		pr_warn("cannot reserve video memory at 0x%lx\n",
 			efifb_fix.smem_start);
 	}
 
 	info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
 	if (!info) {
-		pr_err("efifb: cannot allocate framebuffer\n");
+		pr_err("cannot allocate framebuffer\n");
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
@@ -277,23 +277,23 @@ static int efifb_probe(struct platform_device *dev)
 	else
 		info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
 	if (!info->screen_base) {
-		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
-			efifb_fix.smem_len, efifb_fix.smem_start);
+		pr_err("abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		       efifb_fix.smem_len, efifb_fix.smem_start);
 		err = -EIO;
 		goto err_release_fb;
 	}
 
-	pr_info("efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
-	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
-	pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
-	       efifb_defined.xres, efifb_defined.yres,
-	       efifb_defined.bits_per_pixel, efifb_fix.line_length,
-	       screen_info.pages);
+	pr_info("framebuffer at 0x%lx, using %dk, total %dk\n",
+		efifb_fix.smem_start, size_remap/1024, size_total/1024);
+	pr_info("mode is %dx%dx%d, linelength=%d, pages=%d\n",
+		efifb_defined.xres, efifb_defined.yres,
+		efifb_defined.bits_per_pixel, efifb_fix.line_length,
+		screen_info.pages);
 
 	efifb_defined.xres_virtual = efifb_defined.xres;
 	efifb_defined.yres_virtual = efifb_fix.smem_len /
 					efifb_fix.line_length;
-	pr_info("efifb: scrolling: redraw\n");
+	pr_info("scrolling: redraw\n");
 	efifb_defined.yres_virtual = efifb_defined.yres;
 
 	/* some dummy values for timing to make fbset happy */
@@ -311,17 +311,15 @@ static int efifb_probe(struct platform_device *dev)
 	efifb_defined.transp.offset = screen_info.rsvd_pos;
 	efifb_defined.transp.length = screen_info.rsvd_size;
 
-	pr_info("efifb: %s: "
-	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
-	       "Truecolor",
-	       screen_info.rsvd_size,
-	       screen_info.red_size,
-	       screen_info.green_size,
-	       screen_info.blue_size,
-	       screen_info.rsvd_pos,
-	       screen_info.red_pos,
-	       screen_info.green_pos,
-	       screen_info.blue_pos);
+	pr_info("Truecolor: size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+		screen_info.rsvd_size,
+		screen_info.red_size,
+		screen_info.green_size,
+		screen_info.blue_size,
+		screen_info.rsvd_pos,
+		screen_info.red_pos,
+		screen_info.green_pos,
+		screen_info.blue_pos);
 
 	efifb_fix.ypanstep  = 0;
 	efifb_fix.ywrapstep = 0;
@@ -350,17 +348,17 @@ static int efifb_probe(struct platform_device *dev)
 
 	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
 	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
+		pr_err("cannot add sysfs attrs\n");
 		goto err_unmap;
 	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
-		pr_err("efifb: cannot allocate colormap\n");
+		pr_err("cannot allocate colormap\n");
 		goto err_groups;
 	}
 	err = register_framebuffer(info);
 	if (err < 0) {
-		pr_err("efifb: cannot register framebuffer\n");
+		pr_err("cannot register framebuffer\n");
 		goto err_fb_dealoc;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
-- 
2.15.0
