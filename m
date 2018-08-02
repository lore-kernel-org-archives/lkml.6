Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8890C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42212151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDB419Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42212151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbeHBQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbeHBQTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F5A21501;
        Thu,  2 Aug 2018 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533220092;
        bh=Hv5Vu9a5v/kJE5LPOtwewikMmMb0q+JjRGnFv7mTJSc=;
        h=Date:From:To:Cc:Subject:From;
        b=SDB419Q42/UnFVGCZ8XO9YYEnu59tEBwVDbiv2nQ1B5gTpqsuE7JdWBBna0Wd1ZDA
         z8QNBQa9hNGDHEYXjpLKwr4EQZK6XTOYfZHqujlD6LiQ6gOHQTe1j2CVhgMgpZPEn+
         gjqlpnVSDhdPXx4KzMCFLH6iizRjVN/HjubDNRG8=
Date:   Thu, 2 Aug 2018 09:28:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hari Vyas <hari.vyas@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180802142811.GA6155@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Fix integer overflow in new mobiveil driver (Dan Carpenter)

  - Fix race during NVMe removal/rescan (Hari Vyas)


The following changes since commit bd91b56cb3b27492963caeb5fccefe20a986ca8d:

  PCI/AER: Work around use-after-free in pcie_do_fatal_recovery() (2018-07-26 12:13:04 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-5

for you to fetch changes up to 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76:

  PCI: Fix is_added/is_busmaster race condition (2018-07-31 11:27:54 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-5

----------------------------------------------------------------
Dan Carpenter (1):
      PCI: mobiveil: Avoid integer overflow in IB_WIN_SIZE

Hari Vyas (1):
      PCI: Fix is_added/is_busmaster race condition

 arch/powerpc/kernel/pci-common.c          |  4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
 arch/powerpc/platforms/pseries/setup.c    |  3 ++-
 drivers/pci/bus.c                         |  6 +++---
 drivers/pci/controller/pcie-mobiveil.c    |  2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/pci.h                         | 11 +++++++++++
 drivers/pci/probe.c                       |  4 ++--
 drivers/pci/remove.c                      |  5 +++--
 include/linux/pci.h                       |  1 -
 10 files changed, 28 insertions(+), 13 deletions(-)
