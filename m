Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeESLny (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:43:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeESLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:43:51 -0400
Date: Sat, 19 May 2018 04:43:43 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oubheiqj8edo5rzewt11cbn0@git.kernel.org>
Cc: jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include compiler-gcc: Add __pure attribute
 helper
Git-Commit-ID: 6e1690c4c0b540930f08295b6a95c8660b257745
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

Commit-ID:  6e1690c4c0b540930f08295b6a95c8660b257745
Gitweb:     https://git.kernel.org/tip/6e1690c4c0b540930f08295b6a95c8660b257745
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 15:12:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 May 2018 15:17:21 -0300

tools include compiler-gcc: Add __pure attribute helper

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
