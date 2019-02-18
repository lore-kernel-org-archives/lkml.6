Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91142070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfBRVI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:58 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfBRVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:07:59 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MekKJ-1hVzpn14AH-00akyl; Mon, 18 Feb 2019 22:07:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        arnd@arndb.de, linux-riscv@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 8/8] riscv: Use latest system call ABI
Date:   Mon, 18 Feb 2019 22:07:12 +0100
Message-Id: <20190218210712.3503891-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ScKittBUPbtTQVR0D2l9QJ/Xwbz5RAo/fF1oCAct/9ud6octFcV
 h3yKXHywP14xKDxJaVLEsUWPE3OmqCjnG82aCB4NUdkfbVY7hwv4QqVPvKB1vAHJ19xcaO5
 3xAwwTl6rnM1agEMyLmSR6J//chNkfRHVVpRX4ULBuwjtaigY5FA4YB1h9617BWsOOYJd8J
 fZOQ9NbBzqv5qvep4QBaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o9dJBFc/2PE=:6OUQhfzYWqi4WunWGXaGYB
 f8vS8yA6t8rxXrEjV2+dgiT8v9CkTOE5ltkLO1zfySqpw9H5yP4F0tmidAyGQKJ18jc2Qyp94
 12pypKf9UmKVK0cryzzr6qL/Yd7V+vqidT+8nqsm9QdjbFqAc9oM7DNzuVibjvheQ575PHNon
 Mkcdar5U2VYCW9MNIVaGPXl7REnT6LfBbW7cKOSXDJ5Ueq6q+FqEBKs8oNtXSfKAtkQ6rlLAN
 rJhAaxiN2ekwUPA2db0cmGB6ORpu86ikvL7CCJ6phhyUf18Sj6Z+TlT/Jpe2HRzdBFxRSaYvQ
 DVhHv05ZNrwohLC1oTH7uSavLNKG003rJPSpe1+0gP2g1lBzc3paQSXYX+4pHayuHNOPwyeTt
 G0OOTppm5+VkOO8Duiax8ns/IvgW45ytBJ3BgpkjOjafbeOfmsyjSMoOzLv7IYCk+25Op6WFS
 YBBLvab8oC/VSpr/Kn6RGM+0ag37Y9rpso+qx6z4QOS9k+wtjuSC+9bVcCWGUWN0P253djT0F
 U8R9lm90BTHgXMmBSrCRhNsU8LQ/HJFHjt3A15sYM23jsPlBKWZl8GQeh4KXdeCjaJbGM4kgI
 gjI6yl7I8ImAunRYolHOLl+VULxe9YqMH94pqQHuIuu+TEguAJfxe5f4F4DYeHuKz1sxnZhts
 JD8zXIPwT20T6Or/Fu7ywh3ogDuoLSaL0IxeXGWpKnHv2g1KT62daFuvl0mG/exugc4Oc4PUZ
 HDKrpRF9L+odFkMf/xPku6J4TybLaPqhB2kBrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't yet have an upstream glibc port for riscv, so there is no user
space for the existing ABI, and we can remove the definitions for 32-bit
time_t, off_t and struct resource and system calls based on them,
including the vdso.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/Kconfig                   | 1 -
 arch/riscv/include/uapi/asm/unistd.h | 5 +----
 arch/riscv/kernel/vdso/Makefile      | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 09fa3a87bf30..feeeaa60697c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,7 +11,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_32BIT_OFF_T if !64BIT
 	# even on 32-bit, physical (and DMA) addresses are > 32-bits
 	select PHYS_ADDR_T_64BIT
 	select OF
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 486a288b454c..0e2eeeb1fd27 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -17,11 +17,8 @@
 
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
-#endif /* __LP64__ */
 #define __ARCH_WANT_SET_GET_RLIMIT
-#ifndef __LP64__
-#define __ARCH_WANT_TIME32_SYSCALLS
-#endif
+#endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
 
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index eed1c137f618..fec62b24df89 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -2,9 +2,11 @@
 
 # Symbols present in the vdso
 vdso-syms  = rt_sigreturn
+ifdef CONFIG_64BIT
 vdso-syms += gettimeofday
 vdso-syms += clock_gettime
 vdso-syms += clock_getres
+endif
 vdso-syms += getcpu
 vdso-syms += flush_icache
 
-- 
2.20.0

