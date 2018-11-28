Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B33C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF322081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF322081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeK1WsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:48:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39942 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeK1WsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:48:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434f511yCnz9v09t;
        Wed, 28 Nov 2018 12:46:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PpBFvOGbriNk; Wed, 28 Nov 2018 12:46:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434f511VTdz9v09s;
        Wed, 28 Nov 2018 12:46:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 427B98B869;
        Wed, 28 Nov 2018 12:46:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tefxGju5SB4r; Wed, 28 Nov 2018 12:46:46 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2875A8B853;
        Wed, 28 Nov 2018 12:46:46 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F0D9569B1B; Wed, 28 Nov 2018 11:46:45 +0000 (UTC)
Message-Id: <da43960839b577896cb62990ab51c7c47b3a5b95.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 12/16] powerpc/mm: Enable 8M hugepage support with HW
 assistance on the 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 11:46:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW assistance naturally supports 8M huge pages without
further modifications.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/tlb_nohash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 4f79639e432f..8ad7aab150b7 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,6 +97,9 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
+	[MMU_PAGE_8M] = {
+		.shift	= 23,
+	},
 };
 #else
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
-- 
2.13.3

