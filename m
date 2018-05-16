Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEPOtr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeEPOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/11] perf bpf: Add license(NAME) helper
Date: Wed, 16 May 2018 11:49:04 -0300
Message-Id: <20180516144908.22212-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To further reduce boilerplate.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vst6hj335s0ebxzqltes3nsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/5sec.c  | 3 +--
 tools/perf/examples/bpf/empty.c | 3 +--
 tools/perf/include/bpf/bpf.h    | 5 +++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index 3d1ed34aec8b..6fc3697ac749 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -40,5 +40,4 @@ int func(void *ctx, int err, long sec)
 	return sec == 5;
 }
 
-char _license[] SEC("license") = "GPL";
-int _version SEC("version") = LINUX_VERSION_CODE;
+license(GPL);
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 86f97763355d..3776d26db9e7 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,4 +1,3 @@
 #include <bpf.h>
 
-char _license[] SEC("license") = "GPL";
-int _version SEC("version") = LINUX_VERSION_CODE;
+license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 003afcab4e51..cdfd18b9c318 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -2,4 +2,9 @@
 #ifndef _PERF_BPF_H
 #define _PERF_BPF_H
 #define SEC(NAME) __attribute__((section(NAME),  used))
+
+#define license(name) \
+char _license[] SEC("license") = #name; \
+int _version SEC("version") = LINUX_VERSION_CODE;
+
 #endif /* _PERF_BPF_H */
-- 
2.14.3
