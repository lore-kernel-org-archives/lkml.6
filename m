Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeEQRV4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:21:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42964 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:21:52 -0400
X-Google-Smtp-Source: AB8JxZo01MJ1GI3Gj3y7meYgZDXGMT9MMQA2DWyLg64IHlyVeoplvgakTmrMbaxUvSRlIwQGQV6hPQ==
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH INTERNAL 1/3] PCI: iproc: Activate PAXC bridge quirk for more devices
Date: Thu, 17 May 2018 10:21:30 -0700
Message-Id: <1526577692-21104-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate PAXC bridge quirk for more PAXC based PCIe root complex with
the following PCIe device ID:
0xd750, 0xd802, 0xd804

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1..47dfea0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
 #endif
 
 /* Originally in EDAC sources for i82875P:
-- 
2.1.4
