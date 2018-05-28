Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165531AbeE1ORy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:17:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60470 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162113AbeE1ORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:17:51 -0400
Message-Id: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 28 May 2018 14:17:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest GCC version emit many warnings similar to the following one.

As arch/powerpc code is built with -Werror, this breaks build with
GCC 8.1

This patch inhibits that warning

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 26ccd0b91512..d6c557530ce8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -145,6 +145,8 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CFLAGS-y += $(call cc-option,-Wno-attribute-alias)
+
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
-- 
2.13.3
