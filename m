Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC428C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C06A20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C06A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJHUrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:47:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32963 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJHUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:47:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g9VhW-0002RV-DG; Mon, 08 Oct 2018 13:35:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: aquantia: remove some redundant variable initializations
Date:   Mon,  8 Oct 2018 14:35:58 +0100
Message-Id: <20181008133558.5841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several variables being initialized that are being set later
and hence the initialization is redundant and can be removed. Remove
then.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 750007513f9d..1d5d6b8df855 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -84,7 +84,7 @@ static int aq_pci_probe_get_hw_by_id(struct pci_dev *pdev,
 				     const struct aq_hw_ops **ops,
 				     const struct aq_hw_caps_s **caps)
 {
-	int i = 0;
+	int i;
 
 	if (pdev->vendor != PCI_VENDOR_ID_AQUANTIA)
 		return -EINVAL;
@@ -107,7 +107,7 @@ static int aq_pci_probe_get_hw_by_id(struct pci_dev *pdev,
 
 int aq_pci_func_init(struct pci_dev *pdev)
 {
-	int err = 0;
+	int err;
 
 	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (!err) {
@@ -141,7 +141,7 @@ int aq_pci_func_alloc_irq(struct aq_nic_s *self, unsigned int i,
 			  char *name, void *aq_vec, cpumask_t *affinity_mask)
 {
 	struct pci_dev *pdev = self->pdev;
-	int err = 0;
+	int err;
 
 	if (pdev->msix_enabled || pdev->msi_enabled)
 		err = request_irq(pci_irq_vector(pdev, i), aq_vec_isr, 0,
@@ -164,7 +164,7 @@ int aq_pci_func_alloc_irq(struct aq_nic_s *self, unsigned int i,
 void aq_pci_func_free_irqs(struct aq_nic_s *self)
 {
 	struct pci_dev *pdev = self->pdev;
-	unsigned int i = 0U;
+	unsigned int i;
 
 	for (i = 32U; i--;) {
 		if (!((1U << i) & self->msix_entry_mask))
@@ -194,8 +194,8 @@ static void aq_pci_free_irq_vectors(struct aq_nic_s *self)
 static int aq_pci_probe(struct pci_dev *pdev,
 			const struct pci_device_id *pci_id)
 {
-	struct aq_nic_s *self = NULL;
-	int err = 0;
+	struct aq_nic_s *self;
+	int err;
 	struct net_device *ndev;
 	resource_size_t mmio_pa;
 	u32 bar;
-- 
2.17.1

