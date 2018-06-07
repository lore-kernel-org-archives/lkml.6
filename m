Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mEuoJpEEGVtxLAAAmS7hNA
	; Thu, 07 Jun 2018 10:10:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8BD70607E7; Thu,  7 Jun 2018 10:10:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1716860452;
	Thu,  7 Jun 2018 10:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1716860452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeFGKKX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:10:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40568 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbeFGKKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:10:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 411hB35fQqz9txc9;
        Thu,  7 Jun 2018 12:10:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DmWjVKMexvp1; Thu,  7 Jun 2018 12:10:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 411hB357wcz9txbq;
        Thu,  7 Jun 2018 12:10:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C3FE8B950;
        Thu,  7 Jun 2018 12:10:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jTKBlrY1qJwO; Thu,  7 Jun 2018 12:10:20 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CC7A8B94D;
        Thu,  7 Jun 2018 12:10:20 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3DB756F83C; Thu,  7 Jun 2018 10:10:20 +0000 (UTC)
Message-Id: <7268fb263b855d2773b387ad4cfe7e29b4f43e80.1528365638.git.christophe.leroy@c-s.fr>
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc: Allow CPU selection also on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends to PPC32 the capability to select the exact
CPU type.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 71ef559cc474..ed7c6edec87e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -86,7 +86,6 @@ endchoice
 
 choice
 	prompt "CPU selection"
-	depends on PPC64
 	default GENERIC_CPU
 	help
 	  This will create a kernel which is optimised for a particular CPU.
@@ -96,13 +95,17 @@ choice
 
 config GENERIC_CPU
 	bool "Generic (POWER4 and above)"
-	depends on !CPU_LITTLE_ENDIAN
+	depends on PPC64 && !CPU_LITTLE_ENDIAN
 
 config GENERIC_CPU
 	bool "Generic (POWER8 and above)"
-	depends on CPU_LITTLE_ENDIAN
+	depends on PPC64 && CPU_LITTLE_ENDIAN
 	select ARCH_HAS_FAST_MULTIPLIER
 
+config GENERIC_CPU
+	bool "Generic 32 bits powerpc"
+	depends on PPC32 && !PPC_8xx
+
 config CELL_CPU
 	bool "Cell Broadband Engine"
 	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
@@ -138,6 +141,10 @@ config E6500_CPU
 	bool "Freescale e6500"
 	depends on E500
 
+config 860_CPU
+	bool "8xx family"
+	depends on PPC_8xx
+
 endchoice
 
 config SPECIAL_CPU_BOOL
@@ -153,7 +160,7 @@ config SPECIAL_CPU
 	default "power7" if POWER7_CPU
 	default "power8" if POWER8_CPU
 	default "power9" if POWER9_CPU
-	default "860" if PPC_8xx
+	default "860" if 860_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.13.3
