Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9AC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D2B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZTGI6Mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D2B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeIMIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeIMIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:39:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106662133F;
        Thu, 13 Sep 2018 03:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536809509;
        bh=w0s+GdFesNgF4FtBnELA0ZL23KZ4/gDMCj2PhRIn0T4=;
        h=Date:From:To:Cc:Subject:From;
        b=pZTGI6MwKbbJl007hVFQPRa24lCYJ2Yg1gzhD6XX4iTgL5pepXozVIv+N981FiK+S
         TVXP+0zoHth6BDjUPKLkdQVhPF13HzJnJG909MenqgeLTi7Am/bnOfvR0nl8vMB91M
         ZTi+bSI13o/9zSys1vl0CBs0oW6ZbtMn0MpKSFgo=
Date:   Wed, 12 Sep 2018 22:31:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [GIT PULL] PCI fixes for v4.19
Message-ID: <20180913033147.GA73412@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Add Tyrel Datwyler as maintainer for PPC64 RPA hotplug (Tyrel Datwyler)

  - Add Gustavo Pimentel as DesignWare PCI maintainer (Joao Pinto)

  - Fix a Switchtec Spectre v1 vulnerability (Gustavo A. R. Silva)

  - Revert an unnecessary Intel 300 ACS quirk (Mika Westerberg)

  - Fix pciehp hot-add/powerfault detection that left indicators in wrong
    state (Keith Busch)

  - Fix pci_reset_bus() logic error (Dennis Dalessandro)

  - Revert IB/hfi1 PCI reset change that caused a deadlock (Dennis
    Dalessandro)

  - Allow enabling PASID on Root Complex Integrated Endpoints (Felix
    Kuehling)


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-fixes-1

for you to fetch changes up to 9d27e39d309c93025ae6aa97236af15bef2a5f1f:

  PCI: Fix enabling of PASID on RC integrated endpoints (2018-09-11 21:46:49 -0500)

----------------------------------------------------------------
pci-v4.19-fixes-1

----------------------------------------------------------------
Dennis Dalessandro (2):
      PCI: Fix faulty logic in pci_reset_bus()
      IB/hfi1,PCI: Allow bus reset while probing

Felix Kuehling (1):
      PCI: Fix enabling of PASID on RC integrated endpoints

Gustavo A. R. Silva (1):
      switchtec: Fix Spectre v1 vulnerability

Joao Pinto (1):
      MAINTAINERS: Add Gustavo Pimentel as DesignWare PCI maintainer

Keith Busch (1):
      PCI: pciehp: Fix hot-add vs powerfault detection order

Mika Westerberg (1):
      Revert "PCI: Add ACS quirk for Intel 300 series"

Tyrel Datwyler (1):
      MAINTAINERS: Add entries for PPC64 RPA PCI hotplug drivers

 MAINTAINERS                       | 16 +++++++++++++++-
 drivers/infiniband/hw/hfi1/pcie.c | 11 ++++-------
 drivers/pci/hotplug/pciehp_hpc.c  | 18 +++++++++---------
 drivers/pci/pci.c                 |  3 ++-
 drivers/pci/probe.c               |  5 ++++-
 drivers/pci/quirks.c              |  6 ------
 drivers/pci/switch/switchtec.c    |  4 ++++
 include/linux/pci.h               |  3 +++
 8 files changed, 41 insertions(+), 25 deletions(-)
