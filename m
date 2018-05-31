Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755504AbeEaPmL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:42:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33615 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:42:07 -0400
X-Google-Smtp-Source: ADUXVKK1yk5+vjEFM5t5+GFvMHbz3tat5+XZ/+99QCE9BTMP2Y9xnSD56gMyaDeiZxOfykQqNnfKUA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] riscv: add riscv-specific predefines to CHECKFLAGS
Date: Thu, 31 May 2018 17:42:01 +0200
Message-Id: <20180531154201.48618-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V uses the macro __riscv_xlen, predefined by GCC, to
make the distinction between 32 or 64 bit code.

However, sparse doesn't know anything about this macro
which lead to wrong warnings and failures.

Fix this by adding a define of __riscv_xlen to CHECKFLAGS
and add one for __riscv too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 76e958a54..6d4a5f6c3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -71,6 +71,9 @@ KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
 # architectures.  It's faster to have GCC emit only aligned accesses.
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
 
+# arch specific predefines for sparse
+CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
+
 head-y := arch/riscv/kernel/head.o
 
 core-y += arch/riscv/kernel/ arch/riscv/mm/
-- 
2.17.1
