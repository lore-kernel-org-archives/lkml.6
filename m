Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F12206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfAIMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:45:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57440 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731099AbfAIMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:43:33 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CCB7E72CC6D;
        Wed,  9 Jan 2019 15:43:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BC6AE7CCE38; Wed,  9 Jan 2019 15:43:30 +0300 (MSK)
Date:   Wed, 9 Jan 2019 15:43:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Guan Xuetao <gxt@pku.edu.cn>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] Move EM_UNICORE to uapi/linux/elf-em.h
Message-ID: <20190109124330.GL11981@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_UNICORE
in order to define AUDIT_ARCH_UNICORE which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/unicore32/include/asm/elf.h | 3 +--
 include/uapi/linux/elf-em.h      | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/include/asm/elf.h b/arch/unicore32/include/asm/elf.h
index 829042d07722..ae66dc1be49e 100644
--- a/arch/unicore32/include/asm/elf.h
+++ b/arch/unicore32/include/asm/elf.h
@@ -19,6 +19,7 @@
  * ELF register definitions..
  */
 #include <asm/ptrace.h>
+#include <linux/elf-em.h>
 
 typedef unsigned long elf_greg_t;
 typedef unsigned long elf_freg_t[3];
@@ -28,8 +29,6 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct fp_state elf_fpregset_t;
 
-#define EM_UNICORE		110
-
 #define R_UNICORE_NONE		0
 #define R_UNICORE_PC24		1
 #define R_UNICORE_ABS32		2
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 4b8df722330e..f47e853546fa 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -37,6 +37,7 @@
 #define EM_ARCOMPACT	93	/* ARCompact processor */
 #define EM_XTENSA	94	/* Tensilica Xtensa Architecture */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
+#define EM_UNICORE	110	/* UniCore-32 */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
 #define EM_HEXAGON	164	/* QUALCOMM Hexagon */
-- 
ldv
