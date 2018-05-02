Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeEBSC2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:02:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeEBSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:02:27 -0400
Date: Wed, 2 May 2018 11:02:18 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vnpc2rakf6vc98pcl5z1cfrg@git.kernel.org>
Cc: jolsa@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, dsahern@gmail.com,
        mingo@kernel.org
Reply-To: wangnan0@huawei.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Remove needless goto
Git-Commit-ID: 857140e81690748ce9a0a7ae7ed91cddb254f51a
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

Commit-ID:  857140e81690748ce9a0a7ae7ed91cddb254f51a
Gitweb:     https://git.kernel.org/tip/857140e81690748ce9a0a7ae7ed91cddb254f51a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 27 Apr 2018 10:53:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 27 Apr 2018 10:53:14 -0300

perf symbols: Remove needless goto

We can plain use the an else to the if block that is right after that
goto, so simplify it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vnpc2rakf6vc98pcl5z1cfrg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5fd81c19eebf..0b230f1a31c4 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1069,12 +1069,8 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				dso__set_loaded(curr_dso);
 			} else
 				curr_dso = curr_map->dso;
-
-			goto new_symbol;
-		}
-
-		if ((used_opd && runtime_ss->adjust_symbols)
-				|| (!used_opd && syms_ss->adjust_symbols)) {
+		} else if ((used_opd && runtime_ss->adjust_symbols) ||
+			   (!used_opd && syms_ss->adjust_symbols)) {
 			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
 				  "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
 				  (u64)sym.st_value, (u64)shdr.sh_addr,
