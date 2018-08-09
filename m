Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD646C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB782239C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y9CAP1r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB782239C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeHJBBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46333 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJBBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so3138260ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=5s2EFOPI3Lw2TWRp42epal20VPIJgp5Jq9rU6QSAInk=;
        b=Y9CAP1r7GtvlzoBfOIhdldYWMQbgYmY1zH+0lilKXbHmcmlb6HIBYnNEwAmznybPpC
         v2xWNNCvlNWW5FGm5tWudHQJqRCMP4WspqRARB03WNTRQVs0CJ7WCMnNVgqH7B2qyww5
         cbXmfvf9ABP0p2ENAiCoJ5qYUdZgrw5Tbuk946juLu3HhoVZKpA/5ZOrQsdjvMtXbv0z
         QGWLtDibt6/uV6q2gwGQjgY7X6Fnd7msU2Q5kSacxMP4D/81EoM4tVscvb8cixhRAbZw
         pllCp4gr42LJ0v7bMT4GUvt9UIIpJGKlTGNgq0J6AqeZBQIXd7m48badOUnUB8PD219B
         3kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=5s2EFOPI3Lw2TWRp42epal20VPIJgp5Jq9rU6QSAInk=;
        b=ROZXAUbM6fGNCzHJP1ks1mLSapHDFPk5Flgu7yHs8CQ077tCbTw6Q6Og8H45v7c+VM
         oItCFGu46XtHb6DFcNTrQKOIwHA68oCn/nQQT9WDZLEz0e5sym/89DlCvYVQrPsiP/2e
         TJRTFnp/qEa6Bn130G9CT9cvokm9bX6Y8nBDut2TGyfhELKKNOQOYRcIO82J4o4WG+fP
         63fz3BimwrX8SBkC0m+FhW4yURAtq83j6RVgc09DFLbZ6Ss9/1POQ9klC2CZYFVMqsiu
         vDS5NBvrcAjyiTHIMJbavcEMRIpX1swP+pd3cWG3YL2qM90lnNM8L7pFn1S1HcVmEP4o
         /tNg==
X-Gm-Message-State: AOUpUlEab7v65hHaAg2kOT376p2+MVC/z7yA0NOBBco+ootei5z19kkM
        muaxEhvm7/Tx5rg2aiE/kA9tBQ==
X-Google-Smtp-Source: AA+uWPySJ7EdEV5bsLjwcz2vfANGYPXCGSv5IbXVHvI/PIvYdHO1Gs1lVCNc7v0EWXVh55busHtvxg==
X-Received: by 2002:a17:902:1007:: with SMTP id b7-v6mr3561106pla.277.1533854073058;
        Thu, 09 Aug 2018 15:34:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e14-v6sm10155053pff.128.2018.08.09.15.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 15:34:31 -0700 (PDT)
Subject: [PATCH v3 2/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
Date:   Thu,  9 Aug 2018 15:19:52 -0700
Message-Id: <20180809221952.24260-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809221952.24260-1-palmer@sifive.com>
References: <20180809221952.24260-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        tklauser@distanz.ch, Arnd Bergmann <arnd@arndb.de>,
        Andrew Waterman <andrew@sifive.com>,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcus Comstedt <marcus@mc.pp.se>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is expected to be included multiple times in the same file in
order to allow the __SYSCALL macro to generate system call tables.  With
a global include guard we end up missing __NR_riscv_flush_icache in the
syscall table, which results in icache flushes that escape the vDSO call
to not actually do anything.

The fix is to move to per-#define include guards, which allows the
system call tables to actually be populated.  Thanks to Macrus Comstedt
for finding and fixing the bug!

I also went ahead and fixed the SPDX header to use a //-style comment,
which I've been told is the canonical way to do it.

Cc: Marcus Comstedt <marcus@mc.pp.se>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/unistd.h        |  5 +++++
 arch/riscv/include/uapi/asm/syscalls.h | 15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 080fb28061de..0caea01d5cca 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -11,6 +11,11 @@
  *   GNU General Public License for more details.
  */
 
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * be included multiple times.  See uapi/asm/syscalls.h for more info.
+ */
+
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
index 818655b0d535..690beb002d1d 100644
--- a/arch/riscv/include/uapi/asm/syscalls.h
+++ b/arch/riscv/include/uapi/asm/syscalls.h
@@ -1,10 +1,13 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2017 SiFive
+ * Copyright (C) 2017-2018 SiFive
  */
 
-#ifndef _ASM__UAPI__SYSCALLS_H
-#define _ASM__UAPI__SYSCALLS_H
+/*
+ * There is explicitly no include guard here because this file is expected to
+ * be included multiple times in order to define the syscall macros via
+ * __SYSCALL.
+ */
 
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
@@ -20,7 +23,7 @@
  * caller.  We don't currently do anything with the address range, that's just
  * in there for forwards compatibility.
  */
+#ifndef __NR_riscv_flush_icache
 #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
-__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-
 #endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-- 
2.16.4

