Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031376AbeEZIJp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:09:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031230AbeEZIJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:09:23 -0400
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To: <dledford@redhat.com>, <jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <leonro@mellanox.com>
Subject: [PATCH V3 rdma-next 0/4] {RDMA/uverbs,hns}: Misc update for hns driver
Date: Sat, 26 May 2018 16:41:43 +0800
Message-ID: <1527324107-56593-1-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason and Doug

This patchset included fixing bug, reset process, and
implementation of the disassociate_ucontext API for hns
driver.

We refactored the implemetion of disaacociate_ucontext
in V1 series according to Jason's comment. The related
link: https://lkml.org/lkml/2018/5/22/967
Thanks.

  Regards
Wei Hu

Wei Hu (Xavier) (4):
  RDMA/hns: Add reset process for RoCE in hip08
  RDMA/hns: Fix the illegal memory operation when cross page
  RDMA/uverbs: Hoist the common process of disassociate_ucontext into ib
    core
  RDMA/hns: Implement the disassociate_ucontext API

 drivers/infiniband/core/uverbs_main.c       |  45 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |   3 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 148 ++++++++++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  77 ++++++++++++++-
 drivers/infiniband/hw/mlx4/main.c           |  34 -------
 drivers/infiniband/hw/mlx5/main.c           |  34 -------
 8 files changed, 262 insertions(+), 90 deletions(-)

-- 
1.9.1
