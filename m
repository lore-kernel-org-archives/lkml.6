Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeCIIzr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:55:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeCIIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:55:45 -0500
Date: Fri, 9 Mar 2018 00:55:25 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ed3956293f2913047c622c238b5bf7ff4fe250bf@git.kernel.org>
Cc: tglx@linutronix.de, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, dsahern@gmail.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: mingo@kernel.org, acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dsahern@gmail.com, namhyung@kernel.org
In-Reply-To: <20180307155020.32613-17-jolsa@kernel.org>
References: <20180307155020.32613-17-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Update tags with .cpp files
Git-Commit-ID: ed3956293f2913047c622c238b5bf7ff4fe250bf
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

Commit-ID:  ed3956293f2913047c622c238b5bf7ff4fe250bf
Gitweb:     https://git.kernel.org/tip/ed3956293f2913047c622c238b5bf7ff4fe250bf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:17 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:47 -0300

perf tools: Update tags with .cpp files

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
 
