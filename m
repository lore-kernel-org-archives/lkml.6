Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeFCM2T (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeFCM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 17/29] tools include: Move ARRAY_SIZE() to linux/kernel.h
Date: Sun,  3 Jun 2018 14:26:40 +0200
Message-Id: <20180603122652.17453-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 8607c1ee734d12f62c6a46abef13a510e25a1839 upstream.

To match the kernel, then look for places redefining it to make it use
this version, which checks that its parameter is an array at build time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-txlcf1im83bcbj6kh0wxmyy8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/kernel.h | 3 +++
 tools/perf/util/util.h       | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index adb4d0147755..73ccc48126bb 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -4,6 +4,7 @@
 #include <stdarg.h>
 #include <stddef.h>
 #include <assert.h>
+#include <linux/compiler.h>
 
 #ifndef UINT_MAX
 #define UINT_MAX	(~0U)
@@ -76,6 +77,8 @@
 int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 int scnprintf(char * buf, size_t size, const char * fmt, ...);
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
 /*
  * This looks more complex than it should be. But we need to
  * get the type for the ~ right in round_down (it needs to be
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 43899e0d6fa1..e72d370889f8 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -23,8 +23,6 @@
 #endif
 #endif
 
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
-
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
-- 
2.17.1
