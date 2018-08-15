Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF495C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578E2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C578E2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeHOTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:55:34 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.216]:43433 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729381AbeHOTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:55:34 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0580B12EF22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:02:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pzBlfBUOABcCXpzBqfjPUU; Wed, 15 Aug 2018 12:02:35 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=60314 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpzBk-004KFO-1q; Wed, 15 Aug 2018 12:02:28 -0500
Date:   Wed, 15 Aug 2018 12:02:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: cfi_cmdset_0020: Mark expected switch fall-throughs
Message-ID: <20180815170226.GA14553@embeddedor.com>
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
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpzBk-004KFO-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:60314
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114857 ("Missing break in switch")
Addresses-Coverity-ID: 114858 ("Missing break in switch")
Addresses-Coverity-ID: 114859 ("Missing break in switch")
Addresses-Coverity-ID: 114860 ("Missing break in switch")
Addresses-Coverity-ID: 114861 ("Missing break in switch")
Addresses-Coverity-ID: 114862 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/chips/cfi_cmdset_0020.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index 35aa72b..e752067 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -324,6 +324,7 @@ static inline int do_read_onechip(struct map_info *map, struct flchip *chip, lof
 	case FL_JEDEC_QUERY:
 		map_write(map, CMD(0x70), cmd_addr);
 		chip->state = FL_STATUS;
+		/* Fall through */
 
 	case FL_STATUS:
 		status = map_read(map, cmd_addr);
@@ -461,6 +462,7 @@ static int do_write_buffer(struct map_info *map, struct flchip *chip,
 #ifdef DEBUG_CFI_FEATURES
 	printk("%s: 1 status[%x]\n", __func__, map_read(map, cmd_adr));
 #endif
+		/* Fall through */
 
 	case FL_STATUS:
 		status = map_read(map, cmd_adr);
@@ -754,6 +756,7 @@ static inline int do_erase_oneblock(struct map_info *map, struct flchip *chip, u
 	case FL_READY:
 		map_write(map, CMD(0x70), adr);
 		chip->state = FL_STATUS;
+		/* Fall through */
 
 	case FL_STATUS:
 		status = map_read(map, adr);
@@ -995,6 +998,7 @@ static void cfi_staa_sync (struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			/* Fall through */
 		case FL_SYNCING:
 			mutex_unlock(&chip->mutex);
 			break;
@@ -1050,6 +1054,7 @@ static inline int do_lock_oneblock(struct map_info *map, struct flchip *chip, un
 	case FL_READY:
 		map_write(map, CMD(0x70), adr);
 		chip->state = FL_STATUS;
+		/* Fall through */
 
 	case FL_STATUS:
 		status = map_read(map, adr);
@@ -1196,6 +1201,7 @@ static inline int do_unlock_oneblock(struct map_info *map, struct flchip *chip,
 	case FL_READY:
 		map_write(map, CMD(0x70), adr);
 		chip->state = FL_STATUS;
+		/* Fall through */
 
 	case FL_STATUS:
 		status = map_read(map, adr);
-- 
2.7.4

