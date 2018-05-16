Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEPSEJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:04:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEPSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:04:07 -0400
Date: Wed, 16 May 2018 11:03:58 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vst6hj335s0ebxzqltes3nsc@git.kernel.org>
Cc: dsahern@gmail.com, tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, acme@redhat.com,
        tglx@linutronix.de, dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add license(NAME) helper
Git-Commit-ID: 1f477305ab462e2fd1fa8a4c4fa425ad752b3175
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1f477305ab462e2fd1fa8a4c4fa425ad752b3175
Gitweb:     https://git.kernel.org/tip/1f477305ab462e2fd1fa8a4c4fa425ad752b3175
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 May 2018 15:18:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 14:31:24 -0300

perf bpf: Add license(NAME) helper

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
