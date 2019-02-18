Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164E217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfBRWry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:47:54 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43399 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbfBRWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:47:52 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 6223929DC1; Mon, 18 Feb 2019 17:47:49 -0500 (EST)
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] video/macfb: Always initialize DAFB colour table pointer
 register
Date:   Tue, 19 Feb 2019 09:44:54 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't skip the framebuffer CLUT pointer register initialization when
the first dafb_setpalette() invocation has regno equal to zero.

Cc: linux-m68k@lists.linux-m68k.org
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/macfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 37c56c45ee39..8820a556014c 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -148,7 +148,7 @@ static int dafb_setpalette(unsigned int regno, unsigned int red,
 			   unsigned int green, unsigned int blue,
 			   struct fb_info *info)
 {
-	static int lastreg = -1;
+	static int lastreg = -2;
 	unsigned long flags;
 
 	local_irq_save(flags);
-- 
2.19.2

