Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE371C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 04:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF42217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 04:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF42217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeHEGSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 02:18:07 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.189]:20503 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbeHEGSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 02:18:07 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E41A56AADB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 23:14:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mARWfu3ORaSeymARWfSe7q; Sat, 04 Aug 2018 23:14:58 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=39900 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fmARV-000b7j-U6; Sat, 04 Aug 2018 23:14:58 -0500
Date:   Sat, 4 Aug 2018 23:14:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] kdb: kdb_main: mark expected switch fall-throughs
Message-ID: <20180805041454.GA18449@embeddedor.com>
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
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fmARV-000b7j-U6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:39900
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115090 ("Missing break in switch")
Addresses-Coverity-ID: 115091 ("Missing break in switch")
Addresses-Coverity-ID: 114700 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/debug/kdb/kdb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 2ddfce8..2249645 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1545,13 +1545,16 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 				*c++ = printable_char(*cp++);
 				*c++ = printable_char(*cp++);
 				addr += 4;
+				/* fall through */
 			case 4:
 				*c++ = printable_char(*cp++);
 				*c++ = printable_char(*cp++);
 				addr += 2;
+				/* fall through */
 			case 2:
 				*c++ = printable_char(*cp++);
 				addr++;
+				/* fall through */
 			case 1:
 				*c++ = printable_char(*cp++);
 				addr++;
-- 
2.7.4

