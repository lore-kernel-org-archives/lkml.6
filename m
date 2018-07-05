Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2087C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C524194
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C524194
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeGEI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:29:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65193 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeGEI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:29:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41LrcH5YKnz9ttg8;
        Thu,  5 Jul 2018 10:29:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oxaGM3dJAtWo; Thu,  5 Jul 2018 10:29:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41LrcH4qW7z9ttg7;
        Thu,  5 Jul 2018 10:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E6F298B7C3;
        Thu,  5 Jul 2018 10:29:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sy99Jyj_1gnJ; Thu,  5 Jul 2018 10:29:04 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB3D68B7BC;
        Thu,  5 Jul 2018 10:29:04 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AED126FFC6; Thu,  5 Jul 2018 08:29:04 +0000 (UTC)
Message-Id: <b7fb5fcf7c6ff2c11520571f98ae137058d992bf.1530777873.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
References: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 08:29:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test for testing the new assembly strlen() for PPC32

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v7: reduced the scope to PPC32
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile      |  5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index df663ee9ddb3..2f0bd203e18a 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -13,9 +13,12 @@ $(OUTPUT)/memcmp_32: CFLAGS += -m32
 $(OUTPUT)/strlen: strlen.c string.o
 $(OUTPUT)/string.o: string.c
 
+$(OUTPUT)/strlen_32: strlen.c
+$(OUTPUT)/strlen_32: CFLAGS += -m32
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 136242ec4b0e..161a7ee54005 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +7,12 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifndef __powerpc64__
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#define PPC_CNTLZL	cntlzw
+#define PPC_SRLI	srwi
+#endif
-- 
2.13.3

