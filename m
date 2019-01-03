Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86839C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FDD21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pJkB5K+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfACBLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:11:30 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:24280 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfACBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:11:26 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x031Apkd032182;
        Thu, 3 Jan 2019 10:10:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x031Apkd032182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546477852;
        bh=BK1njVfh2IoLFxPPiAZlVo7NqwABDFBCBCKtQ1k2F3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=pJkB5K+zo/ksMybXTBLcPARRk9hsX9TSLsWkch+j40sU71xhtGe0+MwRAQqrzSpft
         FReO0qPaDGXGc/WYpsCPV8zNKETfGH6GnjWbZ2Hd+5Eq5TSxbUtTnxDTq0OqPDdxaZ
         JFARudqWwLTLo+Cgye6DYwkVc6tkv2a8I72yCouu4ejBvdIO+WcGCCXHc2myW/0/W9
         e1kj7r/SVQH/ps/bR/ec0ZHjNGUUqgyARtUY69AVQIBS88ux1NM1MyeVlWoTzKIRBm
         pOC1YFLyuqf7g+ZVpIXhB7vNqKAV82TEAPx/qV1Yxn5JPLSagtvt2+YVcbPa8uC2Lo
         eaXY4kAh427zA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/5] riscv: remove redundant kernel-space generic-y
Date:   Thu,  3 Jan 2019 10:10:36 +0900
Message-Id: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes redundant generic-y defines in
arch/riscv/include/asm/Kbuild.

[1] It is redundant to define the same generic-y in both
    arch/$(ARCH)/include/asm/Kbuild and
    arch/$(ARCH)/include/uapi/asm/Kbuild.

    Remove the following generic-y:

      errno.h
      fcntl.h
      ioctl.h
      ioctls.h
      ipcbuf.h
      mman.h
      msgbuf.h
      param.h
      poll.h
      posix_types.h
      resource.h
      sembuf.h
      setup.h
      shmbuf.h
      signal.h
      socket.h
      sockios.h
      stat.h
      statfs.h
      swab.h
      termbits.h
      termios.h
      types.h

[2] It is redundant to define generic-y when arch-specific
    implementation exists in arch/$(ARCH)/include/asm/*.h

    Remove the following generic-y:

      cacheflush.h
      module.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - rebase on Linus' tree

 arch/riscv/include/asm/Kbuild | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 6a646d9..cccd12c 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bugs.h
-generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += compat.h
 generic-y += cputime.h
@@ -9,16 +8,11 @@ generic-y += dma.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += hardirq.h
 generic-y += hash.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -27,34 +21,15 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
-generic-y += module.h
-generic-y += msgbuf.h
 generic-y += mutex.h
-generic-y += param.h
 generic-y += percpu.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += setup.h
-generic-y += shmbuf.h
 generic-y += shmparam.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
-- 
2.7.4

