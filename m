Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B5820865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B5820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404896AbeKVRnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:43:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKVRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:43:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM74t2G3690893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:04:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM74s0k3690890;
        Wed, 21 Nov 2018 23:04:54 -0800
Date:   Wed, 21 Nov 2018 23:04:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9138svli6ddcphrr3ymy9oy3@git.kernel.org>
Cc:     wangnan0@huawei.com, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Rename perf_evlist__set_filter* to
 perf_evlist__set_tp_filter*
Git-Commit-ID: 7ad92a3371e1536a2dddf68337015569c4917170
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

Commit-ID:  7ad92a3371e1536a2dddf68337015569c4917170
Gitweb:     https://git.kernel.org/tip/7ad92a3371e1536a2dddf68337015569c4917170
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 17:02:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*

To better reflect that this is a tracepoint filter, as opposed, for
instance to map based BPF filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9138svli6ddcphrr3ymy9oy3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c |  4 ++--
 tools/perf/util/evlist.c   | 10 +++++-----
 tools/perf/util/evlist.h   |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 835619476370..d86ba17fcf44 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2586,7 +2586,7 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		thread = parent;
 	}
 
-	return perf_evlist__set_filter_pids(trace->evlist, nr, pids);
+	return perf_evlist__set_tp_filter_pids(trace->evlist, nr, pids);
 }
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
@@ -2702,7 +2702,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * we fork the workload in perf_evlist__prepare_workload.
 	 */
 	if (trace->filter_pids.nr > 0)
-		err = perf_evlist__set_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
+		err = perf_evlist__set_tp_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
 	else if (thread_map__pid(evlist->threads, 0) == -1)
 		err = trace__set_filter_loop_pids(trace);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 668d2a9ef0f4..36526d229315 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1176,7 +1176,7 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 	return err;
 }
 
-int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter)
+int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter)
 {
 	struct perf_evsel *evsel;
 	int err = 0;
@@ -1193,7 +1193,7 @@ int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids)
+int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids)
 {
 	char *filter;
 	int ret = -1;
@@ -1214,15 +1214,15 @@ int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t
 		}
 	}
 
-	ret = perf_evlist__set_filter(evlist, filter);
+	ret = perf_evlist__set_tp_filter(evlist, filter);
 out_free:
 	free(filter);
 	return ret;
 }
 
-int perf_evlist__set_filter_pid(struct perf_evlist *evlist, pid_t pid)
+int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid)
 {
-	return perf_evlist__set_filter_pids(evlist, 1, &pid);
+	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
 bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9919eed6d15b..d108d167eb36 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -98,9 +98,9 @@ void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
 #define perf_evlist__reset_sample_bit(evlist, bit) \
 	__perf_evlist__reset_sample_bit(evlist, PERF_SAMPLE_##bit)
 
-int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter);
-int perf_evlist__set_filter_pid(struct perf_evlist *evlist, pid_t pid);
-int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
+int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter);
+int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid);
+int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
 
 struct perf_evsel *
 perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id);
