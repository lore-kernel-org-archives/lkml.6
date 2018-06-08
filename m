Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lSjMG/Y7GlubKwAAmS7hNA
	; Fri, 08 Jun 2018 08:19:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1B84B607DC; Fri,  8 Jun 2018 08:19:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lA+SjpMP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4BD0960590;
	Fri,  8 Jun 2018 08:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BD0960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeFHITq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:19:46 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:47735 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbeFHITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:36 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AFE861E06A3;
        Fri,  8 Jun 2018 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445973; bh=3erSmJvKPSyjFYr+ikn9jJGFFyX9rzBDXTK0lu5sfF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lA+SjpMPPjQ0kd5exC476ZMWmLryf5i7cvXAC9DUlw2Ny0v9ZjV73qAlavMyz0BYr
         YlXOGvbq5NA1Yiqc786NNZOeooNu7SYjUTJ8WxA90tyIH7gm+swhl4+rZ9Idd99sWV
         LSouievPL3/+IVGWFKXBjc0Q1Z4TrHN06ZO+ZEbCU1qwfINBK9Jp4ug6qJ9ma61OHL
         hxGm97COtiedn6BhWYBYsxqPenD7ULEo5W6iMQQU/UF92ef8Ge+GdBrKcOzOabY9qn
         KKqnGgz92/+Yj4X/SdD+IVgclbp6dzdpM6qwov2hIeb1pXJkTKdEO4nJwW1afINpj1
         N87nYMKTZpOuw==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 91920399F;
        Fri,  8 Jun 2018 01:19:32 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id E93003E91E;
        Fri,  8 Jun 2018 09:19:31 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 03/10] PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
Date: Fri,  8 Jun 2018 09:19:19 +0100
Message-Id:
 <b4eba65e4ae7b8d15a5770a31d6a339de518cea7.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081919.E3eebyoP6HgDE3ktmZkhorL2U0Qjll-1KEtCli9NBNM@z>

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

 drivers/pci/cadence/pcie-cadence-ep.c | 3 ++-
 drivers/pci/dwc/pci-dra7xx.c          | 2 +-
 drivers/pci/dwc/pcie-artpec6.c        | 2 +-
 drivers/pci/endpoint/pci-epc-core.c   | 8 ++++----
 include/linux/pci-epc.h               | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 3d8283e..6b713ca 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -363,7 +363,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f688204..bdf948b 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
 }
 
 static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				 enum pci_epc_irq_type type, u8 interrupt_num)
+				 enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 321b56c..9a2474b 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
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
