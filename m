Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeCFJaV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:30:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:27809 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeCFJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:28:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="209184758"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/5 V2] tpm: sort objects in the Makefile
Date: Tue,  6 Mar 2018 11:24:59 +0200
Message-Id: <20180306092503.11568-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306092503.11568-1-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the tpm Makefile a bit more in order by putting
objects in one column and group together tpm2 modules

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: 1. back to tpm-y notation
    2. Partially sort files alphanumerically.

 drivers/char/tpm/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index acd758381c58..b2d6ca9e62e4 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -3,12 +3,21 @@
 # Makefile for the kernel tpm device drivers.
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
-tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
-	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
-         tpm2-space.o
+tpm-y := tpm-chip.o
+tpm-y += tpm-dev.o
+tpm-y += tpm-dev-common.o
+tpm-y += tpm-interface.o
+tpm-y += tpmrm-dev.o
+tpm-y += tpm-sysfs.o
+tpm-y += tpm1_eventlog.o
+tpm-y += tpm2-cmd.o
+tpm-y += tpm2_eventlog.o
+tpm-y += tpm2-space.o
+
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
+
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
-- 
2.14.3
