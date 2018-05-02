Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeEBRvb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:51:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeEBRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:51:29 -0400
Date: Wed, 2 May 2018 10:51:19 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-iswqjy1elghc5jjvr0nds3nc@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
        mingo@kernel.org, jolsa@kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: jolsa@kernel.org, mingo@kernel.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests vmlinux-kallsyms: Use
 map__for_each_symbol() instead of open coded equivalent
Git-Commit-ID: d05b861e6da27ccb0d1b882f240890b0ed40adff
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

Commit-ID:  d05b861e6da27ccb0d1b882f240890b0ed40adff
Gitweb:     https://git.kernel.org/tip/d05b861e6da27ccb0d1b882f240890b0ed40adff
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 12:32:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:12 -0300

perf tests vmlinux-kallsyms: Use map__for_each_symbol() instead of open coded equivalent

We had this much shorter map__for_each_symbol() helper for ages, use it
and kill one more map_type use outside the code, in the tools.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-iswqjy1elghc5jjvr0nds3nc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index c7f43afd5f89..a99b0c118541 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -108,7 +108,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	 * in the kallsyms dso. For the ones that are in both, check its names and
 	 * end addresses too.
 	 */
-	for (nd = rb_first(&vmlinux_map->dso->symbols[type]); nd; nd = rb_next(nd)) {
+	map__for_each_symbol(vmlinux_map, sym, nd) {
 		struct symbol *pair, *first_pair;
 
 		sym  = rb_entry(nd, struct symbol, rb_node);
