Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeC2QHf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:07:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46328 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeC2QHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:07:33 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 29 Mar 2018 10:07:17 -0600
Message-Id: <20180329160721.4691-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/4] SGL alloc and free helper functions for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

These patches are going to be part of the P2PDMA patchset I'm working
on. The change was suggested by Christoph. I just wanted to get the NVMe
community's initial feedback on them seperate from our main patchset.

That is, except for patch 0003 which I'm pretty sure is a valid bug fix
but it needs review.

I also can not test the fibre channel changes as I do not have hardware
so I'd also appreciate it if someone can test it out.

If you need more context the commit which modifies these to support
P2P is [1]. This will likely be posted as the next version of the P2PDMA
patchset in the next cycle.

Thanks,

Logan


[1] https://github.com/sbates130272/linux-p2pmem/commit/4e57ff23d5ccc4687ac8eb567df1d4d15bf50254

Logan Gunthorpe (4):
  nvmet: Introduce helper functions to allocate and free request SGLs
  nvmet-rdma: Use new SGL alloc/free helper for requests
  nvmet-fc: Don't use the count returned by the dma_map_sg call
  nvmet-fc: Use new SGL alloc/free helper for requests

 drivers/nvme/target/core.c  | 16 ++++++++++++++++
 drivers/nvme/target/fc.c    | 45 ++++++++++++++++-----------------------------
 drivers/nvme/target/nvmet.h |  2 ++
 drivers/nvme/target/rdma.c  | 20 ++++++++++++--------
 4 files changed, 46 insertions(+), 37 deletions(-)

--
2.11.0
