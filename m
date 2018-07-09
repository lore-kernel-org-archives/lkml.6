Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF561208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OqtFUlxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF561208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeGIRnB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:43:01 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:56668 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeGIRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:42:56 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8239E10C010B;
        Mon,  9 Jul 2018 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531158176; bh=kvBNnqNM59xrzxtw8ECplzPvApG8RH7KDd3DtLWL4Tw=;
        h=From:To:Cc:Subject:Date:From;
        b=OqtFUlxkHGebclBT00mx/Xb8/q/DWWHLm5Y2VzDij83qmAYVecOuvH8BwSuvTLqe1
         sikzQgNGQk0C6SD3RCZK3x0N+HPBEJ4u16M5aH8dJWHpMcbRQMzMuTMJBK5XnaZ3d/
         VLB/CGofEI1mLQ40j0TBE1Uh+NZC5uwuN5CltIWCBE+sKVwRUBTp959mlsiXU0l1GD
         ybPa7V+D/5ZJhOSDWBZlaxXzrl7IidT3UAjBA5KGNAezV4o3v7N8/zu3NDSlcvf9CR
         YI0sbX8M6Xc8V/MFIjQI8yrb1Hwoe/V+66OSqknMh+csUXMLRgFaoSRRXAkokYAgwd
         t4aDzuHfloNug==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id EFF4F36E6;
        Mon,  9 Jul 2018 10:42:55 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 4FB583ED86;
        Mon,  9 Jul 2018 18:42:55 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v9 00/12] Add MSI-X support on pcitest tool
Date:   Mon,  9 Jul 2018 18:42:38 +0100
Message-Id: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series made against Lorenzo's master branch.

Fix EP link notification implementation.

Add MSI-X support on pcitest tool.

Add new callbacks methods and handlers to trigger the MSI-X interrupts
on the EP DesignWare IP driver.

Allow to set/get MSI-X EP maximum capability number.

Rework on set/get and triggering MSI methods on EP DesignWare IP driver.

Add a new input parameter (msix) to pcitest tool to test MSI-X feature.

Update the pcitest.sh script to support MSI-X feature tests.

Gustavo Pimentel (12):
  PCI: dwc: Fix EP link notification implementation
  PCI: endpoint: Add MSI-X interfaces
  PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
  PCI: dwc: Add MSI-X callbacks handler
  PCI: dwc: Rework MSI callbacks handler
  PCI: dwc: Add legacy interrupt callback handler
  pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
  pci-epf-test/pci_endpoint_test: Use irq_type module parameter
  pci-epf-test/pci_endpoint_test: Add MSI-X support
  pci_endpoint_test: Add 2 ioctl commands
  tools: PCI: Add MSI-X support
  PCI: endpoint: Add MSI set maximum restriction

 Documentation/PCI/endpoint/pci-test-function.txt  |   8 +-
 Documentation/ioctl/ioctl-number.txt              |   1 +
 Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
 drivers/misc/pci_endpoint_test.c                  | 260 ++++++++++++++++------
 drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 217 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
 drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
 drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c     |  86 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
 drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
 include/linux/pci-epc.h                           |  16 +-
 include/linux/pci-epf.h                           |   1 +
 include/uapi/linux/pcitest.h                      |   3 +
 tools/pci/pcitest.c                               |  51 ++++-
 tools/pci/pcitest.sh                              |  15 ++
 19 files changed, 664 insertions(+), 143 deletions(-)

-- 
2.7.4


