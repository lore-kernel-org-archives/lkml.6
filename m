Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeDDFhD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:37:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeDDFhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:37:02 -0400
Date: Tue, 3 Apr 2018 22:36:41 -0700
From: tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-51125a29a395048fdb3429b8c4ca0ada57097744@git.kernel.org>
Cc: namhyung@kernel.org, acme@redhat.com, hpa@zytor.com, jolsa@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, changbin.du@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, peterz@infradead.org, hpa@zytor.com,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, changbin.du@intel.com, tglx@linutronix.de
In-Reply-To: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
References: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Remove redundant ')'
Git-Commit-ID: 51125a29a395048fdb3429b8c4ca0ada57097744
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  51125a29a395048fdb3429b8c4ca0ada57097744
Gitweb:     https://git.kernel.org/tip/51125a29a395048fdb3429b8c4ca0ada57097744
Author:     Changbin Du <changbin.du@intel.com>
AuthorDate: Tue, 13 Mar 2018 18:40:01 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 16:16:41 -0300

perf trace: Remove redundant ')'

There is a redundant ')' at the tail of each event. So remove it.

$ sudo perf trace --no-syscalls -e 'kmem:*' -a
   899.342 kmem:kfree:(vfs_writev+0xb9) call_site=ffffffff9c453979 ptr=(nil))
   899.344 kmem:kfree:(___sys_recvmsg+0x188) call_site=ffffffff9c9b8b88 ptr=(nil))

Signed-off-by: Changbin Du <changbin.du@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520937601-24952-1-git-send-email-changbin.du@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4e03f0f68241..3ad17ee89403 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1962,7 +1962,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				      trace->output);
 	}
 
-	fprintf(trace->output, ")\n");
+	fprintf(trace->output, "\n");
 
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
