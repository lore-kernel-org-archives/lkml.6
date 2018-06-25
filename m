Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B05C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DE82622B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZitlR5a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DE82622B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965085AbeFYWmt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:49 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:42310 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965038AbeFYWmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:47 -0400
Received: by mail-ua0-f201.google.com with SMTP id c2-v6so4594891uao.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0Et0L1WNV93Y8jFq/slU2S2/QDsQt375W8lPWTfs1Bc=;
        b=ZitlR5a23umamAsH5LxOO1jXh5eil0uclaGl3j21u1ZcICqEwMHGHYW/SlANufZ9Pp
         aCrtpNfvYL8Ns4ofggvwpUFXljxxb+ZeM2tAnXx/c9zAc2a7agGqI0jitk/oQKzKyQ/3
         g7vQ2161rrwm8OIFWbXgJOzIDxBeLaIo98KgABGW2ZO0pLDjxGks/fb1y/S6DWRADGNV
         i2xeWgrwN+fLvxx2cqpo+fJkVLHuPxxlkYCTwBwlpxsgclbdckSBSxeQ8KxC8jbulU6c
         5pP96d9OSSNO0AOHt+PXiuGrlo9mFOBiLeON4iUJEkglKc8JqeDiWMQ7WH/CZ+KKLtFG
         SXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0Et0L1WNV93Y8jFq/slU2S2/QDsQt375W8lPWTfs1Bc=;
        b=NvL+HmuX+1eVO6kA6DRkOj9LUs1eJqwgQjmxZBx0SCQRuw3Wwn+dtuv7nhc7WEIdI5
         7vkVJVUQuD5C88PnXDn9YOB5p6SUdDerJvGvu4Z92CPGkEbXqEGuLBIDL5YLT/tQT0hD
         yHI1xiDLaWOfXEeK1ZB8+hYeP9ZnNo/t70dsqHG6iYge6uGP5wHni6ECrlBMNRVoeAHy
         0Gnq2am5D9fdza3zUCtr5LgKZf1jhqDaulhT6K3HA97b7baXl0LOR1lsUnK6TQPa7MZT
         G3jXt1Xi5Bf4K6BHuX7WARWK3gDFCI4h4Ar78Th2jXMw1H4nAT9IMguVp2eQ94tdLKq1
         mspg==
X-Gm-Message-State: APt69E3qKgZkptnsfzNcsXjNeXeSwzOdz7fI73tjPD+oTXE5rPVOH1Xk
        csHnGdlylnSdJ8tDyiQ38r3GsuQoqJTVmw==
X-Google-Smtp-Source: ADUXVKLjl5yCkiFySSReJU+4bOqmO0dc7PlRxQcx3A4TQQPoNoLAeQQHI7UE7Rs9Uu5jlbaA+iVg6nT6XWoYPw==
MIME-Version: 1.0
X-Received: by 2002:a1f:ae0a:: with SMTP id x10-v6mr6560226vke.92.1529966566293;
 Mon, 25 Jun 2018 15:42:46 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:13 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-26-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 25/27] x86/pie: Add option to build the kernel as PIE
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CONFIG_X86_PIE option which builds the kernel as a Position
Independent Executable (PIE). The kernel is currently build with the
mcmodel=kernel option which forces it to stay on the top 2G of the
virtual address space. With PIE, the kernel will be able to move below
the current limit.

The --emit-relocs linker option was kept instead of using -pie to limit
the impact on mapped sections. Any incompatible relocation will be
catch by the arch/x86/tools/relocs binary at compile time.

If segment based stack cookies are enabled, try to use the compiler
option to select the segment register. If not available, automatically
enabled global stack cookie in auto mode. Otherwise, recommend
compiler update or global stack cookie option.

Performance/Size impact:

Size of vmlinux (Default configuration):
 File size:
 - PIE disabled: +0.18%
 - PIE enabled: -1.977% (less relocations)
 .text section:
 - PIE disabled: same
 - PIE enabled: same

Size of vmlinux (Ubuntu configuration):
 File size:
 - PIE disabled: +0.21%
 - PIE enabled: +10%
 .text section:
 - PIE disabled: same
 - PIE enabled: +0.001%

