Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38936C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF83020883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfAHWSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:18:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40901 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:18:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so6253690qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VM6hRcJkGPh4YrUJm0E4KaKdLei9WT+ure5t9wTqwrs=;
        b=uM0CGJeH6/iYi0aXq+dvXjyLl32I5pBgswZdabijVoymSx9vVIYw4VTCwjgRcwzKco
         9kx+vY2XWqdgiliuWLtaq0pta46ybRGub4T1BwbI3FLKvUuNxytGllqYlUVhwys+wab4
         oI8m6nZNQ3DoBkwsXqlH8ExgTeXcPNSF7hX61pRGGkcPsrTSuYbz/HMgc75ankWu3lst
         pp3J8PqVsav60Hx+GkOs2yd7tqIaVS21MCxLpemhJOtIkHsTmWgStfj63V6r15vS8HwN
         KADB/BDi3fbGLTBcvDsCsxPLtd+FrEzoGq9Ge1CTitKMezdK3pcasiAEe7r8LSCRyEOs
         2gsQ==
X-Gm-Message-State: AJcUukcNbQzj1+8TjQ1qBJ8rWDTWX6D8fom9NE1m+hGDVgCZTpPtdgLO
        V9O4bKjq0MsSzm1O/vfPKNAYcA==
X-Google-Smtp-Source: ALg8bN7zeYNJyfejNjsaVb/0VuZk1NNg5kHvhDy2T0CBHgUDTbJ/+jIWq7mIjZ5tfSK2isWw1ttFrw==
X-Received: by 2002:a0c:c17b:: with SMTP id i56mr3480075qvh.28.1546985888644;
        Tue, 08 Jan 2019 14:18:08 -0800 (PST)
Received: from labbott-redhat.redhat.com ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id h35sm36891273qth.59.2019.01.08.14.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:18:07 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] tools uapi asm: Update asm-generic/unistd.h
Date:   Tue,  8 Jan 2019 14:17:58 -0800
Message-Id: <20190108221758.14546-1-labbott@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4e21565b7fd4 ("asm-generic: add kexec_file_load system
call to unistd.h") added the system call to the generic header
but not to the perf copy resulting a compile failure on aarch64
When running mksyscalltbl

BUILDSTDERR: <stdin>: In function 'main':
BUILDSTDERR: <stdin>:273:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
BUILDSTDERR: <stdin>:273:44: note: each undeclared identifier is reported only once for each function it appears in

Fix this by syncing up.

Fixes: 4e21565b7fd4 ("asm-generic: add kexec_file_load system call to unistd.h")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Found this on Fedora when compiling 5.0-rc1, I hadn't seen a patch
queued yet.
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

