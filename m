Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEBRvA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:51:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeEBRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:50:57 -0400
Date: Wed, 2 May 2018 10:50:45 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x1jpogsvj822sh0q8leiaoep@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        dsahern@gmail.com, wangnan0@huawei.com, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        dsahern@gmail.com, wangnan0@huawei.com, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests vmlinux-kallsyms: Use
 machine__find_kernel_function(_by_name)
Git-Commit-ID: 3cd666b5017cfc9cc258fe8a2d410397f42856bf
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

Commit-ID:  3cd666b5017cfc9cc258fe8a2d410397f42856bf
Gitweb:     https://git.kernel.org/tip/3cd666b5017cfc9cc258fe8a2d410397f42856bf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 12:23:17 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:11 -0300

perf tests vmlinux-kallsyms: Use machine__find_kernel_function(_by_name)

We had this for ages, IIRC for 'perf probe' use initially, so use them
instead of the variants that pass the map_type, that is going away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x1jpogsvj822sh0q8leiaoep@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 4e6c804a3ab4..c7f43afd5f89 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -119,8 +119,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
 
-		first_pair = machine__find_kernel_symbol(&kallsyms, type,
-							 mem_start, NULL);
+		first_pair = machine__find_kernel_function(&kallsyms, mem_start, NULL);
 		pair = first_pair;
 
 		if (pair && UM(pair->start) == mem_start) {
@@ -149,7 +148,7 @@ next_pair:
 				 */
 				continue;
 			} else {
-				pair = machine__find_kernel_symbol_by_name(&kallsyms, type, sym->name, NULL);
+				pair = machine__find_kernel_function_by_name(&kallsyms, sym->name, NULL);
 				if (pair) {
 					if (UM(pair->start) == mem_start)
 						goto next_pair;
