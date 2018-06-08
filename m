Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +hVOFLRZGlsFWAAAmS7hNA
	; Fri, 08 Jun 2018 10:26:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9881C606FA; Fri,  8 Jun 2018 10:26:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1013860590;
	Fri,  8 Jun 2018 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1013860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFHK0b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:26:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2823 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeFHK01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:26:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 412JV94lyWz9ty7C;
        Fri,  8 Jun 2018 12:26:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 01vT6abGZdyC; Fri,  8 Jun 2018 12:26:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 412JV94Gb4z9ty78;
        Fri,  8 Jun 2018 12:26:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2DB68BB57;
        Fri,  8 Jun 2018 12:26:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NZhskhYOxgLV; Fri,  8 Jun 2018 12:26:26 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A40A78BB51;
        Fri,  8 Jun 2018 12:26:26 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9A2166F846; Fri,  8 Jun 2018 10:26:26 +0000 (UTC)
Message-Id:
 <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/4] selftests/powerpc: add test for 32 bits memcmp
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:26:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608102626.dCOmurYeB6YsNAHQSelTiPjgXFK_S6Cv5ItvhXVcGQ8@z>

This patch renames memcmp test to memcmp_64 and adds
a memcmp_32 test for testing the 32 bits version of memcmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 RESENDING without memcmp_32 BIN

 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    |  14 +++++++++++---
 tools/testing/selftests/powerpc/stringloops/memcmp_32.S |   1 +
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 1125e489055e..1e7301d4bac9 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # The loops are all 64-bit code
-CFLAGS += -m64
 CFLAGS += -I$(CURDIR)
 
-TEST_GEN_PROGS := memcmp
-EXTRA_SOURCES := memcmp_64.S ../harness.c
+EXTRA_SOURCES := ../harness.c
+
+$(OUTPUT)/memcmp_64: memcmp.c
+$(OUTPUT)/memcmp_64: CFLAGS += -m64
+
+$(OUTPUT)/memcmp_32: memcmp.c
+$(OUTPUT)/memcmp_32: CFLAGS += -m32
+
+ASFLAGS = $(CFLAGS)
+
+TEST_GEN_PROGS := memcmp_32 memcmp_64
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp_32.S b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
new file mode 120000
index 000000000000..056f2b3af789
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/memcmp_32.S
\ No newline at end of file
-- 
2.13.3
