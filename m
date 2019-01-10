Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E918214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfAJQzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:55:10 -0500
Received: from gateway30.websitewelcome.com ([192.185.168.15]:13578 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727344AbfAJQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:55:10 -0500
X-Greylist: delayed 1244 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 11:55:09 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 31ACF6916
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:34:25 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hdHlgWRwg2PzOhdHlgAa2s; Thu, 10 Jan 2019 10:34:25 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=57780 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghdHk-000J6q-1k; Thu, 10 Jan 2019 10:34:24 -0600
Date:   Thu, 10 Jan 2019 10:34:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ide: hpt366: mark expected switch fall-throughs
Message-ID: <20190110163423.GA17072@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghdHk-000J6q-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:57780
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

Notice that, in this particular case, I removed the "else: "
part from the comment. As we are now using Warning level 3:
-Wimplicit-fallthrough=3, this is what GCC is expecting to
find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ide/hpt366.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4d565b0c5a6e..0a3f9bcc8b04 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -574,7 +574,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 		if (!HPT370_ALLOW_ATA100_5 ||
 		    check_in_drive_list(drive, bad_ata100_5))
 			return ATA_UDMA4;
-		/* else: fall through */
+		/* fall through */
 	case HPT372 :
 	case HPT372A:
 	case HPT372N:
@@ -601,7 +601,7 @@ static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 	case HPT374 :
 		if (ata_id_is_sata(drive->id))
 			return 0x00;
-		/* else: fall through */
+		/* fall through */
 	default:
 		return 0x07;
 	}
-- 
2.20.1

