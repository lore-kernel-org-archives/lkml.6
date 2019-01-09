Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01665C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6720821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfAIHMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:12:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50327 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:12:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097BLgC3855589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:11:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097BItD3855576;
        Tue, 8 Jan 2019 23:11:18 -0800
Date:   Tue, 8 Jan 2019 23:11:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-011532379b7c2de6757e129037bdfc8d704bce23@git.kernel.org>
Cc:     tmricht@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        acme@redhat.com, f.fainelli@gmail.com, jolsa@kernel.org,
        tglx@linutronix.de, kim.phillips@arm.com,
        gregkh@linuxfoundation.org, l.stach@pengutronix.de,
        alexander.shishkin@linux.intel.com, rmk+kernel@armlinux.org.uk,
        cphealy@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: acme@redhat.com, f.fainelli@gmail.com, tmricht@linux.ibm.com,
          ravi.bangoria@linux.ibm.com, l.stach@pengutronix.de,
          jolsa@kernel.org, kim.phillips@arm.com,
          gregkh@linuxfoundation.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, rmk+kernel@armlinux.org.uk,
          cphealy@gmail.com, peterz@infradead.org, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org
In-Reply-To: <20181221034337.26663-2-f.fainelli@gmail.com>
References: <20181221034337.26663-2-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Make find_vdso_map() more modular
Git-Commit-ID: 011532379b7c2de6757e129037bdfc8d704bce23
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  011532379b7c2de6757e129037bdfc8d704bce23
Gitweb:     https://git.kernel.org/tip/011532379b7c2de6757e129037bdfc8d704bce23
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Thu, 20 Dec 2018 19:43:36 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

perf tools: Make find_vdso_map() more modular

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update the filename to find-map.c and all references
to it: perf-read-vdso.c and util/vdso.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20181221034337.26663-2-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                        | 4 ++--
 tools/perf/perf-read-vdso.c                     | 6 +++---
 tools/perf/util/{find-vdso-map.c => find-map.c} | 7 +++----
 tools/perf/util/vdso.c                          | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2921f829a0f4..0ee6795d82cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -662,12 +662,12 @@ $(OUTPUT)perf-%: %.o $(PERFLIBS)
 	$(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 ifndef NO_PERF_READ_VDSO32
-$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -m32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
 ifndef NO_PERF_READ_VDSOX32
-$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
diff --git a/tools/perf/perf-read-vdso.c b/tools/perf/perf-read-vdso.c
index 8c0ca0cc428f..aaa5210ea84a 100644
--- a/tools/perf/perf-read-vdso.c
+++ b/tools/perf/perf-read-vdso.c
@@ -5,17 +5,17 @@
 #define VDSO__MAP_NAME "[vdso]"
 
 /*
- * Include definition of find_vdso_map() also used in util/vdso.c for
+ * Include definition of find_map() also used in util/vdso.c for
  * building perf.
  */
-#include "util/find-vdso-map.c"
+#include "util/find-map.c"
 
 int main(void)
 {
 	void *start, *end;
 	size_t size, written;
 
-	if (find_vdso_map(&start, &end))
+	if (find_map(&start, &end, VDSO__MAP_NAME))
 		return 1;
 
 	size = end - start;
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-map.c
similarity index 71%
rename from tools/perf/util/find-vdso-map.c
rename to tools/perf/util/find-map.c
index d7823e3508fc..7b2300588ece 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-static int find_vdso_map(void **start, void **end)
+static int find_map(void **start, void **end, const char *name)
 {
 	FILE *maps;
 	char line[128];
@@ -7,7 +7,7 @@ static int find_vdso_map(void **start, void **end)
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
+		fprintf(stderr, "cannot open maps\n");
 		return -1;
 	}
 
@@ -21,8 +21,7 @@ static int find_vdso_map(void **start, void **end)
 		if (m < 0)
 			continue;
 
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
+		if (!strncmp(&line[m], name, strlen(name)))
 			found = 1;
 	}
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 741af209b19d..3702cba11d7d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -18,10 +18,10 @@
 #include "debug.h"
 
 /*
- * Include definition of find_vdso_map() also used in perf-read-vdso.c for
+ * Include definition of find_map() also used in perf-read-vdso.c for
  * building perf-read-vdso32 and perf-read-vdsox32.
  */
-#include "find-vdso-map.c"
+#include "find-map.c"
 
 #define VDSO__TEMP_FILE_NAME "/tmp/perf-vdso.so-XXXXXX"
 
@@ -76,7 +76,7 @@ static char *get_file(struct vdso_file *vdso_file)
 	if (vdso_file->found)
 		return vdso_file->temp_file_name;
 
-	if (vdso_file->error || find_vdso_map(&start, &end))
+	if (vdso_file->error || find_map(&start, &end, VDSO__MAP_NAME))
 		return NULL;
 
 	size = end - start;
