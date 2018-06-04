Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeFDHAU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbeFDHAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:00:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 17/29] tools include: Move ARRAY_SIZE() to linux/kernel.h
Date: Mon,  4 Jun 2018 08:58:13 +0200
Message-Id: <20180604065802.833408447@linuxfoundation.org>
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
 tools/include/linux/kernel.h |    3 +++
 tools/perf/util/util.h       |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

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
