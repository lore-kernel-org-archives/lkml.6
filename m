Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99137C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B7921917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLWJeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:34:09 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44293
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbeLWJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:34:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991781"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:55 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Jiri Pirko <jiri@mellanox.com>
Cc:     kernel-janitors@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] mlxsw: spectrum: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:57:11 +0100
Message-Id: <1545555435-24576-17-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

The uses were removed in 244cd96adb5f ("net_sched: remove
list_head from tc_action"), but not the declaration.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 244cd96adb5f ("net_sched: remove list_head from tc_action")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c742a581f0d0..eed1045e4d96 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1347,7 +1347,6 @@ static int mlxsw_sp_port_add_cls_matchall(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_port_mall_tc_entry *mall_tc_entry;
 	__be16 protocol = f->common.protocol;
 	const struct tc_action *a;
-	LIST_HEAD(actions);
 	int err;
 
 	if (!tcf_exts_has_one_action(f->exts)) {

