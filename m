Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD92BC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F11A218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545169247;
	bh=FeSC9pIre235L6EKCrg/anEA02dCzIIXluvloLV1s5Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EEAT5Af3sihSVtCvdvV4PphFMX4qxyMKQhSG/eSdlc0JMig6ozj920gDnoNp+8sHL
	 ilLMsD8l7TvMVoVLp95JVQ53akMMpu6EgO0vo4iUKuBuRSQcR8d0xAkr8JH4+0IoCO
	 vy9CZeRYR5v2qV5NGXdn4ibAOZKUeU2Nk1xKvLNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLRVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeLRVkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:40:46 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CB62184C;
        Tue, 18 Dec 2018 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545169245;
        bh=FeSC9pIre235L6EKCrg/anEA02dCzIIXluvloLV1s5Y=;
        h=Date:From:To:Cc:Subject:From;
        b=KaHJl7FskUfrqz450uK3E1wQdJQYsAlLYk3kz87ywdYuIgVNu/pJxML7FKzw5u2pY
         1CEXh7pcrLy6VTowrg4VWpgYhtVL3A5JpJFiY6GvbnYAKzjBYC5YHP/DV65KnVOYrQ
         Mt9K15ZhNJwOquTp87+mtWsQacyvjMb9kmbnF6TM=
Date:   Tue, 18 Dec 2018 15:40:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181218214043.GA22610@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Fix the ACPI APEI error path, which previously queued several
    uninitialized events (Yanjiang Jin)


The following changes since commit b07b864ee4232b03125992a8f6a490b040adcb6a:

  Revert "PCI/ASPM: Do not initialize link state when aspm_disabled is set" (2018-12-03 18:05:17 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-4

for you to fetch changes up to 1063a5148ac9d1606e80886fa53ee57d45fb4589:

  PCI/AER: Queue one GHES event, not several uninitialized ones (2018-12-14 11:29:37 -0600)

----------------------------------------------------------------
pci-v4.20-fixes-4

----------------------------------------------------------------
Yanjiang Jin (1):
      PCI/AER: Queue one GHES event, not several uninitialized ones

 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
