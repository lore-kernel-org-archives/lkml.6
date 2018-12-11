Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296A0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1CD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWt604Sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1CD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLKIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:09:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40984 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:09:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so11727715edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ccRYGxrCLyaNwaAY2WlusVuzlGscJwbjbruVrt0AN8=;
        b=AWt604SwXOt2DAOgX+cXi84a13/pvXlP2L0FTx6ON9VpQFsEDvt0v8eDvvhQV16W+O
         nD8/Ht7HsXM8ka3ojXRHbDKEFvIGEKZ+Gjq36DSQsVhBgTVDCj5ibi3Bla4TKjdqVtNH
         CNwbefdODdoUEBh87tKSYhRpTvryHRmJh8xXlDT17jbWpVRuffYv6K3tpaWzaxnPjCCS
         hfn2h2hdeL0iOIFzyxU2J1FQdqVHcISezh5uigSbfebeoLLbYQuHLnQKqa+wpU9qC1O4
         T9ZVUr81h2zgsmw0ZBOAtP1IWHXY0+n7UTYBUlsPIN9A1FBxFKvsx4zPdQFO598r/27W
         0Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ccRYGxrCLyaNwaAY2WlusVuzlGscJwbjbruVrt0AN8=;
        b=ovO9Lp1fkswlHXA5ATuHZC8XubzNhq5lz5oqu+NhjYjxoJ/uowrRhpR+ovqXGNzrVB
         dmVbaUIFKCanSzz8p+BZy6kGIUhy9epggkqco34iHA3Ge5/b5YE6YKk9GQfaSB9GWUM2
         WG375URdK9IWcIoyaiLxJWrMHa+Z2ftz1MtTwpQrTNvYSZu5yXq9ivknPGot1lcNy9wm
         Xc+j6T5+MHlYQ6EZkEF3kLcazBo/Yd3tDZpcXRTxpH/FBonwZ2l8ieAuCodTi+YgPLKx
         u0ZmizStxIkJitG62c/Ivt7BhzHg1/yVH9vRq1J5cHoXFeaAL+AaUNHnVt/9LvBxnzIK
         gsyQ==
X-Gm-Message-State: AA+aEWZ2q6pA75Usc8SriDX5PWZwutOHXpqk1igVtWkpLpXX1vSOKY4F
        4DlWu2rm7bR6XiZ/bTH3QCI=
X-Google-Smtp-Source: AFSGD/VNf3G4lrFgEzqcINiGxGe0Mms0sFMwe4yRXvCyi0mzCTg014YGT0pK4JbkAV5dW/lmcFAewQ==
X-Received: by 2002:a50:b36f:: with SMTP id r44mr14210453edd.284.1544515780070;
        Tue, 11 Dec 2018 00:09:40 -0800 (PST)
Received: from localhost.localdomain (46-253-189-212.dynamic.monzoon.net. [46.253.189.212])
        by smtp.gmail.com with ESMTPSA id e14sm3949012edb.79.2018.12.11.00.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:09:39 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: restore asm/syscalls.h UAPI header
Date:   Tue, 11 Dec 2018 09:09:35 +0100
Message-Id: <20181211080935.20856-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UAPI header asm/syscalls.h was merged into UAPI asm/unistd.h header,
which did resolve issue with missing syscalls macros resulting in
glibc (2.28) build failure. It also broke glibc in a different way:
asm/syscalls.h is being used by glibc. I noticed this while doing
Fedora 30/Rawhide mass rebuild.

The patch returns asm/syscalls.h header and incl. it into asm/unistd.h.
I plan to send a patch to glibc to use asm/unistd.h instead of
asm/syscalls.h

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: 27f8899d6002 ("riscv: add asm/unistd.h UAPI header")
---
 arch/riscv/include/uapi/asm/syscalls.h | 29 ++++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/unistd.h   | 20 +-----------------
 2 files changed, 30 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/syscalls.h

diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
new file mode 100644
index 000000000000..206dc4b0f6ea
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/syscalls.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2018 SiFive
+ */
+
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * be included multiple times in order to define the syscall macros via
+ * __SYSCALL.
+ */
+
+/*
+ * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
+ * having a direct 'fence.i' instruction available to userspace (which we
+ * can't trap!), that's not actually viable when running on Linux because the
+ * kernel might schedule a process on another hart.  There is no way for
+ * userspace to handle this without invoking the kernel (as it doesn't know the
+ * thread->hart mappings), so we've defined a RISC-V specific system call to
+ * flush the instruction cache.
+ *
+ * __NR_riscv_flush_icache is defined to flush the instruction cache over an
+ * address range, with the flush applying to either all threads or just the
+ * caller.  We don't currently do anything with the address range, that's just
+ * in there for forwards compatibility.
+ */
+#ifndef __NR_riscv_flush_icache
+#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
+#endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 1f3bd3ebbb0d..06103139db50 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -20,22 +20,4 @@
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
-
-/*
- * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
- * having a direct 'fence.i' instruction available to userspace (which we
- * can't trap!), that's not actually viable when running on Linux because the
- * kernel might schedule a process on another hart.  There is no way for
- * userspace to handle this without invoking the kernel (as it doesn't know the
- * thread->hart mappings), so we've defined a RISC-V specific system call to
- * flush the instruction cache.
- *
- * __NR_riscv_flush_icache is defined to flush the instruction cache over an
- * address range, with the flush applying to either all threads or just the
- * caller.  We don't currently do anything with the address range, that's just
- * in there for forwards compatibility.
- */
-#ifndef __NR_riscv_flush_icache
-#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
-#endif
-__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
+#include <asm/syscalls.h>
-- 
2.19.2

