Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5431FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121082075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121082075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeIFR6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:58:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:58:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DMCNG305914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:22:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DMCHk305911;
        Thu, 6 Sep 2018 06:22:12 -0700
Date:   Thu, 6 Sep 2018 06:22:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5698f26b46e4f47f2371418eb92732048fa4fa66@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        andi@firstfloor.org, dsahern@gmail.com, namhyung@kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, andi@firstfloor.org,
          dsahern@gmail.com, namhyung@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <20180830063252.23729-4-jolsa@kernel.org>
References: <20180830063252.23729-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'no_inherit' to 'struct
 perf_stat_config'
Git-Commit-ID: 5698f26b46e4f47f2371418eb92732048fa4fa66
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

Commit-ID:  5698f26b46e4f47f2371418eb92732048fa4fa66
Gitweb:     https://git.kernel.org/tip/5698f26b46e4f47f2371418eb92732048fa4fa66
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:12 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf stat: Move 'no_inherit' to 'struct perf_stat_config'

Move the static 'no_inherit' variable to 'struct perf_stat_config', so
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 719abdd3b7de..84dbac526925 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static int			run_count			=  1;
-static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -254,7 +253,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	if (leader->nr_members > 1)
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
-	attr->inherit = !no_inherit;
+	attr->inherit = !config->no_inherit;
 
 	/*
 	 * Some events get initialized with sample_(period/type) set,
@@ -1969,7 +1968,7 @@ static const struct option stat_options[] = {
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
 		     "event filter", parse_filter),
-	OPT_BOOLEAN('i', "no-inherit", &no_inherit,
+	OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
 		    "child tasks do not inherit counters"),
 	OPT_STRING('p', "pid", &target.pid, "pid",
 		   "stat events on existing process id"),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 91e6609fce6e..53b2415ba3f3 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -88,6 +88,7 @@ struct runtime_stat {
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
+	bool			 no_inherit;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
