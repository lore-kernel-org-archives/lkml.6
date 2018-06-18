Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB40C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A564208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S1Cv6AEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A564208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeFRPBH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:01:07 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:42208 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964919AbeFRPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:01:03 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9FA2C1E133D;
        Mon, 18 Jun 2018 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529334061; bh=yw6NYWKFFO8V2fhh14Gb4khhkGZLMH2cffQzzkNV59o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=S1Cv6AEiq7GAM5ZbB9T6mH4nuh3j5+I9mvcJsPvus1vNdwA988nG6EYTNd8uun265
         6BmY+L8O2qUL6x4OYAm4bnf4umpVe61ECa9L8MfYH+LAhoBVKS67y4i5uCRvnW4tLj
         nFF+A//ZvLqpkiAMcOwJjAsOz3k7htBuVPhCP0JacSqcaGbN3QoAWRrQQEuPrnJ3o0
         TrJ4lHVkojCXdVQEIhYzbvidu1Q/3Iq3R3Xhoe0kUA9fmLvqMHGkgnjrqh7SN+ELNO
         Lsjm15IWwn0ZGuA+G10oYge8lVBZw568q91weTPG292DIcNW7hlKG+MSS1SldxA3Ks
         5QTGQ+9cSgO4Q==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id BFF833682;
        Mon, 18 Jun 2018 08:01:00 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 249533D752;
        Mon, 18 Jun 2018 16:01:00 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v4 03/10] PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
Date:   Mon, 18 Jun 2018 16:00:22 +0100
Message-Id: <5bfa0cf053878e0e859a8b97227ca03ea4d50e92.1529329262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change {cdns, dra7xx, artpec6}_pcie_ep_raise_irq() and pci_epc_raise_irq()
signature, namely the interrupt_num variable type from u8 to u16 to
accommodate 2048 maximum MSI-X interrupts.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Move into here the pci_epc_raise_irq() signature change from patch
file #1.
 - Move into here the {dra7xx, artpec6}_pcie_ep_raise_irq() signature
changes from patch file #2.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.

 drivers/pci/controller/dwc/pci-dra7xx.c   | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c | 2 +-
 drivers/pci/controller/pcie-cadence-ep.c  | 3 ++-
 drivers/pci/endpoint/pci-epc-core.c       | 8 ++++----
 include/linux/pci-epc.h                   | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 345aab5..ce9224a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
 }
 
 static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				 enum pci_epc_irq_type type, u8 interrupt_num)
+				 enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 321b56c..9a2474b 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index e3fe412..208d11f 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -363,7 +363,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7d77bd0..c72e656 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -131,13 +131,13 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * pci_epc_raise_irq() - interrupt the host system
  * @epc: the EPC device which has to interrupt the host
  * @func_no: the endpoint function number in the EPC device
- * @type: specify the type of interrupt; legacy or MSI
- * @interrupt_num: the MSI interrupt number
+ * @type: specify the type of interrupt; legacy, MSI or MSI-X
+ * @interrupt_num: the MSI or MSI-X interrupt number
  *
- * Invoke to raise an MSI or legacy interrupt
+ * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
-		      enum pci_epc_irq_type type, u8 interrupt_num)
+		      enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	int ret;
 	unsigned long flags;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 89f079f..bb2395b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -35,7 +35,7 @@ enum pci_epc_irq_type {
  *	     MSI-X capability register
  * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
  *	     from the MSI-X capability register
- * @raise_irq: ops to raise a legacy or MSI interrupt
+ * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @owner: the module owner containing the ops
@@ -56,7 +56,7 @@ struct pci_epc_ops {
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
-			     enum pci_epc_irq_type type, u8 interrupt_num);
+			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	struct module *owner;
@@ -154,7 +154,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
-		      enum pci_epc_irq_type type, u8 interrupt_num);
+		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 struct pci_epc *pci_epc_get(const char *epc_name);
-- 
2.7.4


