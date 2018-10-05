Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ECC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C8820834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C8820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeJEU2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:28:02 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.225]:13991 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727701AbeJEU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:28:02 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D2F1D138D3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 08:29:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8QAPg48s4aSey8QAPgR63L; Fri, 05 Oct 2018 08:29:17 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:37494 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g8QAO-001RUe-Vq; Fri, 05 Oct 2018 08:29:17 -0500
Date:   Fri, 5 Oct 2018 15:29:09 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paul Bolle <pebolle@tiscali.nl>, Karsten Keil <isdn@linux-pingi.de>
Cc:     gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gigaset: asyncdata: mark expected switch fall-throughs
Message-ID: <20181005132909.GA5506@embeddedor.com>
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
X-Exim-ID: 1g8QAO-001RUe-Vq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:37494
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

Notice that in this particular case, I replaced the
" --v-- fall through --v-- " comment with a proper
"fall through", which is what GCC is expecting to find.

Addresses-Coverity-ID: 1364476 ("Missing break in switch")
Addresses-Coverity-ID: 1364477 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/gigaset/asyncdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/gigaset/asyncdata.c b/drivers/isdn/gigaset/asyncdata.c
index bc20855..c0cbee0 100644
--- a/drivers/isdn/gigaset/asyncdata.c
+++ b/drivers/isdn/gigaset/asyncdata.c
@@ -65,7 +65,7 @@ static unsigned cmd_loop(unsigned numbytes, struct inbuf_t *inbuf)
 				cs->respdata[0] = 0;
 				break;
 			}
-			/* --v-- fall through --v-- */
+			/* fall through */
 		case '\r':
 			/* end of message line, pass to response handler */
 			if (cbytes >= MAX_RESP_SIZE) {
@@ -100,7 +100,7 @@ static unsigned cmd_loop(unsigned numbytes, struct inbuf_t *inbuf)
 				goto exit;
 			}
 			/* quoted or not in DLE mode: treat as regular data */
-			/* --v-- fall through --v-- */
+			/* fall through */
 		default:
 			/* append to line buffer if possible */
 			if (cbytes < MAX_RESP_SIZE)
-- 
2.7.4

