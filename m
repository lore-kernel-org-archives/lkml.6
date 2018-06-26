Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCC826BA5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC826BA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935822AbeFZNvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44375 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935379AbeFZNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:51:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 479FBACF0;
        Tue, 26 Jun 2018 13:51:46 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 0/2] nvme: add controller id and disk name to tracepoints
Date:   Tue, 26 Jun 2018 15:51:39 +0200
Message-Id: <20180626135141.14088-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch one is a preparation patch from Sagi and caches the nvme_ctrl in
the nvme_request. This is not only useful for the tracepoints but for
further development as well.

The second patch adds the controller IDs and if applicable the disk
name to the tracepoints so we can distinguish between the individual
controllers and disks.

The patches are relative to the nvme-4.19 branch.

Johannes Thumshirn (1):
  nvme: trace: add disk name to tracepoints

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   | 10 ++++++----
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  5 +++--
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/trace.h  | 30 +++++++++++++++++++-----------
 drivers/nvme/target/loop.c |  2 +-
 7 files changed, 32 insertions(+), 21 deletions(-)

-- 
2.16.4

