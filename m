Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E141C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 03:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC25208C4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 03:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU602LFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC25208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeGHDqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 23:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754509AbeGHDqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 23:46:30 -0400
Received: from localhost (157.sub-174-217-21.myvzw.com [174.217.21.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30EB2087C;
        Sun,  8 Jul 2018 03:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531021590;
        bh=nR3YKUaNGyuL6WUmgGio1T9nU5kGtsd/+6SXIKcPsvQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pU602LFEf5Y2tfm2iuhlSyYWsL+7JmVxhxN7kO6MteQUcPk7ORQeoJgkJNKbDhD5I
         tjfy68ip8Qe/7YMkFYNTdcdY5nx/4I7RQDCM3+fwRE9cir2ZcRBjrtiUwmGRm3QVVV
         aNbXCbAVhbYYLG6D2WY+nu1u4GL9ZMC6/9n9Ol0M=
Date:   Sat, 7 Jul 2018 22:46:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180708034627.GA90792@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


PCI fixes:

  - Fix a use-after-free in the endpoint code (Dan Carpenter) 

  - Stop defaulting CONFIG_PCIE_DW_PLAT_HOST to yes (Geert Uytterhoeven)

  - Fix an nfp regression caused by a change in how we limit the number of
    VFs we can enable (Jakub Kicinski)

  - Fix failure path cleanup issues in the new R-Car gen3 PHY support
    (Marek Vasut)

  - Fix leaks of OF nodes in faraday, xilinx-nwl, xilinx (Nicholas
    Mc Guire)


The following changes since commit 925d31668d5b6c9849c50167f31f9b5cf9eec892:

  PCI: controller: Move PCI_DOMAINS selection to arch Kconfig (2018-06-26 15:37:37 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-2

for you to fetch changes up to 83235822b8b4fe47ecbd6b6bcbcc902860ac00fc:

  nfp: stop limiting VFs to 0 (2018-06-29 15:09:00 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-2

----------------------------------------------------------------
Dan Carpenter (1):
      PCI: endpoint: Use after free in pci_epf_unregister_driver()

Geert Uytterhoeven (1):
      PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST default to yes

Jakub Kicinski (2):
      PCI/IOV: Reset total_VFs limit after detaching PF driver
      nfp: stop limiting VFs to 0

Marek Vasut (2):
      PCI: rcar: Shut the PHY down in failpath
      PCI: rcar: Clean up PHY init on failure

Nicholas Mc Guire (3):
      PCI: xilinx: Add missing of_node_put()
      PCI: xilinx-nwl: Add missing of_node_put()
      PCI: faraday: Add missing of_node_put()

 drivers/net/ethernet/netronome/nfp/nfp_main.c |  6 +-----
 drivers/pci/controller/dwc/Kconfig            |  1 -
 drivers/pci/controller/pci-ftpci100.c         |  2 ++
 drivers/pci/controller/pcie-rcar.c            | 16 +++++++++++++---
 drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
 drivers/pci/controller/pcie-xilinx.c          |  1 +
 drivers/pci/endpoint/pci-epf-core.c           |  4 ++--
 drivers/pci/iov.c                             | 16 ++++++++++++++++
 drivers/pci/pci-driver.c                      |  1 +
 drivers/pci/pci.h                             |  4 ++++
 10 files changed, 41 insertions(+), 12 deletions(-)
