Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A69218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbeLTSeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:34:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbeLTSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:34:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIXY9s3687546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:33:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIXXZm3687541;
        Thu, 20 Dec 2018 10:33:33 -0800
Date:   Thu, 20 Dec 2018 10:33:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2e7xwm5i2qcc88jp2lyawdyd@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, ren_guo@c-sky.com, arnd@arndb.de,
        hpa@zytor.com
Reply-To: arnd@arndb.de, hpa@zytor.com, ren_guo@c-sky.com, acme@redhat.com,
          namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools uapi asm: Update asm-generic/unistd.h copy
Git-Commit-ID: 89a0948984896352cac1ebe079cb3d64d6c3adc6
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

Commit-ID:  89a0948984896352cac1ebe079cb3d64d6c3adc6
Gitweb:     https://git.kernel.org/tip/89a0948984896352cac1ebe079cb3d64d6c3adc6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 12:53:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:17:41 -0300

tools uapi asm: Update asm-generic/unistd.h copy

To get the change in:

  b7d624ab4312 ("asm-generic: unistd.h: fixup broken macro include.")

That doesn't imply in any changes in the tools.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2e7xwm5i2qcc88jp2lyawdyd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 538546edbfbd..c7f3321fbe43 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -760,8 +760,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate __NR3264_ftruncate
 #define __NR_lseek __NR3264_lseek
 #define __NR_sendfile __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_newfstatat __NR3264_fstatat
 #define __NR_fstat __NR3264_fstat
+#endif
 #define __NR_mmap __NR3264_mmap
 #define __NR_fadvise64 __NR3264_fadvise64
 #ifdef __NR3264_stat
@@ -776,8 +778,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate64 __NR3264_ftruncate
 #define __NR_llseek __NR3264_lseek
 #define __NR_sendfile64 __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_fstatat64 __NR3264_fstatat
 #define __NR_fstat64 __NR3264_fstat
+#endif
 #define __NR_mmap2 __NR3264_mmap
 #define __NR_fadvise64_64 __NR3264_fadvise64
 #ifdef __NR3264_stat
