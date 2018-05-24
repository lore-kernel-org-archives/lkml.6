Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160659-2-11688169400534159568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160659; b=Mygwbm0aoF7pLDsN03U+Q+KiIZ3wlq31uMopEHvC0/0W0vCwL6
    wu/LTNDroUiFMi9m0acpgP6lbfGqlXGgemz1ViE5fE57r3fNyA/PoWB8IlFT3nN6
    GwcR6Wf2vXSrXA6zCsLqhaaiKAPs/Lb7lp1VOd9l6buktU58bJXcVTxXf4W9ZcLm
    ikR1830DTxHUnJEmFXBhSjHnAM2WKlBC6XgTRxhJf0RYS9O+JgDrerRcvoMyFcYG
    V/PanBRbHc22AoMn5HalFVRdb6rTUCXV9tYQMrxNN5AmPP3XeM4u6i5Kj4chhz19
    uWBLm146VM/aPLDe0qfP+kSQjP0KnUFwycpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160659; bh=PWFFlgr4aLPU7ZdR9bhUYlet+oBMoy
    S3bUxsNlI8NFY=; b=eKnDK8uAEG5xFFkRSbwzHDh4BgV3suA+Qw1Rz7agApZ48e
    ObBK2OBWGTCRtkK+y14EUmZmAePH16ZXsPixBHe1QMJ3DnslROGNe+yqzuHwBtrl
    D/EflJkNyVIMxCiE4EeWtf6t/eQQ5bs2wV3vWiR7jXanxLbjMk6jtwpLhPb7OrDS
    8AW95RieVsgSLb0qBJ7K3kma8wEIkZuMakmsLyLeNpPneWA0iA9nV2uu2JF3XtNm
    jfn8a5BG/sw8bBtBD1X6mNZbbKTHPNUSpC4l5t6StQZuUrPPdgIllF4AEKp0bFfO
    kqed0uW2k/cKHwqnh1WA6xwSzdkNmj5mSe89uWSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hIkoHJgg x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hIkoHJgg x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCQO9VhghVy34aqhUbGTdKaupg48fVUpPVdXo2EC8iU8IpjjlXhjosmysFm8cpDYB7aq887l4fx4tgd9JrGqrxZce52PRHoVRuKJ9ZnkLZo8oJ7jqiSa
    Ugr7BQK5otd8oBH1WgMU7mjLjj8cRRaml+v2pyhwCBmuIM7zszARiRWI86giJYhybKcZNhRZrvYp8yY3A/0CVGsgpp4c5+svj8YZe+b4aqQH/2ZFRe+d72Xm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=eh1Yez-EAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=puV817wOSPHiP_ARZ7gA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968011AbeEXJxQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967476AbeEXJxK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Regis Duchesne <hpreg@vmware.com>,
        Ronak Doshi <doshir@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 010/165] vmxnet3: set the DMA mask before the first DMA map operation
Date: Thu, 24 May 2018 11:36:56 +0200
Message-Id: <20180524093622.386349307@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "hpreg@vmware.com" <hpreg@vmware.com>

[ Upstream commit 61aeecea40afb2b89933e27cd4adb10fc2e75cfd ]

The DMA mask must be set before, not after, the first DMA map operation, or
the first DMA map operation could in theory fail on some systems.

Fixes: b0eb57cb97e78 ("VMXNET3: Add support for virtual IOMMU")
Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |   50 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2675,7 +2675,7 @@ vmxnet3_set_mac_addr(struct net_device *
 /* ==================== initialization and cleanup routines ============ */
 
 static int
-vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
+vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter)
 {
 	int err;
 	unsigned long mmio_start, mmio_len;
@@ -2687,30 +2687,12 @@ vmxnet3_alloc_pci_resources(struct vmxne
 		return err;
 	}
 
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_consistent_dma_mask failed\n");
-			err = -EIO;
-			goto err_set_mask;
-		}
-		*dma64 = true;
-	} else {
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_dma_mask failed\n");
-			err = -EIO;
-			goto err_set_mask;
-		}
-		*dma64 = false;
-	}
-
 	err = pci_request_selected_regions(pdev, (1 << 2) - 1,
 					   vmxnet3_driver_name);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to request region for adapter: error %d\n", err);
-		goto err_set_mask;
+		goto err_enable_device;
 	}
 
 	pci_set_master(pdev);
@@ -2738,7 +2720,7 @@ err_bar1:
 	iounmap(adapter->hw_addr0);
 err_ioremap:
 	pci_release_selected_regions(pdev, (1 << 2) - 1);
-err_set_mask:
+err_enable_device:
 	pci_disable_device(pdev);
 	return err;
 }
@@ -3243,7 +3225,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 #endif
 	};
 	int err;
-	bool dma64 = false; /* stupid gcc */
+	bool dma64;
 	u32 ver;
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
@@ -3289,6 +3271,24 @@ vmxnet3_probe_device(struct pci_dev *pde
 	adapter->rx_ring_size = VMXNET3_DEF_RX_RING_SIZE;
 	adapter->rx_ring2_size = VMXNET3_DEF_RX_RING2_SIZE;
 
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
+		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
+			dev_err(&pdev->dev,
+				"pci_set_consistent_dma_mask failed\n");
+			err = -EIO;
+			goto err_set_mask;
+		}
+		dma64 = true;
+	} else {
+		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
+			dev_err(&pdev->dev,
+				"pci_set_dma_mask failed\n");
+			err = -EIO;
+			goto err_set_mask;
+		}
+		dma64 = false;
+	}
+
 	spin_lock_init(&adapter->cmd_lock);
 	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
 					     sizeof(struct vmxnet3_adapter),
@@ -3296,7 +3296,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
 		dev_err(&pdev->dev, "Failed to map dma\n");
 		err = -EFAULT;
-		goto err_dma_map;
+		goto err_set_mask;
 	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
@@ -3347,7 +3347,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 	}
 #endif /* VMXNET3_RSS */
 
-	err = vmxnet3_alloc_pci_resources(adapter, &dma64);
+	err = vmxnet3_alloc_pci_resources(adapter);
 	if (err < 0)
 		goto err_alloc_pci;
 
@@ -3493,7 +3493,7 @@ err_alloc_queue_desc:
 err_alloc_shared:
 	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
 			 sizeof(struct vmxnet3_adapter), PCI_DMA_TODEVICE);
-err_dma_map:
+err_set_mask:
 	free_netdev(netdev);
 	return err;
 }
