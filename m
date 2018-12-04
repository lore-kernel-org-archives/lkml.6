Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A79C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0536C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0536C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeLDWyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:54:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:54:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4MsXke1041122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 14:54:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4MsXaH1041119;
        Tue, 4 Dec 2018 14:54:33 -0800
Date:   Tue, 4 Dec 2018 14:54:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-4a67e3a79e3bdc47dfd0c85a1888067d95a0282c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        paulmck@linux.ibm.com, hpa@zytor.com, willy@infradead.org
Reply-To: hpa@zytor.com, paulmck@linux.ibm.com, willy@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] tools/kernel.h: Replace synchronize_sched() with
 synchronize_rcu()
Git-Commit-ID: 4a67e3a79e3bdc47dfd0c85a1888067d95a0282c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4a67e3a79e3bdc47dfd0c85a1888067d95a0282c
Gitweb:     https://git.kernel.org/tip/4a67e3a79e3bdc47dfd0c85a1888067d95a0282c
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Wed, 7 Nov 2018 15:25:13 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Sat, 1 Dec 2018 12:38:51 -0800

tools/kernel.h: Replace synchronize_sched() with synchronize_rcu()

Now that synchronize_rcu() waits for preempt-disable regions of code
as well as RCU read-side critical sections, synchronize_sched() can be
replaced by synchronize_rcu().  This commit therefore makes this change,
even though it is but a comment.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
---
 tools/include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 6935ef94e77a..857d9e22826e 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -116,6 +116,6 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...);
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
 #define current_gfp_context(k) 0
-#define synchronize_sched()
+#define synchronize_rcu()
 
 #endif
