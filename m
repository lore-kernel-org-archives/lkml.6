Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C341A27EFE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfug1g4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C341A27EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeF2Mkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754380AbeF2Mkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:40:31 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11FA527EF4;
        Fri, 29 Jun 2018 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530276031;
        bh=ODIXJWDtsNwp8pbLYT8Cn7KCN5G67yoXqJAPQiuLFZM=;
        h=Date:From:To:Cc:Subject:From;
        b=Xfug1g4Hl49BiLiE01p+2om0xhOW/AdrIvCF9UJ22TDA97lHacdBkW2EA5IZy+fRh
         dD/eUOt5QwdOHAlAKfvJpfq+TeRwSwPnY92lPJmav9J2YHfKpSTKAZyKoq0B9HgwZj
         gripzKn57yi917Z+yKt9LqFydlf/jvnyqIJPWG94=
Date:   Fri, 29 Jun 2018 07:40:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alan Douglas <adouglas@cadence.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180629124029.GA96021@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Fix crash caused by endpoint library initialization order change (Alan
    Douglas)

  - Fix shpchp NULL pointer dereference regression on non-ACPI platforms
    (Bjorn Helgaas)

  - Move PCI_DOMAINS selection to fix build regression (Lorenzo Pieralisi)


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-1

for you to fetch changes up to 925d31668d5b6c9849c50167f31f9b5cf9eec892:

  PCI: controller: Move PCI_DOMAINS selection to arch Kconfig (2018-06-26 15:37:37 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-1

----------------------------------------------------------------
Alan Douglas (1):
      PCI: Initialize endpoint library before controllers

Bjorn Helgaas (1):
      PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems

Lorenzo Pieralisi (1):
      PCI: controller: Move PCI_DOMAINS selection to arch Kconfig

 arch/arm/Kconfig                 |  8 +++++++-
 arch/arm/mach-bcm/Kconfig        |  1 +
 arch/arm/mach-socfpga/Kconfig    |  1 +
 drivers/pci/Makefile             |  6 +++---
 drivers/pci/controller/Kconfig   |  3 ---
 drivers/pci/hotplug/acpi_pcihp.c | 10 +++++++++-
 6 files changed, 21 insertions(+), 8 deletions(-)
