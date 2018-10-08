Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0FC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025322084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025322084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJHT1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:27:09 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.119]:47979 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbeJHT1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:27:09 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 901FA895EF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 07:15:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9URqguB32SjJA9URqgRUcB; Mon, 08 Oct 2018 07:15:42 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:39966 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9URp-000caK-NU; Mon, 08 Oct 2018 07:15:41 -0500
Date:   Mon, 8 Oct 2018 14:15:39 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paul Bolle <pebolle@tiscali.nl>, Karsten Keil <isdn@linux-pingi.de>
Cc:     gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] isdn/gigaset/isocdata: mark expected switch fall-through
Message-ID: <20181008121539.GA29109@embeddedor.com>
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
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g9URp-000caK-NU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:39966
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notice that in this particular case, I replaced the
"--v-- fall through --v--" comment with a proper
"fall through", which is what GCC is expecting to
find.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/gigaset/isocdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/gigaset/isocdata.c b/drivers/isdn/gigaset/isocdata.c
index 97e00118..f9264ba 100644
--- a/drivers/isdn/gigaset/isocdata.c
+++ b/drivers/isdn/gigaset/isocdata.c
@@ -906,7 +906,7 @@ static void cmd_loop(unsigned char *src, int numbytes, struct inbuf_t *inbuf)
 				cs->respdata[0] = 0;
 				break;
 			}
-			/* --v-- fall through --v-- */
+			/* fall through */
 		case '\r':
 			/* end of message line, pass to response handler */
 			if (cbytes >= MAX_RESP_SIZE) {
-- 
2.7.4

