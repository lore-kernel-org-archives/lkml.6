Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE70C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618002075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618002075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeIFRyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:54:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:54:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DItGL305441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:18:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DIsIn305438;
        Thu, 6 Sep 2018 06:18:54 -0700
Date:   Thu, 6 Sep 2018 06:18:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ybskanehmdilj5fs7080nz1g@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        dsahern@gmail.com, acme@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, dsahern@gmail.com,
          tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Update the header comments
Git-Commit-ID: 5e2d8a5acc99e7b9df9be216f0a73855e865f9a5
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

Commit-ID:  5e2d8a5acc99e7b9df9be216f0a73855e865f9a5
Gitweb:     https://git.kernel.org/tip/5e2d8a5acc99e7b9df9be216f0a73855e865f9a5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 30 Aug 2018 10:02:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf augmented_syscalls: Update the header comments

Reflecting the fact that it now augments more than syscalls:sys_enter_SYSCALL
tracepoints that have filename strings as args. Also mention how the
extra data is handled by the by now modified 'perf trace' beautifiers,
that will use special "augmented" beautifiers when extra data is found
after the expected syscall enter/exit tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ybskanehmdilj5fs7080nz1g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index be06d2c9e8c9..bfa28eaf27b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Augment the openat syscall with the contents of the filename pointer argument.
+ * Augment syscalls with the contents of the pointer arguments.
  *
  * Test it with:
  *
@@ -10,12 +10,10 @@
  * the last one should be the one for '/etc/passwd'.
  *
  * This matches what is marshalled into the raw_syscall:sys_enter payload
- * expected by the 'perf trace' beautifiers, and can be used by them unmodified,
- * which will be done as that feature is implemented in the next csets, for now
- * it will appear in a dump done by the default tracepoint handler in 'perf trace',
- * that uses bpf_output__fprintf() to just dump those contents, as done with
- * the bpf-output event associated with the __bpf_output__ map declared in
- * tools/perf/include/bpf/stdio.h.
+ * expected by the 'perf trace' beautifiers, and can be used by them, that will
+ * check if perf_sample->raw_data is more than what is expected for each
+ * syscalls:sys_{enter,exit}_SYSCALL tracepoint, uing the extra data as the
+ * contents of pointer arguments.
  */
 
 #include <stdio.h>
