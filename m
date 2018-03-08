Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935807AbeCHLgR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:36:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeCHLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:36:14 -0500
Date: Thu, 8 Mar 2018 03:36:00 -0800
From: tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-b45c9f3656b691ab7324c7eaefb3416bea0326d8@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, andy.shevchenko@gmail.com,
        tglx@linutronix.de, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Reply-To: hpa@zytor.com, andy.shevchenko@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, jan.kiszka@siemens.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <2a0ccd51ea6f7996e07162918228e23bdc1fbb03.1520408357.git.jan.kiszka@siemens.com>
References: <2a0ccd51ea6f7996e07162918228e23bdc1fbb03.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86: Consolidate PCI_MMCONFIG configs
Git-Commit-ID: b45c9f3656b691ab7324c7eaefb3416bea0326d8
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

Commit-ID:  b45c9f3656b691ab7324c7eaefb3416bea0326d8
Gitweb:     https://git.kernel.org/tip/b45c9f3656b691ab7324c7eaefb3416bea0326d8
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Wed, 7 Mar 2018 08:39:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:38 +0100

x86: Consolidate PCI_MMCONFIG configs

Since e279b6c1d329 ("x86: start unification of arch/x86/Kconfig.*"), there
exist two PCI_MMCONFIG entries, one from the original i386 and another from
x86_64. Consolidate both entries into a single one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jailhouse-dev@googlegroups.com
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/2a0ccd51ea6f7996e07162918228e23bdc1fbb03.1520408357.git.jan.kiszka@siemens.com

---
 arch/x86/Kconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6bd763640925..573b7c49d9f8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2640,8 +2640,10 @@ config PCI_DIRECT
 	depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
 
 config PCI_MMCONFIG
-	def_bool y
-	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
+	bool "Support mmconfig PCI config space access" if X86_64
+	default y
+	depends on PCI && (ACPI || SFI)
+	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
 
 config PCI_OLPC
 	def_bool y
@@ -2656,11 +2658,6 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
-config PCI_MMCONFIG
-	bool "Support mmconfig PCI config space access"
-	default y
-	depends on X86_64 && PCI && (ACPI || SFI)
-
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
 	depends on PCI
