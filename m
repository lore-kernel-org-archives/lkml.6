Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970802AbeCSTCP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970768AbeCSTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FDA217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/14] perf debug: Avoid setting 'quiet' to 'true' unnecessarily
Date: Mon, 19 Mar 2018 16:01:29 -0300
Message-Id: <20180319190136.7441-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

When using --quiet to disable messages, we will set the 'quiet' variable
to 'true' first, then check that variable to decide whether we need to
call perf_quiet_option(), so no need to set 'quiet' to 'true' once more
in perf_quiet_option().

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520944274-37001-2-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f3a71db83947..3d6459626c2a 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -232,7 +232,6 @@ int perf_quiet_option(void)
 		var++;
 	}
 
-	quiet = true;
 	return 0;
 }
 
-- 
2.14.3
