Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D903ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8EB20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDkjnVDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8EB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeGWVEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:04:15 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44147 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeGWVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:04:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so3365168oih.11;
        Mon, 23 Jul 2018 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQLG0mNyRfCdnJvs632GE/CPpAlUSOPE8hbK+IFSBCo=;
        b=GDkjnVDS6nk5CXmRAXEtHUl8Lspxnfl+LpnmAmznsRSiP8whibRlfQwyMBl0ISTnp+
         rd4j3J21Bm6xT64SHmUbemtFfSKiC+Gn01OjuVt2ZrPsZA9AIjMw1qla9MbMDy7pC2mg
         K5EaQH71ktGTrjv8qU034cRJPAZ0Mom/vrjQdWcBYAA+8Z75XJpILIKLR6OUkLeLF7sy
         eFyAghWOmWUHRk2eJrqEDZCKCzE/1LYTeGs1QL68jpob+RXjzZp7Bc6k2MdahXfXASn0
         az7ZHAC+dOis2ApJlodjlYKMsRZU1Ebxa+R/ebF4yDDx03vGuBh7EsaVGqKDDpnd832i
         NJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQLG0mNyRfCdnJvs632GE/CPpAlUSOPE8hbK+IFSBCo=;
        b=L4SIYJd1gfJkVIEBQppCyY1UDfpybl9r4saMbrjqB+tDueGknUEvhH3Q8Od9EV09Kx
         ZI1REsz5wc6wh3URMW6nX77RzRO0eZ6r+zxhpsxKGbXD0arQtazmI8LD2WLglr6yILoT
         cQ0quqK/Cu60aoFvjENgc/EqZOzJL2/U0G9NmF3yieFv/516wEeDgtzpbfVYsQUywAU4
         1URHs7Y79wMPuGtHzfCeOWnvLWfi05aPJLSe4oCki6MP65GcIiKL7SgWGv9STw0trbBC
         gsyZWPZL83QRK1m4jjYzscygHdLMeuRaCfxyFhKUIqJyFZXLN+71OfsC5Ly2vXsBC4rG
         8Ssg==
X-Gm-Message-State: AOUpUlHG8KZcbAgL83/lX8rM8J1MqA0YnAXYXyu+p/CcXgSNLZ3OEj4+
        xm7EwwpAlci8v2Qk1twvLc4gxeLo8u0=
X-Google-Smtp-Source: AAOMgpcMGKADQMoa0WRXhiLmLzZVZzDoLbyynnuLJoWJ82QABX47VPXxsBaZWGyZJtLicZ+alh6tzQ==
X-Received: by 2002:aca:2c83:: with SMTP id s125-v6mr238042ois.103.1532376088012;
        Mon, 23 Jul 2018 13:01:28 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id x126-v6sm4926495oig.15.2018.07.23.13.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:01:26 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        jeffrey.t.kirsher@intel.com, ariel.elior@cavium.com,
        michael.chan@broadcom.com, ganeshgr@chelsio.com,
        tariqt@mellanox.com, jakub.kicinski@netronome.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        mike.marciniszyn@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Do not clear AER bits if we don't own AER
Date:   Mon, 23 Jul 2018 15:01:08 -0500
Message-Id: <20180723200118.23657-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we don't own AER, we shouldn't touch the AER error bits. Clearing
error bits willy-nilly might cause firmware to miss some errors. In
theory, these bits get cleared by FFS, or via ACPI _HPX method. These
mechanisms are not subject to the problem.

This race is mostly of theoretical significance, since I can't
reasonably demonstrate this race in the lab.

On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
need for two checks: aer_cap and get_firmware_first().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..85c3e173c025 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+
+static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
+{
+	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
+}
+
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
-	if (!dev->aer_cap)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
@@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = dev->aer_cap;
-	if (!pos)
+	if (pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
+	pos = dev->aer_cap;
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
-- 
2.17.1

