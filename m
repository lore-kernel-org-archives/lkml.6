Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C79C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431E2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0431E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeHBKQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:16:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16822 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbeHBKQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:16:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41h3DK2RfFz9ttRp;
        Thu,  2 Aug 2018 10:26:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id E1KElBa1nPFy; Thu,  2 Aug 2018 10:26:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41h3DK1x6Vz9ttRc;
        Thu,  2 Aug 2018 10:26:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BE198B844;
        Thu,  2 Aug 2018 10:26:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id euwXLo8lK4Ih; Thu,  2 Aug 2018 10:26:26 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B0188B842;
        Thu,  2 Aug 2018 10:26:26 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0E43E6F72F; Thu,  2 Aug 2018 08:26:25 +0000 (UTC)
Message-Id: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1533198182.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 1/4] selftests/powerpc: add test for 32 bits memcmp
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 Aug 2018 08:26:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames memcmp test to memcmp_64 and adds
a memcmp_32 test for testing the 32 bits version of memcmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v9: no change
 v8: rebased on latest powerpc/merge
 v7: no change
 v6: no change
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    | 14 +++++++++++---
 tools/testing/selftests/powerpc/stringloops/memcmp_32.S |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index c60c6172dd3c..3862256c2b7d 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # The loops are all 64-bit code
-CFLAGS += -m64 -maltivec
 CFLAGS += -I$(CURDIR)
 
-TEST_GEN_PROGS := memcmp
-EXTRA_SOURCES := memcmp_64.S ../harness.c
+EXTRA_SOURCES := ../harness.c
+
+$(OUTPUT)/memcmp_64: memcmp.c
+$(OUTPUT)/memcmp_64: CFLAGS += -m64 -maltivec
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

