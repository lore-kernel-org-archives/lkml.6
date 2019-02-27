Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9421850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfB0T2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:28:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:58983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbfB0T2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:28:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 11:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="119590474"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2019 11:28:29 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     sfr@canb.auug.org.au, joro@8bytes.org
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/ATS: Add inline to pci_prg_resp_pasid_required()
Date:   Wed, 27 Feb 2019 11:26:46 -0800
Message-Id: <65d2712b741cc17c72994642458520853e78f6ba.1551295414.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227132004.4d3a3da4@canb.auug.org.au>
References: <20190227132004.4d3a3da4@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unused function warning when compiled with CONFIG_PCI_PASID
disabled.

Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/linux/pci-ats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index facfd6a18fe1..1ebb88e7c184 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -67,7 +67,7 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 	return -EINVAL;
 }
 
-static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	return 0;
 }
-- 
2.20.1

