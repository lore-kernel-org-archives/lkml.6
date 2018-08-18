Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB5C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7B62188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7B62188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeHROjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:39:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:39:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBURUa1286348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:30:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBURFn1286345;
        Sat, 18 Aug 2018 04:30:27 -0700
Date:   Sat, 18 Aug 2018 04:30:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ab371169fb7db9587f09137e93a49c6afeab16f7@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        eranian@google.com, hpa@zytor.com, dsahern@gmail.com
Reply-To: acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, dsahern@gmail.com, eranian@google.com,
          jolsa@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20180804130521.11408-11-jolsa@kernel.org>
References: <20180804130521.11408-11-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add PERCENT_PERIOD_LOCAL percent
 value
Git-Commit-ID: ab371169fb7db9587f09137e93a49c6afeab16f7
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

Commit-ID:  ab371169fb7db9587f09137e93a49c6afeab16f7
Gitweb:     https://git.kernel.org/tip/ab371169fb7db9587f09137e93a49c6afeab16f7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:49 -0300

perf annotate: Add PERCENT_PERIOD_LOCAL percent value

Adding and computing local period percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_PERIOD_LOCAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 ++
 tools/perf/util/annotate.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b7485a512da1..b37e8cc18668 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1781,6 +1781,8 @@ static void calc_percent(struct sym_hist *sym_hist,
 	if (hists->stats.nr_non_filtered_samples)
 		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
 
+	if (sym_hist->period)
+		data->percent[PERCENT_PERIOD_LOCAL] = 100.0 * period / sym_hist->period;
 }
 
 static void annotation__calc_percent(struct annotation *notes,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3a06cb2b6e28..890b6869caa9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -104,6 +104,7 @@ struct sym_hist_entry {
 enum {
 	PERCENT_HITS_LOCAL,
 	PERCENT_HITS_GLOBAL,
+	PERCENT_PERIOD_LOCAL,
 	PERCENT_MAX,
 };
 
