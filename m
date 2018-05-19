Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeESLk1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:40:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeESLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:40:26 -0400
Date: Sat, 19 May 2018 04:40:15 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p5x29u6mq2ml3mtnbg9844ad@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
        jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org, acme@redhat.com
Reply-To: dsahern@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib api: The tracing_mnt variable doesn't
 need to be global
Git-Commit-ID: 00a6270361c025bfaae1d70ef1b596d182e05e8a
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

Commit-ID:  00a6270361c025bfaae1d70ef1b596d182e05e8a
Gitweb:     https://git.kernel.org/tip/00a6270361c025bfaae1d70ef1b596d182e05e8a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 16 May 2018 16:20:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 16 May 2018 16:20:12 -0300

tools lib api: The tracing_mnt variable doesn't need to be global

Its only used in the file it is defined, so just make it static.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p5x29u6mq2ml3mtnbg9844ad@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 7b7fd0b18551..4f8ec7d476b8 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -13,8 +13,7 @@
 
 #include "tracing_path.h"
 
-
-char tracing_mnt[PATH_MAX]         = "/sys/kernel/debug";
+static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
 char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
 char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
 
@@ -129,7 +128,7 @@ int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 		snprintf(buf, size,
 			 "Error:\tNo permissions to read %s/%s\n"
 			 "Hint:\tTry 'sudo mount -o remount,mode=755 %s'\n",
-			 tracing_events_path, filename, tracing_mnt);
+			 tracing_events_path, filename, tracing_path_mount());
 	}
 		break;
 	default:
