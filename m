Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B852080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B852080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeKAHGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:06:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKAHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:06:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM6YdN2560823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:06:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM6YXV2560820;
        Wed, 31 Oct 2018 15:06:34 -0700
Date:   Wed, 31 Oct 2018 15:06:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3euy7c4yy5mvnp5bm16t9vqg@git.kernel.org>
Cc:     kim.phillips@arm.com, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, arnd@arndb.de, acme@redhat.com,
        geert@linux-m68k.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, arnd@arndb.de, jolsa@kernel.org,
          acme@redhat.com, geert@linux-m68k.org, tglx@linutronix.de,
          kim.phillips@arm.com, mingo@kernel.org, hpa@zytor.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools arch uapi: Update asm-generic/unistd.h and
 arm64 unistd.h copies
Git-Commit-ID: 8dd4c0f68c0db4c0f01af60a99a7ed34fd3dee2b
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

Commit-ID:  8dd4c0f68c0db4c0f01af60a99a7ed34fd3dee2b
Gitweb:     https://git.kernel.org/tip/8dd4c0f68c0db4c0f01af60a99a7ed34fd3dee2b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 13:10:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:51 -0300

tools arch uapi: Update asm-generic/unistd.h and arm64 unistd.h copies

To get the changes in:

  82b355d161c9 ("y2038: Remove newstat family from default syscall set")

Which will make the syscall table used by 'perf trace' for arm64 to be
updated from the changes in that patch.

This silences these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3euy7c4yy5mvnp5bm16t9vqg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/unistd.h | 1 +
 tools/include/uapi/asm-generic/unistd.h    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 5072cbd15c82..dae1584cf017 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..538546edbfbd 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -242,10 +242,12 @@ __SYSCALL(__NR_tee, sys_tee)
 /* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
+#endif
 
 /* fs/sync.c */
 #define __NR_sync 81
