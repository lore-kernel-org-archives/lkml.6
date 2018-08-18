Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38524C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25D7218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25D7218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHRPBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:01:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHRPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:01:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBrjq91290938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:53:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBrjK21290935;
        Sat, 18 Aug 2018 04:53:45 -0700
Date:   Sat, 18 Aug 2018 04:53:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-413af01c8d9d5d688df3244401cbddfe98bafe2a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        y.karadz@gmail.com, acme@redhat.com, tz.stoyanov@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: y.karadz@gmail.com, acme@redhat.com, tz.stoyanov@gmail.com,
          tglx@linutronix.de, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          rostedt@goodmis.org, peterz@infradead.org
In-Reply-To: <20180808180703.114110715@goodmis.org>
References: <20180808180703.114110715@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Rename various pevent
 get/set/is APIs
Git-Commit-ID: 413af01c8d9d5d688df3244401cbddfe98bafe2a
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

Commit-ID:  413af01c8d9d5d688df3244401cbddfe98bafe2a
Gitweb:     https://git.kernel.org/tip/413af01c8d9d5d688df3244401cbddfe98bafe2a
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:06 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:35:02 -0300

tools lib traceevent: Rename various pevent get/set/is APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_pid_is_registered, pevent_get_cpus, pevent_set_cpus,
pevent_is_file_bigendian, pevent_is_host_bigendian, pevent_is_latency_format,
pevent_set_latency_format

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180703.114110715@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c |  4 ++--
 tools/lib/traceevent/event-parse.h | 14 +++++++-------
 tools/lib/traceevent/plugin_kvm.c  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 53d866434478..d367f7f2f2fc 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -211,14 +211,14 @@ static const char *find_cmdline(struct tep_handle *pevent, int pid)
 }
 
 /**
- * pevent_pid_is_registered - return if a pid has a cmdline registered
+ * tep_pid_is_registered - return if a pid has a cmdline registered
  * @pevent: handle for the pevent
  * @pid: The pid to check if it has a cmdline registered with.
  *
  * Returns 1 if the pid has a cmdline mapped to it
  * 0 otherwise.
  */
-int pevent_pid_is_registered(struct tep_handle *pevent, int pid)
+int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 {
 	const struct cmdline *comm;
 	struct cmdline key;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 63ec6d419219..7f8921431cf1 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -624,7 +624,7 @@ int tep_register_function(struct tep_handle *pevent, char *name,
 			  unsigned long long addr, char *mod);
 int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
 			      unsigned long long addr);
-int pevent_pid_is_registered(struct tep_handle *pevent, int pid);
+int tep_pid_is_registered(struct tep_handle *pevent, int pid);
 
 void tep_print_event_task(struct tep_handle *pevent, struct trace_seq *s,
 			  struct event_format *event,
@@ -731,12 +731,12 @@ struct event_format **pevent_list_events(struct tep_handle *pevent, enum event_s
 struct format_field **pevent_event_common_fields(struct event_format *event);
 struct format_field **pevent_event_fields(struct event_format *event);
 
-static inline int pevent_get_cpus(struct tep_handle *pevent)
+static inline int tep_get_cpus(struct tep_handle *pevent)
 {
 	return pevent->cpus;
 }
 
-static inline void pevent_set_cpus(struct tep_handle *pevent, int cpus)
+static inline void tep_set_cpus(struct tep_handle *pevent, int cpus)
 {
 	pevent->cpus = cpus;
 }
@@ -761,7 +761,7 @@ static inline void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 	pevent->page_size = _page_size;
 }
 
-static inline int pevent_is_file_bigendian(struct tep_handle *pevent)
+static inline int tep_is_file_bigendian(struct tep_handle *pevent)
 {
 	return pevent->file_bigendian;
 }
@@ -771,7 +771,7 @@ static inline void tep_set_file_bigendian(struct tep_handle *pevent, int endian)
 	pevent->file_bigendian = endian;
 }
 
-static inline int pevent_is_host_bigendian(struct tep_handle *pevent)
+static inline int tep_is_host_bigendian(struct tep_handle *pevent)
 {
 	return pevent->host_bigendian;
 }
@@ -781,12 +781,12 @@ static inline void tep_set_host_bigendian(struct tep_handle *pevent, int endian)
 	pevent->host_bigendian = endian;
 }
 
-static inline int pevent_is_latency_format(struct tep_handle *pevent)
+static inline int tep_is_latency_format(struct tep_handle *pevent)
 {
 	return pevent->latency_format;
 }
 
-static inline void pevent_set_latency_format(struct tep_handle *pevent, int lat)
+static inline void tep_set_latency_format(struct tep_handle *pevent, int lat)
 {
 	pevent->latency_format = lat;
 }
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 7ebe82bf19ce..1d0d15906225 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -388,8 +388,8 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianess.
 	 */
-	if (pevent_is_file_bigendian(event->pevent) ==
-	    pevent_is_host_bigendian(event->pevent)) {
+	if (tep_is_file_bigendian(event->pevent) ==
+	    tep_is_host_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
 				 role.level,
