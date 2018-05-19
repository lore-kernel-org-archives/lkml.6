Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeESKz6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbeESKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:48 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/18] tools include compiler-gcc: Add __pure attribute helper
Date: Sat, 19 May 2018 07:54:58 -0300
Message-Id: <20180519105507.16450-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Adopt it from the kernel sources, will be used soon.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oubheiqj8edo5rzewt11cbn0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler-gcc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index a3a4427441bf..70fe61295733 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -21,6 +21,9 @@
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+#ifndef __pure
+#define  __pure		__attribute__((pure))
+#endif
 #define  noinline	__attribute__((noinline))
 #ifndef __packed
 #define __packed	__attribute__((packed))
-- 
2.14.3
