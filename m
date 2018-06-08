Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yAeaHak6GltbJAAAmS7hNA
	; Fri, 08 Jun 2018 08:19:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6AD0608BF; Fri,  8 Jun 2018 08:19:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XNAejoGr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26B3F60590;
	Fri,  8 Jun 2018 08:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26B3F60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeFHITn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:19:43 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:47734 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbeFHITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:36 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AE2071E04A3;
        Fri,  8 Jun 2018 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445973; bh=9UCxShg4DFlxwjj5LUgbVXBCIgWFgXp1odYPFCGvQXg=;
        h=From:To:Cc:Subject:Date:From;
        b=XNAejoGrVIHNv1WMTBHi6+eP8duszhuiAdDBH0wjWCAs2Yk+ezPf656eKGjJgMzek
         +NSWEkoZhiJCbBaz0/U/ZtWT496f1ut4QHo1KpBr4sHBOQJCUNKW7ZsEtvW9HOIlCs
         gQyrxT061fck6p/f/z1QcNAjCXAUGo6SoCLHmmP6Qs6wXM1HoBGu7Hg7SRWP8INno0
         OgBPhzgZvC5VTHDr2ua5m7EXnIlqSQTIn8GXXL0asfZVhzCSYOFNGGHkqQe6TKRHze
         nurRcWZtOEluzSkI6ytMdHpQ2KSqDJt/H4Jraqb5S1eWJ8gsi/KeLyB6jxPVrdo7h5
         4irmm/BlvgrMQ==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 694EF59A4;
        Fri,  8 Jun 2018 01:19:32 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id BC42D3E910;
        Fri,  8 Jun 2018 09:19:31 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 00/10] Add MSI-X support on pcitest tool
Date: Fri,  8 Jun 2018 09:19:16 +0100
Message-Id: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081916.shet5YWs71rXWjmz7LAi_RE9BrD5X8PO_8VyhtKuaDc@z>

Patch series made against Lorenzo's branches and also depends of:
 - pci/dwc
 - pci/endpoint

Add MSI-X support on pcitest tool.

Add new callbacks methods and handlers to trigger the MSI-X interrupts
on the EP DesignWare IP driver.

Allow to set/get MSI-X EP maximum capability number.

Rework on set/get and triggering MSI methods on EP DesignWare IP driver.

Add a new input parameter (msix) to pcitest tool to test MSI-X feature.

Update the pcitest.sh script to support MSI-X feature tests.

Gustavo Pimentel (10):
  PCI: endpoint: Add MSI-X interfaces
  PCI: dwc: Add MSI-X callbacks handler
  PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
  PCI: dwc: Rework MSI callbacks handler
  PCI: dwc: Add legacy interrupt callback handler
  pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
  pci-epf-test/pci_endpoint_test: Use irq_type module parameter
  pci-epf-test/pci_endpoint_test: Add MSI-X support
  pci_endpoint_test: Add 2 ioctl commands
  tools: PCI: Add MSI-X support

 Documentation/misc-devices/pci-endpoint-test.txt |   6 +
 drivers/misc/pci_endpoint_test.c                 | 261 +++++++++++++++++------
 drivers/pci/cadence/pcie-cadence-ep.c            |   3 +-
 drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
 drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
 drivers/pci/dwc/pcie-designware-ep.c             | 205 ++++++++++++++++--
 drivers/pci/dwc/pcie-designware-plat.c           |   7 +-
 drivers/pci/dwc/pcie-designware.h                |  31 +--
 drivers/pci/endpoint/functions/pci-epf-test.c    |  81 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
 drivers/pci/endpoint/pci-epc-core.c              |  68 +++++-
 include/linux/pci-epc.h                          |  15 +-
 include/linux/pci-epf.h                          |   1 +
 include/uapi/linux/pcitest.h                     |   3 +
 tools/pci/pcitest.c                              |  51 ++++-
 tools/pci/pcitest.sh                             |  15 ++
 16 files changed, 643 insertions(+), 132 deletions(-)

-- 
2.7.4
