Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FDEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2802146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2802146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeHBKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:16:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43099 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731951AbeHBKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:16:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41h3DR2XFMz9ttRp;
        Thu,  2 Aug 2018 10:26:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CjQTFQ7HN1GT; Thu,  2 Aug 2018 10:26:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41h3DR22FNz9ttRc;
        Thu,  2 Aug 2018 10:26:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 812E08B843;
        Thu,  2 Aug 2018 10:26:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4t-ZbpLPrzDK; Thu,  2 Aug 2018 10:26:32 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4026B8B842;
        Thu,  2 Aug 2018 10:26:32 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 181506F72F; Thu,  2 Aug 2018 08:26:32 +0000 (UTC)
Message-Id: <3193a73d4b251d25e6c10cd1e875a450de50a7e6.1533198182.git.christophe.leroy@c-s.fr>
In-Reply-To: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1533198182.git.christophe.leroy@c-s.fr>
References: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1533198182.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 Aug 2018 08:26:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test for testing the new assembly strlen() for PPC32

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v9: fixed relevant checkpatch warnings
 v8: removed defines in ppc_asm.h that were added in v6 (not used anymore since v7) ; added missing link to strlen_32.S
 v7: reduced the scope to PPC32
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    | 5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/cache.h | 3 +++
 tools/testing/selftests/powerpc/stringloops/strlen_32.S | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/cache.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/strlen_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 779b644461c4..9e510de2c07d 100644
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
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/cache.h b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
new file mode 100644
index 000000000000..38685554b6c1
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define	IFETCH_ALIGN_BYTES 4
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen_32.S b/tools/testing/selftests/powerpc/stringloops/strlen_32.S
new file mode 120000
index 000000000000..72b13731b24c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen_32.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/strlen_32.S
\ No newline at end of file
-- 
2.13.3

