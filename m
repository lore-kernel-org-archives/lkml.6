Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDDKHl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:07:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeDDKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:07:38 -0400
Date: Wed, 4 Apr 2018 03:07:24 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-d6f73825dcd0fa1de9a6bf37c79f6109cc87b82f@git.kernel.org>
Cc: tglx@linutronix.de, palmer@sifive.com, hpa@zytor.com, arnd@arndb.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, palmer@sifive.com,
        hpa@zytor.com
In-Reply-To: <20180404043130.31277-4-palmer@sifive.com>
References: <20180404043130.31277-4-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Make GENERIC_IRQ_MULTI_HANDLER depend on
 !MULTI_IRQ_HANDLER
Git-Commit-ID: d6f73825dcd0fa1de9a6bf37c79f6109cc87b82f
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

Commit-ID:  d6f73825dcd0fa1de9a6bf37c79f6109cc87b82f
Gitweb:     https://git.kernel.org/tip/d6f73825dcd0fa1de9a6bf37c79f6109cc87b82f
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Tue, 3 Apr 2018 21:31:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 4 Apr 2018 12:04:28 +0200

genirq: Make GENERIC_IRQ_MULTI_HANDLER depend on !MULTI_IRQ_HANDLER

These config switches enable the same code in the core and the not yet
converted architecture code. They can be selected both by randconfig builds
and cause linker error because the same symbols are defined twice.

Make the new GENERIC_IRQ_MULTI_HANDLER depend on !MULTI_IRQ_HANDLER to
prevent that. The dependency will be removed once all architectures are
converted over.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20180404043130.31277-4-palmer@sifive.com

---
 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2baefca9..c6766f326072 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -134,6 +134,7 @@ config GENERIC_IRQ_DEBUGFS
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
+	depends on !MULTI_IRQ_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
