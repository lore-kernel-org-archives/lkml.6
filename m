Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFDG7O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbeFDG7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 15/29] tools include: Introduce linux/bug.h, from the kernel sources
Date: Mon,  4 Jun 2018 08:58:11 +0200
Message-Id: <20180604065802.754284290@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 tools/include/linux/bug.h |   10 ++++++++++
 tools/perf/MANIFEST       |    1 +
 2 files changed, 11 insertions(+)

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
