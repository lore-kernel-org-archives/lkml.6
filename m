Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeBYRYn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:24:43 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39606 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeBYRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:09 -0500
X-Google-Smtp-Source: AH8x226NZcxM/SMe5y4Vq1SKhpdtPbzufuIqYNcCJF6o1eIN0U63Iocx3fpGjKVpjRu4GaocU8S58g==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 14/21] powerpc: Add missing prototype for arch_irq_work_raise
Date: Sun, 25 Feb 2018 18:22:29 +0100
Message-Id: <20180225172236.29650-15-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4f8b50bbbe63 ("irq_work, ppc: Fix up arch hooks") a new function
arch_irq_work_raise was added without a prototype in header irq_work.h.

Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:523:6: error: no previous prototype for ‘arch_irq_work_raise’ [-Werror=missing-prototypes]
 void arch_irq_work_raise(void)
      ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/irq_work.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/irq_work.h b/arch/powerpc/include/asm/irq_work.h
index c6d3078bd8c3..b8b0be8f1a07 100644
--- a/arch/powerpc/include/asm/irq_work.h
+++ b/arch/powerpc/include/asm/irq_work.h
@@ -6,5 +6,6 @@ static inline bool arch_irq_work_has_interrupt(void)
 {
 	return true;
 }
+extern void arch_irq_work_raise(void);
 
 #endif /* _ASM_POWERPC_IRQ_WORK_H */
-- 
2.11.0
