Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCNQxq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:53:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46512 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:53:45 -0400
X-Google-Smtp-Source: AG47ELv84p2YiSMHupw8PS17irMBayOz0t1ariqbYebh03NCC7zIDDgWeS7WzWtNoGl2LMW6KTwjgg==
Subject: [PATCH] RISC-V: Rename CONFIG_CMDLINE_OVERRIDE to CONFIG_CMDLINE_FORCE
Date: Wed, 14 Mar 2018 09:41:43 -0700
Message-Id: <20180314164143.11898-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
Cc: Palmer Dabbelt <palmer@sifive.com>, Trung Tran <trung.tran@ettus.com>,
        Moritz Fischer <mdf@kernel.org>, Michael J Clark <mjc@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree code looks for CONFIG_CMDLINE_FORCE, but we were using
CONFIG_CMDLINE_OVERRIDE.  It looks like this was just a hold over from
before our device tree conversion -- in fact, we'd already removed the
support for CONFIG_CMDLINE_OVERRIDE from our arch-specific code so it
didn't even work any more.

Thanks to Mortiz and Trung for finding the original bug, and for Michael
for suggeting a better fix.

CC: Trung Tran <trung.tran@ettus.com>
CC: Moritz Fischer <mdf@kernel.org>
CC: Michael J Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 04807c7f64cc..992412dda60c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -281,7 +281,7 @@ config CMDLINE_BOOL
 	  in CONFIG_CMDLINE.
 
 	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
+	  line if CMDLINE_FORCE is set to 'N'. Otherwise, the default
 	  command line will be ignored and replaced by the built-in string.
 
 config CMDLINE
@@ -291,7 +291,7 @@ config CMDLINE
 	help
 	  Supply command-line options at build time by entering them here.
 
-config CMDLINE_OVERRIDE
+config CMDLINE_FORCE
 	bool "Built-in command line overrides bootloader arguments"
 	depends on CMDLINE_BOOL
 	help
-- 
2.16.1
