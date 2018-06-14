Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B105C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4DC208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4DC208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeFNGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:24:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeFNGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:24:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6Nove763905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:23:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6No5b763902;
        Wed, 13 Jun 2018 23:23:50 -0700
Date:   Wed, 13 Jun 2018 23:23:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a5cfa6217c94a1f1cfad4481fc14f5fc399abde3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de, frederic@kernel.org, peterz@infradead.org,
        dsahern@gmail.com, eranian@google.com, hpa@zytor.com,
        milian.wolff@kdab.com, mingo@kernel.org, andi@firstfloor.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          milian.wolff@kdab.com, mingo@kernel.org, andi@firstfloor.org,
          frederic@kernel.org, peterz@infradead.org, dsahern@gmail.com,
          eranian@google.com, hpa@zytor.com
In-Reply-To: <20180606221513.11302-8-jolsa@kernel.org>
References: <20180606221513.11302-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Add event parsing error handling to
 add_default_attributes
Git-Commit-ID: a5cfa6217c94a1f1cfad4481fc14f5fc399abde3
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

Commit-ID:  a5cfa6217c94a1f1cfad4481fc14f5fc399abde3
Gitweb:     https://git.kernel.org/tip/a5cfa6217c94a1f1cfad4481fc14f5fc399abde3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 16:03:21 -0300

perf stat: Add event parsing error handling to add_default_attributes

Add missing error handling for parse_events calls in add_default_attributes
functions. The error handler displays error details, like for transactions (-T):

Before:
  $ perf stat -T
  Cannot set up transaction events

After:
  $ perf stat -T
  Cannot set up transaction events
  event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
                                    \___ unknown term

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3fc1f5286d50..22547a490e1f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2442,14 +2442,13 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
+	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (null_run)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
-
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
@@ -2460,6 +2459,7 @@ static int add_default_attributes(void)
 					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
+			parse_events_print_error(&errinfo, transaction_attrs);
 			return -1;
 		}
 		return 0;
@@ -2485,10 +2485,11 @@ static int add_default_attributes(void)
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
 				metric_only = true;
-			err = parse_events(evsel_list, smi_cost_attrs, NULL);
+			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
 				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			return -1;
 		}
 		if (err) {
@@ -2523,12 +2524,13 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
-			err = parse_events(evsel_list, str, NULL);
+			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
 				free(str);
+				parse_events_print_error(&errinfo, str);
 				return -1;
 			}
 		} else {
