Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672776-5-7325975920635078604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672775; b=qhj7Lp+cnwY+07Wqu9ECoVuvex4z/gX6IHnF5+BgsBBSW4Ztyk
    VzCO5XnR4bjZn86pWQoh8L9wUBkSWweyygB9tSiBB09C20O/O0HkwUSAsLlIoesV
    RHe2GutcRvoPkjbFvnOq1NkewcuglXq17qDO3NSyxrL0nqhFfVGiCPW0+6S+ZSez
    Ebh/JBLz6oHQeJnESDyUbgtv5T+O/+CLa6O7enI0Hu4CVGd8oL6thdo+c0apI4Fz
    TQevxcfbVSErCVrvqzkHBsnqGpUAK83objiTVOzItcd4JeFM9Eo60baY8JOOrZzi
    7edE0iusXbvV2KdJvEXr76s7P5Cau0On9U9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524672775; bh=BPTSuEnE6jlRHMSPU4M23tQO9MzVfP
    BbVxzFt35dOrY=; b=DEmbhrk5lq+sOxNocRf69APA7ZNSKj8/14zYeFENuvXpM3
    O0OQ1kdUGzS6hokCkhUNhZTJPzKs4P1oto32LAFPbuSsniM/8fllxgPmc5pvvGqb
    HLXfXbW5bAYrhBsEoFGVXosSUjAZYPq3vy8Dh7mZnX8LfvU9Dj4vsxX30xAbWl+1
    szgAdELDd8cIs6a3L0C6ow3U/8E5riGhodF9seArdDnexIGMBwf8IPYxYFokuggm
    /jW6RBwstnr7ab6iwvqJ21D8Ormg2jO8lAErcyyo2IC6tGbF+Z+YYpsULfYeuftD
    hrmUbkYi8cz9rqJFoGljRQeN8eyForgKmABOASbw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWQvrheLH5CJcO3P+z8ZdpBKZkyXlI+i3cvVHwqJSeE+qedPqn/TfUPSvNaUT5WC3XonvO4E8kXDCAFGR1b6Atgu70j/kcJpf/YhzgsTjEsQURLvL8j
    +k4bfA+9SW6LFpc/a+5lX3wye2WcHCdouE1RkY0qUZVHnZMkUBI2c1GhIPslBZlxG++79iS5vYuiQkLEkkoORrYiAjgcJB80mTaD779JwvU4GFWHds/bKIMu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=MvuuwTCpAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Chx9Alyx62UdC6-7EaAA:9
    a=dVHiktpip_riXrfdqayU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeDYQMv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:12:51 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:32197 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeDYQMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 12:12:19 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: [PATCH] pmem: fix badblocks population for raw mode
Date: Wed, 25 Apr 2018 10:11:25 -0600
Message-Id: <20180425161125.8082-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pmem_attach_disk() calls nvdimm_badblocks_populate() with resource
range uninitialized in the case of raw mode.  This leads the pmem
driver to hit MCE despite of ARS reporting the range bad.

Initialize 'bb_res' for raw mode.

Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface to use struct dev_pagemap")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvdimm/pmem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d714926ecf5..2d7875209bce 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -367,9 +367,11 @@ static int pmem_attach_disk(struct device *dev,
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
-	} else
+	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
+		memcpy(&bb_res, res, sizeof(bb_res));
+	}
 
 	/*
 	 * At release time the queue must be frozen before
