Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C766C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLRNvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:51:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:51:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDpFor2850867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:51:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDpFWK2850864;
        Tue, 18 Dec 2018 05:51:15 -0800
Date:   Tue, 18 Dec 2018 05:51:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-0631ca3a6e6edd23a2ca7cab707d1abf291a097d@git.kernel.org>
Cc:     rostedt@goodmis.org, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, tz.stoyanov@gmail.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com
Reply-To: rostedt@goodmis.org, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, tz.stoyanov@gmail.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@redhat.com
In-Reply-To: <20181122112937.10582-1-adrian.hunter@intel.com>
References: <20181122112937.10582-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Fix compile warnings in
 tools/lib/traceevent/event-parse.c
Git-Commit-ID: 0631ca3a6e6edd23a2ca7cab707d1abf291a097d
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

Commit-ID:  0631ca3a6e6edd23a2ca7cab707d1abf291a097d
Gitweb:     https://git.kernel.org/tip/0631ca3a6e6edd23a2ca7cab707d1abf291a097d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 22 Nov 2018 13:29:37 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:21 -0300

tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c

Fix following warnings:

  event-parse.c: In function ‘tep_find_event_by_name’:
  event-parse.c:3521:21: warning: ‘event’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    pevent->last_event = event;
    ~~~~~~~~~~~~~~~~~~~^~~~~~~
    CC       ui/gtk/hists.o
    LINK     plugin_mac80211.so
    CC       nlattr.o
  event-parse.c: In function ‘tep_data_lat_fmt’:
  event-parse.c:5200:4: warning: ‘migrate_disable’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", migrate_disable);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:5207:4: warning: ‘lock_depth’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      trace_seq_printf(s, "%d", lock_depth);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LINK     plugin_sched_switch.so
    LINK     plugin_function.so
    LINK     plugin_xen.so
  event-parse.c: In function ‘tep_event_info’:
  event-parse.c:5047:7: warning: ‘len_arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
         trace_seq_printf(s, format, len_arg, (char)val);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4884:6: note: ‘len_arg’ was declared here
    int len_arg;
        ^~~~~~~
  event-parse.c:4338:11: warning: ‘vsize’ may be used uninitialized in this function [-Wmaybe-uninitialized]
       val = tep_read_number(pevent, bptr, vsize);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  event-parse.c:4224:6: note: ‘vsize’ was declared here
    int vsize;
        ^~~~~

$ gcc --version
  gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lkml.kernel.org/r/20181122112937.10582-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 3692f29fee46..fbd6d6813fab 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3498,7 +3498,7 @@ struct tep_event_format *
 tep_find_event_by_name(struct tep_handle *pevent,
 		       const char *sys, const char *name)
 {
-	struct tep_event_format *event;
+	struct tep_event_format *event = NULL;
 	int i;
 
 	if (pevent->last_event &&
@@ -4221,7 +4221,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 	unsigned long long ip, val;
 	char *ptr;
 	void *bptr;
-	int vsize;
+	int vsize = 0;
 
 	field = pevent->bprint_buf_field;
 	ip_field = pevent->bprint_ip_field;
@@ -4881,7 +4881,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 	char format[32];
 	int show_func;
 	int len_as_arg;
-	int len_arg;
+	int len_arg = 0;
 	int len;
 	int ls;
 
@@ -5146,8 +5146,8 @@ void tep_data_lat_fmt(struct tep_handle *pevent,
 	static int migrate_disable_exists;
 	unsigned int lat_flags;
 	unsigned int pc;
-	int lock_depth;
-	int migrate_disable;
+	int lock_depth = 0;
+	int migrate_disable = 0;
 	int hardirq;
 	int softirq;
 	void *data = record->data;
