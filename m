Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A34C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B1D20863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBIMUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:20:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:20:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CJN0n2624047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:19:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CJNQ92624044;
        Sat, 9 Feb 2019 04:19:23 -0800
Date:   Sat, 9 Feb 2019 04:19:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-489338a717a0dfbbd5a3fabccf172b78f0ac9015@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, gustavo@embeddedor.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        namhyung@kernel.org, acme@redhat.com, jolsa@kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org,
          acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          gustavo@embeddedor.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190122233439.GA5868@embeddedor>
References: <20190122233439.GA5868@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests evsel-tp-sched: Fix bitwise operator
Git-Commit-ID: 489338a717a0dfbbd5a3fabccf172b78f0ac9015
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

Commit-ID:  489338a717a0dfbbd5a3fabccf172b78f0ac9015
Gitweb:     https://git.kernel.org/tip/489338a717a0dfbbd5a3fabccf172b78f0ac9015
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Tue, 22 Jan 2019 17:34:39 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 11:32:14 -0300

perf tests evsel-tp-sched: Fix bitwise operator

Notice that the use of the bitwise OR operator '|' always leads to true
in this particular case, which seems a bit suspicious due to the context
in which this expression is being used.

Fix this by using bitwise AND operator '&' instead.

This bug was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
Link: http://lkml.kernel.org/r/20190122233439.GA5868@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/evsel-tp-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5f8501c68da4..5cbba70bcdd0 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
 		return -1;
 	}
 
-	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
+	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
 			 evsel->name, name, is_signed, should_be_signed);
