Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCOJCU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:02:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751095AbeCOJCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:02:18 -0400
From: Honggang LI <honli@redhat.com>
To: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc: noaos@mellanox.com, linux-kernel@vger.kernel.org, honli@redhat.com
Subject: [PATCH 0/2] IB/core: Set invalid active widths to 1X when port is not active
Date: Thu, 15 Mar 2018 17:02:12 +0800
Message-Id: <20180315090214.21706-1-honli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honggang Li <honli@redhat.com>

Before the mlx5 RoCE port negotiate the active rate and width
with remote side, the mlx5_ib driver set them to zero.

The tool 'ibstat' of 'infiniband-diags' package will panic as it
read invalid width from the sys file. Set the active widths to
lowest valid vaule as what ib_core module did for invalid rates.

Honggang Li (2):
  IB/core: Set speed string to SDR for invalid active rates
  IB/core: Set width to 1X for invalid active widths when port is down

 drivers/infiniband/core/sysfs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.14.GIT
