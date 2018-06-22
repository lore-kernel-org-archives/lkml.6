Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69586C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209DF2464B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bcHhJN3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209DF2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeFVRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:03:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40268 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeFVRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so3774027plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=lAKRgGd3bTj/9uJpGQMMiJVThchgNzfIl0n1yyaV7Yk=;
        b=bcHhJN3RR0GqDjIqrtnpy4rr7nFHIJGQ0BCWN3rgKwv3clYVd/HPLa7GHdX83+r4t2
         SbcJHQzD5MDJRXFhIVa1U/L5DlUhfm+i4F+umcgFfaqag2ji8Ibqu5aXJb0dlFbJekDS
         amieEEZr9yQ52TkTZsfjiiBe6/3k1IWdTyLMiq8L/XLvm6494sgBY65n6lxc7o7cBWRw
         g12NEv2WTFQIWTARCxx4FLegt8cUsO8IxzhfBOYofbvFSSeSG2+COSEdWjK2cvReS/fv
         HXgzsiUNn3n0sbTgh/dlw+dwShRLBorRwcQCRd52IGDpchf3KuFf1oyhDvxcGaYhC6Sq
         zzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=lAKRgGd3bTj/9uJpGQMMiJVThchgNzfIl0n1yyaV7Yk=;
        b=aQb+xaRDituMROz6YuBZeEbklHJRqTZdBUVoyBDLqJvGL65Huu62jEvZPLC8izen50
         ugalVlogwLJEpaStjqksipJVkk97G38VxqEhCFQ9pMqw6GGMBjAmktaifg7UhL5fnb7Q
         UZQiWxaRFRiVjJyVukwPjsdjiVaI0WBklbIedkhynKutoVBqlo8SKCuqbM8XTocRh4jK
         v27bNxKkMB7lqbfI6DBBMgYXDMTmqKNe+RIPb+ApTR+rRi3L78kRKDd5FVcKlN4gJxvq
         Kkracr2F3TT5eQ1iDgYeIkb55krGwKSSX1zyafuukKE0wTcSE+db3ZIxsYQ5Gjmsziqk
         AG3w==
X-Gm-Message-State: APt69E3guvWkeJUhgQe9n5I+QJNrDMiXvPBK79IXOnolIEngrI13Lcvs
        P5aJ984zg3nuS4gLzVxR2WjxNw==
X-Google-Smtp-Source: ADUXVKKs8CVh3Itz5c45tPo/KpxtusMaF76814lNMC4O1JXy3NzLpP5ir/1ZcKfTLm7WCggHOFEK1g==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21-v6mr2540441plr.114.1529686922157;
        Fri, 22 Jun 2018 10:02:02 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r26-v6sm24213354pfj.180.2018.06.22.10.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:02:01 -0700 (PDT)
Subject: [PATCH 4/5] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 22 Jun 2018 10:01:25 -0700
Message-Id: <20180622170126.6308-5-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com, Palmer Dabbelt <palmer@sifive.com>,
        pombredanne@nexb.com, Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that openrisc copied arm64's GENERIC_IRQ_MULTI_HANDLER code
(which came from arm).  I wanted to make this generic so I could use it
in the RISC-V port.  This patch converts the openrisc code to use the
generic version.

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
-- 
2.16.4

