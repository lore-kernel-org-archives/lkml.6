Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeC0QU5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:20:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35470 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeC0QTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:33 -0400
X-Google-Smtp-Source: AG47ELte6BEnZK/dyKhxqA1yQ3O+k+cRd/jsaSagmTdeLP/fLTlrP009cS4Hh0sDS2T3MCIyllXtow==
Subject: [PATCH v4 2/8] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
Date: Tue, 27 Mar 2018 09:19:05 -0700
Message-Id: <20180327161911.14086-3-palmer@sifive.com>
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

arm has an optional MULTI_IRQ_HANDLER, which openrisc copied but didn't
make optional.  I'm converting this to generic code, but in order to
ensure everything stays bisectable I want this defined on openrisc for
now.  This will go away by the end of the patch set.

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
