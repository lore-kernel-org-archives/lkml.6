Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63044C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200D625637
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200D625637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeFYIu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:50:59 -0400
Received: from exmail.andestech.com ([59.124.169.137]:36860 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbeFYIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:50:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5P8qhrk009416;
        Mon, 25 Jun 2018 16:52:43 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 25 Jun 2018
 16:50:00 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zongbox@gmail.com>
CC:     Zong Li <zong@andestech.com>, <greentime@andestech.com>
Subject: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index and type for 32-bit
Date:   Mon, 25 Jun 2018 16:49:39 +0800
Message-ID: <4c4def99db5e0392238947dc878c5018cc7aca3e.1529915117.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529915117.git.zong@andestech.com>
References: <cover.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5P8qhrk009416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic marco to get the index and type of symbol.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/uapi/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index 5cae4c30cd8e..1e0dfc36aab9 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -21,8 +21,13 @@ typedef struct user_regs_struct elf_gregset_t;
 
 typedef union __riscv_fp_state elf_fpregset_t;
 
-#define ELF_RISCV_R_SYM(r_info) ((r_info) >> 32)
-#define ELF_RISCV_R_TYPE(r_info) ((r_info) & 0xffffffff)
+#if __riscv_xlen == 64
+#define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
+#define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
+#else
+#define ELF_RISCV_R_SYM(r_info)		ELF32_R_SYM(r_info)
+#define ELF_RISCV_R_TYPE(r_info)	ELF32_R_TYPE(r_info)
+#endif
 
 /*
  * RISC-V relocation types
-- 
2.16.1

