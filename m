Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2411C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899422075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899422075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeIFSDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:03:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:03:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DR5RD308130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:27:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DR53L308127;
        Thu, 6 Sep 2018 06:27:05 -0700
Date:   Thu, 6 Sep 2018 06:27:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1c21e9899d6a9ea72d4d678faa7b0ec22bcf59a9@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, acme@redhat.com,
        andi@firstfloor.org, peterz@infradead.org, mingo@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          mingo@kernel.org, dsahern@gmail.com, acme@redhat.com,
          peterz@infradead.org, andi@firstfloor.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180830063252.23729-13-jolsa@kernel.org>
References: <20180830063252.23729-13-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'struct perf_evlist' argument to
 perf_stat_synthesize_config()
Git-Commit-ID: 1c21e9899d6a9ea72d4d678faa7b0ec22bcf59a9
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

Commit-ID:  1c21e9899d6a9ea72d4d678faa7b0ec22bcf59a9
Gitweb:     https://git.kernel.org/tip/1c21e9899d6a9ea72d4d678faa7b0ec22bcf59a9
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Add 'struct perf_evlist' argument to perf_stat_synthesize_config()

Get rid of the 'evsel_list' global variable dependency, here in
perf_stat_synthesize_config() we are adding the 'evlist' arg.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ae5029875e87..cb36344c25b7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -404,12 +404,13 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
 				       struct perf_tool *tool,
+				       struct perf_evlist *evlist,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evsel_list,
+		err = perf_event__synthesize_attrs(tool, evlist,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
@@ -417,12 +418,11 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(tool,
-						evsel_list,
+	err = perf_event__synthesize_extra_attr(tool, evlist,
 						process_synthesized_event,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(tool, evsel_list->threads,
+	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
 						process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -430,7 +430,7 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(tool, evsel_list->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
@@ -608,7 +608,8 @@ try_again:
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, NULL, is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
+						  is_pipe);
 		if (err < 0)
 			return err;
 	}
