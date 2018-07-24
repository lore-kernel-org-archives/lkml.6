Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E2F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E2F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbeGXM6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:58:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57434 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388225AbeGXM6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:58:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E43920756; Tue, 24 Jul 2018 13:52:10 +0200 (CEST)
Received: from localhost (unknown [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id F03462072B;
        Tue, 24 Jul 2018 13:52:09 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] mips: use asm-generic version of msi.h
Date:   Tue, 24 Jul 2018 13:52:08 +0200
Message-Id: <20180724115208.11199-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary to be able to include <linux/msi.h> when
CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:

   In file included from include/linux/kvm_host.h:20:0,
                    from arch/mips/kernel/asm-offsets.c:24:
>> include/linux/msi.h:197:10: fatal error: asm/msi.h: No such file or directory
    #include <asm/msi.h>
             ^~~~~~~~~~~
   compilation terminated.
   make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/mips/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 45d541baf359..58351e48421e 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-- 
2.14.4

