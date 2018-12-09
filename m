Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70B20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLILIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:08:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLILIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:08:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB9B7dWY2918519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 9 Dec 2018 03:07:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB9B7bbi2918514;
        Sun, 9 Dec 2018 03:07:37 -0800
Date:   Sun, 9 Dec 2018 03:07:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-63fea0af43af5beb3779fd2cae078d5d77b4bb11@git.kernel.org>
Cc:     bp@suse.de, paulus@samba.org, hpa@zytor.com, mpe@ellerman.id.au,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        mingo@kernel.org, richard@sigma-star.at, x86@kernel.org,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, yamada.masahiro@socionext.com,
          mpe@ellerman.id.au, mingo@kernel.org, richard@sigma-star.at,
          benh@kernel.crashing.org, x86@kernel.org,
          linux-kernel@vger.kernel.org, bp@suse.de, paulus@samba.org
In-Reply-To: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86, powerpc: Remove -funit-at-a-time compiler
 option entirely
Git-Commit-ID: 63fea0af43af5beb3779fd2cae078d5d77b4bb11
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

Commit-ID:  63fea0af43af5beb3779fd2cae078d5d77b4bb11
Gitweb:     https://git.kernel.org/tip/63fea0af43af5beb3779fd2cae078d5d77b4bb11
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 12 Nov 2018 11:35:20 +0900
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 9 Dec 2018 11:55:32 +0100

x86, powerpc: Remove -funit-at-a-time compiler option entirely

GCC 4.6 manual says:

  -funit-at-a-time
    This option is left for compatibility reasons. -funit-at-a-time has
    no effect, while -fno-unit-at-a-time implies -fno-toplevel-reorder
    and -fno-section-anchors. Enabled by default.

Remove it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Richard Weinberger <richard@sigma-star.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com
---
 arch/powerpc/Makefile | 4 ----
 arch/x86/Makefile     | 4 ----
 arch/x86/Makefile.um  | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..854199c9ab7e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -228,10 +228,6 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
 KBUILD_CFLAGS += $(call cc-option,-mno-spe)
 KBUILD_CFLAGS += $(call cc-option,-mspe=no)
 
-# Enable unit-at-a-time mode when possible. It shrinks the
-# kernel considerably.
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-
 # FIXME: the module load should be taught about the additional relocs
 # generated by this.
 # revert to pre-gcc-4.4 behaviour of .eh_frame
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f4134524..58d82e9dc36d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -130,10 +130,6 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-
-        # -funit-at-a-time shrinks the kernel .text considerably
-        # unfortunately it makes reading oopses harder.
-        KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 endif
 
 ifdef CONFIG_X86_X32
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 577976b7d1f8..1db7913795f5 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -26,9 +26,6 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-
 KBUILD_CFLAGS += $(cflags-y)
 
 else
@@ -50,6 +47,4 @@ ELF_FORMAT := elf64-x86-64
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
-# Do unit-at-a-time unconditionally on x86_64, following the host
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 endif
