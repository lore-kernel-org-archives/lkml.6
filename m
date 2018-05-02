Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEBRyi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:54:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeEBRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:54:35 -0400
Date: Wed, 2 May 2018 10:54:26 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a9t4d4hfrycczq9vpsk5sr8q@git.kernel.org>
Cc: hpa@zytor.com, dsahern@gmail.com, jolsa@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, namhyung@kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, wangnan0@huawei.com, jolsa@kernel.org,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Unexport symbol_type__is_a()
Git-Commit-ID: a2f1c160fec491de394dbec930b192da98618803
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

Commit-ID:  a2f1c160fec491de394dbec930b192da98618803
Gitweb:     https://git.kernel.org/tip/a2f1c160fec491de394dbec930b192da98618803
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:17:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:15 -0300

perf symbols: Unexport symbol_type__is_a()

Now this is only used in the symbols.c file, where it will finally
disappear when we remove the MAP_{FUNCTION,VARIABLE} split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a9t4d4hfrycczq9vpsk5sr8q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 tools/perf/util/symbol.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7aa32372f08c..8d9967357354 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -70,7 +70,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
-bool symbol_type__is_a(char symbol_type, enum map_type map_type)
+static bool symbol_type__is_a(char symbol_type, enum map_type map_type)
 {
 	symbol_type = toupper(symbol_type);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0e95d9478783..924f465307b1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -300,7 +300,6 @@ size_t __symbol__fprintf_symname(const struct symbol *sym,
 				 bool unknown_as_addr, FILE *fp);
 size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp);
 size_t symbol__fprintf(struct symbol *sym, FILE *fp);
-bool symbol_type__is_a(char symbol_type, enum map_type map_type);
 bool symbol__restricted_filename(const char *filename,
 				 const char *restricted_filename);
 int symbol__config_symfs(const struct option *opt __maybe_unused,
