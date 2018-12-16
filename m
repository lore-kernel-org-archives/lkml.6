Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBEAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA6E21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o6c7dip1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeLPOOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:14:53 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:44533 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:14:52 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBGEEL6x022177;
        Sun, 16 Dec 2018 23:14:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBGEEL6x022177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544969662;
        bh=bRnFzMl6SC/OU6ZcWC6UVZzhDD1c/gjs6ObQ7o3ogIs=;
        h=From:To:Cc:Subject:Date:From;
        b=o6c7dip1c8avpy1jDGYphn+6zd1IGlanpW0JOklgRn5BEBEQqfSOG87IM989gvC5r
         QN2y3fxheTWo1Ii2FbHXJ5cxOmgu7AzrAq5EOhpFB7yiVlYm87ynz9R0oxRRU5VyoE
         8+muK36r6F+LaQTzoggiD8LvK/mbXv0oLYp2MUqy+yKDb/Ods3FBfDzuv2nc5NkbRH
         lRhUS2uKpXDj8aLEeGmdUUWmHIRZz7SwPxZ/7zZB00FzEgpueb8PwXSiubW9sz/EkE
         84qQ0S6BQYzEqkWk5V8Kb+5dfIgB5EshmWCcqvjLZX259HEHvqgyw5LgRal0Eo/gpn
         65Dyo1uMBzimA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nickhu <nickhu@andestech.com>
Subject: [PATCH] nds32: remove redundant kernel-space generic-y
Date:   Sun, 16 Dec 2018 23:14:11 +0900
Message-Id: <1544969651-14403-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes redundant generic-y defines in
arch/nds32/include/asm/Kbuild.

[1] It is redundant to define the same generic-y in both
    arch/$(ARCH)/include/asm/Kbuild and
    arch/$(ARCH)/include/uapi/asm/Kbuild.

    Remove the following generic-y:

      bitsperlong.h
      bpf_perf_event.h
      errno.h
      fcntl.h
      ioctl.h
      ioctls.h
      mman.h
      shmbuf.h
      stat.h

[2] It is redundant to define generic-y when arch-specific
    implementation exists in arch/$(ARCH)/include/asm/*.h

    Remove the following generic-y:

      ftrace.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nds32/include/asm/Kbuild | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index f81b633..64ceff7 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -1,8 +1,6 @@
 generic-y += asm-offsets.h
 generic-y += atomic.h
 generic-y += bitops.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
@@ -16,17 +14,12 @@ generic-y += div64.h
 generic-y += dma.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
-generic-y += fcntl.h
-generic-y += ftrace.h
 generic-y += gpio.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
 generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
@@ -38,7 +31,6 @@ generic-y += limits.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
 generic-y += parport.h
 generic-y += pci.h
 generic-y += percpu.h
@@ -46,9 +38,7 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
-generic-y += shmbuf.h
 generic-y += sizes.h
-generic-y += stat.h
 generic-y += switch_to.h
 generic-y += timex.h
 generic-y += topology.h
-- 
2.7.4

