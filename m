Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11400C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C112070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfAIHON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:14:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:14:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097DlO53856005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:13:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097Dlf43856002;
        Tue, 8 Jan 2019 23:13:47 -0800
Date:   Tue, 8 Jan 2019 23:13:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-2e4318a287bdf815140462257ab8697f5289a12f@git.kernel.org>
Cc:     namhyung@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org, jolsa@redhat.com,
        akpm@linux-foundation.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          tstoyanov@vmware.com, namhyung@kernel.org, rostedt@goodmis.org,
          akpm@linux-foundation.org, jolsa@redhat.com, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20181201040852.358871851@goodmis.org>
References: <20181201040852.358871851@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename struct cmdline to
 struct tep_cmdline
Git-Commit-ID: 2e4318a287bdf815140462257ab8697f5289a12f
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

Commit-ID:  2e4318a287bdf815140462257ab8697f5289a12f
Gitweb:     https://git.kernel.org/tip/2e4318a287bdf815140462257ab8697f5289a12f
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 23:08:09 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

tools lib traceevent: Rename struct cmdline to struct tep_cmdline

In order to make libtraceevent a proper library, variables, data
structures and functions should have a unique prefix to prevent name
space conflicts. That prefix will be "tep_".

This patch renames 'struct cmdline' to 'struct tep_cmdline'.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.358871851@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-local.h |  4 ++--
 tools/lib/traceevent/event-parse.c       | 36 ++++++++++++++++----------------
 tools/lib/traceevent/event-parse.h       |  8 +++----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index 9a092dd4a86d..35833ee32d6c 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -7,7 +7,7 @@
 #ifndef _PARSE_EVENTS_INT_H
 #define _PARSE_EVENTS_INT_H
 
-struct cmdline;
+struct tep_cmdline;
 struct cmdline_list;
 struct func_map;
 struct func_list;
@@ -36,7 +36,7 @@ struct tep_handle {
 	int long_size;
 	int page_size;
 
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	struct cmdline_list *cmdlist;
 	int cmdline_count;
 
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 44b80471b024..a850342baf86 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -124,15 +124,15 @@ struct tep_print_arg *alloc_arg(void)
 	return calloc(1, sizeof(struct tep_print_arg));
 }
 
-struct cmdline {
+struct tep_cmdline {
 	char *comm;
 	int pid;
 };
 
 static int cmdline_cmp(const void *a, const void *b)
 {
-	const struct cmdline *ca = a;
-	const struct cmdline *cb = b;
+	const struct tep_cmdline *ca = a;
+	const struct tep_cmdline *cb = b;
 
 	if (ca->pid < cb->pid)
 		return -1;
@@ -152,7 +152,7 @@ static int cmdline_init(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist = pevent->cmdlist;
 	struct cmdline_list *item;
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	int i;
 
 	cmdlines = malloc(sizeof(*cmdlines) * pevent->cmdline_count);
@@ -179,8 +179,8 @@ static int cmdline_init(struct tep_handle *pevent)
 
 static const char *find_cmdline(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return "<idle>";
@@ -208,8 +208,8 @@ static const char *find_cmdline(struct tep_handle *pevent, int pid)
  */
 int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return 1;
@@ -235,9 +235,9 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 static int add_new_comm(struct tep_handle *pevent,
 			const char *comm, int pid, bool override)
 {
-	struct cmdline *cmdlines = pevent->cmdlines;
-	struct cmdline *cmdline;
-	struct cmdline key;
+	struct tep_cmdline *cmdlines = pevent->cmdlines;
+	struct tep_cmdline *cmdline;
+	struct tep_cmdline key;
 	char *new_comm;
 
 	if (!pid)
@@ -5331,8 +5331,8 @@ const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid)
 	return comm;
 }
 
-static struct cmdline *
-pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *next)
+static struct tep_cmdline *
+pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct tep_cmdline *next)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)next;
 
@@ -5344,7 +5344,7 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
 	while (cmdlist && strcmp(cmdlist->comm, comm) != 0)
 		cmdlist = cmdlist->next;
 
-	return (struct cmdline *)cmdlist;
+	return (struct tep_cmdline *)cmdlist;
 }
 
 /**
@@ -5360,10 +5360,10 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
  * next pid.
  * Also, it does a linear search, so it may be slow.
  */
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next)
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next)
 {
-	struct cmdline *cmdline;
+	struct tep_cmdline *cmdline;
 
 	/*
 	 * If the cmdlines have not been converted yet, then use
@@ -5402,7 +5402,7 @@ struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *co
  * Returns the pid for a give cmdline. If @cmdline is NULL, then
  * -1 is returned.
  */
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline)
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)cmdline;
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index e6f4249910e6..77a4a1dd4b4d 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -526,10 +526,10 @@ int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
 const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid);
-struct cmdline;
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next);
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline);
+struct tep_cmdline;
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next);
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline);
 
 void tep_print_field(struct trace_seq *s, void *data,
 		     struct tep_format_field *field);
