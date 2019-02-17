Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A25C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212E2184E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBQXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:30:01 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43480 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBQXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:30:01 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C78AC29D9A; Sun, 17 Feb 2019 18:29:59 -0500 (EST)
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] video/macfb: Call fb_invert_cmaps()
Date:   Mon, 18 Feb 2019 10:25:27 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'inverse' parameter has no effect otherwise. Remove set-but-unused
variable.

Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/macfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 00671055a611..37c56c45ee39 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -136,7 +136,6 @@ static struct fb_fix_screeninfo macfb_fix = {
 static void *slot_addr;
 static struct fb_info fb_info;
 static u32 pseudo_palette[16];
-static int inverse;
 static int vidtest;
 
 /*
@@ -520,7 +519,7 @@ static void __init macfb_setup(char *options)
 			continue;
 
 		if (!strcmp(this_opt, "inverse"))
-			inverse = 1;
+			fb_invert_cmaps();
 		else
 			if (!strcmp(this_opt, "vidtest"))
 				vidtest = 1; /* enable experimental CLUT code */
-- 
2.19.2

