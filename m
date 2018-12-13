Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89F7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC87E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeLMRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:24:12 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40266 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeLMRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:24:12 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F32CB72CC6C;
        Thu, 13 Dec 2018 20:24:08 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E88D6964E82; Thu, 13 Dec 2018 20:24:08 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:24:08 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guan Xuetao <gxt@pku.edu.cn>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 22/27] Move EM_UNICORE to uapi/linux/elf-em.h
Message-ID: <20181213172408.GV6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
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

Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v6: unchanged
    v5: added Cc

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
index f392dd9d07f7..2533bb1db3ef 100644
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
