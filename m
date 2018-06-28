Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6621C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7932A2788B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gu5tn+RI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ijYzMRBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7932A2788B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935582AbeF1Tb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:31:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934767AbeF1Tbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:31:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9A69606DD; Thu, 28 Jun 2018 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214311;
        bh=uYhO8Bjg7DjWDoy7J+AbsxsKpB+vMBY6Sus+ktBHeag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu5tn+RI99JRHtaF2Ngw+8x+Q6/dERQ9/bJQOEjOYoYG2eHbgHSeLOK8lfq/4DF0I
         wPav8eWA+iDIL0yx8DUgflALhrd+2N4n+los7DKqxEscEbhl9q1/rlVgjhAcGxNHvO
         DlIfxDzY0hWasVQ6nsx0wh2eJ7eqpBZdaiGijduE=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9C1560C62;
        Thu, 28 Jun 2018 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214301;
        bh=uYhO8Bjg7DjWDoy7J+AbsxsKpB+vMBY6Sus+ktBHeag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijYzMRBtdT5uAFXQYYPb/OUxuSL31xnTD98JwDt4aKew6FHzk5zu8JTZxz2cjJ6Ao
         7QNvasbOpsaI5GzVU03ttDRMOLa8/zBbS6w35HNw7jkitUV24moHB5UDFGatNLLOC5
         +hnSE3qLZoR3/wN5e6SNWyRubgOWzOOSeevdxBtc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9C1560C62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list),
        kvm@vger.kernel.org (open list:VFIO DRIVER)
Subject: [PATCH V4 6/7] PCI: Rename pci_try_reset_bus() to pci_reset_bus()
Date:   Thu, 28 Jun 2018 15:31:04 -0400
Message-Id: <1530214274-21139-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the old implementation of pci_reset_bus() is gone, replace
pci_try_reset_bus() with pci_reset_bus().

Compared to the old implementation, new code will fail immmediately with
-EAGAIN if object lock cannot be obtained.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c |  2 +-
 drivers/pci/pci.c                 | 18 +++++++++---------
 drivers/vfio/pci/vfio_pci.c       |  4 ++--
 include/linux/pci.h               |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index df4f2d3..baf7c32 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	return pci_try_reset_bus(dev);
+	return pci_reset_bus(dev);
 }
 
 /*
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6cec722..28a071d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4784,7 +4784,7 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
 /**
- * __pci_try_reset_slot - Try to reset a PCI slot
+ * __pci_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *`
  * A PCI bus may host multiple slots, each slot may support a reset mechanism
@@ -4798,7 +4798,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-static int __pci_try_reset_slot(struct pci_slot *slot)
+static int __pci_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
@@ -4854,12 +4854,12 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
 /**
- * __pci_try_reset_bus - Try to reset a PCI bus
+ * __pci_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int __pci_try_reset_bus(struct pci_bus *bus)
+static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
@@ -4882,22 +4882,22 @@ static int __pci_try_reset_bus(struct pci_bus *bus)
 }
 
 /**
- * pci_try_reset_bus - Try to reset a PCI bus
+ * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_try_reset_bus(struct pci_dev *pdev)
+int pci_reset_bus(struct pci_dev *pdev)
 {
 	bool slot = false;
 
 	if (!pci_probe_reset_slot(pdev->slot))
 		slot = true;
 
-	return slot ? __pci_try_reset_slot(pdev->slot) :
-			__pci_try_reset_bus(pdev->bus);
+	return slot ? __pci_reset_slot(pdev->slot) :
+			__pci_reset_bus(pdev->bus);
 }
-EXPORT_SYMBOL_GPL(pci_try_reset_bus);
+EXPORT_SYMBOL_GPL(pci_reset_bus);
 
 /**
  * pcix_get_max_mmrbc - get PCI-X maximum designed memory read byte count
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 71018ec..345c0dc 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1010,7 +1010,7 @@ static long vfio_pci_ioctl(void *device_data,
 						    &info, slot);
 		if (!ret)
 			/* User has access, do the reset */
-			ret = pci_try_reset_bus(vdev->pdev);
+			ret = pci_reset_bus(vdev->pdev);
 
 hot_reset_release:
 		for (i--; i >= 0; i--)
@@ -1372,7 +1372,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 	}
 
 	if (needs_reset)
-		ret = pci_try_reset_bus(vdev->pdev);
+		ret = pci_reset_bus(vdev->pdev);
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ad0c89a..79a2c27 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1096,7 +1096,7 @@ int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_try_reset_bus(struct pci_dev *dev);
+int pci_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.7.4

