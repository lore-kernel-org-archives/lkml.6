Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AF620862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RJ08DMUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AF620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeGSJO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:14:28 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57216 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeGSJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:14:27 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BC8A124E1346;
        Thu, 19 Jul 2018 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531989145; bh=PjYTxCNqqGpb85g/xsGmYlBj1TTfA2pQMlR3Q0wM7PY=;
        h=From:To:Cc:Subject:Date:From;
        b=RJ08DMUszTfsICaxNuEWD9bKjREy7ITBQF9qBSAn6h1XX+0RGCtQbdKpCHjJujH9Q
         dGCBX4kNLx4mMI5v3o7RJ/XAbeb3RlQCeM9EzTyrNPqKDfHqcgc7A4IC1Eo6XPjFdy
         64HIXIuxKTXEtWxPza7hhUh0UtvfLk2hqCNTFDsWcXHsaSD3Sc7kEl6JsQ0NWkgqFo
         15KK9IkQm/zt+kW8rV0FNQFv2YUHw/4rr/i1hCY4ZPTHjmo6w2JBoWpaD7miqBFIWM
         9qCu8TCsQGmN2OMQyTGJH9Z9iDFGxZV4plRKGErqNY5Q31IJ32ua/THl7UUsOk0Nk4
         +bqNrg87k+saA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5ED253E5C;
        Thu, 19 Jul 2018 01:32:25 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id DAE137BB1;
        Thu, 19 Jul 2018 10:32:23 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v14 00/12] Add MSI-X support on pcitest tool
Date:   Thu, 19 Jul 2018 10:32:10 +0200
Message-Id: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
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
 drivers/misc/pci_endpoint_test.c                   | 290 ++++++++++++++++-----
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 210 +++++++++++++--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  29 ++-
 drivers/pci/controller/pcie-cadence-ep.c           |   3 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  86 ++++--
 drivers/pci/endpoint/pci-ep-cfs.c                  |  24 ++
 drivers/pci/endpoint/pci-epc-core.c                |  68 ++++-
 include/linux/pci-epc.h                            |  16 +-
 include/linux/pci-epf.h                            |   1 +
 include/uapi/linux/pcitest.h                       |   3 +
 tools/pci/pcitest.c                                |  51 +++-
 tools/pci/pcitest.sh                               |  15 ++
 22 files changed, 735 insertions(+), 150 deletions(-)

-- 
2.7.4

