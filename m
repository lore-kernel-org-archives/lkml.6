Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeBGOtm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:49:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754457AbeBGOsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:48:51 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 07/10] perf tools: Rename __map_groups__fixup_end to map_groups__fixup_end
Date: Wed,  7 Feb 2018 15:48:35 +0100
Message-Id: <20180207144838.16823-8-jolsa@kernel.org>
In-Reply-To: <20180207144838.16823-1-jolsa@kernel.org>
References: <20180207144838.16823-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to keep the '__' prefix now when there's
map_groups__fixup_end function gone.

Link: http://lkml.kernel.org/n/tip-xq9wpm97spnpaxfjhaz1a03n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c    | 2 +-
 tools/perf/util/symbol-elf.c | 2 +-
 tools/perf/util/symbol.c     | 2 +-
 tools/perf/util/symbol.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 49ebd451151a..a02242eb25a1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1005,7 +1005,7 @@ int __machine__load_kallsyms(struct machine *machine, const char *filename,
 		 * kernel, with modules between them, fixup the end of all
 		 * sections.
 		 */
-		__map_groups__fixup_end(&machine->kmaps, type);
+		map_groups__fixup_end(&machine->kmaps, type);
 	}
 
 	return ret;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 2de770511e70..6d1e4dc2709f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1124,7 +1124,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			 * We need to fixup this here too because we create new
 			 * maps here, for things like vsyscall sections.
 			 */
-			__map_groups__fixup_end(kmaps, map->type);
+			map_groups__fixup_end(kmaps, map->type);
 		}
 	}
 	err = nr;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dcb81176669a..fe15dafaef66 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -228,7 +228,7 @@ void symbols__fixup_end(struct rb_root *symbols)
 		curr->end = roundup(curr->start, 4096) + 4096;
 }
 
-void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
+void map_groups__fixup_end(struct map_groups *mg, enum map_type type)
 {
 	struct maps *maps = &mg->maps[type];
 	struct map *next, *curr;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0563f33c1eb3..cf955f1d1718 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -316,7 +316,7 @@ void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel)
 void symbols__insert(struct rb_root *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root *symbols);
 void symbols__fixup_end(struct rb_root *symbols);
-void __map_groups__fixup_end(struct map_groups *mg, enum map_type type);
+void map_groups__fixup_end(struct map_groups *mg, enum map_type type);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
-- 
2.13.6
