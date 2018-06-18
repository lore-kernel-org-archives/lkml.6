Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D8B208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kx7OJiXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D8B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965331AbeFRPEJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:04:09 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:42207 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964918AbeFRPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:01:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 98D311E04F7;
        Mon, 18 Jun 2018 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529334061; bh=BPUL6tm3QsV4cXmbS1MdxYx6PO+LVGi6PCd9tRsjytE=;
        h=From:To:Cc:Subject:Date:From;
        b=kx7OJiXOQeLBhfwqeLMsbtbov/QLNeH4AFe7lvlBHuaYpzUAttHWWjAKc9ZGYkzCt
         X3sM1hSF5amI07vxooKe8Ok+kPxUAwNnZLwOZh+KFay532uUBv81thPBjEGnrcj9X2
         wJ7l1FVhg9P7Uh2UCF+jC/1YOD4YC67SERsKciUhGdABkb+KvODScrLB2Q+naqtSVs
         S5OjaV7w7dnlyEG/pwhAi7NQy9cIu7nw/opQf7k8ux9hVNMTG/XpR8+GRKlHWtIt6a
         1UipDpjWLOsmlMWq3i5znt9mdwqQe44GjN29PKRiVwWpE1h8SFy5QsF1srKK2yv2MI
         V2ybXkmWQHM8Q==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9AAD35FEA;
        Mon, 18 Jun 2018 08:01:00 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id CD1EA3D73D;
        Mon, 18 Jun 2018 16:00:59 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v4 00/10] Add MSI-X support on pcitest tool
Date:   Mon, 18 Jun 2018 16:00:19 +0100
Message-Id: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series made against Lorenzo's master branch.

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

 Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
 drivers/misc/pci_endpoint_test.c                  | 261 ++++++++++++++++------
 drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware-plat.c |   7 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
 drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c     |  81 +++++--
 drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
 drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
 include/linux/pci-epc.h                           |  15 +-
 include/linux/pci-epf.h                           |   1 +
 include/uapi/linux/pcitest.h                      |   3 +
 tools/pci/pcitest.c                               |  51 ++++-
 tools/pci/pcitest.sh                              |  15 ++
 16 files changed, 643 insertions(+), 132 deletions(-)

-- 
2.7.4


