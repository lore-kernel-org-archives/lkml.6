Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbeCGPv4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:51:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934060AbeCGPvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:51:52 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 16/19] perf tools: Update tags with .cpp files
Date: Wed,  7 Mar 2018 16:50:17 +0100
Message-Id: <20180307155020.32613-17-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some .cpp files, make ctags/cscope aware of them.

Link: http://lkml.kernel.org/n/tip-37og2tumxswqeyx0htq3zu04@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
