Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A59C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58102064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58102064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeJNQ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:59:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:59:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9E9IOBf3117310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Oct 2018 02:18:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9E9IKU33117307;
        Sun, 14 Oct 2018 02:18:20 -0700
Date:   Sun, 14 Oct 2018 02:18:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-dca5203e3fe2f5d8bc8157b205d766142d3a6b77@git.kernel.org>
Cc:     ndesaulniers@google.com, hpa@zytor.com, natechancellor@gmail.com,
        bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: natechancellor@gmail.com, hpa@zytor.com, ndesaulniers@google.com,
          tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181013010713.6999-1-natechancellor@gmail.com>
References: <20181013010713.6999-1-natechancellor@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Add -Wno-pointer-sign to KBUILD_CFLAGS
Git-Commit-ID: dca5203e3fe2f5d8bc8157b205d766142d3a6b77
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

Commit-ID:  dca5203e3fe2f5d8bc8157b205d766142d3a6b77
Gitweb:     https://git.kernel.org/tip/dca5203e3fe2f5d8bc8157b205d766142d3a6b77
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Fri, 12 Oct 2018 18:07:14 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Oct 2018 11:11:23 +0200

x86/boot: Add -Wno-pointer-sign to KBUILD_CFLAGS

When compiling the kernel with Clang, this warning appears even though
it is disabled for the whole kernel because this folder has its own set
of KBUILD_CFLAGS. It was disabled before the beginning of git history.

In file included from arch/x86/boot/compressed/kaslr.c:29:
In file included from arch/x86/boot/compressed/misc.h:21:
In file included from ./include/linux/elf.h:5:
In file included from ./arch/x86/include/asm/elf.h:77:
In file included from ./arch/x86/include/asm/vdso.h:11:
In file included from ./include/linux/mm_types.h:9:
In file included from ./include/linux/spinlock.h:88:
In file included from ./arch/x86/include/asm/spinlock.h:43:
In file included from ./arch/x86/include/asm/qrwlock.h:6:
./include/asm-generic/qrwlock.h:101:53: warning: passing 'u32 *' (aka
'unsigned int *') to parameter of type 'int *' converts between pointers
to integer types with different sign [-Wpointer-sign]
        if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
                                                           ^~~~~
./include/linux/compiler.h:76:40: note: expanded from macro 'likely'
# define likely(x)      __builtin_expect(!!(x), 1)
                                            ^
./include/asm-generic/atomic-instrumented.h:69:66: note: passing
argument to parameter 'old' here
static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
                                                                 ^

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20181013010713.6999-1-natechancellor@gmail.com

---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 28764dacf018..466f66c8a7f8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -37,6 +37,7 @@ KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += -Wno-pointer-sign
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
