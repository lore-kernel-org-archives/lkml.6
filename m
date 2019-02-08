Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5721929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663543;
	bh=safym6PJ2O/usn+yVRwjhoFchGx5+Mmu+SU7pCV9hls=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=y0+GjdjNMZnJdzB891Dmy4aJgTpVT25EKCiwTmttUHuYOdrflUPF8IFbFilq4cno2
	 6BqtaDfgcoFl0slJAf/ptApP5VfN5AJa9WMbCsWAb6jG00V9lopgtfbFKxRnU2zuoX
	 hxlTO3CxdMJNsB+iI6Q7CxTYmlN2LsigOb6pUFE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBHWFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfBHWFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:41 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8F221908;
        Fri,  8 Feb 2019 22:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663540;
        bh=safym6PJ2O/usn+yVRwjhoFchGx5+Mmu+SU7pCV9hls=;
        h=Subject:From:To:Cc:Date:From;
        b=1JgKdZINPVgfC5SMtFVklvnvXKqcALDnMM7GbZ+Kk5QTK8PW7jAI4B7JPHGiN62H2
         fRGlDcfbZIHABvrxhSSYy78UG8o/FpoR0vdZOdOlOScd0+6+tsyXUirneU4pAdayRL
         q6ZJtxeIeDsDxYixLfdem2ReqJT6sq1VC8lmzniE=
Subject: [PATCH v1 0/7] iommu: Minor cleanups and dev_printk() usage
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:05:33 -0600
Message-ID: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've had these minor iommu cleanups lying around for a while, but the ugly
dmesg logs from [1] prompted me to finally post them.  Take what you like,
ignore the rest, and tell me so I can clear out my queue of old stuff.

These fix no actual bugs.

[1] https://lore.kernel.org/linux-pci/1547649064-19019-1-git-send-email-liudongdong3@huawei.com

---

Bjorn Helgaas (7):
      iommu: Use dev_printk() when possible
      iommu/amd: Use dev_printk() when possible
      iommu/vt-d: Use dev_printk() when possible
      iommu/vt-d: Remove unnecessary local variable initializations
      iommu/vt-d: Remove unused dmar_remove_one_dev_info() argument
      iommu/vt-d: Remove misleading "domain 0" test from domain_exit()
      iommu/vt-d: Simplify control flow


 drivers/iommu/amd_iommu.c      |   25 +++----
 drivers/iommu/amd_iommu_init.c |   20 +++---
 drivers/iommu/intel-iommu.c    |  136 +++++++++++++++++-----------------------
 drivers/iommu/iommu.c          |    8 +-
 4 files changed, 84 insertions(+), 105 deletions(-)
