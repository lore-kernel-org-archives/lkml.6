Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F0DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5884520851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeKTKke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:40:34 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53500 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbeKTKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:40:34 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B058672CA5E;
        Tue, 20 Nov 2018 03:14:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A2A937CD1FF; Tue, 20 Nov 2018 03:14:18 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:14:18 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] Move EM_HEXAGON to uapi/linux/elf-em.h
Message-ID: <20181120001418.GA11387@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_HEXAGON
in order to define AUDIT_ARCH_HEXAGON which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v2: unchanged since v1

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
index 93722e60204c..ba3696e3d694 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -37,6 +37,7 @@
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_HEXAGON	164	/* QUALCOMM Hexagon */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
ldv
