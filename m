Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166354AbeBOSWn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:22:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:3049 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166306AbeBOSWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:22:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="35068989"
From: Joe Konno <joe.konno@linux.intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ard.biesheuvel@linaro.org, matthew.garrett@nebula.com, jk@ozlabs.org,
        ak@linux.intel.com, tony.luck@intel.com
Subject: [PATCH 2/2] efi: restrict top-level attribute permissions
Date: Thu, 15 Feb 2018 10:22:08 -0800
Message-Id: <20180215182208.35003-3-joe.konno@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215182208.35003-1-joe.konno@linux.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Konno <joe.konno@intel.com>

Restrict four top-level (/sys/firmware/efi) attributes to match systab.
This is for consistency's sake, as well as hygiene.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Joe Konno <joe.konno@intel.com>
---
 drivers/firmware/efi/efi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index cd42f66a7c85..9a1f6c85c8c7 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -167,11 +167,13 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
 	return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
 }
 
-static struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
-static struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
-static struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
+static struct kobj_attribute efi_attr_fw_vendor =
+	__ATTR_RO_MODE(fw_vendor, 0400);
+static struct kobj_attribute efi_attr_runtime = __ATTR_RO_MODE(runtime, 0400);
+static struct kobj_attribute efi_attr_config_table =
+	__ATTR_RO_MODE(config_table, 0400);
 static struct kobj_attribute efi_attr_fw_platform_size =
-	__ATTR_RO(fw_platform_size);
+	__ATTR_RO_MODE(fw_platform_size, 0400);
 
 static struct attribute *efi_subsys_attrs[] = {
 	&efi_attr_systab.attr,
-- 
2.14.1
