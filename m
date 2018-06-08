Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ji9uJ4RYGls7VAAAmS7hNA
	; Fri, 08 Jun 2018 10:20:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 906B2607A4; Fri,  8 Jun 2018 10:20:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0A18660590;
	Fri,  8 Jun 2018 10:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A18660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFHKUs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:20:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22254 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752685AbeFHKUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:20:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 412JMb0Vlyz9ttrk;
        Fri,  8 Jun 2018 12:20:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 153MSih0MUS0; Fri,  8 Jun 2018 12:20:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 412JMZ72Pfz9ttqt;
        Fri,  8 Jun 2018 12:20:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BE0D8BB57;
        Fri,  8 Jun 2018 12:20:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R0FEJXsAKSoj; Fri,  8 Jun 2018 12:20:44 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 173BC8BB51;
        Fri,  8 Jun 2018 12:20:44 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 071796F846; Fri,  8 Jun 2018 10:20:44 +0000 (UTC)
Message-Id: <d840d836f392b890c2e477d059b5a3a511a14631.1528452373.git.christophe.leroy@c-s.fr>
In-Reply-To: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:20:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the test for testing the new assembly strlen() instead
of the generic strlen()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile |  3 +--
 .../selftests/powerpc/stringloops/asm/cache.h        |  1 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h      | 20 ++++++++++++++++++++
 tools/testing/selftests/powerpc/stringloops/string.S |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/cache.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/string.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index df663ee9ddb3..0c088a6d0369 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -10,8 +10,7 @@ $(OUTPUT)/memcmp_64: CFLAGS += -m64
 $(OUTPUT)/memcmp_32: memcmp.c
 $(OUTPUT)/memcmp_32: CFLAGS += -m32
 
-$(OUTPUT)/strlen: strlen.c string.o
-$(OUTPUT)/string.o: string.c
+$(OUTPUT)/strlen: strlen.c string.S
 
 ASFLAGS = $(CFLAGS)
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/cache.h b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
new file mode 100644
index 000000000000..8a2840831122
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
@@ -0,0 +1 @@
+#define	IFETCH_ALIGN_BYTES 4
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 136242ec4b0e..9f8e34ffc131 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_PPC32)
+#ifdef __powerpc64__
+#define CONFIG_PPC64
+#else
+#define CONFIG_PPC32
+#endif
+#endif
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +14,15 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifdef __powerpc64__
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#else
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#endif
diff --git a/tools/testing/selftests/powerpc/stringloops/string.S b/tools/testing/selftests/powerpc/stringloops/string.S
new file mode 120000
index 000000000000..9f5babec7d21
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/string.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/string.S
\ No newline at end of file
-- 
2.13.3
