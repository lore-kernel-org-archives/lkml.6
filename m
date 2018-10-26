Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C147ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21B220856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21B220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJZS4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:56:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:4614 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZS4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:56:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 03:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,427,1534834800"; 
   d="scan'208";a="91412711"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2018 03:20:04 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2] tpm: fix kdoc for tpm2_flush_context_cmd()
Date:   Fri, 26 Oct 2018 13:15:58 +0300
Message-Id: <20181026101558.11753-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdoc for tpm2_flush_context_cmd() was off.

Fixes: 9aa36b399a50 ("tpm: export tpm2_flush_context_cmd")'
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: drop 'commit' from Fixes:
 drivers/char/tpm/tpm2-cmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae86fb0218ab..ba94dd5f11a4 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -343,10 +343,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 /**
  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
  * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
+ * @handle: context handle
+ * @flags: tpm transmit flags - bitmap
  *
- * Return: same as with tpm_transmit_cmd
  */
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags)
-- 
2.14.5

