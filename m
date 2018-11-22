Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655F020870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2t/ePcCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655F020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404297AbeKVOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:14 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C8220821;
        Thu, 22 Nov 2018 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857808;
        bh=W3ASI8XIJ9Ky//wq9Idi+tcb//0TQCXhwzvDTUYTER8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2t/ePcCVhEssMGxnk9KHDD63EHHQnqEtkREHpHzafpq99EhxDr1BYBM4CUzfRW+R4
         /mxvlnmYNqFn1+eufrLZY/ZbfB6zfrKGMk7hs/BijhD71sLMP6iQch81DwDXrWjxsv
         tlGS2eZtm5qNEDwNZKgoSBWAEbQ3l5VLo05U5wjg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/28] perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
Date:   Thu, 22 Nov 2018 00:35:51 -0300
Message-Id: <20181122033611.15890-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.5

