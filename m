Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDDEcV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:32:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36861 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeDDEcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:32:18 -0400
X-Google-Smtp-Source: AIpwx4/ju23HThV1+tO0EWDUCg4uo+IUxwyQWPxn2GCDrqryW0kNVA2r3EehMe1YTduMUZnTtvcTig==
Subject: [PATCH 3/3] irq: GENERIC_IRQ_MULTI_HANDLER conflicts with MULTI_IRQ_HANDLER
Date: Tue,  3 Apr 2018 21:31:30 -0700
Message-Id: <20180404043130.31277-4-palmer@sifive.com>
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

These define the same symbol so they're mutually exclusive.  By the end
of this patch set I'll have removed MULTI_IRQ_HANDLER, but for now it's
slightly easier to make these as conflicting so architectures that now
define MULTI_IRQ_HANDLER won't get the generic version selected by
randconfig.

This will go away when every port is converted over to
GENERIC_IRQ_MULTI_HANDLER.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
-- 
2.16.1
