Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F34C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6E204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeKEP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:28:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeKEP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:28:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA569oXi218054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 22:09:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA569oNr218051;
        Sun, 4 Nov 2018 22:09:50 -0800
Date:   Sun, 4 Nov 2018 22:09:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-f75d651587f719a813ebbbfeee570e6570731d55@git.kernel.org>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        rdunlap@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, bp@suse.de,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          rdunlap@infradead.org, mingo@kernel.org,
          akpm@linux-foundation.org, peterz@infradead.org, bp@suse.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <dda2e4d8-bedd-3167-20fe-8c7d2d35b354@infradead.org>
References: <dda2e4d8-bedd-3167-20fe-8c7d2d35b354@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] resource/docs: Fix new kernel-doc warnings
Git-Commit-ID: f75d651587f719a813ebbbfeee570e6570731d55
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

Commit-ID:  f75d651587f719a813ebbbfeee570e6570731d55
Gitweb:     https://git.kernel.org/tip/f75d651587f719a813ebbbfeee570e6570731d55
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sun, 4 Nov 2018 18:40:14 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Nov 2018 07:05:04 +0100

resource/docs: Fix new kernel-doc warnings

The first group of warnings is caused by a "/**" kernel-doc notation
marker but the function comments are not in kernel-doc format.
Also add another error return value here.

  ../kernel/resource.c:337: warning: Function parameter or member 'start' not described in 'find_next_iomem_res'
  ../kernel/resource.c:337: warning: Function parameter or member 'end' not described in 'find_next_iomem_res'
  ../kernel/resource.c:337: warning: Function parameter or member 'flags' not described in 'find_next_iomem_res'
  ../kernel/resource.c:337: warning: Function parameter or member 'desc' not described in 'find_next_iomem_res'
  ../kernel/resource.c:337: warning: Function parameter or member 'first_lvl' not described in 'find_next_iomem_res'
  ../kernel/resource.c:337: warning: Function parameter or member 'res' not described in 'find_next_iomem_res'

Add the missing function parameter documentation for the other warnings:

  ../kernel/resource.c:409: warning: Function parameter or member 'arg' not described in 'walk_iomem_res_desc'
  ../kernel/resource.c:409: warning: Function parameter or member 'func' not described in 'walk_iomem_res_desc'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b69c2e20f6e4 ("resource: Clean it up a bit")
Link: http://lkml.kernel.org/r/dda2e4d8-bedd-3167-20fe-8c7d2d35b354@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/resource.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b3a3a1fc499e..17bcb189d530 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -318,14 +318,14 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
-/**
+/*
  * Finds the lowest iomem resource that covers part of [start..end].  The
  * caller must specify start, end, flags, and desc (which may be
  * IORES_DESC_NONE).
  *
  * If a resource is found, returns 0 and *res is overwritten with the part
  * of the resource that's within [start..end]; if none is found, returns
- * -1.
+ * -1. Returns -EINVAL for other invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
@@ -390,7 +390,9 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 }
 
 /**
- * Walks through iomem resources and calls func() with matching resource
+ * walk_iomem_res_desc - walk through iomem resources
+ *
+ * Walks through iomem resources and calls @func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
  * All the memory ranges which overlap start,end and also match flags and
  * desc are valid candidates.
@@ -399,6 +401,8 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
  * @flags: I/O resource flags
  * @start: start addr
  * @end: end addr
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
  *
  * NOTE: For a new descriptor search, define a new IORES_DESC in
  * <linux/ioport.h> and set it in 'desc' of a target resource entry.
