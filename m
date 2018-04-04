Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDDKIi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:08:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:08:37 -0400
Date: Wed, 4 Apr 2018 03:08:27 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-83fbdf1c0595470d98ee99a6474099aee870640f@git.kernel.org>
Cc: arnd@arndb.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        palmer@sifive.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        palmer@sifive.com, hpa@zytor.com, arnd@arndb.de,
        torvalds@linux-foundation.org
In-Reply-To: <20180404043130.31277-3-palmer@sifive.com>
References: <20180404043130.31277-3-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
Git-Commit-ID: 83fbdf1c0595470d98ee99a6474099aee870640f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  83fbdf1c0595470d98ee99a6474099aee870640f
Gitweb:     https://git.kernel.org/tip/83fbdf1c0595470d98ee99a6474099aee870640f
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Tue, 3 Apr 2018 21:31:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 4 Apr 2018 12:04:28 +0200

openrisc: Set CONFIG_MULTI_IRQ_HANDLER

arm has an optional MULTI_IRQ_HANDLER, which openrisc copied but didn't
make optional.  The multi irq handler infrastructure has been copied to
generic code selectable with a new config symbol. That symbol can be
selected by randconfig builds and can cause build breakage.

Introduce CONFIG_MULTI_IRQ_HANDLER as an intermediate step which prevents
the core config symbol from being selected. The openrisc local config
symbol will be removed once openrisc gets converted to the generic code.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20180404043130.31277-3-palmer@sifive.com

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
