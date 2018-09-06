Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A9EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C52064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1C52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeIFSE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:04:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeIFSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:04:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DQX0v307924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:26:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DQXqV307921;
        Thu, 6 Sep 2018 06:26:33 -0700
Date:   Thu, 6 Sep 2018 06:26:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1821f4eb480bdd3c7c2a1863431ba539c7b0c1f8@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        andi@firstfloor.org, tglx@linutronix.de, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        peterz@infradead.org, acme@redhat.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, andi@firstfloor.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          dsahern@gmail.com, mingo@kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          peterz@infradead.org
In-Reply-To: <20180830063252.23729-12-jolsa@kernel.org>
References: <20180830063252.23729-12-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'struct perf_tool' argument to
 perf_stat_synthesize_config()
Git-Commit-ID: 1821f4eb480bdd3c7c2a1863431ba539c7b0c1f8
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

Commit-ID:  1821f4eb480bdd3c7c2a1863431ba539c7b0c1f8
Gitweb:     https://git.kernel.org/tip/1821f4eb480bdd3c7c2a1863431ba539c7b0c1f8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Add 'struct perf_tool' argument to perf_stat_synthesize_config()

So that we can use the function outside the 'perf stat' command with standard
synthesize functions, that take 'struct perf_tool *' argument.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d0d19a5ffa85..ae5029875e87 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -403,12 +403,13 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 }
 
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
+				       struct perf_tool *tool,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(NULL, evsel_list,
+		err = perf_event__synthesize_attrs(tool, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
@@ -416,12 +417,12 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(NULL,
+	err = perf_event__synthesize_extra_attr(tool,
 						evsel_list,
 						process_synthesized_event,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(NULL, evsel_list->threads,
+	err = perf_event__synthesize_thread_map2(tool, evsel_list->threads,
 						process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -429,14 +430,14 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(NULL, evsel_list->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evsel_list->cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(NULL, config,
+	err = perf_event__synthesize_stat_config(tool, config,
 						 process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
@@ -607,7 +608,7 @@ try_again:
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, NULL, is_pipe);
 		if (err < 0)
 			return err;
 	}
