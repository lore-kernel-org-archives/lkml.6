Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A813C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6A8219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iB93f2Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbeLVQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:54:40 -0500
Received: from condef-04.nifty.com ([202.248.20.69]:57919 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLVQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:54:40 -0500
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-04.nifty.com with ESMTP id wBM9r7LC011548;
        Sat, 22 Dec 2018 18:53:07 +0900
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBM9p7DN014613;
        Sat, 22 Dec 2018 18:51:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBM9p7DN014613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545472268;
        bh=ND+aJPnbi1isezN4iF7leDctF3P1l1D8eol/rcKWEro=;
        h=From:To:Cc:Subject:Date:From;
        b=iB93f2Ntt2Ldni+uOl09oWDHfUuCCp8GwIHthpte7aG6vsEjP929ZCgsZQVLH08yw
         yNkCMYGczG3pwShOdpZMYrwMVw7nnBVR5lSgSUVLk4BPQQ4YCovb7fNBCS2l3r5Jzq
         cxUTpkz6QEVFRr2S8bVNLnKHYJ6DOR0GX6AhlqHsByGyAfqcjLJsy3WqpbQSBaiqHL
         9oSTpkOQQWj0gc+GnvAUvicm6+KKcPjnfOWIFCV0ekvThcy5ambNgcOqTXvr2wlAZ7
         p78w6cScbHkTADrNW7GT+jrPJL9CGR+4hL1hEnMKOIKGl7z8WA5wL7NnvMKvXbBkTD
         UTPjiPANlaPAw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-omap@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] treewide: remove explicit rules for *offsets.s
Date:   Sat, 22 Dec 2018 18:50:33 +0900
Message-Id: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These explicit rules are unneeded because scripts/Makefile.build
provides a pattern rule to create %.s from %.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild                              | 9 +--------
 arch/arm/mach-at91/Makefile         | 3 ---
 arch/arm/mach-omap2/Makefile        | 3 ---
 arch/ia64/kernel/Makefile           | 5 -----
 drivers/memory/Makefile.asm-offsets | 3 ---
 samples/bpf/Makefile                | 3 ---
 6 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/Kbuild b/Kbuild
index 0053042..b24210c 100644
--- a/Kbuild
+++ b/Kbuild
@@ -16,10 +16,6 @@ bounds-file := include/generated/bounds.h
 always  := $(bounds-file)
 targets := kernel/bounds.s
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-kernel/bounds.s: kernel/bounds.c FORCE
-	$(call if_changed_dep,cc_s_c)
-
 $(obj)/$(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
@@ -50,10 +46,7 @@ offsets-file := include/generated/asm-offsets.h
 always  += $(offsets-file)
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-arch/$(SRCARCH)/kernel/asm-offsets.s: arch/$(SRCARCH)/kernel/asm-offsets.c \
-                                      $(obj)/$(timeconst-file) $(obj)/$(bounds-file) FORCE
-	$(call if_changed_dep,cc_s_c)
+arch/$(SRCARCH)/kernel/asm-offsets.s: $(obj)/$(timeconst-file) $(obj)/$(bounds-file)
 
 $(obj)/$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 7415f18..f87066b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -19,9 +19,6 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
 endif
 
-arch/arm/mach-at91/pm_data-offsets.s: arch/arm/mach-at91/pm_data-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
 	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 01377c2..55c482c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,9 +236,6 @@ obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
-arch/arm/mach-omap2/pm-asm-offsets.s: arch/arm/mach-omap2/pm-asm-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index d0c0ccd..7372d99 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -50,10 +50,5 @@ CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 # The gate DSO image is built using a special linker script.
 include $(src)/Makefile.gate
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-arch/$(SRCARCH)/kernel/nr-irqs.s: arch/$(SRCARCH)/kernel/nr-irqs.c
-	$(Q)mkdir -p $(dir $@)
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
 	$(call filechk,offsets,__ASM_NR_IRQS_H__)
diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
index 843ff60..f968dfa 100644
--- a/drivers/memory/Makefile.asm-offsets
+++ b/drivers/memory/Makefile.asm-offsets
@@ -1,5 +1,2 @@
-drivers/memory/emif-asm-offsets.s: drivers/memory/emif-asm-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index be0a961..100a49d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -227,9 +227,6 @@ $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
 	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
-$(obj)/syscall_nrs.s:	$(src)/syscall_nrs.c
-	$(call if_changed_dep,cc_s_c)
-
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
 
-- 
2.7.4

