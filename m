Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FC620894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MElyhB/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FC620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeHAAcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731637AbeHAAcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:32:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78382083F;
        Tue, 31 Jul 2018 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533077412;
        bh=Ag9J46CAGiJc9uu7m6Ypm5lHYJ4JCw9TrXDltjWula0=;
        h=Subject:From:To:Cc:Date:From;
        b=MElyhB/oqb/Pd3STg0OfN0zgir97E4Z+KDRcd2b1OXr+ZhEFJPlc4xa/NXw5mqbw4
         xPuBOgvOD8D56Rbi9sgLoq0qDmr35xjtV+gF9r3aQRJvyQeEyewM9Nzpo5xEf/m9YW
         u+Ag5AmYY88WhzrJHF0DQNzltWfYQO1IA59AZgqE=
Subject: [PATCH] PCI/AER: Remove duplicate PCI_EXP_AER_FLAGS definition
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
        Rajat Jain <rajatja@google.com>
Date:   Tue, 31 Jul 2018 17:50:10 -0500
Message-ID: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI_EXP_AER_FLAGS was defined twice (with identical definitions), once
under #ifdef CONFIG_ACPI_APEI, and again at the top level.  This looks like
my merge error from these commits:

  fd3362cb73de ("PCI/AER: Squash aerdrv_core.c into aerdrv.c")
  41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")

Remove the duplicate PCI_EXP_AER_FLAGS definition.

Fixes: 41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2b344c9e2d46..c6cc855bfa22 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -329,8 +329,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
 static bool aer_firmware_first;
 

