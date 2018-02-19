Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeBSMKe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:10:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:37144 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbeBSMKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:10:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="31168607"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: use kmemdup() to copy the EFI event log
Date: Mon, 19 Feb 2018 14:10:26 +0200
Message-Id: <20180219121026.14304-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_eventlog_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_efi.c b/drivers/char/tpm/tpm_eventlog_efi.c
index e3f9ffd341d2..57c8b3cc46be 100644
--- a/drivers/char/tpm/tpm_eventlog_efi.c
+++ b/drivers/char/tpm/tpm_eventlog_efi.c
@@ -50,10 +50,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(log_size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		goto err_memunmap;
-	memcpy(log->bios_event_log, log_tbl->log, log_size);
 	log->bios_event_log_end = log->bios_event_log + log_size;
 
 	tpm_log_version = log_tbl->version;
-- 
2.14.1
