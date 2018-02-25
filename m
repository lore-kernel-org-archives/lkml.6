Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeBYRYA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:24:00 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39607 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBYRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:10 -0500
X-Google-Smtp-Source: AH8x224CW7DLDqDHzS9yo3+gn9tusK8j3AYUFI7WVaVJZiEh3If45s82dLh2vb5ipJY+7+Xsq8cXhQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 16/21] powerpc: Add missing prototype for init_IRQ
Date: Sun, 25 Feb 2018 18:22:31 +0100
Message-Id: <20180225172236.29650-17-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function init_IRQ was added without a prototype declared in header irq.h.
Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/irq.o
arch/powerpc/kernel/irq.c:662:13: error: no previous prototype for ‘init_IRQ’ [-Werror=missing-prototypes]
 void __init init_IRQ(void)
             ^~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index e8e3a0a04eb0..ee39ce56b2a2 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -66,6 +66,7 @@ extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
 extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
 extern void do_IRQ(struct pt_regs *regs);
+extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
 
 int irq_choose_cpu(const struct cpumask *mask);
-- 
2.11.0