The size increase is mainly due to not having access to the 32-bit signed
relocation that can be used with mcmodel=kernel. A small part is due to reduced
optimization for PIE code. This bug [1] was opened with gcc to provide a better
code generation for kernel PIE.

Hackbench (50% and 1600% on thread/process for pipe/sockets):
 - PIE disabled: no significant change (avg -/+ 0.5% on latest test).
 - PIE enabled: between -1% to +1% in average (default and Ubuntu config).

Kernbench (average of 10 Half and Optimal runs):
 Elapsed Time:
 - PIE disabled: no significant change (avg -0.5%)
 - PIE enabled: average -0.5% to +0.5%
 System Time:
 - PIE disabled: no significant change (avg -0.1%)
 - PIE enabled: average -0.4% to +0.4%.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82303

Signed-off-by: Thomas Garnier <thgarnie@google.com>

merge pie
---
 arch/x86/Kconfig  |  8 ++++++++
 arch/x86/Makefile | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f98a47662023..42f77aff5df1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2228,6 +2228,14 @@ config X86_GLOBAL_STACKPROTECTOR
 
 	   If unsure, say N
 
+config X86_PIE
+	bool
+	depends on X86_64
+	select DEFAULT_HIDDEN
+	select WEAK_PROVIDE_HIDDEN
+	select DYNAMIC_MODULE_BASE
+	select MODULE_REL_CRCS if MODVERSIONS
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 112ccdc99566..b3647d78c26e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -60,6 +60,8 @@ endif
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
 KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
 
+stackglobal := $(call cc-option-yn, -mstack-protector-guard=global)
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
@@ -135,7 +137,48 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
 ifdef CONFIG_X86_PIE
+        KBUILD_CFLAGS += -fPIE
         KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/x86/kernel/module.lds
+
+        # Relax relocation in both CFLAGS and LDFLAGS to support older compilers
+        KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
+        LDFLAGS_vmlinux += $(call ld-option,--no-relax)
+        KBUILD_LDFLAGS_MODULE += $(call ld-option,--no-relax)
+
+        # Stack validation is not yet support due to self-referenced switches
+ifdef CONFIG_STACK_VALIDATION
+        $(warning CONFIG_STACK_VALIDATION is not yet supported for x86_64 pie \
+	        build.)
+        SKIP_STACK_VALIDATION := 1
+        export SKIP_STACK_VALIDATION
+endif
+
+ifndef CONFIG_CC_STACKPROTECTOR_NONE
+ifndef CONFIG_X86_GLOBAL_STACKPROTECTOR
+        stackseg-flag := -mstack-protector-guard-reg=%gs
+        ifeq ($(call cc-option-yn,$(stackseg-flag)),n)
+                # Try to enable global stack cookie if possible
+                ifeq ($(stackglobal), y)
+                        $(warning Cannot use CONFIG_CC_STACKPROTECTOR_* while \
+                                building a position independent kernel. \
+                                Default to global stack protector \
+                                (CONFIG_X86_GLOBAL_STACKPROTECTOR).)
+                        CONFIG_X86_GLOBAL_STACKPROTECTOR := y
+                        KBUILD_CFLAGS += -DCONFIG_X86_GLOBAL_STACKPROTECTOR
+                        KBUILD_AFLAGS += -DCONFIG_X86_GLOBAL_STACKPROTECTOR
+                else
+                        $(error echo Cannot use \
+                                CONFIG_CC_STACKPROTECTOR_(REGULAR|STRONG|AUTO) \
+                                while building a position independent binary. \
+                                Update your compiler or use \
+                                CONFIG_X86_GLOBAL_STACKPROTECTOR)
+                endif
+        else
+                KBUILD_CFLAGS += $(stackseg-flag)
+        endif
+endif
+endif
+
 else
         KBUILD_CFLAGS += -mcmodel=kernel
 endif
@@ -146,7 +189,7 @@ endif
 endif
 
 ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
-        ifeq ($(call cc-option, -mstack-protector-guard=global),)
+        ifeq ($(stackglobal), n)
                 $(error Cannot use CONFIG_X86_GLOBAL_STACKPROTECTOR: \
                         -mstack-protector-guard=global not supported \
                         by compiler)
-- 
2.18.0.rc2.346.g013aa6912e-goog

