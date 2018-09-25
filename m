Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA834C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7016D20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7016D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeIYPkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:40:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:40:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9WlNv3386201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:32:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9WleF3386198;
        Tue, 25 Sep 2018 02:32:47 -0700
Date:   Tue, 25 Sep 2018 02:32:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ded2b8fe2e431d8029ab50238744fcce06a2f0c6@git.kernel.org>
Cc:     andi@firstfloor.org, hpa@zytor.com, jolsa@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, alexey.budankov@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexey.budankov@linux.intel.com, tglx@linutronix.de,
          andi@firstfloor.org, hpa@zytor.com
In-Reply-To: <20180913125450.21342-5-jolsa@kernel.org>
References: <20180913125450.21342-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add 'struct perf_mmap' arg to
 record__write()
Git-Commit-ID: ded2b8fe2e431d8029ab50238744fcce06a2f0c6
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

Commit-ID:  ded2b8fe2e431d8029ab50238744fcce06a2f0c6
Gitweb:     https://git.kernel.org/tip/ded2b8fe2e431d8029ab50238744fcce06a2f0c6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 13 Sep 2018 14:54:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:11 -0300

perf tools: Add 'struct perf_mmap' arg to record__write()

The struct perf_mmap map argument will hold the file pointer to write
the data to.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 24 ++++++++++++++----------
 tools/perf/util/auxtrace.c  |  2 +-
 tools/perf/util/auxtrace.h  |  1 +
 tools/perf/util/mmap.c      |  6 +++---
 tools/perf/util/mmap.h      |  2 +-
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fd8b12c5f4ae..0980dfe3396b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -106,9 +106,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, void *bf, size_t size)
+static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
+			 void *bf, size_t size)
 {
-	if (perf_data__write(rec->session->data, bf, size) < 0) {
+	struct perf_data_file *file = &rec->session->data->file;
+
+	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
 	}
@@ -127,15 +130,15 @@ static int process_synthesized_event(struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, event, event->header.size);
+	return record__write(rec, NULL, event, event->header.size);
 }
 
-static int record__pushfn(void *to, void *bf, size_t size)
+static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
 
 	rec->samples++;
-	return record__write(rec, bf, size);
+	return record__write(rec, map, bf, size);
 }
 
 static volatile int done;
@@ -170,6 +173,7 @@ static void record__sig_exit(void)
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 static int record__process_auxtrace(struct perf_tool *tool,
+				    struct perf_mmap *map,
 				    union perf_event *event, void *data1,
 				    size_t len1, void *data2, size_t len2)
 {
@@ -197,11 +201,11 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	if (padding)
 		padding = 8 - padding;
 
-	record__write(rec, event, event->header.size);
-	record__write(rec, data1, len1);
+	record__write(rec, map, event, event->header.size);
+	record__write(rec, map, data1, len1);
 	if (len2)
-		record__write(rec, data2, len2);
-	record__write(rec, &pad, padding);
+		record__write(rec, map, data2, len2);
+	record__write(rec, map, &pad, padding);
 
 	return 0;
 }
@@ -549,7 +553,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	 * at least one event.
 	 */
 	if (bytes_written != rec->bytes_written)
-		rc = record__write(rec, &finished_round_event, sizeof(finished_round_event));
+		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2fecee57f555..c4617bcfd521 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1285,7 +1285,7 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	ev.auxtrace.tid = mm->tid;
 	ev.auxtrace.cpu = mm->cpu;
 
-	if (fn(tool, &ev, data1, len1, data2, len2))
+	if (fn(tool, map, &ev, data1, len1, data2, len2))
 		return -1;
 
 	mm->prev = head;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 7eeb141361b9..a86b7eab6673 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -435,6 +435,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
+				  struct perf_mmap *map,
 				  union perf_event *event, void *data1,
 				  size_t len1, void *data2, size_t len2);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 215f69f41672..cdb95b3a1213 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -281,7 +281,7 @@ int perf_mmap__read_init(struct perf_mmap *map)
 }
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size))
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
@@ -300,7 +300,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
 
-		if (push(to, buf, size) < 0) {
+		if (push(md, to, buf, size) < 0) {
 			rc = -1;
 			goto out;
 		}
@@ -310,7 +310,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	size = md->end - md->start;
 	md->start += size;
 
-	if (push(to, buf, size) < 0) {
+	if (push(md, to, buf, size) < 0) {
 		rc = -1;
 		goto out;
 	}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 05a6d47c7956..e603314dc792 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -93,7 +93,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
