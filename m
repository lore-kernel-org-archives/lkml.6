Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AzilBpUEGVuyLwAAmS7hNA
	; Thu, 07 Jun 2018 10:10:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ECF1E607F7; Thu,  7 Jun 2018 10:10:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7211760452;
	Thu,  7 Jun 2018 10:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7211760452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbeFGKK0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:10:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25128 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932518AbeFGKKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:10:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 411hB55rXHz9txcB;
        Thu,  7 Jun 2018 12:10:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id x99ziGRAeZb4; Thu,  7 Jun 2018 12:10:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 411hB55LyZz9txbq;
        Thu,  7 Jun 2018 12:10:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A9628B950;
        Thu,  7 Jun 2018 12:10:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qJZU51P3MwYb; Thu,  7 Jun 2018 12:10:22 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A83E8B94D;
        Thu,  7 Jun 2018 12:10:22 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 472916F83C; Thu,  7 Jun 2018 10:10:22 +0000 (UTC)
Message-Id: <630b39e3b632912e982168782e071ddf15336eb3.1528365638.git.christophe.leroy@c-s.fr>
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc: Allow CPU selection of e300core variants
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  7 Jun 2018 10:10:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC supports -mcpu=e300c2 and -mcpu=e300c3

This patch gives the opportunity to tune kernel to one of
those two types.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ed7c6edec87e..d174acb41389 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -145,6 +145,14 @@ config 860_CPU
 	bool "8xx family"
 	depends on PPC_8xx
 
+config E300C2_CPU
+	bool "e300c2 (832x)"
+	depends on PPC_BOOK3S_32
+
+config E300C3_CPU
+	bool "e300c3 (831x)"
+	depends on PPC_BOOK3S_32
+
 endchoice
 
 config SPECIAL_CPU_BOOL
@@ -161,6 +169,8 @@ config SPECIAL_CPU
 	default "power8" if POWER8_CPU
 	default "power9" if POWER9_CPU
 	default "860" if 860_CPU
+	default "e300c2" if E300C2_CPU
+	default "e300c3" if E300C3_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.13.3
