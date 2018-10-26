Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BFBECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C5720848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C5720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeJ0DXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:23:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:52476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbeJ0DXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:23:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 11:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="102977893"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2018 11:44:50 -0700
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
Subject: [PATCH] tpm: tpm_ibmvtpm: fix kdoc warnings
Date:   Fri, 26 Oct 2018 21:40:43 +0300
Message-Id: <20181026184043.5524-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181026184043.5524-1-tomas.winkler@intel.com>
References: <20181026184043.5524-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant lines in the kdoc:

Fixes kdoc warnings:

drivers/char/tpm/tpm_ibmvtpm.c:42: warning: Cannot understand  *
 on line 42 - I thought it was a doc line
drivers/char/tpm/tpm_ibmvtpm.c:57: warning: Cannot understand  *
 on line 57 - I thought it was a doc line

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 25f6e2665385..07b5a487d0c8 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -39,8 +39,7 @@ static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
 
 /**
- *
- * ibmvtpm_send_crq_word - Send a CRQ request
+ * ibmvtpm_send_crq_word() - Send a CRQ request
  * @vdev:	vio device struct
  * @w1:		pre-constructed first word of tpm crq (second word is reserved)
  *
@@ -54,8 +53,7 @@ static int ibmvtpm_send_crq_word(struct vio_dev *vdev, u64 w1)
 }
 
 /**
- *
- * ibmvtpm_send_crq - Send a CRQ request
+ * ibmvtpm_send_crq() - Send a CRQ request
  *
  * @vdev:	vio device struct
  * @valid:	Valid field
-- 
2.14.5

