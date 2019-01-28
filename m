Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E5920989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690862;
	bh=2BeKfaQx2WgYOy2LAB21EcSI5EM5xCzabMCMBdSAD/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CB2JnmCGPuA3VFTgk4exRJeEDXxLvNK1FKCfTnJHxsz5O6V/NpQPhPzD0VqcgII7k
	 C7unQu3DjR1daMuJPOKRj3mr2LTNzlR38UldjLua6IrTwAWKZNSqBALOUv4m6GMk9I
	 rIxqadHGftWwffgaXDRNeLRx81xQmstfv3OiAP14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfA1PyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfA1PyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA69520855;
        Mon, 28 Jan 2019 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690858;
        bh=2BeKfaQx2WgYOy2LAB21EcSI5EM5xCzabMCMBdSAD/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byC+xaWXxcwp9JMUUKSjBsWOLvULkdhNNgiRiDEnZ9KJ/Rys8EhYg609qjwio2PSz
         7h07p1JCAZfbYP64sW77DjakPvSsIKJrhi3huGY94J8IKH9OHz1WoUxYcVwLay5vav
         c0hupYhDZxaQxOY0DwKvcem382tDpdcPdcJlNp1M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 215/304] tools uapi asm: Update asm-generic/unistd.h copy
Date:   Mon, 28 Jan 2019 10:42:12 -0500
Message-Id: <20190128154341.47195-215-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 89a0948984896352cac1ebe079cb3d64d6c3adc6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

