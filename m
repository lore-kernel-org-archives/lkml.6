Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ADECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC72083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBnvA7ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJZC3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:29:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42313 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeJZC3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:29:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so4549804pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mhHGO13bVohChjIAZJCbUoJwXKO5hCdLnoJYxQkBt4=;
        b=aBnvA7nyGeekzL6FXSynAVgUWdilQs42jXOk5S9OBuFSInFOg0G4aZ4/g0+F4Pydlb
         m4liS3F7g2t0CKkqlYN/IsIqmum5wAKy4VkXtkwd2G1Xd8XnvumdHy775plMKQatSmsz
         1buzrUlnorB6CQqYcs58oEMHO0PS0bBxvBXZdFmrlm8jpC7hrNJxtjFfGC3pwdciVO18
         HJe0kY4BBjQtKQQYZRbZBVs9kK3RKqx66BC63aEVYfUDGvWmU8/BpJzlVW17SiROWWKA
         VrJlOHOHQHkaOQZLKM5OxmqV1XzXnDNIFpDo78ShzKMa8cDLd+qc1pJQ+U0nDPJYggzo
         3DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9mhHGO13bVohChjIAZJCbUoJwXKO5hCdLnoJYxQkBt4=;
        b=pv5BPq72I9VUbVSYu1Y5N671+tTEN4Mm3OKHjqyAJQoZs/Ys1T704yQgbBeUevUTse
         s2WGuaQoGwn6LSt1vvxKMPrMylW0iIyDzEVgV2DHn3f+CDxki/JTyOM3UjrkK/edE29m
         PvUMo3tHa4bCUpdZNjXXHjqx5pyHGDFsx78tHNIy+eCqoh4Z8a7bkECgwuI3Fra9inB0
         OceL3NKgkWbpeaaPjXyv9TJjel5narmCJBWfARDYsUXbE4l8ZCpPrvPrSLpS4eGCqmlj
         2LRJgx4XSt/GbIoWdqoMwp1rkqS4H5rcGyXVfwEesi4u7e0SU3LMgGZKbSAhP98VSn+a
         CPZQ==
X-Gm-Message-State: AGRZ1gIIVmsyhoxbMGT9mrZkPErDgAx0/riTLh+08Hb1kIgwqFxUjrUI
        AfayZYb/iq/QCDC3lcejNkCAMdYL
X-Google-Smtp-Source: AJdET5cZDiEAnSIfD0JZmh4kj+Ib3UgyxJYFWCVw1OMDQLL7q2pswCfGzPZZk/4m+08RqE3gQW8Srw==
X-Received: by 2002:a62:67c3:: with SMTP id t64-v6mr232262pfj.76.1540490146303;
        Thu, 25 Oct 2018 10:55:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p19-v6sm2261885pff.172.2018.10.25.10.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:55:45 -0700 (PDT)
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
Subject: [PATCH v2 2/2] perf tests: Add a test for the ARM 32-bit [vectors] page
Date:   Thu, 25 Oct 2018 10:55:08 -0700
Message-Id: <20181025175508.6967-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025175508.6967-1-f.fainelli@gmail.com>
References: <20181025175508.6967-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
independance with respect to the ARM CPU being used. Add a test which
tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
turned on to help asses the system's health.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 ++++
 tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 +++++
 4 files changed, 34 insertions(+)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c

diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index 883c57ff0c08..d9ae2733f9cc 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,4 +1,5 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+libperf-y += vectors-page.o
 
 libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5b1543c98022..6848101a855f 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Vectors page",
+		.func = test__vectors_page,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
new file mode 100644
index 000000000000..7ffdd79971c8
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests/tests.h"
+#include "util/find-map.c"
+
+#define VECTORS__MAP_NAME "[vectors]"
+
+int test__vectors_page(struct test *test __maybe_unused,
+		       int subtest __maybe_unused)
+{
+	void *start, *end;
+
+	if (find_map(&start, &end, VECTORS__MAP_NAME)) {
+		pr_err("%s not found, is CONFIG_KUSER_HELPERS enabled?\n",
+		       VECTORS__MAP_NAME);
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b82f55fcc294..399f18ca71a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -119,4 +119,9 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
 #endif
+
+#if defined(__arm__)
+int test__vectors_page(struct test *test, int subtest);
+#endif
+
 #endif /* TESTS_H */
-- 
2.17.1

