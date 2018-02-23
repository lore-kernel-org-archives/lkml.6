Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeBWI0H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:26:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBWI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:26:04 -0500
Date: Fri, 23 Feb 2018 00:25:39 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-9c0a30b67bd916a7da1a7101dbf3115e5f10d852@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, rjw@rjwysocki.net,
        andriy.shevchenko@linux.intel.com, bhelgaas@google.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org, mingo@kernel.org,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        rjw@rjwysocki.net, jdelvare@suse.com
In-Reply-To: <20180222125923.57385-3-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-3-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] ACPI/sleep: Simplify code by using the new
 dmi_get_bios_year() helper
Git-Commit-ID: 9c0a30b67bd916a7da1a7101dbf3115e5f10d852
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

Commit-ID:  9c0a30b67bd916a7da1a7101dbf3115e5f10d852
Gitweb:     https://git.kernel.org/tip/9c0a30b67bd916a7da1a7101dbf3115e5f10d852
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 22 Feb 2018 14:59:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:20:30 +0100

ACPI/sleep: Simplify code by using the new dmi_get_bios_year() helper

...instead of open coding its functionality.

No changes in functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222125923.57385-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/acpi/sleep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 46cde0912762..b35923e3a926 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -376,12 +376,10 @@ void __init acpi_sleep_no_blacklist(void)
 
 static void __init acpi_sleep_dmi_check(void)
 {
-	int year;
-
 	if (ignore_blacklist)
 		return;
 
-	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2012)
+	if (dmi_get_bios_year() >= 2012)
 		acpi_nvs_nosave_s3();
 
 	dmi_check_system(acpisleep_dmi_table);
