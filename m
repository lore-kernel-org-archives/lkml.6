Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF8CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD72086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDD72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933538AbeGIWmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:42:17 -0400
Received: from gateway36.websitewelcome.com ([50.116.127.2]:33555 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933364AbeGIWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:42:14 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id B57F240225635
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 16:43:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ceqpfc8KRaSeycer5fFYCD; Mon, 09 Jul 2018 17:42:12 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51878 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fceqp-003yJG-8r; Mon, 09 Jul 2018 17:41:47 -0500
Date:   Mon, 9 Jul 2018 17:41:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] video: fbdev: mark expected switch fall-throughs
Message-ID: <20180709224145.GA15004@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fceqp-003yJG-8r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51878
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/i740fb.c  | 1 +
 drivers/video/fbdev/pm2fb.c   | 2 ++
 drivers/video/fbdev/tdfxfb.c  | 1 +
 drivers/video/fbdev/via/lcd.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 7bc5f60..f6d7b04 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -429,6 +429,7 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 		break;
 	case 9 ... 15:
 		bpp = 15;
+		/* fall through */
 	case 16:
 		if ((1000000 / var->pixclock) > DACSPEED16) {
 			dev_err(info->device, "requested pixclock %i MHz out of range (max. %i MHz at 15/16bpp)\n",
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index bd6c2f5..1dcf02e 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -233,8 +233,10 @@ static u32 to3264(u32 timing, int bpp, int is64)
 	switch (bpp) {
 	case 24:
 		timing *= 3;
+		/* fall through */
 	case 8:
 		timing >>= 1;
+		/* fall through */
 	case 16:
 		timing >>= 1;
 	case 32:
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index dec1fed..fbbf26b 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -522,6 +522,7 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	case 32:
 		var->transp.offset = 24;
 		var->transp.length = 8;
+		/* fall through */
 	case 24:
 		var->red.offset = 16;
 		var->green.offset = 8;
diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 5d21ff4..b9305d7 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -758,6 +758,7 @@ static void set_lcd_output_path(int set_iga, int output_interface)
 		    viaparinfo->chip_info->gfx_chip_name))
 			viafb_write_reg_mask(CR97, VIACR, 0x84,
 				       BIT7 + BIT2 + BIT1 + BIT0);
+		/* fall through */
 	case INTERFACE_DVP0:
 	case INTERFACE_DVP1:
 	case INTERFACE_DFP_HIGH:
-- 
2.7.4

