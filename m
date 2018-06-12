Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCB63C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC2B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeFLJPD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:15:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44433 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932626AbeFLJO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:14:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 414kjm6yJYz9ttln;
        Tue, 12 Jun 2018 11:14:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UeZevPgvkU9E; Tue, 12 Jun 2018 11:14:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 414kjm6TX9z9ttBy;
        Tue, 12 Jun 2018 11:14:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 101358B924;
        Tue, 12 Jun 2018 11:14:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JMNtNRupm4dG; Tue, 12 Jun 2018 11:14:55 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E43078B923;
        Tue, 12 Jun 2018 11:14:55 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D5DD26F83E; Tue, 12 Jun 2018 09:14:55 +0000 (UTC)
Message-Id: <3ce192afa184bf3e0f5b949f82b33a3e1fc3f34e.1528791416.git.christophe.leroy@c-s.fr>
In-Reply-To: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 12 Jun 2018 09:14:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the test for testing the new assembly strlen() instead
of the generic strlen()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |  3 +--
 .../selftests/powerpc/stringloops/asm/cache.h      |  1 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 30 ++++++++++++++++++++++
 .../testing/selftests/powerpc/stringloops/string.S |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)
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
index 136242ec4b0e..5226bd8bc39f 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_PPC32)
+#ifdef __powerpc64__
+#define CONFIG_PPC64
+#else
+#define CONFIG_PPC32
+#endif
+#endif
+
+#ifdef __LITTLE_ENDIAN__
+#define CONFIG_CPU_LITTLE_ENDIAN
+#else
+#define CONFIG_CPU_BIG_ENDIAN
+#endif
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +20,19 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifdef __powerpc64__
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#define PPC_CNTLZL	cntlzd
+#define PPC_SRLI	srdi
+#else
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#define PPC_CNTLZL	cntlzw
+#define PPC_SRLI	srwi
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

