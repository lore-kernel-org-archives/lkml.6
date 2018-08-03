Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D41C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1C52173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1C52173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbeHCMQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:16:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:16:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AK8un3848715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:20:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AK8ka3848712;
        Fri, 3 Aug 2018 03:20:08 -0700
Date:   Fri, 3 Aug 2018 03:20:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-78ae2e1cd845480caaa2f181fee64e51f679f5aa@git.kernel.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org, palmer@sifive.com,
        will.deacon@arm.com, arnd@arndb.de, tglx@linutronix.de,
        hpa@zytor.com, gregkh@linuxfoundation.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, arnd@arndb.de, palmer@sifive.com,
          will.deacon@arm.com, linux-kernel@vger.kernel.org, hch@lst.de,
          mingo@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org
In-Reply-To: <20180622170126.6308-4-palmer@sifive.com>
References: <20180622170126.6308-4-palmer@sifive.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: 78ae2e1cd845480caaa2f181fee64e51f679f5aa
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

Commit-ID:  78ae2e1cd845480caaa2f181fee64e51f679f5aa
Gitweb:     https://git.kernel.org/tip/78ae2e1cd845480caaa2f181fee64e51f679f5aa
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Fri, 22 Jun 2018 10:01:24 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:14:09 +0200

arm64: Use the new GENERIC_IRQ_MULTI_HANDLER

It appears arm64 copied arm's GENERIC_IRQ_MULTI_HANDLER code, but made
it unconditional.

Converts the arm64 code to use the new generic code, which simply consists
of deleting the arm64 code and setting MULTI_IRQ_HANDLER instead.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: shorne@gmail.com
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
Link: https://lkml.kernel.org/r/20180622170126.6308-4-palmer@sifive.com

---
 arch/arm64/Kconfig           |  4 +---
 arch/arm64/include/asm/irq.h |  2 --
 arch/arm64/kernel/irq.c      | 10 ----------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..3d1011957823 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -74,6 +74,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
@@ -264,9 +265,6 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a0fee6985e6a..b2b0c6405eb0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,8 +8,6 @@
 
 struct pt_regs;
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..780a12f59a8f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-void (*handle_arch_irq)(struct pt_regs *) = NULL;
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
