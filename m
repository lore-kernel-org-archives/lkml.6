Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC358C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3822145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3822145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJHXPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:15:21 -0400
Received: from gateway36.websitewelcome.com ([192.185.198.13]:40470 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbeJHXPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:15:21 -0400
X-Greylist: delayed 1449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2018 19:15:20 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id B916A40137370
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 09:45:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9Xc3gyy6tBcCX9XcHgI9H3; Mon, 08 Oct 2018 10:38:52 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:44784 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9Xc2-002kZ2-LZ; Mon, 08 Oct 2018 10:38:26 -0500
Date:   Mon, 8 Oct 2018 17:38:24 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: cyapa - mark expected switch fall-throughs
Message-ID: <20181008153824.GA14336@embeddedor.com>
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
X-Exim-ID: 1g9Xc2-002kZ2-LZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:44784
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the "Fallthrough state"
commern with a proper "Fall through", which is what GCC is expecting to
find.

Addresses-Coverity-ID: 114758 ("Missing break in switch")
Addresses-Coverity-ID: 114759 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/mouse/cyapa_gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 076dda4..00e395d 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -1067,7 +1067,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
 			return error;
 		}
 
-	/* Fallthrough state */
+	/* Fall through */
 	case CYAPA_STATE_BL_IDLE:
 		/* Try to get firmware version in bootloader mode. */
 		cyapa_gen3_bl_query_data(cyapa);
@@ -1078,7 +1078,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
 			return error;
 		}
 
-	/* Fallthrough state */
+	/* Fall through */
 	case CYAPA_STATE_OP:
 		/*
 		 * Reading query data before going back to the full mode
-- 
2.7.4

