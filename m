Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E80C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DB220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DB220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeLMRWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:22:24 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38150 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeLMRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:22:24 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 998F672CC6C;
        Thu, 13 Dec 2018 20:22:21 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8A382964E82; Thu, 13 Dec 2018 20:22:21 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:22:21 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Richard Kuo <rkuo@codeaurora.org>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/27] Move EM_HEXAGON to uapi/linux/elf-em.h
Message-ID: <20181213172221.GJ6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_HEXAGON
in order to define AUDIT_ARCH_HEXAGON which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v6: unchanged
    v5: added Cc

 arch/hexagon/include/asm/elf.h | 6 +-----
 include/uapi/linux/elf-em.h    | 1 +
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 80311e7b8ca6..d10fbd54ae51 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -23,11 +23,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-
-/*
- * This should really be in linux/elf-em.h.
- */
-#define EM_HEXAGON	164   /* QUALCOMM Hexagon */
+#include <linux/elf-em.h>
 
 struct elf32_hdr;
 
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index ee0b26ab92b0..e0fb2794bbad 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -38,6 +38,7 @@
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_HEXAGON	164	/* QUALCOMM Hexagon */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
ldv
