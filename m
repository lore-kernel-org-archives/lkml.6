Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B1AECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc3pygGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJYIjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:39:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39590 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:39:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so2984831plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdoa5uG/C/yFK/pypJK3S7rkugclZSk0NfLcNIRwaGE=;
        b=fc3pygGSwEEPAW3r4bwjPRmvcQzuep7NvwGSBhz+AuGz2VyNJu0nDWATH4Zs50eIFt
         JCULcDYH31P+Br9Twmm5JtQZEieCHo4M1k/pxcu0LdbcRR5Uv/nVd3U1tb5r4w+yuXJL
         StiHC8keRvWKdD8X+CO5ph82DjJYpxxhKRD55OVN+dLwpewGRE70LpIeQbt42sD38hZb
         +gDsTO0fhlLp/SWQSv0ga884AW2AVIodEYAVlXE1Gz61FcaY1ub040dd3xJKE3Ha4lXf
         2317OZaH7VnFkrG4Rv3R0C/6b6DZMS0GlgoWHRbIuFZMTO+zDNJGhFolHePCievfltbj
         F1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdoa5uG/C/yFK/pypJK3S7rkugclZSk0NfLcNIRwaGE=;
        b=m9tl1zBdA+yzOgsp5x7o7RaWGnt02raODvb7bjTAPktW1qkxkZClMtVxyEbmOTkNel
         XaBFTiZcZ9tcqHvtQsyy8UGXgW7Psszo6IlIUGeHe1LralvnbDFLaSGpKfNASeeyAM9i
         E1X8msc/r6WkOkTt6HtbfIzDR3HY/yUwFcpCPH868enBJPVNgjvQSg72wrNYivwBfuEI
         z6BqNWoPVfQgIE50cr++zv/2jdZRJh2Tiz79ooSdVI2onltT5hDrjOSi6uANZKZQHrUO
         J86jPF9s050KGo6E93ywGMZiN0dO02hsBtkcavebNtOLHFjw/lj3o7DUKSOCJjtGTR+U
         zi+w==
X-Gm-Message-State: AGRZ1gIhk0VsFbqA2mCIeFYgN/Ja+HRbaqi9LoW+pF4AwdKsguhKkWL9
        XO9eiOVll8hOVpw9RNXYn9w=
X-Google-Smtp-Source: AJdET5c3ICJ0PbEBzN+0FIH7uUukjvxy5ac/QWXueJ9tPinMC/lc2D06Lvu3ZTrOA0xI5aJhILe4LA==
X-Received: by 2002:a17:902:3a5:: with SMTP id d34-v6mr4387228pld.231.1540426170394;
        Wed, 24 Oct 2018 17:09:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o9-v6sm12008598pgn.30.2018.10.24.17.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:09:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list),
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH 1/2] perf tools: Make find_vdso_map() more modular
Date:   Wed, 24 Oct 2018 17:09:04 -0700
Message-Id: <20181025000905.6095-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update find_vdso_map() to use it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/util/find-map.c      | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/find-vdso-map.c | 30 +++---------------------------
 2 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/util/find-map.c

diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
new file mode 100644
index 000000000000..42533fc21108
--- /dev/null
+++ b/tools/perf/util/find-map.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+static int find_map(void **start, void **end, const char *name)
+{
+	FILE *maps;
+	char line[128];
+	int found = 0;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		fprintf(stderr, "vdso: cannot open maps\n");
+		return -1;
+	}
+
+	while (!found && fgets(line, sizeof(line), maps)) {
+		int m = -1;
+
+		/* We care only about private r-x mappings. */
+		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
+				start, end, &m))
+			continue;
+		if (m < 0)
+			continue;
+
+		if (!strncmp(&line[m], name, sizeof(name) - 1))
+			found = 1;
+	}
+
+	fclose(maps);
+	return !found;
+}
+
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-vdso-map.c
index d7823e3508fc..840d7d6e29e2 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-vdso-map.c
@@ -1,31 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "find-map.c"
+
 static int find_vdso_map(void **start, void **end)
 {
-	FILE *maps;
-	char line[128];
-	int found = 0;
-
-	maps = fopen("/proc/self/maps", "r");
-	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
-		return -1;
-	}
-
-	while (!found && fgets(line, sizeof(line), maps)) {
-		int m = -1;
-
-		/* We care only about private r-x mappings. */
-		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
-				start, end, &m))
-			continue;
-		if (m < 0)
-			continue;
-
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
-			found = 1;
-	}
-
-	fclose(maps);
-	return !found;
+	return find_map(start, end, VDSO__MAP_NAME);
 }
-- 
2.17.1

