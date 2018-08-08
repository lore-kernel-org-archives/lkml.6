Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA31C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20EA2177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20EA2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeHHU2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbeHHU1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:27:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA3C21A86;
        Wed,  8 Aug 2018 18:07:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnSrP-0002VA-7M; Wed, 08 Aug 2018 14:07:03 -0400
Message-Id: <20180808180703.114110715@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 14:03:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH v2 21/24] tools/lib/traceevent: Rename various pevent get/set/is APIs
References: <20180808180245.352784763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_pid_is_registered, pevent_get_cpus, pevent_set_cpus,
pevent_is_file_bigendian, pevent_is_host_bigendian, pevent_is_latency_format,
pevent_set_latency_format

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
-- 
2.18.0


