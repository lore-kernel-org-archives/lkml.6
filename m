Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C64208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeLNUgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:36:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeLNUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:36:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKacGv1455356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:36:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKacuT1455353;
        Fri, 14 Dec 2018 12:36:38 -0800
Date:   Fri, 14 Dec 2018 12:36:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-94888c7cef41d435506acd2e93cedf039d3db69d@git.kernel.org>
Cc:     mingo@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, tstoyanov@vmware.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          tstoyanov@vmware.com, mingo@kernel.org,
          akpm@linux-foundation.org, rostedt@goodmis.org,
          namhyung@kernel.org
In-Reply-To: <20181130154647.591673556@goodmis.org>
References: <20181130154647.591673556@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Rename tep_free_format() to
 tep_free_event()
Git-Commit-ID: 94888c7cef41d435506acd2e93cedf039d3db69d
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

Commit-ID:  94888c7cef41d435506acd2e93cedf039d3db69d
Gitweb:     https://git.kernel.org/tip/94888c7cef41d435506acd2e93cedf039d3db69d
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 10:44:08 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 30 Nov 2018 17:14:53 -0300

tools lib traceevent: Rename tep_free_format() to tep_free_event()

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. This renames tep_free_format() to tep_free_event(), which
describes more closely the purpose of the function.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.591673556@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 6 +++---
 tools/lib/traceevent/event-parse.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 047be5f700b5..a3e7d0a75e11 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6154,7 +6154,7 @@ __parse_event(struct tep_handle *pevent,
 	return 0;
 
 event_add_failed:
-	tep_free_format(event);
+	tep_free_event(event);
 	return ret;
 }
 
@@ -6763,7 +6763,7 @@ static void free_formats(struct tep_format *format)
 	free_format_fields(format->fields);
 }
 
-void tep_free_format(struct tep_event *event)
+void tep_free_event(struct tep_event *event)
 {
 	free(event->name);
 	free(event->system);
@@ -6849,7 +6849,7 @@ void tep_free(struct tep_handle *pevent)
 	}
 
 	for (i = 0; i < pevent->nr_events; i++)
-		tep_free_format(pevent->events[i]);
+		tep_free_event(pevent->events[i]);
 
 	while (pevent->handlers) {
 		handle = pevent->handlers;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 2a1a644c5ec8..950ad185a5c4 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -475,7 +475,7 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				struct tep_event **eventp,
 				const char *buf,
 				unsigned long size, const char *sys);
-void tep_free_format(struct tep_event *event);
+void tep_free_event(struct tep_event *event);
 void tep_free_format_field(struct tep_format_field *field);
 
 void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
