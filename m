Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B9C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 02:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04815217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 02:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04815217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeHEEvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 00:51:39 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.65]:16858 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbeHEEvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 00:51:39 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 790F47427
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 21:48:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m965ftL6taSeym965fRwan; Sat, 04 Aug 2018 21:48:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=39292 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm964-0007lR-WB; Sat, 04 Aug 2018 21:48:45 -0500
Date:   Sat, 4 Aug 2018 21:48:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] kdb: kdb_support: mark expected switch fall-throughs
Message-ID: <20180805024844.GA15367@embeddedor.com>
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
X-Exim-ID: 1fm964-0007lR-WB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:39292
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the code comments with
a proper "fall through" annotation, which is what GCC is expecting
to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/debug/kdb/kdb_support.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 990b3cc..89ac604 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -432,7 +432,7 @@ int kdb_getphysword(unsigned long *word, unsigned long addr, size_t size)
 				*word = w8;
 			break;
 		}
-		/* drop through */
+		/* fall through */
 	default:
 		diag = KDB_BADWIDTH;
 		kdb_printf("kdb_getphysword: bad width %ld\n", (long) size);
@@ -481,7 +481,7 @@ int kdb_getword(unsigned long *word, unsigned long addr, size_t size)
 				*word = w8;
 			break;
 		}
-		/* drop through */
+		/* fall through */
 	default:
 		diag = KDB_BADWIDTH;
 		kdb_printf("kdb_getword: bad width %ld\n", (long) size);
@@ -525,7 +525,7 @@ int kdb_putword(unsigned long addr, unsigned long word, size_t size)
 			diag = kdb_putarea(addr, w8);
 			break;
 		}
-		/* drop through */
+		/* fall through */
 	default:
 		diag = KDB_BADWIDTH;
 		kdb_printf("kdb_putword: bad width %ld\n", (long) size);
-- 
2.7.4

