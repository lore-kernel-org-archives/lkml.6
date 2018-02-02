Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBBNtU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:49:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:38327 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeBBNs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:48:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="14968314"
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [Patch v2 1/5] ACPI / LPIT: Export lpit_read_residency_count_address()
Date: Fri,  2 Feb 2018 19:13:33 +0530
Message-Id: <1517579017-19935-2-git-send-email-rajneesh.bhardwaj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Export lpit_read_residency_count_address(), so that it can be used from
drivers built as module. With the recent changes, the builtin_pci
functionality of the intel_pmc_core driver is removed and now it can be
built as a module to read this exported interface to calculate the PMC base
address.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/acpi_lpit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index e94e478dd18b..cf4fc0161164 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -100,6 +100,7 @@ int lpit_read_residency_count_address(u64 *address)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
 
 static void lpit_update_residency(struct lpit_residency_info *info,
 				 struct acpi_lpit_native *lpit_native)
-- 
2.7.4
