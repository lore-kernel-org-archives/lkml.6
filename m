Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1F220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeIMA0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:26:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeIMA0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:26:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJJQEl2743996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:19:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJJQIG2743993;
        Wed, 12 Sep 2018 12:19:26 -0700
Date:   Wed, 12 Sep 2018 12:19:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vt7k2itnitp1t9p3dp7qeb08@git.kernel.org>
Cc:     namhyung@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, hpa@zytor.com,
        mathieu.desnoyers@efficios.com, jolsa@kernel.org,
        dsahern@gmail.com, kim.phillips@arm.com, mpe@ellerman.id.au,
        ravi.bangoria@linux.vnet.ibm.com, mingo@kernel.org,
        peterz@infradead.org, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com, acme@redhat.com, tglx@linutronix.de,
        wangnan0@huawei.com
Reply-To: tmricht@linux.vnet.ibm.com, peterz@infradead.org,
          brueckner@linux.vnet.ibm.com, mingo@kernel.org,
          ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
          tglx@linutronix.de, wangnan0@huawei.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, will.deacon@arm.com, arnd@arndb.de,
          namhyung@kernel.org, kim.phillips@arm.com, dsahern@gmail.com,
          jolsa@kernel.org, mathieu.desnoyers@efficios.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 asm-generic/unistd.h
Git-Commit-ID: f9e6e4351e0bb0811a8b3696679cc6050e4f5947
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

Commit-ID:  f9e6e4351e0bb0811a8b3696679cc6050e4f5947
Gitweb:     https://git.kernel.org/tip/f9e6e4351e0bb0811a8b3696679cc6050e4f5947
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Sep 2018 11:00:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 11:04:43 -0300

tools headers uapi: Update tools's copy of asm-generic/unistd.h

To get the changes in:

	db7a2d1809a5 ("asm-generic: unistd.h: Wire up sys_rseq")

That wires up the new 'rsec' system call, which will automagically
support that syscall in the syscall table used by 'perf trace' on
arm/arm64.

This cures the following warning during perf's build:

	Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
	diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-vt7k2itnitp1t9p3dp7qeb08@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 42990676a55e..df4bedb9b01c 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_rseq 293
+__SYSCALL(__NR_rseq, sys_rseq)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
