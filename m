Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932847AbeCMKtN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:49:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:64144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbeCMKtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:49:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="27634185"
From: changbin.du@intel.com
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH] perf trace: remove redundant ')'
Date: Tue, 13 Mar 2018 18:40:01 +0800
Message-Id: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

There is a redundant ')' at the tail of each event. So remove it.
$ sudo perf trace --no-syscalls -e 'kmem:*' -a
   899.342 kmem:kfree:(vfs_writev+0xb9) call_site=ffffffff9c453979 ptr=(nil))
   899.344 kmem:kfree:(___sys_recvmsg+0x188) call_site=ffffffff9c9b8b88 ptr=(nil))

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7f1b18..7273f5f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1959,7 +1959,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				      trace->output);
 	}
 
-	fprintf(trace->output, ")\n");
+	fprintf(trace->output, "\n");
 
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
-- 
2.7.4
