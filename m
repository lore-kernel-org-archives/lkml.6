Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AC420892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AC420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbeKHBXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:23:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeKHBXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:23:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7Fpsrj1468338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 07:51:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7FprO11468333;
        Wed, 7 Nov 2018 07:51:53 -0800
Date:   Wed, 7 Nov 2018 07:51:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f26621e60b35369bca9228bc936dc723b3e421af@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        bp@suse.de, tglx@linutronix.de, torvalds@linux-foundation.org,
        mingo@kernel.org
Reply-To: bp@suse.de, tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <20181105093307.GA12445@zn.tnic>
References: <20181105093307.GA12445@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] resource/docs: Complete kernel-doc style function
 documentation
Git-Commit-ID: f26621e60b35369bca9228bc936dc723b3e421af
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

Commit-ID:  f26621e60b35369bca9228bc936dc723b3e421af
Gitweb:     https://git.kernel.org/tip/f26621e60b35369bca9228bc936dc723b3e421af
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 5 Nov 2018 10:33:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 7 Nov 2018 16:47:47 +0100

resource/docs: Complete kernel-doc style function documentation

Add the missing kernel-doc style function parameters documentation.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: linux-tip-commits@vger.kernel.org
Cc: rdunlap@infradead.org
Fixes: b69c2e20f6e4 ("resource: Clean it up a bit")
Link: http://lkml.kernel.org/r/20181105093307.GA12445@zn.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/resource.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 17bcb189d530..b0fbf685c77a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -318,17 +318,24 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
-/*
- * Finds the lowest iomem resource that covers part of [start..end].  The
- * caller must specify start, end, flags, and desc (which may be
+/**
+ * Finds the lowest iomem resource that covers part of [@start..@end].  The
+ * caller must specify @start, @end, @flags, and @desc (which may be
  * IORES_DESC_NONE).
  *
- * If a resource is found, returns 0 and *res is overwritten with the part
- * of the resource that's within [start..end]; if none is found, returns
- * -1. Returns -EINVAL for other invalid parameters.
+ * If a resource is found, returns 0 and @*res is overwritten with the part
+ * of the resource that's within [@start..@end]; if none is found, returns
+ * -1 or -EINVAL for other invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
+ *
+ * @start:	start address of the resource searched for
+ * @end:	end address of same resource
+ * @flags:	flags which the resource must have
+ * @desc:	descriptor the resource must have
+ * @first_lvl:	walk only the first level children, if set
+ * @res:	return ptr, if resource found
  */
 static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
@@ -390,9 +397,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 }
 
 /**
- * walk_iomem_res_desc - walk through iomem resources
- *
- * Walks through iomem resources and calls @func() with matching resource
+ * Walks through iomem resources and calls func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
  * All the memory ranges which overlap start,end and also match flags and
  * desc are valid candidates.
