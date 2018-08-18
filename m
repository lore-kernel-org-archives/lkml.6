Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE7EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F3121878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F3121878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeHROnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:43:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:43:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBZueT1286954
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:35:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBZuHP1286951;
        Sat, 18 Aug 2018 04:35:56 -0700
Date:   Sat, 18 Aug 2018 04:35:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e6902d1b7326149952abf8e7f07513e254668e52@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, dsahern@gmail.com,
        acme@redhat.com, hpa@zytor.com, eranian@google.com,
        namhyung@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
          eranian@google.com, namhyung@kernel.org, dsahern@gmail.com
In-Reply-To: <20180804130521.11408-21-jolsa@kernel.org>
References: <20180804130521.11408-21-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Add --percent-type option
Git-Commit-ID: e6902d1b7326149952abf8e7f07513e254668e52
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

Commit-ID:  e6902d1b7326149952abf8e7f07513e254668e52
Gitweb:     https://git.kernel.org/tip/e6902d1b7326149952abf8e7f07513e254668e52
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:54 -0300

perf report: Add --percent-type option

Set annotation percent type from following choices:

  global-period, local-period, global-hits, local-hits

With following report option setup the percent type will be passed to
annotation browser:

  $ perf report --percent-type period-local

The local/global keywords set if the percentage is computed in the scope
of the function (local) or the whole data (global).  The period/hits
keywords set the base the percentage is computed on - the samples period
or the number of samples (hits).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 tools/perf/builtin-report.c              | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 917e36fde6d8..474a4941f65d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,15 @@ include::itrace.txt[]
 	Display monitored tasks stored in perf data. Displaying pid/tid/ppid
 	plus the command string aligned to distinguish parent and child tasks.
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02f7a3c27761..143542ffac20 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1124,6 +1124,9 @@ int cmd_report(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
+	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
 	OPT_END()
 	};
 	struct perf_data data = {
