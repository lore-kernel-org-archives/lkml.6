Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2073CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A9221904
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfBARl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:41:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:41232 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfBARl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:41:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 09:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="315573012"
Received: from gandrejc-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2019 09:41:23 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        zohar@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] tpm/st33zp24: Fix name collision with TPM_BUFSIZE
Date:   Fri,  1 Feb 2019 19:41:17 +0200
Message-Id: <20190201174117.23440-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
ST33ZP24_BUFSIZE as it collides with TPM_BUFSIZE defined in
drivers/char/tpm/tpm.h.

Cc: stable@vger.kernel.org
Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/st33zp24/i2c.c      | 2 +-
 drivers/char/tpm/st33zp24/spi.c      | 2 +-
 drivers/char/tpm/st33zp24/st33zp24.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.19.1

