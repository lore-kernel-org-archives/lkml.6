Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB93C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC27F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLJE35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:29:57 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38850 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeLJE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:29:55 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C942272CC66;
        Mon, 10 Dec 2018 07:29:53 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C09A17CEFE9; Mon, 10 Dec 2018 07:29:53 +0300 (MSK)
Date:   Mon, 10 Dec 2018 07:29:53 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/25] Move EM_NDS32 to uapi/linux/elf-em.h
Message-ID: <20181210042953.GJ6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_NDS32
in order to define AUDIT_ARCH_NDS32 which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v5: added Cc

 arch/nds32/include/asm/elf.h | 3 +--
 include/uapi/linux/elf-em.h  | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index f5f9cf7e0544..71f9d51481a2 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -9,14 +9,13 @@
  */
 
 #include <asm/ptrace.h>
+#include <linux/elf-em.h>
 
 typedef unsigned long elf_greg_t;
 typedef unsigned long elf_freg_t[3];
 
 extern unsigned int elf_hwcap;
 
-#define EM_NDS32			167
-
 #define R_NDS32_NONE			0
 #define R_NDS32_16_RELA			19
 #define R_NDS32_32_RELA			20
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index e0fb2794bbad..d8695ad90f6b 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -39,6 +39,8 @@
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
 #define EM_HEXAGON	164	/* QUALCOMM Hexagon */
+#define EM_NDS32	167	/* Andes Technology compact code size
+				   embedded RISC processor family */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
ldv
