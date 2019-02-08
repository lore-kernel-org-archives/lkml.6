Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D858C282D7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329D6218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBHSGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:06:18 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:37640 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbfBHSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:06:18 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3BBEA400CD8B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 12:06:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sAXZgZoOQdnCesAXZgZjNF; Fri, 08 Feb 2019 12:06:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=57552 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsAXY-004Bi0-80; Fri, 08 Feb 2019 12:06:16 -0600
Date:   Fri, 8 Feb 2019 12:06:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: cfi_cmdset_0002: Mark expected switch fall-throughs
Message-ID: <20190208180615.GA24601@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gsAXY-004Bi0-80
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:57552
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mtd/chips/cfi_cmdset_0002.c: In function ‘get_chip’:
drivers/mtd/chips/cfi_cmdset_0002.c:870:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (mode == FL_READY && chip->oldstate == FL_READY)
      ^
drivers/mtd/chips/cfi_cmdset_0002.c:873:2: note: here
  default:
  ^~~~~~~
drivers/mtd/chips/cfi_cmdset_0002.c: In function ‘cfi_amdstd_sync’:
drivers/mtd/chips/cfi_cmdset_0002.c:2745:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
    chip->state = FL_SYNCING;
    ~~~~~~~~~~~~^~~~~~~~~~~~
drivers/mtd/chips/cfi_cmdset_0002.c:2750:3: note: here
   case FL_SYNCING:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 72428b6bfc47..0b0a1874d3bf 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -869,6 +869,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
 		/* Only if there's no operation suspended... */
 		if (mode == FL_READY && chip->oldstate == FL_READY)
 			return 0;
+		/* fall through */
 
 	default:
 	sleep:
@@ -2747,6 +2748,7 @@ static void cfi_amdstd_sync (struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			/* fall through */
 		case FL_SYNCING:
 			mutex_unlock(&chip->mutex);
 			break;
-- 
2.20.1

