Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D27C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46C24071
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF46C24071
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeGEIyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:54:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45559 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeGEIyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:54:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Ls920xf1z9ttgN;
        Thu,  5 Jul 2018 10:53:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9cMgfA6Xh5WN; Thu,  5 Jul 2018 10:53:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Ls920QRGz9ttg7;
        Thu,  5 Jul 2018 10:53:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 543108B7C3;
        Thu,  5 Jul 2018 10:53:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y8Yu-gcuFNhu; Thu,  5 Jul 2018 10:53:59 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36D148B7BC;
        Thu,  5 Jul 2018 10:53:59 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 324636FFC6; Thu,  5 Jul 2018 08:53:59 +0000 (UTC)
Message-Id: <e8ab1af859386fe663840843f787bd4d41045529.1530780629.git.christophe.leroy@c-s.fr>
In-Reply-To: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
References: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 2/3] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 08:53:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test for testing the new assembly strlen() for PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Untested

 tools/testing/selftests/powerpc/stringloops/Makefile      |  5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 12 ++++++++++++
 tools/testing/selftests/powerpc/stringloops/strlen_64.S   |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/powerpc/stringloops/strlen_64.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 2f0bd203e18a..bff66284375c 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -16,9 +16,12 @@ $(OUTPUT)/string.o: string.c
 $(OUTPUT)/strlen_32: strlen.c
 $(OUTPUT)/strlen_32: CFLAGS += -m32
 
+$(OUTPUT)/strlen_64: strlen.c
+$(OUTPUT)/strlen_64: CFLAGS += -m64
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32 strlen_64
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 161a7ee54005..891092990217 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifdef __LITTLE_ENDIAN__
+#define CONFIG_CPU_LITTLE_ENDIAN
+#else
+#define CONFIG_CPU_BIG_ENDIAN
+#endif
 
 #include <ppc-asm.h>
 
@@ -15,4 +20,11 @@
 #define PPC_ROTLI	rotlwi
 #define PPC_CNTLZL	cntlzw
 #define PPC_SRLI	srwi
+#else
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#define PPC_CNTLZL	cntlzd
+#define PPC_SRLI	srdi
 #endif
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen_64.S b/tools/testing/selftests/powerpc/stringloops/strlen_64.S
new file mode 120000
index 000000000000..d720a2766ec3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen_64.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/strlen_64.S
\ No newline at end of file
-- 
2.13.3

