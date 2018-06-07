Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WaI9ISjpGFuOUwAAmS7hNA
	; Thu, 07 Jun 2018 08:14:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B41FC607E7; Thu,  7 Jun 2018 08:14:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04749607E7;
	Thu,  7 Jun 2018 08:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04749607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFGIOg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:14:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFGIOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:14:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578EPLS2125178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:14:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578EPN32125175;
        Thu, 7 Jun 2018 01:14:25 -0700
Date: Thu, 7 Jun 2018 01:14:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p650ofrl8xike4dewxod51gg@git.kernel.org>
Cc: mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, wangnan0@huawei.com, namhyung@kernel.org,
        jolsa@kernel.org, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        acme@redhat.com
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          tglx@linutronix.de, wangnan0@huawei.com, namhyung@kernel.org,
          jolsa@kernel.org, dsahern@gmail.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: No need to have
 report_callchain_help as a global
Git-Commit-ID: 9d0199cd2a7a326510fc7f731d7974ef2fbc03d0
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

Commit-ID:  9d0199cd2a7a326510fc7f731d7974ef2fbc03d0
Gitweb:     https://git.kernel.org/tip/9d0199cd2a7a326510fc7f731d7974ef2fbc03d0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 14:34:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:54 -0300

perf report: No need to have report_callchain_help as a global

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
