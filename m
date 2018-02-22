Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeBVM7d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:16589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932502AbeBVM73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="29845355"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
Date: Thu, 22 Feb 2018 14:59:20 +0200
Message-Id: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used in several places and more users may come.
By using this helper they may create a slightly cleaner code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 46e151172d95..241c27008c70 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -147,4 +147,11 @@ static inline const struct dmi_system_id *
 
 #endif
 
+static inline int dmi_get_bios_year(void)
+{
+	int year;
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+	return year;
+}
+
 #endif	/* __DMI_H__ */
-- 
2.16.1
