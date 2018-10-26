Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A7ECDE4A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D320868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013D320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJ0DW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:22:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:52476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbeJ0DW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:22:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 11:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="102977890"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2018 11:44:47 -0700
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
Subject: [PATCH v3] tpm: fix kdoc for tpm2_flush_context_cmd()
Date:   Fri, 26 Oct 2018 21:40:42 +0300
Message-Id: <20181026184043.5524-1-tomas.winkler@intel.com>
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
V3: Align arguments with tab.
 drivers/char/tpm/tpm2-cmd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae86fb0218ab..a6bec13afa69 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -342,11 +342,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 /**
  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
+ * @chip:	TPM chip to use
+ * @handle:	context handle
+ * @flags:	tpm transmit flags - bitmap
  *
- * Return: same as with tpm_transmit_cmd
  */
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags)
-- 
2.14.5

