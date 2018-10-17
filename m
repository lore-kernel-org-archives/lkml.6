Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE241ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061B21477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8061B21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeJRBOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:14:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:53440 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJRBOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:14:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 10:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="96076007"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2018 10:17:36 -0700
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
Subject: [PATCH] tpm: fix kdoc for tpm2_flush_context_cmd()
Date:   Wed, 17 Oct 2018 20:13:31 +0300
Message-Id: <20181017171331.13393-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdoc for tpm2_flush_context_cmd() was off.

Fixes: commit 9aa36b399a50 ("tpm: export tpm2_flush_context_cmd")'
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3acf4fd4e5a5..26cc31451290 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -352,10 +352,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
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
2.14.4

