Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF62C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794F21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7794F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbeIUTvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:51:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:4682 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbeIUTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:51:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="71839164"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 07:02:21 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v4 14/21] tpm: tpm-interface.c drop unused macros
Date:   Fri, 21 Sep 2018 16:58:13 +0300
Message-Id: <20180921135820.20549-15-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180921135820.20549-1-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit:
"tpm_tis: further simplify calculation of ordinal duration"
left unused macros, we can drop them now.

Fixes compilation warnings:
tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-Wunused-macros]
tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-macros]
tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-Wunused-macros]

Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal duration")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: New in the series.
V4: Fix the commit message.

 drivers/char/tpm/tpm-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6cd3aed1e190..d7059fc72c51 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -33,10 +33,6 @@
 
 #include "tpm.h"
 
-#define TSC_MAX_ORDINAL 12
-#define TPM_PROTECTED_COMMAND 0x00
-#define TPM_CONNECTION_COMMAND 0x40
-
 /*
  * Bug workaround - some TPM's don't flush the most
  * recently changed pcr on suspend, so force the flush
-- 
2.14.4

