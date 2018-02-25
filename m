Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeBYRZh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:25:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54315 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeBYRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:05 -0500
X-Google-Smtp-Source: AG47ELt+FKn+OVVE6RRvYmzyReLPGzAVKfSWpog3i6Lqmpx8aiUPzvMV6kN3dOkeuvRIGpyzXPPW6w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 11/21] powerpc: Add missing prototype for hdec_interrupt
Date: Sun, 25 Feb 2018 18:22:26 +0100
Message-Id: <20180225172236.29650-12-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit dabe859ec636 ("powerpc: Give hypervisor decrementer interrupts
their own handler") an empty body function was added, but no prototype was
declared. Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:629:6: error: no previous prototype for ‘hdec_interrupt’ [-Werror=missing-prototypes]
 void hdec_interrupt(struct pt_regs *regs)
      ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b240666b7bc1..a7a8a9ac5991 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -31,6 +31,7 @@ extern void to_tm(int tim, struct rtc_time * tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
+extern void hdec_interrupt(struct pt_regs *regs);
 
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
-- 
2.11.0
