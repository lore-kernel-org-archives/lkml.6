Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C2C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0121878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B0121878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeHROng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:43:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:43:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBYq2l1286849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:34:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBYqGt1286846;
        Sat, 18 Aug 2018 04:34:52 -0700
Date:   Sat, 18 Aug 2018 04:34:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4c04868fbe931ec315ad34bb7e28e5cf725f88e4@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        jolsa@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, eranian@google.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, eranian@google.com, hpa@zytor.com,
          peterz@infradead.org, mingo@kernel.org, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          jolsa@kernel.org
In-Reply-To: <20180804130521.11408-19-jolsa@kernel.org>
References: <20180804130521.11408-19-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Display percent type in stdio
 output
Git-Commit-ID: 4c04868fbe931ec315ad34bb7e28e5cf725f88e4
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

Commit-ID:  4c04868fbe931ec315ad34bb7e28e5cf725f88e4
Gitweb:     https://git.kernel.org/tip/4c04868fbe931ec315ad34bb7e28e5cf725f88e4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:19 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:53 -0300

perf annotate: Display percent type in stdio output

In following patches we will allow to switch percent type even for stdio
annotation outputs. Adding the percent type value into the annotation
outputs title.

  $ perf annotate --stdio
   Percent         |      Sou ... instructions:u } (2805 samples, percent: local period)
  --------------------------- ... ------------------------------------------------------
  ...

  $ perf annotate --stdio2
  Samples: 2K of events 'anon ...  count (approx.): 156525487, [percent: local period]
  safe_write.c() /usr/bin/yes
  Percent
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 05d15629afd0..6316fa96d984 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2056,10 +2056,12 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		evsel_name = buf;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
+	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
 				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
-				  d_filename, evsel_name, h->nr_samples);
+				  d_filename, evsel_name, h->nr_samples,
+				  percent_type_str(opts->percent_type));
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
@@ -2434,7 +2436,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
-	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
+	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
+		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
