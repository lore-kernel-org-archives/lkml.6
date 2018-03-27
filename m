Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeC0QTi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:19:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38676 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0QT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:27 -0400
X-Google-Smtp-Source: AG47ELvG4fMagaej8eVAUP/8jKzUKHpSoE9BLEKfSsx916j52Z9v9swg1jMJUIXVOCeS4BWz2mJUWQ==
Subject: [PATCH v4 1/8] arm64: Set CONFIG_MULTI_IRQ_HANDLER
Date: Tue, 27 Mar 2018 09:19:04 -0700
Message-Id: <20180327161911.14086-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm has an optional MULTI_IRQ_HANDLER, which arm64 copied but didn't
make optional.  I'm converting this to generic code, but in order to
ensure everything stays bisectable I want this defined on arm64 for now.
This will go away by the end of the patch set.

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
