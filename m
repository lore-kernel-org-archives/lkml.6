Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E9F20852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ggM7fPPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E9F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQKDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:03:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59861 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:03:17 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B7E8624E1393;
        Tue, 17 Jul 2018 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531819896; bh=xWay15+tMZ5QoUFyv+vu3iYt+QFjUiCzSfdbhpG7rXk=;
        h=From:To:Cc:Subject:Date:From;
        b=ggM7fPPFwd5L41vkihdJWxac+LD00TbKBXA2jRfBKJkbTcLywPJFlFKyTvUpMGdty
         FZP7IAb+2MRN9k4O5Mn3QKrjWesjlXwRfJ0Vo1+bWD9zycQS03oDhYtJB9Ak8KLXnp
         +ugRfY2ZnWPKWB4+Cg7s/G/7vzoERwCwrcwqTA8GDdCaBwJ4pbmWoO/Yyu8cW+jU37
         tuTQt6MBr3rgPHUG7WYVxe4BR04uDMYccxmI1XaAMEeD8sqbCLLCvk92Lr0kyNfSpV
         wKF//6y1M4LjagrT3GRtZ1PhfSFKP4ZPocwSfOm/SX+1jcyOeuEcl3f5ffasW5vjYH
         dH6k/iWEeVTDw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id CBF143F5F;
        Tue, 17 Jul 2018 02:31:34 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B16813BBE8;
        Tue, 17 Jul 2018 11:31:33 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v12 00/12] Add MSI-X support on pcitest tool
Date:   Tue, 17 Jul 2018 11:31:20 +0200
Message-Id: <cover.1531818979.git.gustavo.pimentel@synopsys.com>
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

Update related documentation accordingly.

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

 .../PCI/endpoint/function/binding/pci-test.txt     |   2 +
 Documentation/PCI/endpoint/pci-endpoint.txt        |   4 +-
 Documentation/PCI/endpoint/pci-test-function.txt   |  29 ++-
 Documentation/PCI/endpoint/pci-test-howto.txt      |  30 ++-
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/misc-devices/pci-endpoint-test.txt   |   6 +
 drivers/misc/pci_endpoint_test.c                   | 276 ++++++++++++++++-----
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 210 ++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  29 ++-
 drivers/pci/controller/pcie-cadence-ep.c           |   3 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  86 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                  |  24 ++
 drivers/pci/endpoint/pci-epc-core.c                |  68 ++++-
 include/linux/pci-epc.h                            |  16 +-
 include/linux/pci-epf.h                            |   1 +
 include/uapi/linux/pcitest.h                       |   3 +
 tools/pci/pcitest.c                                |  51 +++-
 tools/pci/pcitest.sh                               |  15 ++
 22 files changed, 722 insertions(+), 149 deletions(-)

-- 
2.7.4

