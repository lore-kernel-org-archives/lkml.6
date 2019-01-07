Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBF5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0E20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfAGCxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:53:08 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54290 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAGCxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:53:07 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CB1D172CC70;
        Mon,  7 Jan 2019 05:53:05 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C1AC28E5C51; Mon,  7 Jan 2019 05:53:05 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:53:05 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     linux-kernel@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v7 04/22] Move EM_ARCOMPACT and EM_ARCV2 to
 uapi/linux/elf-em.h
Message-ID: <20190107025305.GD1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should never have been defined in the arch tree to begin with, and
now uapi/linux/audit.h header is going to use EM_ARCOMPACT and EM_ARCV2
in order to define AUDIT_ARCH_ARCOMPACT and AUDIT_ARCH_ARCV2 which are
needed to implement syscall_get_arch() which in turn is required to
extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: unchanged
    v6: unchanged
    v5: added Cc
    v2: added Acked-by

 arch/arc/include/asm/elf.h  | 6 +-----
 include/uapi/linux/elf-em.h | 2 ++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/elf.h b/arch/arc/include/asm/elf.h
index aa2d6da9d187..2b80c184c9c8 100644
--- a/arch/arc/include/asm/elf.h
+++ b/arch/arc/include/asm/elf.h
@@ -10,13 +10,9 @@
 #define __ASM_ARC_ELF_H
 
 #include <linux/types.h>
+#include <linux/elf-em.h>
 #include <uapi/asm/elf.h>
 
-/* These ELF defines belong to uapi but libc elf.h already defines them */
-#define EM_ARCOMPACT		93
-
-#define EM_ARCV2		195	/* ARCv2 Cores */
-
 #define EM_ARC_INUSE		(IS_ENABLED(CONFIG_ISA_ARCOMPACT) ? \
 					EM_ARCOMPACT : EM_ARCV2)
 
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 0c3000faedba..081675ed89cb 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -34,6 +34,7 @@
 #define EM_M32R		88	/* Renesas M32R */
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */
+#define EM_ARCOMPACT	93	/* ARCompact processor */
 #define EM_XTENSA	94	/* Tensilica Xtensa Architecture */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
@@ -42,6 +43,7 @@
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
 #define EM_TILEGX	191	/* Tilera TILE-Gx */
+#define EM_ARCV2	195	/* ARCv2 Cores */
 #define EM_RISCV	243	/* RISC-V */
 #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
 #define EM_CSKY		252	/* C-SKY */
-- 
ldv
