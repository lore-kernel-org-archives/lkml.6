Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92138C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626A0218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479054;
	bh=Tf7vJdpasXGD0vCqwThK6BxTFDnd2wfBtNAGO5QUdxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1C/jPEAwi0FAKS/aez2XA4TevlJ8iXumPVbEC1MBPhBY/trRXk/p4C64pl15yHWS
	 lkGAvl1+9RTyduFP+HAAj8uCBwx1RM6vbCPgtBZrnzkpY9yDHqhV88giR+u05sfS73
	 HaIVahKux7r8kziwHnAA49DfSoZgOebDeEeC07RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBFSuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfBFSuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0D3218D2;
        Wed,  6 Feb 2019 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479049;
        bh=Tf7vJdpasXGD0vCqwThK6BxTFDnd2wfBtNAGO5QUdxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1RN8c32HpCPQr/vlSgS7lqrc5MU2/nW56kkCCvbPh3TYzGsgEYlL7NAteArB6qSwW
         Klianl83brUST0y4MqZCIiaVdU+wVbXmCNlwtb/WsZQ3eqrJ3bImVnVG7EmDgksFYJ
         j4uUvwpIZ/o2zuRbw5yc0X9IW8ItNnfBDhwaKMcM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 29/53] perf tools: Add fallback versions for CPU_{OR,EQUAL}()
Date:   Wed,  6 Feb 2019 15:48:39 -0300
Message-Id: <20190206184903.24054-30-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From the glibc sources, so that we can keep the tooling buildable in
older systems while using recent sched.h CPU_ macros.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-hvm9ysmrjip75ebdzhzoh429@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpu-set-sched.h | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/perf/util/cpu-set-sched.h

diff --git a/tools/perf/util/cpu-set-sched.h b/tools/perf/util/cpu-set-sched.h
new file mode 100644
index 000000000000..8cf4e40d322a
--- /dev/null
+++ b/tools/perf/util/cpu-set-sched.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Definitions taken from glibc for use with older systems, same licensing.
+#ifndef _CPU_SET_SCHED_PERF_H
+#define _CPU_SET_SCHED_PERF_H
+
+#include <features.h>
+#include <sched.h>
+
+#ifndef CPU_EQUAL
+#ifndef __CPU_EQUAL_S
+#if __GNUC_PREREQ (2, 91)
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__builtin_memcmp (cpusetp1, cpusetp2, setsize) == 0)
+#else
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__extension__							      \
+   ({ const __cpu_mask *__arr1 = (cpusetp1)->__bits;			      \
+      const __cpu_mask *__arr2 = (cpusetp2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	if (__arr1[__i] != __arr2[__i])					      \
+	  break;							      \
+      __i == __imax; }))
+#endif
+#endif // __CPU_EQUAL_S
+
+#define CPU_EQUAL(cpusetp1, cpusetp2) \
+  __CPU_EQUAL_S (sizeof (cpu_set_t), cpusetp1, cpusetp2)
+#endif // CPU_EQUAL
+
+#ifndef CPU_OR
+#ifndef __CPU_OP_S
+#define __CPU_OP_S(setsize, destset, srcset1, srcset2, op) \
+  (__extension__							      \
+   ({ cpu_set_t *__dest = (destset);					      \
+      const __cpu_mask *__arr1 = (srcset1)->__bits;			      \
+      const __cpu_mask *__arr2 = (srcset2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	((__cpu_mask *) __dest->__bits)[__i] = __arr1[__i] op __arr2[__i];    \
+      __dest; }))
+#endif // __CPU_OP_S
+
+#define CPU_OR(destset, srcset1, srcset2) \
+  __CPU_OP_S (sizeof (cpu_set_t), destset, srcset1, srcset2, |)
+#endif // CPU_OR
+
+#endif // _CPU_SET_SCHED_PERF_H
-- 
2.20.1

