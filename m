Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeFCM2L (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751718AbeFCM2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 15/29] tools include: Introduce linux/bug.h, from the kernel sources
Date: Sun,  3 Jun 2018 14:26:38 +0200
Message-Id: <20180603122652.17453-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 379d61b1c7d42512cded04d372f15a7e725db9e1 upstream.

With just what we will need in the upcoming changesets, the
BUILD_BUG_ON_ZERO() definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-lw8zg7x6ttwcvqhp90mwe3vo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/bug.h | 10 ++++++++++
 tools/perf/MANIFEST       |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 tools/include/linux/bug.h

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
new file mode 100644
index 000000000000..8e4a4f49135d
--- /dev/null
+++ b/tools/include/linux/bug.h
@@ -0,0 +1,10 @@
+#ifndef _TOOLS_PERF_LINUX_BUG_H
+#define _TOOLS_PERF_LINUX_BUG_H
+
+/* Force a compilation error if condition is true, but also produce a
+   result (of value 0 and type size_t), so the expression can be used
+   e.g. in a structure initializer (or where-ever else comma expressions
+   aren't permitted). */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+
+#endif	/* _TOOLS_PERF_LINUX_BUG_H */
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 776f6b23ea2e..a4f98e131819 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -63,6 +63,7 @@ tools/include/linux/bitops.h
 tools/include/linux/compiler.h
 tools/include/linux/compiler-gcc.h
 tools/include/linux/coresight-pmu.h
+tools/include/linux/bug.h
 tools/include/linux/filter.h
 tools/include/linux/hash.h
 tools/include/linux/kernel.h
-- 
2.17.1
