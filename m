Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCLUgK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:36:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeCLUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:36:09 -0400
Date: Mon, 12 Mar 2018 13:36:06 -0700
From: Darren Hart <dvhart@infradead.org>
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] platform/x86: dell-smbios: Resolve dependency error on
 ACPI_WMI
Message-ID: <4716007c23abeb0e42015786794539454aff487b.1520886814.git.dvhart@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to DCDBAS for DELL_SMBIOS_SMM, if DELL_SMBIOS_WMI is enabled,
DELL_SMBIOS becomes dependent on ACPI_WMI. Update the depends lines to
prevent a configuration where DELL_SMBIOS=y and either backend
dependency =m. Update the comment accordingly.

Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
Since v1: Split depends line into two per Andy Shevchenko's feedback

 drivers/platform/x86/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e55b008..1868aab 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -106,13 +106,14 @@ config ASUS_LAPTOP
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
 #
-# If the DELL_SMBIOS_SMM feature is enabled, the DELL_SMBIOS driver
-# becomes dependent on the DCDBAS driver. The "depends" line prevents a
-# configuration where DELL_SMBIOS=y while DCDBAS=m.
+# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
+# backends are selected. The "depends" line prevents a configuration
+# where DELL_SMBIOS=y while either of those dependencies =m.
 #
 config DELL_SMBIOS
 	tristate "Dell SMBIOS driver"
 	depends on DCDBAS || DCDBAS=n
+	depends on ACPI_WMI || ACPI_WMI=n
 	---help---
 	This provides support for the Dell SMBIOS calling interface.
 	If you have a Dell computer you should enable this option.
-- 
2.9.5


-- 
Darren Hart
VMware Open Source Technology Center
