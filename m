Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D962173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D962173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeHCMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:16:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:16:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AKiC83848744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:20:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AKina3848741;
        Fri, 3 Aug 2018 03:20:44 -0700
Date:   Fri, 3 Aug 2018 03:20:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-c5ca4560de0f04a3c872bdd17ae3378762c66bd2@git.kernel.org>
Cc:     will.deacon@arm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, palmer@sifive.com, mingo@kernel.org,
        shorne@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Reply-To: gregkh@linuxfoundation.org, will.deacon@arm.com,
          tglx@linutronix.de, mingo@kernel.org, palmer@sifive.com,
          shorne@gmail.com, arnd@arndb.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180622170126.6308-5-palmer@sifive.com>
References: <20180622170126.6308-5-palmer@sifive.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: c5ca4560de0f04a3c872bdd17ae3378762c66bd2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c5ca4560de0f04a3c872bdd17ae3378762c66bd2
Gitweb:     https://git.kernel.org/tip/c5ca4560de0f04a3c872bdd17ae3378762c66bd2
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Fri, 22 Jun 2018 10:01:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:14:09 +0200

openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER

It appears that openrisc copied arm64's GENERIC_IRQ_MULTI_HANDLER code
(which came from arm).  Cnvert it to use the generic version.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: nicolas.pitre@linaro.org
Cc: vladimir.murzin@arm.com
Cc: keescook@chromium.org
Cc: jinb.park7@gmail.com
Cc: yamada.masahiro@socionext.com
Cc: alexandre.belloni@bootlin.com
Cc: pombredanne@nexb.com
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: kstewart@linuxfoundation.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: openrisc@lists.librecores.org
Link: https://lkml.kernel.org/r/20180622170126.6308-5-palmer@sifive.com

---
 arch/openrisc/Kconfig           | 5 +----
 arch/openrisc/include/asm/irq.h | 2 --
 arch/openrisc/kernel/irq.c      | 7 -------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,7 +27,6 @@ config OPENRISC
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
-	select MULTI_IRQ_HANDLER
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
@@ -36,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -69,9 +69,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool  y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
index d9eee0a2b7b4..eb612b1865d2 100644
--- a/arch/openrisc/include/asm/irq.h
+++ b/arch/openrisc/include/asm/irq.h
@@ -24,6 +24,4 @@
 
 #define NO_IRQ		(-1)
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 #endif /* __ASM_OPENRISC_IRQ_H__ */
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 35e478a93116..5f9445effaf8 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -41,13 +41,6 @@ void __init init_IRQ(void)
 	irqchip_init();
 }
 
-static void (*handle_arch_irq)(struct pt_regs *);
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	handle_arch_irq = handle_irq;
-}
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	handle_arch_irq(regs);
