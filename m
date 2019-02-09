Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63031C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CC121916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBIMkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:40:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36601 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:40:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Ce37j2629364
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:40:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Ce2uC2629359;
        Sat, 9 Feb 2019 04:40:02 -0800
Date:   Sat, 9 Feb 2019 04:40:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ph72xhl9moqa0g1hxcyudwfn@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org,
          mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf-loader: Remove unecessary includes from
 bpf-loader.h
Git-Commit-ID: ebc52aee6130653b934a86637108ac2a7c95c74c
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

Commit-ID:  ebc52aee6130653b934a86637108ac2a7c95c74c
Gitweb:     https://git.kernel.org/tip/ebc52aee6130653b934a86637108ac2a7c95c74c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 13:06:18 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf bpf-loader: Remove unecessary includes from bpf-loader.h

To cut the header dep tree, to get unecessary object rebuilds to be
reduced when a change happens in headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ph72xhl9moqa0g1hxcyudwfn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 1 +
 tools/perf/util/bpf-loader.h | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 2f3eb6d293ee..6e68698aa0ad 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include "perf.h"
 #include "debug.h"
+#include "evlist.h"
 #include "bpf-loader.h"
 #include "bpf-prologue.h"
 #include "probe-event.h"
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 62d245a90e1d..3f46856e3330 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -8,11 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/err.h>
-#include <string.h>
 #include <bpf/libbpf.h>
-#include "probe-event.h"
-#include "evlist.h"
-#include "debug.h"
 
 enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__START = __LIBBPF_ERRNO__START - 100,
@@ -44,6 +40,7 @@ enum bpf_loader_errno {
 };
 
 struct perf_evsel;
+struct perf_evlist;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -87,6 +84,8 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
+#include <string.h>
+#include "debug.h"
 
 static inline struct bpf_object *
 bpf__prepare_load(const char *filename __maybe_unused,
