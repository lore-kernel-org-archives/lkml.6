Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3913C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74364208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74364208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeHBNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:49:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbeHBNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:49:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72BvuKl3490712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 04:57:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72BvtZP3490708;
        Thu, 2 Aug 2018 04:57:55 -0700
Date:   Thu, 2 Aug 2018 04:57:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhong Jiang <tipbot@zytor.com>
Message-ID: <tip-3ff4f80a74fd38398ae1bd8a458ba9c51aa0dd44@git.kernel.org>
Cc:     yang.shi@linux.alibaba.com, zhongjiang@huawei.com, arnd@arndb.de,
        mingo@kernel.org, longman@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          longman@redhat.com, mingo@kernel.org, yang.shi@linux.alibaba.com,
          zhongjiang@huawei.com, arnd@arndb.de
In-Reply-To: <1533054298-35824-1-git-send-email-zhongjiang@huawei.com>
References: <1533054298-35824-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Remove redundant NULL pointer
 check
Git-Commit-ID: 3ff4f80a74fd38398ae1bd8a458ba9c51aa0dd44
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

Commit-ID:  3ff4f80a74fd38398ae1bd8a458ba9c51aa0dd44
Gitweb:     https://git.kernel.org/tip/3ff4f80a74fd38398ae1bd8a458ba9c51aa0dd44
Author:     Zhong Jiang <zhongjiang@huawei.com>
AuthorDate: Wed, 1 Aug 2018 00:24:58 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 13:53:04 +0200

debugobjects: Remove redundant NULL pointer check

kmem_cache_destroy() has a built in NULL pointer check, so the one at the
call can be removed.

Signed-off-by: Zhong Jiang <zhongjiang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <longman@redhat.com>
Cc: <arnd@arndb.de>
Cc: <yang.shi@linux.alibaba.com>
Link: https://lkml.kernel.org/r/1533054298-35824-1-git-send-email-zhongjiang@huawei.com

---
 lib/debugobjects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 24c1df0d7466..70935ed91125 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1188,8 +1188,7 @@ void __init debug_objects_mem_init(void)
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-		if (obj_cache)
-			kmem_cache_destroy(obj_cache);
+		kmem_cache_destroy(obj_cache);
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
