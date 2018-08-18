Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098AEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9182198E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9182198E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeHROeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:34:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:34:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBQJSA1285636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:26:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBQJmD1285633;
        Sat, 18 Aug 2018 04:26:19 -0700
Date:   Sat, 18 Aug 2018 04:26:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5ecf7d30eb4f9c046f5284f20133d7b69729c315@git.kernel.org>
Cc:     jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, acme@redhat.com, eranian@google.com,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, namhyung@kernel.org, peterz@infradead.org,
          eranian@google.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
          mingo@kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180804130521.11408-3-jolsa@kernel.org>
References: <20180804130521.11408-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Make annotation_line__max_percent
 static
Git-Commit-ID: 5ecf7d30eb4f9c046f5284f20133d7b69729c315
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

Commit-ID:  5ecf7d30eb4f9c046f5284f20133d7b69729c315
Gitweb:     https://git.kernel.org/tip/5ecf7d30eb4f9c046f5284f20133d7b69729c315
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:45 -0300

perf annotate: Make annotation_line__max_percent static

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b6e7d0d56622..956c9b19d81c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2441,7 +2441,8 @@ bool ui__has_annotation(void)
 }
 
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes)
+static double annotation_line__max_percent(struct annotation_line *al,
+					   struct annotation *notes)
 {
 	double percent_max = 0.0;
 	int i;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5f24fc9dcc7c..a93502d0c582 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -169,7 +169,6 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    struct annotation_write_ops *ops);
 
