Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387FEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10924217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeLROFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:05:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLROFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:05:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE5HmR2853201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:05:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE5Hjh2853198;
        Tue, 18 Dec 2018 06:05:17 -0800
Date:   Tue, 18 Dec 2018 06:05:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sihyeon Jang <tipbot@zytor.com>
Message-ID: <tip-00879763fcf21f4b32d63d2241c877f8c1df950e@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        uneedsihyeon@gmail.com, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: uneedsihyeon@gmail.com, jolsa@kernel.org, acme@redhat.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20181202080651.4685-1-uneedsihyeon@gmail.com>
References: <20181202080651.4685-1-uneedsihyeon@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty mmap_flags: Fixed syntax error Fixed
 missing ']' error
Git-Commit-ID: 00879763fcf21f4b32d63d2241c877f8c1df950e
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

Commit-ID:  00879763fcf21f4b32d63d2241c877f8c1df950e
Gitweb:     https://git.kernel.org/tip/00879763fcf21f4b32d63d2241c877f8c1df950e
Author:     Sihyeon Jang <uneedsihyeon@gmail.com>
AuthorDate: Sun, 2 Dec 2018 17:06:51 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:56:13 -0300

perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error

Committer testing:

Before:

  # tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
  tools/perf/trace/beauty/mmap_flags.sh: line 23: [: missing `]'
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  tools/perf/trace/beauty/mmap_flags.sh: line 28: [: missing `]'
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  #

After:

  $ tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  $

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: aca70cc40a0b ("perf beauty mmap_flags: Check if the arch has a mmap.h file")
Link: http://lkml.kernel.org/r/20181202080651.4685-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index cd41023107d7..32bac9c0d694 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
