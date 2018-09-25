Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7DECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23F920867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23F920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeIYPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:38:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:38:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9VgZM3386123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:31:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9VgeT3386120;
        Tue, 25 Sep 2018 02:31:42 -0700
Date:   Tue, 25 Sep 2018 02:31:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7336555a682c09fd9a3fdf38724493e52653be50@git.kernel.org>
Cc:     peterz@infradead.org, alexey.budankov@linux.intel.com,
        acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, hpa@zytor.com, andi@firstfloor.org,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, peterz@infradead.org,
          alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, andi@firstfloor.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180913125450.21342-3-jolsa@kernel.org>
References: <20180913125450.21342-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove perf_tool from event_op3
Git-Commit-ID: 7336555a682c09fd9a3fdf38724493e52653be50
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

Commit-ID:  7336555a682c09fd9a3fdf38724493e52653be50
Gitweb:     https://git.kernel.org/tip/7336555a682c09fd9a3fdf38724493e52653be50
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 13 Sep 2018 14:54:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:10 -0300

perf tools: Remove perf_tool from event_op3

Now that we keep a perf_tool pointer inside perf_session, there's no need
to have a perf_tool argument in the event_op3 callback. Remove it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-3-jolsa@kernel.org
[ Fix the builtin-inject.c build for !HAVE_AUXTRACE_SUPPORT ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 11 +++++------
 tools/perf/util/auxtrace.c  |  7 +++----
 tools/perf/util/auxtrace.h  |  5 ++---
 tools/perf/util/session.c   |  8 +++-----
 tools/perf/util/tool.h      |  4 +---
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d77ed2aea95a..b4a29f435b06 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -131,10 +131,10 @@ static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
 	return 0;
 }
 
-static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
-				       union perf_event *event,
-				       struct perf_session *session)
+static s64 perf_event__repipe_auxtrace(struct perf_session *session,
+				       union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 	int ret;
@@ -172,9 +172,8 @@ static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
 #else
 
 static s64
-perf_event__repipe_auxtrace(struct perf_tool *tool __maybe_unused,
-			    union perf_event *event __maybe_unused,
-			    struct perf_session *session __maybe_unused)
+perf_event__repipe_auxtrace(struct perf_session *session __maybe_unused,
+			    union perf_event *event __maybe_unused)
 {
 	pr_err("AUX area tracing not supported\n");
 	return -EINVAL;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 86f0bc445f93..3017b205a157 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -931,9 +931,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	}
 }
 
-s64 perf_event__process_auxtrace(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session)
+s64 perf_event__process_auxtrace(struct perf_session *session,
+				 union perf_event *event)
 {
 	s64 err;
 
@@ -949,7 +948,7 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
 	if (!session->auxtrace || event->header.type != PERF_RECORD_AUXTRACE)
 		return -EINVAL;
 
-	err = session->auxtrace->process_auxtrace_event(session, event, tool);
+	err = session->auxtrace->process_auxtrace_event(session, event, session->tool);
 	if (err < 0)
 		return err;
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 97776470a52e..6be89776358c 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -519,9 +519,8 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 					 perf_event__handler_t process);
 int perf_event__process_auxtrace_info(struct perf_session *session,
 				      union perf_event *event);
-s64 perf_event__process_auxtrace(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session);
+s64 perf_event__process_auxtrace(struct perf_session *session,
+				 union perf_event *event);
 int perf_event__process_auxtrace_error(struct perf_session *session,
 				       union perf_event *event);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e781cdba845c..7d2c8ce6cfad 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -275,10 +275,8 @@ static int skipn(int fd, off_t n)
 	return 0;
 }
 
-static s64 process_event_auxtrace_stub(struct perf_tool *tool __maybe_unused,
-				       union perf_event *event,
-				       struct perf_session *session
-				       __maybe_unused)
+static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
+				       union perf_event *event)
 {
 	dump_printf(": unhandled!\n");
 	if (perf_data__is_pipe(session->data))
@@ -1376,7 +1374,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_AUXTRACE:
 		/* setup for reading amidst mmap */
 		lseek(fd, file_offset + event->header.size, SEEK_SET);
-		return tool->auxtrace(tool, event, session);
+		return tool->auxtrace(session, event);
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
 		return tool->auxtrace_error(session, event);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9c7f78d76275..56e4ca54020a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -27,13 +27,11 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 			     struct perf_evlist **pevlist);
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
+typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
 
-typedef s64 (*event_op3)(struct perf_tool *tool, union perf_event *event,
-			 struct perf_session *session);
-
 enum show_feature_header {
 	SHOW_FEAT_NO_HEADER = 0,
 	SHOW_FEAT_HEADER,
