Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeDHTs0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 15:48:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36293 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeDHTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 15:48:25 -0400
X-Google-Smtp-Source: AIpwx4+Y2i8ZTlXLVKa2dWqhsNjRVbVL+69m29E2G0I5XJn7poSm9T3+avGNLkNgvU4MRQ9iH/kq0w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/32: Make some functions static
Date: Sun,  8 Apr 2018 21:48:20 +0200
Message-Id: <20180408194821.19682-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180408194318.8062-1-malat@debian.org>
References: <20180408194318.8062-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
prototypes for

- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

were added but at the same time in commit d15a261d876d ("powerpc/32: Make
some functions static") those same functions were made static. Fix
conflicting changes by removing the prototypes and leave the function as
static. Fix the following warnings, treated as errors with W=1:

  arch/powerpc/kernel/setup_32.c:127:19: error: static declaration of ‘ppc_setup_l2cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:140:19: error: static declaration of ‘ppc_setup_l3cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:186:19: error: static declaration of ‘ppc_init’ follows non-static declaration

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Previous version contained the reverted patch, correct that.

 arch/powerpc/kernel/setup.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 35ca309848d7..829ed66f0a40 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -19,9 +19,6 @@ void irqstack_early_init(void);
 void setup_power_save(void);
 unsigned long __init early_init(unsigned long dt_ptr);
 void __init machine_init(u64 dt_ptr);
-int __init ppc_setup_l2cr(char *str);
-int __init ppc_setup_l3cr(char *str);
-int __init ppc_init(void);
 #else
 static inline void setup_power_save(void) { };
 #endif
-- 
2.11.0
