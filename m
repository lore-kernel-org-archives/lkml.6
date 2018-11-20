Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95737C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674C72089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674C72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbeKTKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:40:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53728 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbeKTKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:40:49 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A66AD72CA5E;
        Tue, 20 Nov 2018 03:14:33 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 9BC297CD1FF; Tue, 20 Nov 2018 03:14:33 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:14:33 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/15] Move EM_ARCOMPACT and EM_ARCV2 to
 uapi/linux/elf-em.h
Message-ID: <20181120001433.GB11387@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These should never have been defined in the arch tree to begin with, and
now uapi/linux/audit.h header is going to use EM_ARCOMPACT and EM_ARCV2
in order to define AUDIT_ARCH_ARCOMPACT and AUDIT_ARCH_ARCV2 which are
needed to implement syscall_get_arch() which in turn is required to
extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
---
v2: added Acked-by to [PATCH 02/13 v2]

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
index ba3696e3d694..91b33833630b 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -34,6 +34,7 @@
 #define EM_M32R		88	/* Renesas M32R */
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */
+#define EM_ARCOMPACT	93	/* ARCompact processor */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
@@ -42,6 +43,7 @@
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
 #define EM_TILEGX	191	/* Tilera TILE-Gx */
+#define EM_ARCV2	195	/* ARCv2 Cores */
 #define EM_RISCV	243	/* RISC-V */
 #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
-- 
ldv
