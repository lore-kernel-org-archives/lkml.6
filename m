Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD58FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFC5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeKTKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:42:46 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55672 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbeKTKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:42:44 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D6F1472CA5E;
        Tue, 20 Nov 2018 03:16:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B3D277CD1FF; Tue, 20 Nov 2018 03:16:28 +0300 (MSK)
Date:   Tue, 20 Nov 2018 03:16:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>, Ley Foon Tan <lftan@altera.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        nios2-dev@lists.rocketboards.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/15] nios2: define syscall_get_arch()
Message-ID: <20181120001628.GL11387@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120001128.GA11300@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
request.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v2: unchanged since v1

 arch/nios2/include/asm/syscall.h | 6 ++++++
 include/uapi/linux/audit.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 9de220854c4a..cf35e210fc4d 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -17,6 +17,7 @@
 #ifndef __ASM_NIOS2_SYSCALL_H__
 #define __ASM_NIOS2_SYSCALL_H__
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 
@@ -135,4 +136,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_NIOS2;
+}
+
 #endif
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index b9ce3016e85b..205aa32d81ed 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -402,6 +402,7 @@ enum {
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
 #define AUDIT_ARCH_NDS32	(EM_NDS32|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_NDS32BE	(EM_NDS32)
+#define AUDIT_ARCH_NIOS2	(EM_ALTERA_NIOS2|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
 #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
-- 
ldv
