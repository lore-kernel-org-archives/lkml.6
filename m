Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DEEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6676B2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6676B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeGIWEj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:04:39 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.68]:30619 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932887AbeGIWEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:04:38 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7C7F4127E742
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 17:04:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ceGrf2IgakBj6ceGrfPba4; Mon, 09 Jul 2018 17:04:37 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51294 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fceGq-003k3v-QK; Mon, 09 Jul 2018 17:04:37 -0500
Date:   Mon, 9 Jul 2018 17:04:36 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] omapfb: Mark expected switch fall-throughs
Message-ID: <20180709220436.GA10751@embeddedor.com>
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
X-Exim-ID: 1fceGq-003k3v-QK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51294
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
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
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c   | 2 ++
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index fb605ae..8d63d1b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -1905,6 +1905,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
 			color_mode == OMAP_DSS_COLOR_UYVY)
 			width = width >> 1;
+		/* fall through */
 	case OMAP_DSS_ROT_90:
 	case OMAP_DSS_ROT_270:
 		*offset1 = 0;
@@ -1927,6 +1928,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
 			color_mode == OMAP_DSS_COLOR_UYVY)
 			width = width >> 1;
+		/* fall through */
 	case OMAP_DSS_ROT_90 + 4:
 	case OMAP_DSS_ROT_270 + 4:
 		*offset1 = 0;
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index e08e566..6b5a0db 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -893,6 +893,7 @@ int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl,
 				/ (var->bits_per_pixel >> 2);
 			break;
 		}
+		/* fall through */
 	default:
 		screen_width = fix->line_length / (var->bits_per_pixel >> 3);
 		break;
-- 
2.7.4

