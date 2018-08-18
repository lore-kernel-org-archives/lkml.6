Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33683C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E755E2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E755E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeHROdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:33:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:33:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBPnaI1285593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:25:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBPnqd1285590;
        Sat, 18 Aug 2018 04:25:49 -0700
Date:   Sat, 18 Aug 2018 04:25:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7a3e71e0d806070071f53271705b0c511c0359fc@git.kernel.org>
Cc:     dsahern@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, eranian@google.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, eranian@google.com,
          hpa@zytor.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, namhyung@kernel.org, jolsa@kernel.org,
          peterz@infradead.org
In-Reply-To: <20180804130521.11408-2-jolsa@kernel.org>
References: <20180804130521.11408-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Make symbol__annotate_fprintf2()
 local
Git-Commit-ID: 7a3e71e0d806070071f53271705b0c511c0359fc
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

Commit-ID:  7a3e71e0d806070071f53271705b0c511c0359fc
Gitweb:     https://git.kernel.org/tip/7a3e71e0d806070071f53271705b0c511c0359fc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:45 -0300

perf annotate: Make symbol__annotate_fprintf2() local

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/r/20180804130521.11408-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f91775b4bc3c..b6e7d0d56622 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2129,7 +2129,7 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops ops = {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a4c0d91907e6..5f24fc9dcc7c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -340,7 +340,6 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel,
 			    struct annotation_options *options);
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
