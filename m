Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689EA20C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689EA20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbeGEQ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:29:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26543 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753432AbeGEQYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:24:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39F4wsyz9ttRy;
        Thu,  5 Jul 2018 18:24:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NoTp27-Dgjod; Thu,  5 Jul 2018 18:24:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39F4SwZz9ttRm;
        Thu,  5 Jul 2018 18:24:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74EA08B8CF;
        Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4dUUnIMjq0Xp; Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55D388B8BC;
        Thu,  5 Jul 2018 18:24:51 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4E741711E2; Thu,  5 Jul 2018 16:24:51 +0000 (UTC)
Message-Id: <7df5e140a48f60c74374fe77841ad1f3eaf3f594.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 01/16] powerpc: remove kdump.h from page.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:24:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page.h doesn't need kdump.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/page.h     | 1 -
 arch/powerpc/kernel/crash.c         | 1 -
 arch/powerpc/kernel/machine_kexec.c | 1 +
 arch/powerpc/kernel/setup_32.c      | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index db7be0779d55..a9fbefaacf10 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -17,7 +17,6 @@
 #include <asm/types.h>
 #endif
 #include <asm/asm-compat.h>
-#include <asm/kdump.h>
 
 /*
  * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 17c8b99680f2..43a3ce2301e8 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -23,7 +23,6 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/kexec.h>
-#include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/setjmp.h>
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 936c7e2d421e..e530cbd48995 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/ftrace.h>
 
+#include <asm/kdump.h>
 #include <asm/machdep.h>
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 74457485574b..ef747a5a30b9 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,6 +40,7 @@
 #include <asm/code-patching.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/kdump.h>
 
 #define DBG(fmt...)
 
-- 
2.13.3

