Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeBVNA0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:00:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:48484 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbeBVM72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="177232562"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] ACPI / sleep: Re-use new dmi_get_bios_year() helper
Date: Thu, 22 Feb 2018 14:59:22 +0200
Message-Id: <20180222125923.57385-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of open coding its functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
-- 
2.16.1
