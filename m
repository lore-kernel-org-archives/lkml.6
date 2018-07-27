Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4464020842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4464020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeG1ALh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:11:37 -0400
Received: from gateway30.websitewelcome.com ([192.185.198.26]:21090 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388497AbeG1ALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:11:37 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2018 20:11:37 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A5DEF5784
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:27:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jBCef8T7SPvAdjBCffBs6u; Fri, 27 Jul 2018 17:27:19 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.187] (port=34332 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fjBCd-000yzi-OD; Fri, 27 Jul 2018 17:27:15 -0500
Date:   Fri, 27 Jul 2018 17:27:14 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH linux-next] Remove PTR_RET
Message-ID: <20180727222714.GA21243@embeddedor.com>
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
X-Source-IP: 189.250.102.187
X-Source-L: No
X-Exim-ID: 1fjBCd-000yzi-OD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.187]:34332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last instances of PTR_RET have been replaced with PTR_ERR_OR_ZERO.

We can completely remove PTR_RET from the codebase now.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/err.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index 87be243..a139c64 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -62,9 +62,6 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 		return 0;
 }
 
-/* Deprecated */
-#define PTR_RET(p) PTR_ERR_OR_ZERO(p)
-
 #endif
 
 #endif /* _LINUX_ERR_H */
-- 
2.7.4

