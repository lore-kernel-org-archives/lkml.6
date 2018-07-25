Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C1C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3671420671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3671420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbeGYWDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:03:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbeGYWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:03:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKmsBl501154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:48:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKmr5P501151;
        Wed, 25 Jul 2018 13:48:53 -0700
Date:   Wed, 25 Jul 2018 13:48:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-a7f660d6576a5f4504c8ab4f4956bba03d48bf52@git.kernel.org>
Cc:     ravi.bangoria@linux.vnet.ibm.com, mingo@kernel.org,
        brueckner@linux.ibm.com, tglx@linutronix.de, namhyung@kernel.org,
        jolsa@redhat.com, tmricht@linux.vnet.ibm.com, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        mpe@ellerman.id.au, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: mpe@ellerman.id.au, peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, brueckner@linux.ibm.com,
          ravi.bangoria@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          kim.phillips@arm.com, tmricht@linux.vnet.ibm.com,
          jolsa@redhat.com, namhyung@kernel.org
In-Reply-To: <20180706163454.f714b9ab49ecc8566a0b3565@arm.com>
References: <20180706163454.f714b9ab49ecc8566a0b3565@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace arm64: Use generated syscall table
Git-Commit-ID: a7f660d6576a5f4504c8ab4f4956bba03d48bf52
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

Commit-ID:  a7f660d6576a5f4504c8ab4f4956bba03d48bf52
Gitweb:     https://git.kernel.org/tip/a7f660d6576a5f4504c8ab4f4956bba03d48bf52
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 6 Jul 2018 16:34:54 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:53:01 -0300

perf trace arm64: Use generated syscall table

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

It also enables users to specify wildcards, for example, perf trace -e
'open*', just like was already possible on x86, s390, and powerpc, which
means arm64 can now pass the "Check open filename arg using perf trace +
vfs_getname" test.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180706163454.f714b9ab49ecc8566a0b3565@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config   | 2 ++
 tools/perf/util/syscalltbl.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f5a3b402589e..d3318f99006c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -54,6 +54,8 @@ endif
 
 ifeq ($(SRCARCH),arm64)
   NO_PERF_REGS := 0
+  NO_SYSCALL_TABLE := 0
+  CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 0ee7f568d60c..3393d7ee9401 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -38,6 +38,10 @@ static const char **syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char **syscalltbl_native = syscalltbl_powerpc_32;
+#elif defined(__aarch64__)
+#include <asm/syscalls.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_arm64;
 #endif
 
 struct syscall {
