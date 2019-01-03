Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE58C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E352070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfACNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:12:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfACNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:12:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DCPie1384044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:12:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DCPmO1384041;
        Thu, 3 Jan 2019 05:12:25 -0800
Date:   Thu, 3 Jan 2019 05:12:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-fbe7e42515af6c2ecee04b1c851f78de1d190281@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        colin.king@canonical.com, tglx@linutronix.de, acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
          colin.king@canonical.com, tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20181221084809.6108-1-colin.king@canonical.com>
References: <20181221084809.6108-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Use correct SECCOMP prefix spelling,
 "SECOMP_*" -> "SECCOMP_*"
Git-Commit-ID: fbe7e42515af6c2ecee04b1c851f78de1d190281
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

Commit-ID:  fbe7e42515af6c2ecee04b1c851f78de1d190281
Gitweb:     https://git.kernel.org/tip/fbe7e42515af6c2ecee04b1c851f78de1d190281
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Fri, 21 Dec 2018 08:48:09 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:32:54 -0300

perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"

The spelling of the SECCOMP is incorrect, fix these.

Signed-off-by: Colin King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Link: http://lkml.kernel.org/r/20181221084809.6108-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 4600c28a3cfe..637722e2796b 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -9,7 +9,7 @@
 static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_SET_MODE_";
+	const char *prefix = "SECCOMP_SET_MODE_";
 	int op = arg->val;
 	size_t printed = 0;
 
@@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 						   struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_FILTER_FLAG_";
+	const char *prefix = "SECCOMP_FILTER_FLAG_";
 	int printed = 0, flags = arg->val;
 
 #define	P_FLAG(n) \
