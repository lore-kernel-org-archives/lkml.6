Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B474C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC9217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vQEYuiIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeLPORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:17:49 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:40938 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:17:48 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBGEGuwb018450;
        Sun, 16 Dec 2018 23:16:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBGEGuwb018450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544969817;
        bh=ILH5imu8O0LoLSiFVWcbAOqN++8qSuqiHsLmtGn8IIE=;
        h=From:To:Cc:Subject:Date:From;
        b=vQEYuiIp4vlVKlzKQvlZ6HU1FLp0TOKHAQou4ZxKSU9ZPawF8Nq1sBB2/NojUzKWf
         RqT4LKYZOUrbb4pn/VNrBN6dohY2PdhL1qCd/XSkbWy95AYpg9Dt4ezSVACRWgS57K
         nuIX1KmTkXJ9iGR5HUxqjthe8WWa3F4aIor1dNt33im0oN/SqysLeRV/6R67m35eQK
         jYIW+zm58ERKJtnQSw0NHZvyRmZRdC1cz29G7p3MwlNgsQ1mIX3xiIfkSgCgpVakmB
         5gKYipXceHcSqsxkjWBX7rYHD+4eZvlGY3ItAueM2vYdQWgR4GTlO4OiS8fGLcvyTu
         GWL53hx6DbHRg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] arc: remove redundant kernel-space generic-y
Date:   Sun, 16 Dec 2018 23:16:21 +0900
Message-Id: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes redundant generic-y defines in
arch/arc/include/asm/Kbuild.

It is redundant to define generic-y when arch-specific implementation
exists in arch/$(ARCH)/include/asm/*.h

Remove the following generic-y:

    dma-mapping.h
    fb.h
    kmap_types.h
    pci.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arc/include/asm/Kbuild | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index feed50c..caa2702 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -3,23 +3,19 @@ generic-y += bugs.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
-generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
-generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
-generic-y += kmap_types.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += parport.h
-generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += topology.h
-- 
2.7.4

