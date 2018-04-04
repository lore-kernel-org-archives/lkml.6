Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDDEcR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:32:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40880 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeDDEcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:32:15 -0400
X-Google-Smtp-Source: AIpwx49utf+lp89LlreKJYhCLzF2gYlcXnM9gMp6d5kCYNvir+IsDNlyvZZhtBRmH2er3AMP2Fgfxg==
Subject: [PATCH 1/3] arm64: Set CONFIG_MULTI_IRQ_HANDLER
Date: Tue,  3 Apr 2018 21:31:28 -0700
Message-Id: <20180404043130.31277-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180404043130.31277-1-palmer@sifive.com>
References: <CA+55aFxRZQgPwtjS0+eiCZvkEVFvOKktuiwG4TZ653Yso3E4bA@mail.gmail.com>
 <20180404043130.31277-1-palmer@sifive.com>
Cc: mingo@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm has an optional MULTI_IRQ_HANDLER, which arm64 copied but didn't
make optional.  I'm converting this to generic code, but in order to aid
the porting effort I want to define this on arm64 for a bit.  This will
go away at the end of this patch set.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..302d0b681676 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
+	select MULTI_IRQ_HANDLER
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
@@ -275,6 +276,9 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config MULTI_IRQ_HANDLER
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.16.1
