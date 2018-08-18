Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB2AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3C21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB3C21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHROil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:38:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44305 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:38:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBUv4b1286379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:30:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBUvxQ1286376;
        Sat, 18 Aug 2018 04:30:57 -0700
Date:   Sat, 18 Aug 2018 04:30:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e58684df912906d944967e2ce0f3ed5d5140d1e5@git.kernel.org>
Cc:     hpa@zytor.com, eranian@google.com, dsahern@gmail.com,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          dsahern@gmail.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20180804130521.11408-12-jolsa@kernel.org>
References: <20180804130521.11408-12-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add PERCENT_PERIOD_GLOBAL percent
 value
Git-Commit-ID: e58684df912906d944967e2ce0f3ed5d5140d1e5
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

Commit-ID:  e58684df912906d944967e2ce0f3ed5d5140d1e5
Gitweb:     https://git.kernel.org/tip/e58684df912906d944967e2ce0f3ed5d5140d1e5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:12 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:49 -0300

perf annotate: Add PERCENT_PERIOD_GLOBAL percent value

Adding and computing global period percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_PERIOD_GLOBAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 +++
 tools/perf/util/annotate.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b37e8cc18668..e890164592b0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1783,6 +1783,9 @@ static void calc_percent(struct sym_hist *sym_hist,
 
 	if (sym_hist->period)
 		data->percent[PERCENT_PERIOD_LOCAL] = 100.0 * period / sym_hist->period;
+
+	if (hists->stats.total_period)
+		data->percent[PERCENT_PERIOD_GLOBAL] = 100.0 * period / hists->stats.total_period;
 }
 
 static void annotation__calc_percent(struct annotation *notes,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 890b6869caa9..48fe2aa6b5a8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -105,6 +105,7 @@ enum {
 	PERCENT_HITS_LOCAL,
 	PERCENT_HITS_GLOBAL,
 	PERCENT_PERIOD_LOCAL,
+	PERCENT_PERIOD_GLOBAL,
 	PERCENT_MAX,
 };
 
