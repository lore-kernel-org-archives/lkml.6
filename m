Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FAAECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0684020840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0684020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbeGOXzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:55:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:55:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNUelJ921731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:30:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNUeAg921728;
        Sun, 15 Jul 2018 16:30:40 -0700
Date:   Sun, 15 Jul 2018 16:30:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-bf3eeb9b5f2a1a05b3a68c6d82112babd58d6a39@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, akpm@linux-foundation.org,
        luto@amacapital.net
Reply-To: bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, akpm@linux-foundation.org, luto@amacapital.net,
          viro@zeniv.linux.org.uk, peterz@infradead.org, hpa@zytor.com,
          dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
          tony.luck@intel.com
In-Reply-To: <153108276256.37979.1689794213845539316.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108276256.37979.1689794213845539316.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] lib/iov_iter: Document _copy_to_iter_mcsafe()
Git-Commit-ID: bf3eeb9b5f2a1a05b3a68c6d82112babd58d6a39
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

Commit-ID:  bf3eeb9b5f2a1a05b3a68c6d82112babd58d6a39
Gitweb:     https://git.kernel.org/tip/bf3eeb9b5f2a1a05b3a68c6d82112babd58d6a39
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Sun, 8 Jul 2018 13:46:02 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:05:05 +0200

lib/iov_iter: Document _copy_to_iter_mcsafe()

Add some theory of operation documentation to _copy_to_iter_mcsafe().

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: http://lkml.kernel.org/r/153108276256.37979.1689794213845539316.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/iov_iter.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7e43cd54c84c..94fa361be7bb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,6 +596,32 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
+/**
+ * _copy_to_iter_mcsafe - copy to user with source-read error exception handling
+ * @addr: source kernel address
+ * @bytes: total transfer length
+ * @iter: destination iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_to_iter() for protecting read/write to persistent memory.
+ * Unless / until an architecture can guarantee identical performance
+ * between _copy_to_iter_mcsafe() and _copy_to_iter() it would be a
+ * performance regression to switch more users to the mcsafe version.
+ *
+ * Otherwise, the main differences between this and typical _copy_to_iter().
+ *
+ * * Typical tail/residue handling after a fault retries the copy
+ *   byte-by-byte until the fault happens again. Re-triggering machine
+ *   checks is potentially fatal so the implementation uses source
+ *   alignment and poison alignment assumptions to avoid re-triggering
+ *   hardware exceptions.
+ *
+ * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
+ *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
+ *   a short copy.
+ *
+ * See MCSAFE_TEST for self-test.
+ */
 size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
