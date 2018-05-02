Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEBSA3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:00:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeEBSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:00:26 -0400
Date: Wed, 2 May 2018 10:57:53 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4pour7egur07tkrpbynawemv@git.kernel.org>
Cc: hpa@zytor.com, jolsa@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, namhyung@kernel.org,
        dsahern@gmail.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Remove map_type arg from
 map_groups__find()
Git-Commit-ID: e1f2a0d0f2d80c7fedb5f910367bc12d02e914a7
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

Commit-ID:  e1f2a0d0f2d80c7fedb5f910367bc12d02e914a7
Gitweb:     https://git.kernel.org/tip/e1f2a0d0f2d80c7fedb5f910367bc12d02e914a7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 09:49:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:18 -0300

perf map: Remove map_type arg from map_groups__find()

One more step in ditching the split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4pour7egur07tkrpbynawemv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 2 +-
 tools/perf/util/map.h                        | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 7d7a65ca2e8d..9a0242e74cfc 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index f053eae3b6eb..5522ce384723 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index b22d643cb602..5f39efef0856 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 7da845026323..7879df34569a 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_X86_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 579ad7d2711d..d035d8f0d5b2 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -222,7 +222,8 @@ static inline struct map *__map_groups__find(struct map_groups *mg,
 
 static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 {
-	return __map_groups__find(mg, MAP__FUNCTION, addr);
+	struct map *map = __map_groups__find(mg, MAP__FUNCTION, addr);
+	return map ?: __map_groups__find(mg, MAP__VARIABLE, addr);
 }
 
 struct map *map_groups__first(struct map_groups *mg);
