Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A035CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64708218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64708218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHRPFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHRPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:05:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBvH4n1291598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:57:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBvHBP1291595;
        Sat, 18 Aug 2018 04:57:17 -0700
Date:   Sat, 18 Aug 2018 04:57:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c9b51a017065bf514ab5a380f2fb3b0dada5bc68@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, alexander.kapshuk@gmail.com,
        hpa@zytor.com, peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, acme@redhat.com, tglx@linutronix.de
Reply-To: dsahern@gmail.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, alexander.kapshuk@gmail.com,
          mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          namhyung@kernel.org, peterz@infradead.org
In-Reply-To: <20180813111504.3568-2-jolsa@kernel.org>
References: <20180813111504.3568-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Move syscall_64.tbl check into
 check-headers.sh
Git-Commit-ID: c9b51a017065bf514ab5a380f2fb3b0dada5bc68
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

Commit-ID:  c9b51a017065bf514ab5a380f2fb3b0dada5bc68
Gitweb:     https://git.kernel.org/tip/c9b51a017065bf514ab5a380f2fb3b0dada5bc68
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 13 Aug 2018 13:15:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 15:10:40 -0300

perf tools: Move syscall_64.tbl check into check-headers.sh

Probably leftover from the time we introducd the check-headers.sh script.

Committer testing:

Remove the 'rseq' syscall from tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
to fake a diff:

make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  CC       /tmp/build/perf/util/syscalltbl.o
  INSTALL  trace_plugins
<SNIP>
  $ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2018-08-13 15:49:50.896585176 -0300
  +++ arch/x86/entry/syscalls/syscall_64.tbl	2018-07-20 12:04:04.536858304 -0300
  @@ -342,6 +342,7 @@
   331	common	pkey_free		__x64_sys_pkey_free
   332	common	statx			__x64_sys_statx
   333	common	io_pgetevents		__x64_sys_io_pgetevents
  +334	common	rseq			__x64_sys_rseq

  #
  # x32-specific system call numbers start at 512 to avoid cache impact
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180813111504.3568-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/Makefile | 3 ---
 tools/perf/check-headers.sh  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 1a38e78117ce..8cc6642fce7a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -19,9 +19,6 @@ systbl := $(sys)/syscalltbl.sh
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sys)/syscall_64.tbl $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-        (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index b61f8a4dfca3..466540ee8ea7 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -101,4 +101,7 @@ check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 
+# diff non-symmetric files
+check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
+
 cd tools/perf
