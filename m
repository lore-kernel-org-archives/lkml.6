Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80121C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CAA218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLWJeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:34:16 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44311
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727411AbeLWJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:34:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991784"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:55 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Tariq Toukan <tariqt@mellanox.com>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] net/mlx4_core: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:57:14 +0100
Message-Id: <1545555435-24576-20-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares has never
been used.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: c82e9aa0a8bc ("mlx4_core: resource tracking for HCA resources used by guests")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
index 31bd56727022..eb13d3618162 100644
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -4729,7 +4729,6 @@ static void rem_slave_srqs(struct mlx4_dev *dev, int slave)
 	struct res_srq *tmp;
 	int state;
 	u64 in_param;
-	LIST_HEAD(tlist);
 	int srqn;
 	int err;
 
@@ -4795,7 +4794,6 @@ static void rem_slave_cqs(struct mlx4_dev *dev, int slave)
 	struct res_cq *tmp;
 	int state;
 	u64 in_param;
-	LIST_HEAD(tlist);
 	int cqn;
 	int err;
 
@@ -4858,7 +4856,6 @@ static void rem_slave_mrs(struct mlx4_dev *dev, int slave)
 	struct res_mpt *tmp;
 	int state;
 	u64 in_param;
-	LIST_HEAD(tlist);
 	int mptn;
 	int err;
 
@@ -4926,7 +4923,6 @@ static void rem_slave_mtts(struct mlx4_dev *dev, int slave)
 	struct res_mtt *mtt;
 	struct res_mtt *tmp;
 	int state;
-	LIST_HEAD(tlist);
 	int base;
 	int err;
 
@@ -5115,7 +5111,6 @@ static void rem_slave_eqs(struct mlx4_dev *dev, int slave)
 	struct res_eq *tmp;
 	int err;
 	int state;
-	LIST_HEAD(tlist);
 	int eqn;
 
 	err = move_all_busy(dev, slave, RES_EQ);

