Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F67217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977593;
	bh=Hufxlwi6tD44CoDQIMALZZB9Ry/As4iRr5ebwX5EQs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mYDVN0KsgwR0eyUlwSaCc2yHTebtiFo6grwLh44bJpk40NneaWfj9oF3IlKhLhlHg
	 F+/RxluPL3WzX+XP+bhMVksi+O4NlzTS4AiT5BGJDgCpjgo+PL9TQay+lUuNEfzzxD
	 5A/utUfEEYcAovcoy7UPXKZhLWsOqXkvOA85wAi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfAHT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbfAHT7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:49 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EEC20883;
        Tue,  8 Jan 2019 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977587;
        bh=Hufxlwi6tD44CoDQIMALZZB9Ry/As4iRr5ebwX5EQs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2+4/g1IffNb2rH1RkVu4mBx8vsuIIBzL5VeD+SNe0faOxVHPDaFMnkrCnxSvwSsH
         ZWhAlyFsz+BQHqa02NKwG8kYO3CGdcXtP3ov2M7MrIX8JQ6dJv685IfDrD9ziXOEnP
         tkxHs7CERoXrErukj72Yn+Zu92YAgSqwxtMPrI04=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/16] tools lib traceevent: Rename struct cmdline to struct tep_cmdline
Date:   Tue,  8 Jan 2019 16:59:01 -0300
Message-Id: <20190108195910.17726-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

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
 tools/lib/traceevent/event-parse-local.h |  4 +--
 tools/lib/traceevent/event-parse.c       | 36 ++++++++++++------------
 tools/lib/traceevent/event-parse.h       |  8 +++---
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
-- 
2.20.1

