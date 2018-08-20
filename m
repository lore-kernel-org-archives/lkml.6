Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C199C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1E021570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1E021570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHTNCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:02:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:02:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94B6580D;
        Mon, 20 Aug 2018 02:47:36 -0700 (PDT)
Received: from e107981-ln.Emea.Arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDFA3F2EA;
        Mon, 20 Aug 2018 02:47:35 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource() comment
Date:   Mon, 20 Aug 2018 10:47:29 +0100
Message-Id: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
Bridge IP driver")

and

commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()")

first patched then removed pcibios_align_resource() from the microblaze
architecture code but failed to remove the comment that was added to
it.

Remove it since it has now become stale and it is quite confusing.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/pci/pci-common.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index f34346d56095..2ffd171af8b6 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
 
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- *
- * Why? Because some silly external IO cards only decode
- * the low 10 bits of the IO address. The 0x00-0xff region
- * is reserved for motherboard devices that decode all 16
- * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
- * but we want to try to avoid allocating at 0x2900-0x2bff
- * which might have be mirrored at 0x0100-0x03ff..
- */
 int pcibios_add_device(struct pci_dev *dev)
 {
 	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-- 
2.15.0

