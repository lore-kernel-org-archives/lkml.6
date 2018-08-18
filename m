Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9070A21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9070A21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHROhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:37:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:37:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBTtKU1286116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:29:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBTt7m1286113;
        Sat, 18 Aug 2018 04:29:55 -0700
Date:   Sat, 18 Aug 2018 04:29:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-75a8c1ff287b2a949b50c1c1e58a6492e21a3ac5@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, eranian@google.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org
Reply-To: eranian@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
          acme@redhat.com, jolsa@kernel.org, peterz@infradead.org,
          mingo@kernel.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20180804130521.11408-10-jolsa@kernel.org>
References: <20180804130521.11408-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add PERCENT_HITS_GLOBAL percent
 value
Git-Commit-ID: 75a8c1ff287b2a949b50c1c1e58a6492e21a3ac5
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

Commit-ID:  75a8c1ff287b2a949b50c1c1e58a6492e21a3ac5
Gitweb:     https://git.kernel.org/tip/75a8c1ff287b2a949b50c1c1e58a6492e21a3ac5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:48 -0300

perf annotate: Add PERCENT_HITS_GLOBAL percent value

Adding and computing global hits percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_HITS_GLOBAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 +++++++-
 tools/perf/util/annotate.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 074adb2a831e..b7485a512da1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1759,6 +1759,7 @@ out_close_stdout:
 }
 
 static void calc_percent(struct sym_hist *sym_hist,
+			 struct hists *hists,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1776,6 +1777,10 @@ static void calc_percent(struct sym_hist *sym_hist,
 		data->he.nr_samples = hits;
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
+
+	if (hists->stats.nr_non_filtered_samples)
+		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
+
 }
 
 static void annotation__calc_percent(struct annotation *notes,
@@ -1795,6 +1800,7 @@ static void annotation__calc_percent(struct annotation *notes,
 		end  = next ? next->offset : len;
 
 		for_each_group_evsel(evsel, leader) {
+			struct hists *hists = evsel__hists(evsel);
 			struct annotation_data *data;
 			struct sym_hist *sym_hist;
 
@@ -1803,7 +1809,7 @@ static void annotation__calc_percent(struct annotation *notes,
 			sym_hist = annotation__histogram(notes, evsel->idx);
 			data = &al->data[i++];
 
-			calc_percent(sym_hist, data, al->offset, end);
+			calc_percent(sym_hist, hists, data, al->offset, end);
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0afbf8075fca..3a06cb2b6e28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -103,6 +103,7 @@ struct sym_hist_entry {
 
 enum {
 	PERCENT_HITS_LOCAL,
+	PERCENT_HITS_GLOBAL,
 	PERCENT_MAX,
 };
 
