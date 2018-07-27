Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D70C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE4208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L63F86NW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CE4208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeG0Slu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbeG0Slu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:41:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9833208AF;
        Fri, 27 Jul 2018 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532711940;
        bh=4EIsl+VyEOlUlyOkIWdoECd/oAKtLMnmoARgn8nj6dY=;
        h=Date:From:To:Cc:Subject:From;
        b=L63F86NWpoz/wluyldXMAIuTrAN6TnOLC+yNQS81mVxsXso7vAyBg5snXd7APaEbq
         QQTyR/w0+rpRcnGZjze9cfVfl6z8qGSIglr+oOrAknIChDDxPnIKbaH0HmVN7ZTwGq
         z43keBlPcDvOIC/weD6WQxcfJHUl0CgZzvbIELzw=
Date:   Fri, 27 Jul 2018 12:18:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Tai <thomas.tai@oracle.com>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180727171858.GA16743@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Fix a use-after-free error in fatal error recovery (Thomas Tai)


The following changes since commit 270ed733e68955049b693bea8f4a1efb293a96ae:

  PCI: v3-semi: Fix I/O space page leak (2018-07-18 17:02:13 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-4

for you to fetch changes up to bd91b56cb3b27492963caeb5fccefe20a986ca8d:

  PCI/AER: Work around use-after-free in pcie_do_fatal_recovery() (2018-07-26 12:13:04 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-4

----------------------------------------------------------------
Thomas Tai (1):
      PCI/AER: Work around use-after-free in pcie_do_fatal_recovery()

 drivers/pci/pcie/err.c | 2 ++
 1 file changed, 2 insertions(+)
