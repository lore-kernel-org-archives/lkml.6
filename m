Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeEOHkw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbeEOHku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:40:50 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/5] Misc NVMe lockdep fixes
Date: Tue, 15 May 2018 09:40:38 +0200
Message-Id: <20180515074043.22843-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've "accidently" activated lockdep and ran some tests on nvme, here's
the post-fallout patch series.

Johannes Thumshirn (5):
  nvme: fix lockdep warning in nvme_mpath_clear_current_path
  nvme: don't hold nvmf_transports_rwsem for more than transport lookups
  nvme: call nvmf_create_ctrl before checking for duplicate assignment
  nvmet: use atomic allocations when allocating fc requests
  nvmet: fcloop: use irqsave spinlocks

 drivers/nvme/host/fabrics.c  | 20 +++++++---------
 drivers/nvme/host/nvme.h     |  3 ++-
 drivers/nvme/target/fcloop.c | 54 ++++++++++++++++++++++++--------------------
 3 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.16.3
