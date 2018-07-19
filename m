Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3450ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRJgrI+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5676B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeGSWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeGSWfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:35:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795BB206B7;
        Thu, 19 Jul 2018 21:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532037006;
        bh=GuT73mncBLgKm5wnlSmqZirw5gqwoyiomCEYS9hY7Dc=;
        h=Subject:From:To:Cc:Date:From;
        b=hRJgrI+kPygZNv/g4HYg/scNAb9u8vVYI9cOHkx1r00Vq+pxL0rluQ9ngV5E9j/dM
         w5fHD2cUB7zW7g5BcKSL4iofvdQkaFbDwZZVoK1r2gDLfPcu3hmKRfnuVrx0PvOjT0
         1GXKcT9J73qKjvUMe9xs7WbxRkJlfCqgxC8bbrio=
Subject: [PATCH v1] PCI/IOV: Tidy pci_sriov_set_totalvfs()
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 16:50:05 -0500
Message-ID: <153203700547.38654.5004300385518326333.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix minor style issues in pci_sriov_set_totalvfs().  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d0d73dbbd5ca..aee859971ba1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -802,15 +802,15 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 {
 	if (!dev->is_physfn)
 		return -ENOSYS;
+
 	if (numvfs > dev->sriov->total_VFs)
 		return -EINVAL;
 
 	/* Shouldn't change if VFs already enabled */
 	if (dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
 		return -EBUSY;
-	else
-		dev->sriov->driver_max_VFs = numvfs;
 
+	dev->sriov->driver_max_VFs = numvfs;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);

