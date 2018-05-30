Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbeE3Etz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:49:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53059 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeE3Etw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:49:52 -0400
X-Google-Smtp-Source: ADUXVKKVSu5qtMuwZwJ6xnEI3y2R1j4MIPA1ClVI4t8G5bbEGUt8dcTP2XjAVkayh8fwZZgA8u8dLQ==
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf hists browser: Fix stale hist_entry__tui_annotate() declaration
Date: Wed, 30 May 2018 12:49:27 +0800
Message-Id: <1527655767-12161-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 464fb4fd6af7 ("perf hists browser: Pass annotation_options
from tool to browser") has added extra parameter for functions, but it
missed to update hist_entry__tui_annotate() declaration for
!HAVE_SLANG_SUPPORT configuration so this results in regression for perf
tool building failure.

This patch is to update hist_entry__tui_annotate() declaration for
new added argument '*annotation_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/hist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 5f30758..cafafbf 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -460,7 +460,8 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   struct annotation_options *annotation_opts __maybe_unused)
 {
 	return 0;
 }
-- 
2.7.4
