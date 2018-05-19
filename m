Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeESKzd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbeESKz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:55:27 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/18] tools lib api: The tracing_mnt variable doesn't need to be global
Date: Sat, 19 May 2018 07:54:51 -0300
Message-Id: <20180519105507.16450-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
