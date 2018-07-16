Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E8CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C0A20844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="J3jzxnsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C0A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbeGPMss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:48:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33352 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbeGPMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:48:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so26133975edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmM4JYftKYhCCurgxsP7XQ560bIMgpTe7zxRKdKo/cM=;
        b=J3jzxnsPc8HysLAU/Q/lS2GxCl74VipHjbaWF7qsjEf8tb2EuJES24GTGNLrdULXSj
         naljVOwHMyDQpfz1imViu4LcPbePodQkIPUDUqyEXg1zHO3HkQ76oQ6Ay/lyj0ZR7mre
         v1cmeoEV759DRK2Mpi8PFI5kDg6CPkRyzJ18yMQU5sOVTxPu5SmvVzcSvUedTuCL8wBd
         8kEcKvDzY/8cOnm5F7zJKo9yrdmyCfkq8/WH1cnrlr4iwyGRkHU3eTycLx63bwqEsUlF
         QSdQM5073WcJDv8EKY+NKqjAhenMPwwv5lqpSdID9PegXzz042ARPKSHwSO8K9r9lVx4
         oAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmM4JYftKYhCCurgxsP7XQ560bIMgpTe7zxRKdKo/cM=;
        b=DDbuSX3DVkQh5cXWPMnw9gAYLr+kN36VkYKW2elKFs9rXf2TOnuxbkR/E+kIF2+iF9
         QrA/VyRyMU45FIIThrzpXdgrh69cYx3YUZLebKX1nUqa1oV7EZRRKfTp99N7c8MrIomK
         KHiMRcTErzuyH5zgh35IAbLAGDavSCyIV2hjBYxsOeLcfr22ZCLZavh3LjAL1mfOtqAE
         M9f4UTrXo+nagxSeWrT9DEEhVRWFMGN74fE7sTzIcgL2e2xFd6Nnw2eNk1Ep1uP1D7Ix
         K+RHkwUc2b3AtD+uzVZimPnzzngYHraxJ95VW0KQJON5s4nl1evzt+g6lZzqmssfL15W
         Yfnw==
X-Gm-Message-State: AOUpUlFqG14bvPbwVZGfuEoHJBnqYQ4dXlMtX5LyBGwdOc/U5f8tcaBV
        Md5jewOXem0RdAd0LZdXL+FJLDeoLCk=
X-Google-Smtp-Source: AAOMgpdTHcZ/jchP3tjEwBF18B50GUoaG0VIdVJzxrem9DZB4kYXz90hrN8oCJaRiVhnEULieFxAug==
X-Received: by 2002:a50:d0ca:: with SMTP id g10-v6mr17234652edf.182.1531743694078;
        Mon, 16 Jul 2018 05:21:34 -0700 (PDT)
Received: from maco.fcp3.net (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4635471edi.26.2018.07.16.05.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:21:33 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com,
        malchev@google.com, joelaf@google.com
Subject: [PATCH 1/6] export: explicitly align struct kernel_symbol.
Date:   Mon, 16 Jul 2018 14:21:20 +0200
Message-Id: <20180716122125.175792-2-maco@android.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180716122125.175792-1-maco@android.com>
References: <20180716122125.175792-1-maco@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows growing struct kernel_symbol without wasting bytes to
alignment.

struct kernel_symbol was already implicitly being aligned to the word
size, except on x86_64 and m68k, where it is aligned to 16 and 2 bytes,
respectively.

As far as I can tell there is no requirement for aligning struct
kernel_symbol to 16 bytes on x86_64, but gcc aligns structs to their
size, and the linker aligns the custom __ksymtab sections to the largest
data type contained within, so setting KSYM_ALIGN to 16 was necessary to
stay consistent with the code generated for non-ASM EXPORT_SYMBOL(). Now
that non-ASM EXPORT_SYMBOL() explicitly aligns to word size (8),
KSYM_ALIGN is no longer necessary.

As for m68k, struct kernel_symbol is aligned to 2 bytes even though the
structure itself is 8 bytes; using a 4-byte alignment shouldn't hurt.

I manually verified the output of the __ksymtab sections didn't change
on x86, x86_64, arm, arm64 and m68k. As expected, the section contents
didn't change, and the ELF section alignment only changed on x86_64 and
m68k. Feedback from other archs more than welcome.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 arch/m68k/include/asm/export.h | 1 -
 arch/x86/include/asm/Kbuild    | 1 +
 arch/x86/include/asm/export.h  | 5 -----
 include/linux/export.h         | 1 +
 4 files changed, 2 insertions(+), 6 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

diff --git a/arch/m68k/include/asm/export.h b/arch/m68k/include/asm/export.h
index 0af20f48bd07..b53008b67ce1 100644
--- a/arch/m68k/include/asm/export.h
+++ b/arch/m68k/include/asm/export.h
@@ -1,3 +1,2 @@
-#define KSYM_ALIGN 2
 #define KCRC_ALIGN 2
 #include <asm-generic/export.h>
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index de690c2d2e33..a0ab9ab61c75 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,5 +8,6 @@ generated-y += xen-hypercalls.h
 
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
+generic-y += export.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
deleted file mode 100644
index 2a51d66689c5..000000000000
--- a/arch/x86/include/asm/export.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifdef CONFIG_64BIT
-#define KSYM_ALIGN 16
-#endif
-#include <asm-generic/export.h>
diff --git a/include/linux/export.h b/include/linux/export.h
index b768d6dd3c90..ad6b8e697b27 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -64,6 +64,7 @@ extern struct module __this_module;
 	static const struct kernel_symbol __ksymtab_##sym		\
 	__used								\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	__attribute__((aligned(sizeof(void *))))                        \
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #if defined(__KSYM_DEPS__)
-- 
2.18.0.203.gfac676dfb9-goog

