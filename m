Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965839AbeCHLfr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:35:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935582AbeCHLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:35:45 -0500
Date: Thu, 8 Mar 2018 03:35:30 -0800
From: tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-55027a7772b1a9c36fb9731fc6c847b6a59c5bef@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jan.kiszka@siemens.com,
        tglx@linutronix.de, andy.shevchenko@gmail.com, hpa@zytor.com,
        bhelgaas@google.com
Reply-To: bhelgaas@google.com, jan.kiszka@siemens.com, tglx@linutronix.de,
        andy.shevchenko@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
In-Reply-To: <a2faf78c54f340f5549149e8b679c95950dae83d.1520408357.git.jan.kiszka@siemens.com>
References: <a2faf78c54f340f5549149e8b679c95950dae83d.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86: Align x86_64 PCI_MMCONFIG with 32-bit
 variant
Git-Commit-ID: 55027a7772b1a9c36fb9731fc6c847b6a59c5bef
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

Commit-ID:  55027a7772b1a9c36fb9731fc6c847b6a59c5bef
Gitweb:     https://git.kernel.org/tip/55027a7772b1a9c36fb9731fc6c847b6a59c5bef
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Wed, 7 Mar 2018 08:39:15 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:38 +0100

x86: Align x86_64 PCI_MMCONFIG with 32-bit variant

Allow to enable PCI_MMCONFIG when only SFI is present and make this option
default on. This will help consolidating both into one Kconfig statement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jailhouse-dev@googlegroups.com
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/a2faf78c54f340f5549149e8b679c95950dae83d.1520408357.git.jan.kiszka@siemens.com

---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1236b187824..6bd763640925 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2658,7 +2658,8 @@ config PCI_DOMAINS
 
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
-	depends on X86_64 && PCI && ACPI
+	default y
+	depends on X86_64 && PCI && (ACPI || SFI)
 
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
