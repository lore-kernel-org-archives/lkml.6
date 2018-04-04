Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDDKIG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:08:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDDKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:08:05 -0400
Date: Wed, 4 Apr 2018 03:07:55 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-667b24d049e5dd643a351757fee1a17472cd1719@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, arnd@arndb.de, palmer@sifive.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        arnd@arndb.de, palmer@sifive.com
In-Reply-To: <20180404043130.31277-2-palmer@sifive.com>
References: <20180404043130.31277-2-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] arm64: Set CONFIG_MULTI_IRQ_HANDLER
Git-Commit-ID: 667b24d049e5dd643a351757fee1a17472cd1719
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

Commit-ID:  667b24d049e5dd643a351757fee1a17472cd1719
Gitweb:     https://git.kernel.org/tip/667b24d049e5dd643a351757fee1a17472cd1719
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Tue, 3 Apr 2018 21:31:28 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 4 Apr 2018 12:04:28 +0200

arm64: Set CONFIG_MULTI_IRQ_HANDLER

arm has an optional MULTI_IRQ_HANDLER, which arm64 copied but didn't make
optional.  The multi irq handler infrastructure has been copied to generic
code selectable with a new config symbol. That symbol can be selected by
randconfig builds and can cause build breakage.

Introduce CONFIG_MULTI_IRQ_HANDLER as an intermediate step which prevents
the core config symbol from being selected. The arm64 local config symbol
will be removed once arm64 gets converted to the generic code.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20180404043130.31277-2-palmer@sifive.com

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
