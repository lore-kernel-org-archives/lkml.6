Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8075121871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLRO1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:27:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:27:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEQxQW2857920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:26:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEQxP92857917;
        Tue, 18 Dec 2018 06:26:59 -0800
Date:   Tue, 18 Dec 2018 06:26:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eugeniy Paltsev <tipbot@zytor.com>
Message-ID: <tip-6d99a79cb40da3eddafef844b7a679fe5162f224@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        Eugeniy.Paltsev@synopsys.com, jolsa@redhat.com, mingo@kernel.org,
        alexey.brodkin@synopsys.com, vineet.gupta1@synopsys.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          Eugeniy.Paltsev@synopsys.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          acme@redhat.com, alexey.brodkin@synopsys.com,
          vineet.gupta1@synopsys.com, jolsa@redhat.com, mingo@kernel.org
In-Reply-To: <20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com>
References: <20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce basic support for ARC
Git-Commit-ID: 6d99a79cb40da3eddafef844b7a679fe5162f224
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

Commit-ID:  6d99a79cb40da3eddafef844b7a679fe5162f224
Gitweb:     https://git.kernel.org/tip/6d99a79cb40da3eddafef844b7a679fe5162f224
Author:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
AuthorDate: Tue, 4 Dec 2018 20:51:18 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:42 -0300

perf annotate: Introduce basic support for ARC

Introduce basic 'perf annotate' support for ARC to be able to use
anotation via stdio interface.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
Link: http://lkml.kernel.org/r/20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arc/annotate/instructions.c |  9 +++++++++
 tools/perf/arch/common.c                    | 11 ++++++++++-
 tools/perf/util/annotate.c                  |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
new file mode 100644
index 000000000000..2f00e995c7e3
--- /dev/null
+++ b/tools/perf/arch/arc/annotate/instructions.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+
+static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	arch->initialized = true;
+	arch->objdump.comment_char = ';';
+	return 0;
+}
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 5f69fd0b745a..f3824ca7c20b 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -5,6 +5,13 @@
 #include "../util/util.h"
 #include "../util/debug.h"
 
+const char *const arc_triplets[] = {
+	"arc-linux-",
+	"arc-snps-linux-uclibc-",
+	"arc-snps-linux-gnu-",
+	NULL
+};
+
 const char *const arm_triplets[] = {
 	"arm-eabi-",
 	"arm-linux-androideabi-",
@@ -147,7 +154,9 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arm"))
+	if (!strcmp(arch, "arc"))
+		path_list = arc_triplets;
+	else if (!strcmp(arch, "arm"))
 		path_list = arm_triplets;
 	else if (!strcmp(arch, "arm64"))
 		path_list = arm64_triplets;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 51d291b0b81f..ac9805e0bc76 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -134,6 +134,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 	return 0;
 }
 
+#include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
@@ -142,6 +143,10 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/sparc/annotate/instructions.c"
 
 static struct arch architectures[] = {
+	{
+		.name = "arc",
+		.init = arc__annotate_init,
+	},
 	{
 		.name = "arm",
 		.init = arm__annotate_init,
