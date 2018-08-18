Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0EDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0B218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D0B218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeHRPIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:08:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHRPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:08:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBxMKW1291783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:59:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBxL6g1291780;
        Sat, 18 Aug 2018 04:59:21 -0700
Date:   Sat, 18 Aug 2018 04:59:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b96679422007c3fa04625be14977904c27c722eb@git.kernel.org>
Cc:     luto@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        joro@8bytes.org, ak@linux.intel.com, hpa@zytor.com,
        acme@redhat.com, adrian.hunter@intel.com
Reply-To: acme@redhat.com, hpa@zytor.com, joro@8bytes.org,
          ak@linux.intel.com, adrian.hunter@intel.com,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          rostedt@goodmis.org, mingo@kernel.org, luto@kernel.org,
          peterz@infradead.org, jolsa@redhat.com
In-Reply-To: <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
References: <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kallsyms: Simplify update_iter_mod()
Git-Commit-ID: b96679422007c3fa04625be14977904c27c722eb
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

Commit-ID:  b96679422007c3fa04625be14977904c27c722eb
Gitweb:     https://git.kernel.org/tip/b96679422007c3fa04625be14977904c27c722eb
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 6 Jun 2018 15:54:09 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 19:10:23 -0300

kallsyms: Simplify update_iter_mod()

The logic in update_iter_mod() is overcomplicated and gets worse every
time another get_ksymbol_* function is added.

In preparation for adding another get_ksymbol_* function, simplify logic
in update_iter_mod().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: (ftrace changes only) Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1528289651-4113-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/kallsyms.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..aa31aa07f2ef 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -506,27 +506,24 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	}
 }
 
+/*
+ * The end position (last + 1) of each additional kallsyms section is recorded
+ * in iter->pos_..._end as each section is added, and so can be used to
+ * determine which get_ksymbol_...() function to call next.
+ */
 static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
-	if (iter->pos_ftrace_mod_end > 0 &&
-	    iter->pos_ftrace_mod_end < iter->pos)
-		return get_ksymbol_bpf(iter);
-
-	if (iter->pos_mod_end > 0 &&
-	    iter->pos_mod_end < iter->pos) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
+	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
+	    get_ksymbol_mod(iter))
 		return 1;
-	}
 
-	if (!get_ksymbol_mod(iter)) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
-	}
+	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
+	    get_ksymbol_ftrace_mod(iter))
+		return 1;
 
-	return 1;
+	return get_ksymbol_bpf(iter);
 }
 
 /* Returns false if pos at or past end of file. */
