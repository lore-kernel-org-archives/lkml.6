Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05830C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B692084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGMmeBhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B692084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeJZC3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:29:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46530 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeJZC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:29:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4548008pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igItdgfVLpy//ooqk3EpZZUvy+RRjQcCmWqgswgpgcQ=;
        b=UGMmeBhqEc/MdfOhAW1lZBJazmKvBsc/0QL0efi83USTLShDEb+PTqu273vl1AuHJ1
         vyorQdiL3bgONJPJrKT27rCgnjXDvBzrARq8+7FNP5ude/8hG5L78jCmEaRzOc8vyfex
         CcmfDdCf9/lYPKbTy2P1iGVXYBv/2/GrPjk1ll0NfuJmHD8bF3kbtM6gU6SlART0dYJy
         Ra0zS7BzyvR3nN5ulJepsulKyNSDadT9liIA4E1fHlG3YpdKs2NViOGeg3O9b1Mp9sf0
         FD5PkxV/wfU50vMo1pkoGZ+WE6LrLBZzRNVi3lckpSHWh/ajxETksQRyWLUMklWywPsP
         159w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igItdgfVLpy//ooqk3EpZZUvy+RRjQcCmWqgswgpgcQ=;
        b=W/ZmZbAd+jKagiY/jzzWWzqEckJKnuPhOkyYcIoEY+e1oBZrR34S/utwRPb3hSRAmU
         l3C/yMCOYBl00IQc4thGCUeUZmnt+3kbC4dohyY7z9d8dO/hITwvu3Ro5GouPp5V9MXh
         JESgLB0HCEIRwG0GncUU+r4o5jbLA7epBFlUxbtwrEeHkpppe7eD3XmdeluFr3kkbDyu
         BLLphor3illypqUNKPplvOYiqFh5mwTP/Nk7LvAW0shBSxrYlAHFFAEamipQq/eQ1wEB
         H/SMXzYjQC9CfuCTMC6AMssfK+VIFVq08Y7LLu4kXZmRaociwW3K6jSfenRwUnD58mqX
         c84g==
X-Gm-Message-State: AGRZ1gKSIinOhJkHjFG9EW65TQGpOii2TlTzJTH2Q0eBllFxfMsvk17Q
        kZ0vrmRg7LT/Kwv9UPZPVpcE+ccn
X-Google-Smtp-Source: AJdET5egWPYVmY8FQCUNQDen2ykdgVyHNHv1KNMf6bp0YzxlGpW6bCDKMfoQTJ1RFvoIb2VSq2C22g==
X-Received: by 2002:aa7:8302:: with SMTP id t2-v6mr196870pfm.81.1540490144151;
        Thu, 25 Oct 2018 10:55:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p19-v6sm2261885pff.172.2018.10.25.10.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:55:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
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
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH v2 1/2] perf tools: Make find_vdso_map() more modular
Date:   Thu, 25 Oct 2018 10:55:07 -0700
Message-Id: <20181025175508.6967-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025175508.6967-1-f.fainelli@gmail.com>
References: <20181025175508.6967-1-f.fainelli@gmail.com>
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
index 000000000000..19a3431a7b2a
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
+		if (!strncmp(&line[m], name, strlen(name)))
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

