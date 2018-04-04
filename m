Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDDEcj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:32:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40883 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbeDDEcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:32:17 -0400
X-Google-Smtp-Source: AIpwx48gzTy4VrnzWfinWntbPEZPukYdpbEJwgmAdMIRVUYWVgxYQ5K5VKPo6JqxghOfvYNZ4klnDA==
Subject: [PATCH 2/3] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
Date: Tue,  3 Apr 2018 21:31:29 -0700
Message-Id: <20180404043130.31277-3-palmer@sifive.com>
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
 arch/openrisc/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 339df7324e9c..9ecad05bfc73 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,6 +27,7 @@ config OPENRISC
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
+	select MULTI_IRQ_HANDLER
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
@@ -68,6 +69,9 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool  y
 
+config MULTI_IRQ_HANDLER
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.16.1
