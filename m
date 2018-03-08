Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeCHTzU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeCHTwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF5C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 47/54] perf tools: Update tags with .cpp files
Date: Thu,  8 Mar 2018 16:50:22 -0300
Message-Id: <20180308195029.14991-48-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We have some .cpp files, make ctags/cscope aware of them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4679e237a7f5..f7517e1b73f8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -708,15 +708,15 @@ TAG_FILES= ../../include/uapi/linux/perf_event.h
 
 TAGS:
 	$(QUIET_GEN)$(RM) TAGS; \
-	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs etags -a $(TAG_FILES)
+	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs etags -a $(TAG_FILES)
 
 tags:
 	$(QUIET_GEN)$(RM) tags; \
-	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs ctags -a $(TAG_FILES)
+	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs ctags -a $(TAG_FILES)
 
 cscope:
 	$(QUIET_GEN)$(RM) cscope*; \
-	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs cscope -b $(TAG_FILES)
+	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs cscope -b $(TAG_FILES)
 
 ### Testing rules
 
-- 
2.14.3
