Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeDITfW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754195AbeDITfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:35:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6067921771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/13] perf tools: No need to include namespaces.h in util.h
Date: Mon,  9 Apr 2018 16:34:34 -0300
Message-Id: <20180409193437.14199-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
