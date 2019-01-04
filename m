Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A17C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3A218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626923;
	bh=iwvS8omtsbCJiINK+FnKNNU7hTQ+btQlbXq7SHsj12s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EM73RVaVpJJeoFtWixf59KCJZSgldjbafV0N3lKmazxNA2dfSlFvjdG8MZr+wZJGx
	 CPwwjP+A3kjjBamGGKUgEPER/yfiocRjTb9XggyNhmaQmXNVcxLuNXgzBuSwB772zR
	 XtYz42KDt/IccO9+raDoP6tgylbPBlM83voN+2DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfADSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfADSea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42853218FF;
        Fri,  4 Jan 2019 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626869;
        bh=iwvS8omtsbCJiINK+FnKNNU7hTQ+btQlbXq7SHsj12s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2BvLzpi9jAZ4OTfHIdMkKsJXUnLAWNTi9eHu54e1YE+hcqW/ajxtaKfb7OPc6sEB
         XgruZeWvgKZ+jKNnEsm4WZmNhOdIbTA/U/HJMIwygYQtL5WtA5+TI1NXB+jMgv4Yp6
         Pdk39mXtsbd/EbN8Zq+YLojCf49kLrzsoG73Yme4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 10/16] tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
Date:   Fri,  4 Jan 2019 15:33:31 -0300
Message-Id: <20190104183337.12771-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  b7d624ab4312 asm-generic: unistd.h: fixup broken macro include.
  4e21565b7fd4 asm-generic: add kexec_file_load system call to unistd.h

With this the 'kexec_file_load' syscall will be added to arm64's syscall
table and will appear on the output of 'perf trace' on that platform.

This silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-er8j7qhavtdw0kdga3zswynm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index c7f3321fbe43..d90127298f12 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.20.1

