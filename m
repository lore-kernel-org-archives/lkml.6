Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22212C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D0C20C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D0C20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeGEQ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:29:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753775AbeGEQYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:24:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39H5kjBz9ttS3;
        Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4iQsh6UDKiAn; Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39H5GNxz9ttRm;
        Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D6118B8CF;
        Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NJdqaevKdBIg; Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 645558B8BC;
        Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5C5C3711E2; Thu,  5 Jul 2018 16:24:53 +0000 (UTC)
Message-Id: <f3abb67da795471b235206cfd242c17e856f5b33.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 02/16] powerpc: remove unneeded inclusions of
 cpu_has_feature.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:24:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files not using cpu_has_feature() don't need cpu_has_feature.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cacheflush.h | 1 -
 arch/powerpc/include/asm/cputime.h    | 1 -
 arch/powerpc/include/asm/dbell.h      | 1 -
 arch/powerpc/kernel/vdso.c            | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 0d72ec75da63..d5a8d7bf0759 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -11,7 +11,6 @@
 
 #include <linux/mm.h>
 #include <asm/cputable.h>
-#include <asm/cpu_has_feature.h>
 
 /*
  * No cache flushing is required when address mappings are changed,
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index bc4903badb3f..133672744b2e 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -23,7 +23,6 @@
 #include <asm/div64.h>
 #include <asm/time.h>
 #include <asm/param.h>
-#include <asm/cpu_has_feature.h>
 
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 9f2ae0d25e15..998c42ff1caa 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,7 +16,6 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
-#include <asm/cpu_has_feature.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index d2205b97628c..65b3bdb99f0b 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -22,7 +22,6 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 
-#include <asm/cpu_has_feature.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
-- 
2.13.3

