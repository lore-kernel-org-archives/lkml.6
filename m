Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDJF37 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:29:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeDJF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:29:58 -0400
Date: Mon, 9 Apr 2018 22:29:45 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vq26rsuwq1cqylpcyvq89c84@git.kernel.org>
Cc: adrian.hunter@intel.com, naveen.n.rao@linux.vnet.ibm.com,
        wangnan0@huawei.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        acme@redhat.com, sandipan@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: dsahern@gmail.com, acme@redhat.com, tglx@linutronix.de,
        sandipan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, wangnan0@huawei.com, adrian.hunter@intel.com,
        naveen.n.rao@linux.vnet.ibm.com, namhyung@kernel.org, mingo@kernel.org,
        hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: No need to include namespaces.h in
 util.h
Git-Commit-ID: ad0902e0c4004dc95bf15229933012121ff54033
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

Commit-ID:  ad0902e0c4004dc95bf15229933012121ff54033
Gitweb:     https://git.kernel.org/tip/ad0902e0c4004dc95bf15229933012121ff54033
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 6 Apr 2018 14:53:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 9 Apr 2018 10:57:50 -0300

perf tools: No need to include namespaces.h in util.h

The only thing that is needed there is a forward declaration for 'struct
nsinfo', so disentanble this, which in turns allows built-in clang
builds, i.e. 'make LIBCLANGLLVM=1 -C tools/perf'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vq26rsuwq1cqylpcyvq89c84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9496365da3d7..c9626c206208 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,8 +11,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <linux/compiler.h>
-#include <linux/types.h>
-#include "namespaces.h"
+#include <sys/types.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -26,6 +25,7 @@ static inline void *zalloc(size_t size)
 #define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
 
 struct dirent;
+struct nsinfo;
 struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
