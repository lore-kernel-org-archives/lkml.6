Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59201C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329372087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfBDNhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:37:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:9198 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfBDNhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:37:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 05:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="135730851"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2019 05:37:51 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        zohar@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] tpm/st33zp24: Fix the name collisions in tpm_st33zp24_spi and tpm_i2c_infineon
Date:   Mon,  4 Feb 2019 15:37:49 +0200
Message-Id: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
ST33ZP24_BUFSIZE.

Rename TPM_BUFSIZE defined in drivers/char/tpm/tpm_i2c_infineon.c to
TPM_I2C_INFINEON_BUFSIZE.

Cc: stable@vger.kernel.org
Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2: Fix also the name collision in tpm_ic2_infineon.
 drivers/char/tpm/st33zp24/i2c.c      |  2 +-
 drivers/char/tpm/st33zp24/spi.c      |  2 +-
 drivers/char/tpm/st33zp24/st33zp24.h |  4 ++--
 drivers/char/tpm/tpm_i2c_infineon.c  | 15 ++++++++-------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index be5d1abd3e8e..8390c5b54c3b 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -33,7 +33,7 @@
 
 struct st33zp24_i2c_phy {
 	struct i2c_client *client;
-	u8 buf[TPM_BUFSIZE + 1];
+	u8 buf[ST33ZP24_BUFSIZE + 1];
 	int io_lpcpd;
 };
 
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index d7909ab287a8..ff019a1e3c68 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -63,7 +63,7 @@
  * some latency byte before the answer is available (max 15).
  * We have 2048 + 1024 + 15.
  */
-#define ST33ZP24_SPI_BUFFER_SIZE (TPM_BUFSIZE + (TPM_BUFSIZE / 2) +\
+#define ST33ZP24_SPI_BUFFER_SIZE (ST33ZP24_BUFSIZE + (ST33ZP24_BUFSIZE / 2) +\
 				  MAX_SPI_LATENCY)
 
 
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index 6f4a4198af6a..20da0a84988d 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -18,8 +18,8 @@
 #ifndef __LOCAL_ST33ZP24_H__
 #define __LOCAL_ST33ZP24_H__
 
-#define TPM_WRITE_DIRECTION             0x80
-#define TPM_BUFSIZE                     2048
+#define TPM_WRITE_DIRECTION	0x80
+#define ST33ZP24_BUFSIZE	2048
 
 struct st33zp24_dev {
 	struct tpm_chip *chip;
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 9086edc9066b..b9d5a1dda8d2 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -26,8 +26,7 @@
 #include <linux/wait.h>
 #include "tpm.h"
 
-/* max. buffer size supported by our TPM */
-#define TPM_BUFSIZE 1260
+#define TPM_I2C_INFINEON_MAX_BUFSIZE 1260
 
 /* max. number of iterations after I2C NAK */
 #define MAX_COUNT 3
@@ -63,11 +62,13 @@ enum i2c_chip_type {
 	UNKNOWN,
 };
 
-/* Structure to store I2C TPM specific stuff */
 struct tpm_inf_dev {
 	struct i2c_client *client;
 	int locality;
-	u8 buf[TPM_BUFSIZE + sizeof(u8)]; /* max. buffer size + addr */
+	/* In addition to the data itself, the buffer must fit the 7-bit I2C
+	 * address and the direction bit.
+	 */
+	u8 buf[TPM_I2C_INFINEON_MAX_BUFSIZE + 1];
 	struct tpm_chip *chip;
 	enum i2c_chip_type chip_type;
 	unsigned int adapterlimit;
@@ -219,7 +220,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 		.buf = tpm_dev.buf
 	};
 
-	if (len > TPM_BUFSIZE)
+	if (len > TPM_I2C_INFINEON_MAX_BUFSIZE)
 		return -EINVAL;
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
@@ -527,8 +528,8 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	u8 retries = 0;
 	u8 sts = TPM_STS_GO;
 
-	if (len > TPM_BUFSIZE)
-		return -E2BIG;	/* command is too long for our tpm, sorry */
+	if (len > TPM_I2C_INFINEON_BUFSIZE)
+		return -E2BIG;
 
 	if (request_locality(chip, 0) < 0)
 		return -EBUSY;
-- 
2.19.1

