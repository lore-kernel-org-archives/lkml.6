Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeFER7n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752709AbeFERwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:02 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 27/46] perf report: No need to have report_callchain_help as a global
Date: Tue,  5 Jun 2018 14:50:11 -0300
Message-Id: <20180605175030.32549-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is used in a single place, move the declaration to that function.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p650ofrl8xike4dewxod51gg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bc133e7a7ac2..cdb5b6949832 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -946,12 +946,6 @@ parse_percent_limit(const struct option *opt, const char *str,
 	return 0;
 }
 
-#define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
-
-const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
-				     CALLCHAIN_REPORT_HELP
-				     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
-
 int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
@@ -960,6 +954,10 @@ int cmd_report(int argc, const char **argv)
 	bool has_br_stack = false;
 	int branch_mode = -1;
 	bool branch_call_mode = false;
+#define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
+	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
+					     CALLCHAIN_REPORT_HELP
+					     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
 	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
 	const char * const report_usage[] = {
 		"perf report [<options>]",
-- 
2.14.3
