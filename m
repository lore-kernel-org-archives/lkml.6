Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A549C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA7D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217536;
	bh=OiQpui6py8YF6hQQeuAlhOsi7OEF8nwAxaYTMtBZLRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYgvsFrqsZ9nzcXQlUhxJwiKnGyTKFWU3BI6ZRISOCDRjr6u9/sdoYjI+vmOxXN+E
	 DEB2vyovPDOcIM1exiD3sku/Oddb9TwPfgzgQ2Uj38xP/I8680U60IMjw5Ei7bGgkU
	 DMIIIICcSVDv8HuNne1KrXdKpnefHk9/8f4ruySk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403753AbfAKOiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390012AbfAKOit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:38:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EF12184A;
        Fri, 11 Jan 2019 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217528;
        bh=OiQpui6py8YF6hQQeuAlhOsi7OEF8nwAxaYTMtBZLRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbDSnO9fGhLW3U8hxBXw346Wm+qT55sX3pFTj0SEvChLI70woAYOhImgCEjqVN2s7
         F2Daa86fBvT21hcuPfsNB6uvc4qEpEHZizgDzW1NQNBxL2UCHFFJq+sC1C8myg4Vic
         P+w9j8GzSJzSzWGIswxIMktHZChBg/6iPlB/8JK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.19 093/148] powerpc: consolidate -mno-sched-epilog into FTRACE flags
Date:   Fri, 11 Jan 2019 15:14:31 +0100
Message-Id: <20190111131117.908117504@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 2a056f58fd33ccc6a0261b552b0f17e7fa4a12f3 upstream.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Makefile                    |   12 ++++++------
 arch/powerpc/kernel/Makefile             |    8 ++++----
 arch/powerpc/kernel/trace/Makefile       |    2 +-
 arch/powerpc/platforms/powermac/Makefile |    2 +-
 arch/powerpc/xmon/Makefile               |    2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -160,8 +160,13 @@ else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
+ifdef CONFIG_FUNCTION_TRACER
+CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
-	CC_FLAGS_FTRACE := -pg -mprofile-kernel
+CC_FLAGS_FTRACE += -mprofile-kernel
+endif
+# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
+CC_FLAGS_FTRACE	+= -mno-sched-epilog
 endif
 
 CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
@@ -229,11 +234,6 @@ ifdef CONFIG_6xx
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
-# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
-ifdef CONFIG_FUNCTION_TRACER
-KBUILD_CFLAGS		+= -mno-sched-epilog
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -22,10 +22,10 @@ CFLAGS_prom.o += $(DISABLE_LATENT_ENTROP
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_prom_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_btext.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_prom.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_cputable.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_btext.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_prom.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -7,7 +7,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR)	:= -
 
 ifdef CONFIG_FUNCTION_TRACER
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj32-$(CONFIG_FUNCTION_TRACER)		+= ftrace_32.o
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -3,7 +3,7 @@ CFLAGS_bootx_init.o  		+= -fPIC
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_bootx_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_bootx_init.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				+= pic.o setup.o time.o feature.o pci.o \
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -8,7 +8,7 @@ UBSAN_SANITIZE := n
 
 # Disable ftrace for the entire directory
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
-KBUILD_CFLAGS = $(subst -mno-sched-epilog,,$(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS)))
+KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 


