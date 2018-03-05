Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeCEUXy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:23:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:19709 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeCEUXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:23:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="209015202"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/6] tpm: sort objects in the Makefile
Date: Mon,  5 Mar 2018 22:20:12 +0200
Message-Id: <20180305202017.24008-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305202017.24008-1-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the tpm Makefile a bit more in order by putting
objects in one column and group together tpm2 modules

Prefer tpm-objs += instead of tpm-y += notation.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index acd758381c58..2fc0e9a73cd6 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -3,9 +3,17 @@
 # Makefile for the kernel tpm device drivers.
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
-tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
-	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
-         tpm2-space.o
+tpm-objs := tpm-interface.o
+tpm-objs += tpm-dev.o
+tpm-objs += tpm-chip.o
+tpm-objs += tpm-dev-common.o
+tpm-objs += tpmrm-dev.o
+tpm-objs += tpm-sysfs.o
+tpm-objs += tpm1_eventlog.o
+tpm-objs += tpm2-cmd.o
+tpm-objs += tpm2-space.o
+tpm-objs += tpm2_eventlog.o
+
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
-- 
2.14.3
