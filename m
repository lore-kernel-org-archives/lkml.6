Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF07CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84842206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfAIMnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:43:14 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56860 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfAIMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:43:12 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5FCE372CA5E;
        Wed,  9 Jan 2019 15:43:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5728D7CCE38; Wed,  9 Jan 2019 15:43:11 +0300 (MSK)
Date:   Wed, 9 Jan 2019 15:43:11 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] m68k: define syscall_get_arch()
Message-ID: <20190109124310.GG11981@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/m68k/include/asm/syscall.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 arch/m68k/include/asm/syscall.h

diff --git a/arch/m68k/include/asm/syscall.h b/arch/m68k/include/asm/syscall.h
new file mode 100644
index 000000000000..d4d7deda8d50
--- /dev/null
+++ b/arch/m68k/include/asm/syscall.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_M68K_SYSCALL_H
+#define _ASM_M68K_SYSCALL_H
+
+#include <uapi/linux/audit.h>
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_M68K;
+}
+
+#endif	/* _ASM_M68K_SYSCALL_H */
-- 
ldv
