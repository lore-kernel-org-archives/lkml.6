Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeBWIZW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:25:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBWIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:25:20 -0500
Date: Fri, 23 Feb 2018 00:24:45 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-492a1abd61e4b4f78c1c5804840a304a9e32da04@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, bhelgaas@google.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        peterz@infradead.org, tglx@linutronix.de, jdelvare@suse.com,
        andriy.shevchenko@linux.intel.com
Reply-To: andriy.shevchenko@linux.intel.com, rjw@rjwysocki.net,
        jdelvare@suse.com, peterz@infradead.org, tglx@linutronix.de,
        bhelgaas@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] dmi: Introduce the dmi_get_bios_year() helper
 function
Git-Commit-ID: 492a1abd61e4b4f78c1c5804840a304a9e32da04
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

Commit-ID:  492a1abd61e4b4f78c1c5804840a304a9e32da04
Gitweb:     https://git.kernel.org/tip/492a1abd61e4b4f78c1c5804840a304a9e32da04
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 22 Feb 2018 14:59:20 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:20:30 +0100

dmi: Introduce the dmi_get_bios_year() helper function

The pattern to only extract the year portion of date is used in
several places and more users may come.

By using this helper they may create slightly cleaner code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ Minor stylistic cleanup. ]
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222125923.57385-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/dmi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 46e151172d95..0bade156e908 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -147,4 +147,13 @@ static inline const struct dmi_system_id *
 
 #endif
 
+static inline int dmi_get_bios_year(void)
+{
+	int year;
+
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+
+	return year;
+}
+
 #endif	/* __DMI_H__ */
