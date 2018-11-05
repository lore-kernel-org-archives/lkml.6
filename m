Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A143C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7020866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmcXL41y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA7020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeKEXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:46:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35882 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEXqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:46:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so8240337wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBz67z/mJka6vEpb5Y3a3+XUqviDBoG9e/F7g9R54D8=;
        b=YmcXL41yZOhgqeGgQlbxWfSZjBCKqUK9pJsIOR+O+4orMpQrZjUD/zO/eTNOVHRw3J
         H0mD1T1/Kj1xkoCVvI4OuiemC7S5VPanxevRNvGWgarV4ipcCSM/PvH0y5cQa/drxEdP
         9FyIEIYRWLoQrGf2FCSbxmCUKnpm3EuBJFs8mHWWbZVaCSxilmNUX9pSwYcP8kIf4pdl
         D2ENrsIjVuY5zLUTnYpAoZVUDISpvTn0DFHIQxaT6FlzcOb41QMqJwyCQLN5JVE5JyfB
         +mX+oZlaNJnod/odg9WlXMipw48ZPsqqGHxEnx4Imyk+CkdRWkBbZxtpWPtB0jUqigbq
         ha5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBz67z/mJka6vEpb5Y3a3+XUqviDBoG9e/F7g9R54D8=;
        b=dZCrt6Q09SBgO+NtfX7txoCFkivS81n52v4nH0kmG6ViHTrWnvVB2AlmiOrDRy4R2E
         OOygYbvrjkAMPjpZA9R71+My7UJlLMaDYID26yHXYfwb7hnSQK4GXk+y4/QRBQjRhrws
         WqEG6Akr78eOxoIxj3NuLC3rR8/hjmcgQFHBlOpcgDGNq/Rw52/UpC0pBY+slg31LaHO
         TEhOU5hSfDOAQI+w2w7NRtyNXtMSAWw7jugIgZJX58k1mQtXZKBsqHkFONVNqObfSfqC
         jU/Fajaoo73EmZradj7NxMw8Gj+PUGSUxuElzmpGbal5l4nNta4hNQELztET39xj/RsN
         zFEg==
X-Gm-Message-State: AGRZ1gKFsMCN2EGNxe2T9K0s+kOKZzQ11coRgr/WXgaw8kCONgIQnOVA
        KsjlDbhx0lHPlh5DKLllPcg=
X-Google-Smtp-Source: AJdET5ck7py4QasQyGRzcxQm5JL6FXB01adS2g6uj+8nSnSBseNoO0Tzehiyf6BUze6097gNy0nVUg==
X-Received: by 2002:a1c:2d57:: with SMTP id t84-v6mr2591331wmt.9.1541427980445;
        Mon, 05 Nov 2018 06:26:20 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id b8-v6sm30105205wme.1.2018.11.05.06.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:26:19 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] riscv: add asm/unistd.h UAPI header
Date:   Mon,  5 Nov 2018 15:26:02 +0100
Message-Id: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Juszkiewicz reported issues while generating syscall table for riscv
using 4.20-rc1. The patch refactors our unistd.h files to match some other
architectures.

- Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT
- Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
- Adjust kernel asm/unistd.h

So now asm/unistd.h UAPI header should show all syscalls for riscv.

Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
generated asm/unistd.h UAPI header thus user didn't see:

- __NR_riscv_flush_icache
- __NR_newfstatat
- __NR_fstat

which are supported by riscv kernel.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Fixes: 67314ec7b025
---
 arch/riscv/include/asm/unistd.h               |  5 ++--
 .../include/uapi/asm/{syscalls.h => unistd.h} | 24 +++++++++++++------
 2 files changed, 19 insertions(+), 10 deletions(-)
 rename arch/riscv/include/uapi/asm/{syscalls.h => unistd.h} (54%)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index eff7aa9aa163..fef96f117b4d 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -13,10 +13,9 @@
 
 /*
  * There is explicitly no include guard here because this file is expected to
- * be included multiple times.  See uapi/asm/syscalls.h for more info.
+ * be included multiple times.
  */
 
-#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
+
 #include <uapi/asm/unistd.h>
-#include <uapi/asm/syscalls.h>
diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/unistd.h
similarity index 54%
rename from arch/riscv/include/uapi/asm/syscalls.h
rename to arch/riscv/include/uapi/asm/unistd.h
index 206dc4b0f6ea..5545f498071d 100644
--- a/arch/riscv/include/uapi/asm/syscalls.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -1,13 +1,23 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright (C) 2017-2018 SiFive
+ * Copyright (C) 2018 David Abdurachmanov <david.abdurachmanov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * There is explicitly no include guard here because this file is expected to
- * be included multiple times in order to define the syscall macros via
- * __SYSCALL.
- */
+#define __ARCH_WANT_NEW_STAT
+
+#include <asm-generic/unistd.h>
 
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
-- 
2.19.1

