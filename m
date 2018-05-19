Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeESLnZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:43:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeESLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:43:23 -0400
Date: Sat, 19 May 2018 04:43:14 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wg1m07flfrg1rm06jjzie8si@git.kernel.org>
Cc: jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        wangnan0@huawei.com, hpa@zytor.com, dsahern@gmail.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org
Reply-To: dsahern@gmail.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib api fs tracing_path: Make
 tracing_events_path private
Git-Commit-ID: 789e465058352122023e4fa7de8dcf5c513e0b0b
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

Commit-ID:  789e465058352122023e4fa7de8dcf5c513e0b0b
Gitweb:     https://git.kernel.org/tip/789e465058352122023e4fa7de8dcf5c513e0b0b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 14:51:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 17 May 2018 14:51:23 -0300

tools lib api fs tracing_path: Make tracing_events_path private

Not anymore accessed outside this library, keep it private.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wg1m07flfrg1rm06jjzie8si@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 3 +--
 tools/lib/api/fs/tracing_path.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 9b451af0721c..120037496f77 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -15,8 +15,7 @@
 
 static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
 static char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
-char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
-
+static char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
 
 static void __tracing_path_set(const char *tracing, const char *mountpoint)
 {
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index 904d085b2ae7..a19136b086dc 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -5,8 +5,6 @@
 #include <linux/types.h>
 #include <dirent.h>
 
-extern char tracing_events_path[];
-
 DIR *tracing_events__opendir(void);
 
 void tracing_path_set(const char *mountpoint);
