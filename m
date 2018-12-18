Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF40CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76DB20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLRN6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:58:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeLRN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:58:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDvgCO2851898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:57:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDvguL2851895;
        Tue, 18 Dec 2018 05:57:42 -0800
Date:   Tue, 18 Dec 2018 05:57:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rpy9t2e0wxpnum1yvxhreafe@git.kernel.org>
Cc:     namhyung@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, namhyung@kernel.org,
          dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty mmap_flags: Check if the arch has a
 mmap.h file
Git-Commit-ID: a1c8cf293d57cb7c952b667805441b9fbb9c640a
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
Message-ID: <20181218135742.qJkL6Np4JaCgN1lqSdsBvpXoroVqxS_SYBtOb3fLBQ4@z>

Commit-ID:  a1c8cf293d57cb7c952b667805441b9fbb9c640a
Gitweb:     https://git.kernel.org/tip/a1c8cf293d57cb7c952b667805441b9fbb9c640a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 27 Nov 2018 12:19:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:14 -0300

perf beauty mmap_flags: Check if the arch has a mmap.h file

If not, then just use what is in asm-generic. This fixes the build for
my sh4, m68k and riscv64 perf test build containers that were failing
due to 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag
constants"), that were not covered in the cset introducing those
tools/arch/*/include/uapi/asm/mman.h files.

  f3539c12d819 ("tools include: Add uapi mman.h for each architecture")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag constants")
Link: https://lkml.kernel.org/n/tip-rpy9t2e0wxpnum1yvxhreafe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              | 2 +-
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67e9adbe6ee8..bfdaefd500ab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -474,7 +474,7 @@ $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_t
 mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
 mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
 
-$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(arch_asm_uapi_dir)/mman.h $(mmap_flags_tbl)
+$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
 	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 22c3fdca8975..cd41023107d7 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
