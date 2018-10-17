Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D82150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D82150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQU5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:57:20 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.252]:21440 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbeJQU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:57:19 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 236E91730598
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:01:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ClSGggxeeBcCXClSHgxc6P; Wed, 17 Oct 2018 08:01:41 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:60694 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gClSF-002JcJ-Hm; Wed, 17 Oct 2018 08:01:39 -0500
Date:   Wed, 17 Oct 2018 15:01:37 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: skbuff.h: Mark expected switch fall-throughs
Message-ID: <20181017130137.GA739@embeddedor.com>
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
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gClSF-002JcJ-Hm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:60694
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 119d092..0ba6874 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3505,13 +3505,19 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
 #define __it(x, op) (x -= sizeof(u##op))
 #define __it_diff(a, b, op) (*(u##op *)__it(a, op)) ^ (*(u##op *)__it(b, op))
 	case 32: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case 24: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case 16: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case  8: diffs |= __it_diff(a, b, 64);
 		break;
 	case 28: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case 20: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case 12: diffs |= __it_diff(a, b, 64);
+		 /* fall through */
 	case  4: diffs |= __it_diff(a, b, 32);
 		break;
 	}
-- 
2.7.4

