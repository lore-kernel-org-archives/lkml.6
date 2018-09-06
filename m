Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921A82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921A82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeIFR7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:59:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58593 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:59:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DNIH8305996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:23:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DNIcS305993;
        Thu, 6 Sep 2018 06:23:18 -0700
Date:   Thu, 6 Sep 2018 06:23:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7d9ad16afe2bfc73b8967cc2aa2dc30f0170a8e2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
        andi@firstfloor.org, namhyung@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com,
          dsahern@gmail.com, namhyung@kernel.org, andi@firstfloor.org,
          acme@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20180830063252.23729-6-jolsa@kernel.org>
References: <20180830063252.23729-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'identifier' flag to 'struct
 perf_stat_config'
Git-Commit-ID: 7d9ad16afe2bfc73b8967cc2aa2dc30f0170a8e2
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

Commit-ID:  7d9ad16afe2bfc73b8967cc2aa2dc30f0170a8e2
Gitweb:     https://git.kernel.org/tip/7d9ad16afe2bfc73b8967cc2aa2dc30f0170a8e2
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf stat: Add 'identifier' flag to 'struct perf_stat_config'

Add 'identifier' flag to 'struct perf_stat_config' to carry the info
whether to use PERF_SAMPLE_IDENTIFIER for events.

This makes create_perf_stat_counter() independent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++++----------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 47789558899a..48c88f568fe1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -261,16 +261,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	 */
 	attr->sample_period = 0;
 
-	/*
-	 * But set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
-	 * while avoiding that older tools show confusing messages.
-	 *
-	 * However for pipe sessions we need to keep it zero,
-	 * because script's perf_evsel__check_attr is triggered
-	 * by attr->sample_type != 0, and we can't run it on
-	 * stat sessions.
-	 */
-	if (!(STAT_RECORD && perf_stat.data.is_pipe))
+	if (config->identifier)
 		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
 
 	/*
@@ -3064,6 +3055,17 @@ int cmd_stat(int argc, const char **argv)
 	if (perf_stat_init_aggr_mode())
 		goto out;
 
+	/*
+	 * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
+	 * while avoiding that older tools show confusing messages.
+	 *
+	 * However for pipe sessions we need to keep it zero,
+	 * because script's perf_evsel__check_attr is triggered
+	 * by attr->sample_type != 0, and we can't run it on
+	 * stat sessions.
+	 */
+	stat_config.identifier = !(STAT_RECORD && perf_stat.data.is_pipe);
+
 	/*
 	 * We dont want to block the signals - that would cause
 	 * child tasks to inherit that and Ctrl-C would not work.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 53b2415ba3f3..918cde064cdc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -89,6 +89,7 @@ struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
 	bool			 no_inherit;
+	bool			 identifier;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
