Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB63217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeLROSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:18:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLROSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:18:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEICME2855344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:18:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEICUh2855341;
        Tue, 18 Dec 2018 06:18:12 -0800
Date:   Tue, 18 Dec 2018 06:18:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-o72pyiwt05f3p2juprwmz2jo@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        davem@davemloft.net, namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, davem@davemloft.net, acme@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Move perf_top__reset_sample_counters() to
 after counts display
Git-Commit-ID: 8aa5c8eddcdd055c29a4c30df2587104c07c7c2d
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
Message-ID: <20181218141812.lpbKblSMp9s6XwL5TbX-G28cPtrpyoV9Wh8lzYWX2Uo@z>

Commit-ID:  8aa5c8eddcdd055c29a4c30df2587104c07c7c2d
Gitweb:     https://git.kernel.org/tip/8aa5c8eddcdd055c29a4c30df2587104c07c7c2d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 13 Nov 2018 11:15:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:58:47 -0300

perf top: Move perf_top__reset_sample_counters() to after counts display

Move the perf_top__reset_sample_counters() call to right after we
display the counters so we can see the updated numbers for longer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-o72pyiwt05f3p2juprwmz2jo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 4 ----
 tools/perf/ui/browsers/hists.c | 3 +++
 tools/perf/util/top.c          | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f22c531be366..fe3ecfb2e64b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,8 +273,6 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	perf_top__header_snprintf(top, bf, sizeof(bf));
 	printf("%s\n", bf);
 
-	perf_top__reset_sample_counters(top);
-
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
 	if (!top->record_opts.overwrite &&
@@ -573,8 +571,6 @@ static void perf_top__sort_new_samples(void *arg)
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-
-	perf_top__reset_sample_counters(t);
 }
 
 static void stop_top(void)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 36b262c49f51..ffac1d54a3d4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2229,8 +2229,11 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
+
+		perf_top__reset_sample_counters(top);
 	}
 
+
 	return printed;
 }
 
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 31a8dee9af69..4c8da8c4435f 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -107,6 +107,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 					top->evlist->cpus->nr > 1 ? "s" : "");
 	}
 
+	perf_top__reset_sample_counters(top);
 	return ret;
 }
 
