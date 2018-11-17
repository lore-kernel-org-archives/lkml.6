Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E68BC04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKQUlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:41:22 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18178 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeKQUlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 15:41:21 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42xrnr2p5nz9v0hl;
        Sat, 17 Nov 2018 11:25:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oFUiAy71h3Sr; Sat, 17 Nov 2018 11:25:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnr2K3Zz9v0hW;
        Sat, 17 Nov 2018 11:25:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BF008B78A;
        Sat, 17 Nov 2018 11:25:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vLPfGap5chsa; Sat, 17 Nov 2018 11:25:07 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 406278B74B;
        Sat, 17 Nov 2018 11:25:07 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 042CE69A6C; Sat, 17 Nov 2018 10:25:07 +0000 (UTC)
Message-Id: <4745d9467c7d399972dbd12265d0c434cb41e1ea.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/kconfig: remove PPC_STD_MMU_32 and PPC_STD_MMU
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Date:   Sat, 17 Nov 2018 10:25:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_STD_MMU_32 and PPC_STD_MMU are not used anymore. Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                   |  2 +-
 arch/powerpc/platforms/Kconfig.cputype | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ac9703e8e722..8ea7c2c02cbf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1096,7 +1096,7 @@ config PHYSICAL_START_BOOL
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
-	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !NONSTATIC_KERNEL
+	default "0x02000000" if PPC_BOOK3S && CRASH_DUMP && !NONSTATIC_KERNEL
 	default "0x00000000"
 
 config PHYSICAL_ALIGN
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a106e78558c0..7e130035bbba 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -312,14 +312,6 @@ config SPE
 
 	  If in doubt, say Y here.
 
-config PPC_STD_MMU
-	def_bool y
-	depends on PPC_BOOK3S
-
-config PPC_STD_MMU_32
-	def_bool y
-	depends on PPC_STD_MMU && PPC32
-
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	def_bool y
 	depends on PPC_BOOK3S_64
@@ -354,7 +346,7 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 
 config PPC_MMU_NOHASH
 	def_bool y
-	depends on !PPC_STD_MMU
+	depends on !PPC_BOOK3S
 
 config PPC_BOOK3E_MMU
 	def_bool y
-- 
2.13.3

