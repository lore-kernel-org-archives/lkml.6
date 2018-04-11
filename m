Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeDKMzw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:55:52 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:46370 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeDKMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:55:45 -0400
X-Google-Smtp-Source: AIpwx48sFtIdNnohqRcQZSIteiPo4t1b/CUgLYr6cvw9sy8pxq5jIzudrZiQzAYohvIplhw92BXbgIunAA==
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 14:54:59 +0200
In-Reply-To: <20180411125501.188477-1-tweek@google.com>
Message-Id: <20180411125501.188477-2-tweek@google.com>
References: <20180411125501.188477-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 1/3] tpm: Move eventlog files to a subdirectory
From: Thiebaud Weksteen <tweek@google.com>
To: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tweek@google.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thiebaud Weksteen <tweek@google.com>
---
 drivers/char/tpm/Makefile                                 | 8 ++++----
 drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} | 2 +-
 drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c}   | 2 +-
 drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c}     | 2 +-
 drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c}     | 2 +-
 drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c}     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (99%)
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (98%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (99%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (99%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index acd758381c58..5dcf5bd35a3d 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -4,11 +4,11 @@
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
-	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
+	 tpm-dev-common.o tpmrm-dev.o eventlog/tpm1.o eventlog/tpm2.o \
          tpm2-space.o
-tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
-tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
-tpm-$(CONFIG_OF) += tpm_eventlog_of.o
+tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
+tpm-$(CONFIG_EFI) += eventlog/efi.o
+tpm-$(CONFIG_OF) += eventlog/of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
diff --git a/drivers/char/tpm/tpm_eventlog_acpi.c b/drivers/char/tpm/eventlog/acpi.c
similarity index 99%
rename from drivers/char/tpm/tpm_eventlog_acpi.c
rename to drivers/char/tpm/eventlog/acpi.c
index 66f19e93c216..8476be2e9526 100644
--- a/drivers/char/tpm/tpm_eventlog_acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -27,7 +27,7 @@
 #include <linux/acpi.h>
 #include <linux/tpm_eventlog.h>
 
-#include "tpm.h"
+#include "../tpm.h"
 
 struct acpi_tcpa {
 	struct acpi_table_header hdr;
diff --git a/drivers/char/tpm/tpm_eventlog_efi.c b/drivers/char/tpm/eventlog/efi.c
similarity index 98%
rename from drivers/char/tpm/tpm_eventlog_efi.c
rename to drivers/char/tpm/eventlog/efi.c
index e3f9ffd341d2..e1593c5271a4 100644
--- a/drivers/char/tpm/tpm_eventlog_efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -14,7 +14,7 @@
 #include <linux/efi.h>
 #include <linux/tpm_eventlog.h>
 
-#include "tpm.h"
+#include "../tpm.h"
 
 /* read binary bios log from EFI configuration table */
 int tpm_read_log_efi(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/eventlog/of.c
similarity index 99%
rename from drivers/char/tpm/tpm_eventlog_of.c
rename to drivers/char/tpm/eventlog/of.c
index 96fd5646f866..c38c37e41389 100644
--- a/drivers/char/tpm/tpm_eventlog_of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -19,7 +19,7 @@
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
 
-#include "tpm.h"
+#include "../tpm.h"
 
 int tpm_read_log_of(struct tpm_chip *chip)
 {
diff --git a/drivers/char/tpm/tpm1_eventlog.c b/drivers/char/tpm/eventlog/tpm1.c
similarity index 99%
rename from drivers/char/tpm/tpm1_eventlog.c
rename to drivers/char/tpm/eventlog/tpm1.c
index add798bd69d0..d6aea3ca950e 100644
--- a/drivers/char/tpm/tpm1_eventlog.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 #include <linux/tpm_eventlog.h>
 
-#include "tpm.h"
+#include "../tpm.h"
 
 
 static const char* tcpa_event_type_strings[] = {
diff --git a/drivers/char/tpm/tpm2_eventlog.c b/drivers/char/tpm/eventlog/tpm2.c
similarity index 99%
rename from drivers/char/tpm/tpm2_eventlog.c
rename to drivers/char/tpm/eventlog/tpm2.c
index 1ce4411292ba..f0723fa9ae14 100644
--- a/drivers/char/tpm/tpm2_eventlog.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/tpm_eventlog.h>
 
-#include "tpm.h"
+#include "../tpm.h"
 
 /*
  * calc_tpm2_event_size() - calculate the event size, where event
-- 
2.17.0.484.g0c8726318c-goog
