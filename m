Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeEBP2u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeEBPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:20 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 25/52] perf map: Shorten map_groups__find() signature
Date: Wed,  2 May 2018 12:19:15 -0300
Message-Id: <20180502151942.20542-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Removing the map_type, that is going away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-18iiiw25r75xn7zlppjldk48@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 2 +-
 tools/perf/tests/vmlinux-kallsyms.c          | 3 +--
 tools/perf/util/event.c                      | 2 +-
 tools/perf/util/map.c                        | 5 ++---
 tools/perf/util/map.h                        | 9 +++++++--
 tools/perf/util/symbol.c                     | 2 +-
 9 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 8cb347760233..7d7a65ca2e8d 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM_SP];
 
-	map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index e907f0f4c20c..f053eae3b6eb 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
 
-	map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 30cbbd6d5be0..b22d643cb602 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
 
-	map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 95036c7a59e8..7da845026323 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_X86_SP];
 
-	map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index a99b0c118541..702cea7371ac 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -19,7 +19,6 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	struct symbol *sym;
 	struct map *kallsyms_map, *vmlinux_map, *map;
 	struct machine kallsyms, vmlinux;
-	enum map_type type = MAP__FUNCTION;
 	struct maps *maps = machine__kernel_maps(&vmlinux);
 	u64 mem_start, mem_end;
 	bool header_printed;
@@ -205,7 +204,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
 
-		pair = map_groups__find(&kallsyms.kmaps, type, mem_start);
+		pair = map_groups__find(&kallsyms.kmaps, mem_start);
 		if (pair == NULL || pair->priv)
 			continue;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 542bd5b79e48..a8739cd0d8ca 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1534,7 +1534,7 @@ struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type
 		return NULL;
 	}
 try_again:
-	al->map = map_groups__find(mg, type, al->addr);
+	al->map = __map_groups__find(mg, type, al->addr);
 	if (al->map == NULL) {
 		/*
 		 * If this is outside of all known maps, and is a negative
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f553e302bf9c..91e2afb010f8 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -574,7 +574,7 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 				       enum map_type type, u64 addr,
 				       struct map **mapp)
 {
-	struct map *map = map_groups__find(mg, type, addr);
+	struct map *map = __map_groups__find(mg, type, addr);
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
@@ -627,8 +627,7 @@ int map_groups__find_ams(struct addr_map_symbol *ams)
 	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
 		if (ams->map->groups == NULL)
 			return -1;
-		ams->map = map_groups__find(ams->map->groups, ams->map->type,
-					    ams->addr);
+		ams->map = __map_groups__find(ams->map->groups, ams->map->type, ams->addr);
 		if (ams->map == NULL)
 			return -1;
 	}
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 8ff75be0a965..b4bcf569a131 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -214,12 +214,17 @@ static inline void map_groups__remove(struct map_groups *mg, struct map *map)
 	maps__remove(&mg->maps[map->type], map);
 }
 
-static inline struct map *map_groups__find(struct map_groups *mg,
-					   enum map_type type, u64 addr)
+static inline struct map *__map_groups__find(struct map_groups *mg,
+					     enum map_type type, u64 addr)
 {
 	return maps__find(&mg->maps[type], addr);
 }
 
+static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
+{
+	return __map_groups__find(mg, MAP__FUNCTION, addr);
+}
+
 static inline struct map *map_groups__first(struct map_groups *mg,
 					    enum map_type type)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0bf4cf76f36a..25701078beab 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -723,7 +723,7 @@ static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
 		if (module)
 			*module = '\0';
 
-		curr_map = map_groups__find(kmaps, map->type, pos->start);
+		curr_map = __map_groups__find(kmaps, map->type, pos->start);
 
 		if (!curr_map) {
 			symbol__delete(pos);
-- 
2.14.3
