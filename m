Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AD0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C3C20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544215501;
	bh=cVkvjP3dADHwuiz0uGDJ3Dh0QNEInTSkY2+tShOcaFU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nPhYCO6il+Sd31XvxM4oRXe1xmQgaP9Fn3Pz0vNyA9cV/ZXLYx/XWdfyW7iCbEFLY
	 bxtxbl+5C7SvEZXc4wK8p2eJzBoFKnO3YlNwPc/grgvblHybaf6H1CfWawZ8Y+6wPo
	 e+M5LmGtKL1Zh0qT1z6U7VknTrPxO+VBeaW5EPVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C3C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLGUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:44:57 -0500
Received: from localhost (unknown [66.115.192.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095BC20868;
        Fri,  7 Dec 2018 20:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544215496;
        bh=cVkvjP3dADHwuiz0uGDJ3Dh0QNEInTSkY2+tShOcaFU=;
        h=Date:From:To:Cc:Subject:From;
        b=BEZYUGk/GzXrEK+TOME9Dq5mm5l3ca0/Ngqh53Ef65DWnJWPle3WwwfWE5YUQpOIu
         tRFTWLysiVHhNBEsE8iViTFem/zSDroQkaR2MzpH9gSwDayhznVjvkaCsNzJGjZCj6
         1A5vFIDJiW9afuwOzFcy6afvRPFpBWsqu6qPdeiA=
Date:   Fri, 7 Dec 2018 14:44:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181207204453.GA578@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Revert ASPM change that caused a regression (Bjorn Helgaas)


The following changes since commit c74eadf881ad634c68880e2c1b504989d95993ee:

  Merge remote-tracking branch 'lorenzo/pci/controller-fixes' into for-linus (2018-11-30 23:42:08 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-3

for you to fetch changes up to b07b864ee4232b03125992a8f6a490b040adcb6a:

  Revert "PCI/ASPM: Do not initialize link state when aspm_disabled is set" (2018-12-03 18:05:17 -0600)

----------------------------------------------------------------
pci-v4.20-fixes-3

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI/ASPM: Do not initialize link state when aspm_disabled is set"

 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
