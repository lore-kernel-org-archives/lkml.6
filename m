Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB5208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDB5208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeHBCxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:53:05 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.52]:34788 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729888AbeHBCxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:53:05 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 663B424C8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 20:04:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id l22bfkm3FSjJAl22bfUwYp; Wed, 01 Aug 2018 20:04:33 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=43488 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fl22a-0024da-Vh; Wed, 01 Aug 2018 20:04:33 -0500
Date:   Wed, 1 Aug 2018 20:04:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] sched/headers: Use true and false for boolean values
Message-ID: <20180802010432.GA32091@embeddedor.com>
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
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fl22a-0024da-Vh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:43488
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/sched/autogroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index b964199..238ac9e 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -43,7 +43,7 @@ static inline void autogroup_init(struct task_struct *init_task) {  }
 static inline void autogroup_free(struct task_group *tg) { }
 static inline bool task_group_is_autogroup(struct task_group *tg)
 {
-	return 0;
+	return false;
 }
 
 static inline struct task_group *
-- 
2.7.4

