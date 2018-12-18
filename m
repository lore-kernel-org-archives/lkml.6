Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A82218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171473;
	bh=Kb8O8hxUjeSR78xQ0jBTx61rGXeSqq0l2FuOxtS6+nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rlcfF2RRP6rlsQctp42ajkq95YvIPmYWUR933pFRJrrSQOsvuuB2joU+O1RzRTovU
	 P5a07q8kwfJGhMbDN4qIm4TuxCpkhmNRLFjMT6g+p3xumrtNcEG1KDlwZSesZLv/YK
	 bHOqGCVfknhxWXMpa78fwGESQ9+wR7PBnV2g14HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeLRWRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeLRWRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:51 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A00321871;
        Tue, 18 Dec 2018 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171471;
        bh=Kb8O8hxUjeSR78xQ0jBTx61rGXeSqq0l2FuOxtS6+nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prWh5r/iJWBpVtFLJ/8nzvN7DtuSVSAGzGjQqBMwnajpNCR3BwVNJeS2f2SVlbnf6
         n74KpilAr0Md9Ayvx5p06CrhleVFTYwXvApl18ho93Y41kegp5xJCsONaEluRJwY/q
         ATMJ4lcT/77WQK3q0qCJXneuXPR8Qb+Pm5jjJVMU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 63/63] tools uapi asm: Update asm-generic/unistd.h copy
Date:   Tue, 18 Dec 2018 19:07:33 -0300
Message-Id: <20181218220733.15839-64-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.19.2

