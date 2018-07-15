Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E106ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FF4208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FF4208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeGOX4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:56:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:56:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNVAT6921772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:31:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNV9UX921765;
        Sun, 15 Jul 2018 16:31:09 -0700
Date:   Sun, 15 Jul 2018 16:31:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-abd08d7d245397bcbded8c6c29ff79a36b3875b0@git.kernel.org>
Cc:     mingo@kernel.org, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, bp@alien8.de, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, luto@amacapital.net,
          tglx@linutronix.de, dan.j.williams@intel.com, mingo@kernel.org,
          viro@zeniv.linux.org.uk, tony.luck@intel.com,
          torvalds@linux-foundation.org, bp@alien8.de,
          peterz@infradead.org, akpm@linux-foundation.org, hpa@zytor.com
In-Reply-To: <153108276767.37979.9462477994086841699.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108276767.37979.9462477994086841699.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] lib/iov_iter: Document _copy_to_iter_flushcache()
Git-Commit-ID: abd08d7d245397bcbded8c6c29ff79a36b3875b0
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

Commit-ID:  abd08d7d245397bcbded8c6c29ff79a36b3875b0
Gitweb:     https://git.kernel.org/tip/abd08d7d245397bcbded8c6c29ff79a36b3875b0
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Sun, 8 Jul 2018 13:46:07 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:05:05 +0200

lib/iov_iter: Document _copy_to_iter_flushcache()

Add some theory of operation documentation to _copy_to_iter_flushcache().

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: http://lkml.kernel.org/r/153108276767.37979.9462477994086841699.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/iov_iter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 94fa361be7bb..09fb73ad9d54 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -727,6 +727,20 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+/**
+ * _copy_from_iter_flushcache - write destination through cpu cache
+ * @addr: destination kernel address
+ * @bytes: total transfer length
+ * @iter: source iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_from_iter() for ensuring that writes to persistent memory
+ * are flushed through the CPU cache. It is differentiated from
+ * _copy_from_iter_nocache() in that guarantees all data is flushed for
+ * all iterator types. The _copy_from_iter_nocache() only attempts to
+ * bypass the cache for the ITER_IOVEC case, and on some archs may use
+ * instructions that strand dirty-data in the cache.
+ */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
