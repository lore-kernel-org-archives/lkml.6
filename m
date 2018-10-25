Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91A920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkWpe9ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91A920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJYIjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:39:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47028 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:39:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id bb7-v6so2975139plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xzNQx0g2AFUYLuLGD7cWeyVjJDjG2pEyMzu7iEGsF4E=;
        b=CkWpe9ka2H1CLKG5cjLE8OEPCY3zTW7pR1FlPmhCabYoUBO1BeCJ7YRLfzUoMpORYu
         b79vU9u+mQotUalFE5IR3eEMaANWeZZ8W6ssqm1Fybf+kL5FtXnNuquQeOCyZImgM8Kx
         C4xJqkyigAV7R3h6wcHxQe/145tBKbg+BbmkrT3dgvXcb0iyu4uIQI0hMiwC03XOaufz
         XQhiAdRCGar+8HwTgWQIXtnKMgerO0jSOsw2eVlyKdoKOHbTCY6qMWOgHxP7BOCCjOzw
         /NITSOqBPKKr9vpLBfFcVTDdoyIfJSIwH4K8fmiB5IX6r9p+tHsn6fxWWFETLD1jm7np
         XK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzNQx0g2AFUYLuLGD7cWeyVjJDjG2pEyMzu7iEGsF4E=;
        b=QfPKYKYSrZZD/fw7heeRUFlDC+yTTs+G93C3/e/V82Hx2dfyR/oDoDkuTb+kLrNYtv
         fAVl26D666sHx3hRVzgQB9UEg7VA/ZKAUmfnCEHZVBJzJYQ5EY4sY2icDec7zNPMlZpY
         BDuBjgrl1ePxB/uEMOEw4IIKkCMF7G1M4TasSFwF7SyrsfzEddi3we+nVkmzkeAYYYKn
         xHwJn2SCkUrGPeZ3x1IVZp0NNELImtYR3YTSnr7q4+SL9cBP365KkS0lH5WqlD7vBDc9
         sXj0RELx7iFKBfxAXCF6QTEhm6qnv0bED9zgv43K+1qslEvsE2KBQHs2eXL0SwQPrj9t
         mktA==
X-Gm-Message-State: AGRZ1gKwlIRNSJqZm5Rk7qUTx/2oVKyBb+aTxmwIp3qEJeAQV12sGoj+
        yUwNP5MbZq1FJktaR08tO4k=
X-Google-Smtp-Source: AJdET5eJI6uu7VjZpHT/W7S+GWBtllsZ6YCEn43HximkgV49O32yhECksXLfU4cousELL4BJPq7G9g==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr4410033plq.77.1540426172541;
        Wed, 24 Oct 2018 17:09:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o9-v6sm12008598pgn.30.2018.10.24.17.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:09:31 -0700 (PDT)
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
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors] page
Date:   Wed, 24 Oct 2018 17:09:05 -0700
Message-Id: <20181025000905.6095-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
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
 tools/perf/arch/arm/tests/vectors-page.c | 20 ++++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 +++++
 4 files changed, 30 insertions(+)
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
index 000000000000..e44223cbf0df
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
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
+	if (find_map(&start, &end, VECTORS__MAP_NAME))
+		return -1;
+
+	return 0;
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

