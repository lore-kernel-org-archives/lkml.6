Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49308C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145620858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F145620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJHSwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:52:09 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:20063 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbeJHSwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:52:08 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 5F20C40132FCE
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 06:40:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9Tu5gCB8sPvAd9Tu5g1vEM; Mon, 08 Oct 2018 06:40:49 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:39242 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9Tu4-000Jhk-MN; Mon, 08 Oct 2018 06:40:48 -0500
Date:   Mon, 8 Oct 2018 13:40:46 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paul Bolle <pebolle@tiscali.nl>, Karsten Keil <isdn@linux-pingi.de>
Cc:     gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] isdn/gigaset: mark expected switch fall-throughs
Message-ID: <20181008114046.GA27098@embeddedor.com>
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
X-Exim-ID: 1g9Tu4-000Jhk-MN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:39242
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "--v-- fall through --v--" with a proper "fall through"
annotation. Also, change "bad cid: fall through" to
"fall through - bad cid".

This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/gigaset/ev-layer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/gigaset/ev-layer.c b/drivers/isdn/gigaset/ev-layer.c
index 1cfcea6..182826e 100644
--- a/drivers/isdn/gigaset/ev-layer.c
+++ b/drivers/isdn/gigaset/ev-layer.c
@@ -1036,7 +1036,7 @@ static void handle_icall(struct cardstate *cs, struct bc_state *bcs,
 		break;
 	default:
 		dev_err(cs->dev, "internal error: disposition=%d\n", retval);
-		/* --v-- fall through --v-- */
+		/* fall through */
 	case ICALL_IGNORE:
 	case ICALL_REJECT:
 		/* hang up actively
@@ -1319,7 +1319,7 @@ static void do_action(int action, struct cardstate *cs,
 			cs->commands_pending = 1;
 			break;
 		}
-		/* bad cid: fall through */
+		/* fall through - bad cid */
 	case ACT_FAILCID:
 		cs->cur_at_seq = SEQ_NONE;
 		channel = cs->curchannel;
-- 
2.7.4

