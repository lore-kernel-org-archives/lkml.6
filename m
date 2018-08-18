Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BACBC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7FB21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7FB21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeHRO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:27:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:27:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBKKV61283489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:20:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBKKBY1283486;
        Sat, 18 Aug 2018 04:20:20 -0700
Date:   Sat, 18 Aug 2018 04:20:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4rixbfzco6tsry0w9ghx3ktb@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        rostedt@goodmis.org, namhyung@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
          jolsa@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
          tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
          namhyung@kernel.org, rostedt@goodmis.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Rename some syscall_tp methods to
 raw_syscall
Git-Commit-ID: 63f11c80e5dd4afae69ea2578addf896ddc06fee
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

Commit-ID:  63f11c80e5dd4afae69ea2578addf896ddc06fee
Gitweb:     https://git.kernel.org/tip/63f11c80e5dd4afae69ea2578addf896ddc06fee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 14:27:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 15:07:28 -0300

perf trace: Rename some syscall_tp methods to raw_syscall

Because raw_syscalls have the field for the syscall number as 'id' while
the syscalls:sys_{enter,exit}_NAME have it as __syscall_nr...

Since we want to support both for being able to enable just a
syscalls:sys_{enter,exit}_name instead of asking for
raw_syscalls:sys_{enter,exit} plus filters, make the method names for
each kind of tracepoint more explicit.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4rixbfzco6tsry0w9ghx3ktb@git.kernel.org
Signef-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7336552c22cf..039f94467968 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -239,7 +239,7 @@ static void perf_evsel__delete_priv(struct perf_evsel *evsel)
 	perf_evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
+static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
 	if (evsel->priv != NULL) {
@@ -257,7 +257,7 @@ out_delete:
 	return -ENOENT;
 }
 
-static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void *handler)
+static struct perf_evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
 {
 	struct perf_evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
 
@@ -268,7 +268,7 @@ static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void
 	if (IS_ERR(evsel))
 		return NULL;
 
-	if (perf_evsel__init_syscall_tp(evsel, handler))
+	if (perf_evsel__init_raw_syscall_tp(evsel, handler))
 		goto out_delete;
 
 	return evsel;
@@ -2288,14 +2288,14 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_evsel *sys_enter, *sys_exit;
 
-	sys_enter = perf_evsel__syscall_newtp("sys_enter", trace__sys_enter);
+	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
 	if (sys_enter == NULL)
 		goto out;
 
 	if (perf_evsel__init_sc_tp_ptr_field(sys_enter, args))
 		goto out_delete_sys_enter;
 
-	sys_exit = perf_evsel__syscall_newtp("sys_exit", trace__sys_exit);
+	sys_exit = perf_evsel__raw_syscall_newtp("sys_exit", trace__sys_exit);
 	if (sys_exit == NULL)
 		goto out_delete_sys_enter;
 
@@ -2717,7 +2717,7 @@ static int trace__replay(struct trace *trace)
 							     "syscalls:sys_enter");
 
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_enter) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
 	    perf_evsel__init_sc_tp_ptr_field(evsel, args))) {
 		pr_err("Error during initialize raw_syscalls:sys_enter event\n");
 		goto out;
@@ -2729,7 +2729,7 @@ static int trace__replay(struct trace *trace)
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "syscalls:sys_exit");
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_exit) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
 	    perf_evsel__init_sc_tp_uint_field(evsel, ret))) {
 		pr_err("Error during initialize raw_syscalls:sys_exit event\n");
 		goto out;
