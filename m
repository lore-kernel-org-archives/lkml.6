Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbeCEUYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:24:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:19709 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeCEUYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:24:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="209015259"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 6/6] tpm: tpm-interface: drop unused tpm_input_header headers.
Date: Mon,  5 Mar 2018 22:20:17 +0200
Message-Id: <20180305202017.24008-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305202017.24008-1-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRC extend and get capability were reimplemented using
tpm_buf_ interface and the dangling tpm_input_headers can be dropped.
together with now unused constants.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7f6968b750c8..ebf52b48d727 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -355,16 +355,7 @@ int tpm_startup(struct tpm_chip *chip)
 }
 
 #define TPM_DIGEST_SIZE 20
-#define TPM_RET_CODE_IDX 6
-#define TPM_INTERNAL_RESULT_SIZE 200
 #define TPM_ORD_GET_CAP 101
-#define TPM_ORD_GET_RANDOM 70
-
-static const struct tpm_input_header tpm_getcap_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(22),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_CAP)
-};
 
 ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		   const char *desc, size_t min_cap_length)
@@ -517,12 +508,6 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 #define TPM_ORD_PCR_EXTEND 20
 #define EXTEND_PCR_RESULT_SIZE 34
 #define EXTEND_PCR_RESULT_BODY_SIZE 20
-static const struct tpm_input_header pcrextend_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(34),
-	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
-};
-
 static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 			   char *log_msg)
 {
@@ -782,6 +767,7 @@ int tpm_pm_resume(struct device *dev)
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
 #define TPM_GETRANDOM_RESULT_SIZE	18
+#define TPM_ORD_GET_RANDOM 70
 static const struct tpm_input_header tpm_getrandom_header = {
 	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
 	.length = cpu_to_be32(14),
-- 
2.14.3
