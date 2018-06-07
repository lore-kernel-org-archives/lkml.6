Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KJPZEQRjGVufZQAAmS7hNA
	; Thu, 07 Jun 2018 16:54:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CFB8F6074D; Thu,  7 Jun 2018 16:54:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5554760115;
	Thu,  7 Jun 2018 16:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5554760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeFGQyC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:54:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:60223 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932630AbeFGQyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:54:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 09:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="57388140"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2018 09:54:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: pfsid fix
Date: Thu,  7 Jun 2018 09:56:58 -0700
Message-Id: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device invalidation throttling(DIT) is supported by an IOMMU, device TLB
invalidation should include physical function source ID(PFSID).

Changes since v1:
- Fixed compile error when CONFIG_PCI_ATS is not set
- Simplified how PF source ID is retrieved

Jacob Pan (2):
  iommu/vt-d: add definitions for PFSID
  iommu/vt-d: fix dev iotlb pfsid use

 drivers/iommu/dmar.c        |  6 +++---
 drivers/iommu/intel-iommu.c | 18 +++++++++++++++++-
 include/linux/intel-iommu.h |  8 +++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.7.4
