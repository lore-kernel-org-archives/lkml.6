Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeFAKtP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:49:15 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:41828 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeFAKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:49:10 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Cupertino Miranda <Cupertino.Miranda@synopsys.com>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>
Subject: [PATCH] ARC: Explicitly specify OUTPUT_FORMAT in the linker script
Date: Fri,  1 Jun 2018 13:49:04 +0300
Message-Id: <20180601104904.48481-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be a good idea to explicitly specify BFD format
depending on -EB/-EL option passed to the linker and not rely on
default behavior as we have now.

Description of the OUTPUT_FORMAT command is available here:
https://sourceware.org/binutils/docs/ld/Format-Commands.html#Format-Commands

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Cupertino Miranda <cmiranda@synopsys.com>
Cc: Claudiu Zissulescu <claziss@synopsys.com>
---
 arch/arc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index f35ed578e007..0a1affc56d76 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -11,6 +11,7 @@
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
+OUTPUT_FORMAT("elf32-littlearc", "elf32-bigarc", "elf32-littlearc")
 OUTPUT_ARCH(arc)
 ENTRY(res_service)
 
-- 
2.16.2
