Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2537C20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2537C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeIERH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48599 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeIERH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4253BB2Rykz9tvSJ;
        Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6Ge4pCGVkj3E; Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4253BB20b4z9tvSC;
        Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BD1D8B82B;
        Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QEzWOXYbl3gV; Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F38B8B762;
        Wed,  5 Sep 2018 14:37:22 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 098457159B; Wed,  5 Sep 2018 12:37:21 +0000 (UTC)
Message-Id: <cffa58d7c94713b47d8d8871063c624bf991d642.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 15/17] powerpc/mm: Define platform default caches
 related flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:37:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache related flags like _PAGE_COHERENT and _PAGE_WRITETHRU
and defined on most platforms. The platforms not defining
them don't define any alternative. So we can give them a NUL
value directly for those platforms directly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h |  3 +++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 ++++
 arch/powerpc/include/asm/pte-common.h        | 11 -----------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index ab043b3e9b99..7a8b3c94592f 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -53,6 +53,9 @@
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
+/* cache related flags non existing on 40x */
+#define _PAGE_COHERENT	0
+
 #define _PAGE_KERNEL_RO		0
 #define _PAGE_KERNEL_ROX	_PAGE_EXEC
 #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index b899c3c877ac..2b4669b3badb 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -46,6 +46,10 @@
 #define _PAGE_NA	0x0200	/* Supervisor NA, User no access */
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
+/* cache related flags non existing on 8xx */
+#define _PAGE_COHERENT	0
+#define _PAGE_WRITETHRU	0
+
 #define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
 #define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
 #define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY)
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 1a2102f8b1e7..ff01368a175a 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -1,17 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Included from asm/pgtable-*.h only ! */
 
-/*
- * Some bits are only used on some cpu families... Make sure that all
- * the undefined gets a sensible default
- */
-#ifndef _PAGE_COHERENT
-#define _PAGE_COHERENT	0
-#endif
-#ifndef _PAGE_WRITETHRU
-#define _PAGE_WRITETHRU	0
-#endif
-
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
  * as _PAGE_SHIFT here (ie, naturally aligned).
  * Platform who don't just pre-define the value so we don't override it here
-- 
2.13.3

